#!/usr/bin/env python3
"""Nighttime report (quiet by default).

Policy:
- If Phase 0G has unfinished items: send a short status snapshot.
- Otherwise: stay silent unless we detect a failure condition.

Failure conditions:
- com.nico.lettabot not running
- com.nico.slack-poller not running
- overnight-runner stderr log contains 'Traceback' or 'Error:'

No secrets are printed.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import subprocess
import urllib.request
from datetime import datetime
from pathlib import Path

STATUS_FILE = Path("/Users/lifeos.nico/Nico/CabinetAgentVault/00-dashboard/status.md")
STATE_DIR = Path("/Users/lifeos.nico/Nico/Logs")
LETTA_CONFIG = Path("/Users/lifeos.nico/Nico/lettabot/lettabot/lettabot.yaml")
CHAT_ID = "8385420240"

OVERNIGHT_ERR = STATE_DIR / "overnight-runner-err.log"
OVERNIGHT_OUT = STATE_DIR / "overnight-runner.log"

CEREBRAS_KEYCHAIN_SERVICE = "cerebras-api-key"
CEREBRAS_KEYCHAIN_ACCOUNT = "lifeos.nico"
CEREBRAS_API_URL = "https://api.cerebras.ai/v1/chat/completions"


def _now() -> str:
    return datetime.now().strftime("%Y-%m-%d %H:%M %Z")


def _read_yaml_field(key: str) -> str | None:
    if not LETTA_CONFIG.exists():
        return None
    m = re.search(rf"^\s*{re.escape(key)}:\s*(\S+)\s*$", LETTA_CONFIG.read_text(), re.MULTILINE)
    return m.group(1) if m else None


def _launchctl_has_pid(label: str) -> bool:
    try:
        out = subprocess.check_output(["/bin/launchctl", "list"], text=True)
    except Exception:
        return False

    for line in out.splitlines():
        if not line.rstrip().endswith(label):
            continue
        parts = line.split()
        if not parts:
            continue
        return parts[0] != "-"

    return False


def _extract_phase0g_block() -> str:
    if not STATUS_FILE.exists():
        return ""

    lines = STATUS_FILE.read_text(encoding="utf-8", errors="replace").splitlines()
    start = None
    for i, line in enumerate(lines):
        if line.strip().startswith("### Phase 0G:"):
            start = i
            break
    if start is None:
        return ""

    out: list[str] = []
    for line in lines[start:]:
        if line.startswith("### ") and out and not line.strip().startswith("### Phase 0G:"):
            break
        out.append(line)

    return "\n".join(out).strip()


def _phase0g_has_open_items(block: str) -> bool:
    return "- [ ]" in block


def _overnight_runner_has_error() -> bool:
    if not OVERNIGHT_ERR.exists():
        return False
    txt = OVERNIGHT_ERR.read_text(encoding="utf-8", errors="replace")
    return "Traceback" in txt or "Error:" in txt


def _send(msg: str) -> None:
    token = _read_yaml_field("token")
    api_key = _read_yaml_field("apiKey")
    if not token or not api_key:
        return

    env = os.environ.copy()
    env["TELEGRAM_BOT_TOKEN"] = token
    env["LETTABOT_API_KEY"] = api_key

    subprocess.run(
        [
            "/opt/homebrew/bin/npm",
            "exec",
            "lettabot-message",
            "--",
            "send",
            "--text",
            msg,
            "--channel",
            "telegram",
            "--chat",
            CHAT_ID,
        ],
        env=env,
        capture_output=True,
        text=True,
        timeout=30,
    )


def _get_cerebras_api_key() -> str | None:
    # Prefer env var for non-interactive runs.
    k = os.environ.get("CEREBRAS_API_KEY")
    if k:
        return k

    # Fallback: macOS Keychain
    try:
        r = subprocess.run(
            [
                "/usr/bin/security",
                "find-generic-password",
                "-s",
                CEREBRAS_KEYCHAIN_SERVICE,
                "-a",
                CEREBRAS_KEYCHAIN_ACCOUNT,
                "-w",
            ],
            capture_output=True,
            text=True,
            timeout=5,
        )
        if r.returncode == 0:
            return r.stdout.strip()
    except Exception:
        return None

    return None


def _cerebras_chat(prompt: str, max_tokens: int = 256) -> dict | None:
    key = _get_cerebras_api_key()
    if not key:
        return None

    payload = {
        "model": "gpt-oss-120b",
        "stream": False,
        "messages": [{"role": "user", "content": prompt}],
        "temperature": 0,
        "max_tokens": max_tokens,
    }

    req = urllib.request.Request(
        CEREBRAS_API_URL,
        data=json.dumps(payload).encode("utf-8"),
        headers={
            "Content-Type": "application/json",
            "Authorization": f"Bearer {key}",
        },
        method="POST",
    )

    try:
        with urllib.request.urlopen(req, timeout=30) as resp:
            return json.loads(resp.read().decode("utf-8", errors="replace"))
    except Exception:
        return None


def main() -> int:
    p = argparse.ArgumentParser()
    p.add_argument("--cerebras", action="store_true", help="Use Cerebras for the report summary")
    p.add_argument("--force", action="store_true", help="Send a message even if there are no failures")
    args = p.parse_args()

    phase0g = _extract_phase0g_block()
    open_phase0g = _phase0g_has_open_items(phase0g) if phase0g else False

    failures: list[str] = []
    if not _launchctl_has_pid("com.nico.lettabot"):
        failures.append("LettaBot not running")
    if not _launchctl_has_pid("com.nico.slack-poller"):
        failures.append("Slack poller not running")
    if _overnight_runner_has_error():
        failures.append("Overnight runner has errors")

    # If nothing to say, stay silent (unless forced)
    if not args.force and not open_phase0g and not failures:
        return 0

    # Build a minimal context blob for summarization
    context_lines: list[str] = []
    if failures:
        context_lines.append("Failures:")
        for f in failures:
            context_lines.append(f"- {f}")
    if open_phase0g and phase0g:
        context_lines.append("Phase 0G snapshot:")
        context_lines.append(phase0g)
    if OVERNIGHT_OUT.exists():
        tail = OVERNIGHT_OUT.read_text(encoding="utf-8", errors="replace").splitlines()[-8:]
        if tail:
            context_lines.append("Overnight runner (tail):")
            context_lines.extend(tail)

    summary = None
    if args.cerebras:
        prompt = (
            "You are Nico running a nightly health/report. Summarize the following context into:\n"
            "- One-line status\n"
            "- Up to 5 bullets (actionable)\n"
            "Keep it plain text.\n\n"
            + "\n".join(context_lines)
        )
        resp = _cerebras_chat(prompt, max_tokens=220)
        if resp and resp.get("choices"):
            msg = resp["choices"][0].get("message", {}).get("content")
            if msg:
                summary = str(msg).strip()

    lines: list[str] = []
    lines.append(f"Night check ({_now()})")

    if summary:
        lines.append("")
        lines.append(summary)
    else:
        # Fallback: send raw context
        lines.append("")
        lines.extend(context_lines)

    _send("\n".join(lines)[:3500])
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
