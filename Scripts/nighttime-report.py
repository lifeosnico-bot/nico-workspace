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

import os
import re
import subprocess
from datetime import datetime
from pathlib import Path

STATUS_FILE = Path("/Users/lifeos.nico/Nico/CabinetAgentVault/00-dashboard/status.md")
STATE_DIR = Path("/Users/lifeos.nico/Nico/Logs")
LETTA_CONFIG = Path("/Users/lifeos.nico/Nico/lettabot/lettabot/lettabot.yaml")
CHAT_ID = "8385420240"

OVERNIGHT_ERR = STATE_DIR / "overnight-runner-err.log"
OVERNIGHT_OUT = STATE_DIR / "overnight-runner.log"


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


def main() -> int:
    phase0g = _extract_phase0g_block()
    open_phase0g = _phase0g_has_open_items(phase0g) if phase0g else False

    failures: list[str] = []
    if not _launchctl_has_pid("com.nico.lettabot"):
        failures.append("LettaBot not running")
    if not _launchctl_has_pid("com.nico.slack-poller"):
        failures.append("Slack poller not running")
    if _overnight_runner_has_error():
        failures.append("Overnight runner has errors")

    if not open_phase0g and not failures:
        return 0

    lines: list[str] = []
    lines.append(f"Night check ({_now()})")

    if failures:
        lines.append("")
        lines.append("Failures:")
        for f in failures:
            lines.append(f"- {f}")

    if open_phase0g and phase0g:
        lines.append("")
        lines.append("Phase 0G snapshot:")
        lines.append(phase0g)

    if OVERNIGHT_OUT.exists():
        tail = OVERNIGHT_OUT.read_text(encoding="utf-8", errors="replace").splitlines()[-4:]
        if tail:
            lines.append("")
            lines.append("Overnight runner (tail):")
            lines.extend(tail)

    _send("\n".join(lines)[:3500])
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
