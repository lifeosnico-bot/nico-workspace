#!/usr/bin/env python3
"""Morning Report heartbeat — writes to Obsidian + sends to Telegram.

Design goals:
- Reliable (no LLM dependency)
- Short
- Uses status.md as source of truth

Set DRY_RUN=1 to print output without sending Telegram.
"""

import json
import os
import re
import sys
import urllib.request
from datetime import datetime
from pathlib import Path

YAML_PATH = "/Users/lifeos.nico/Nico/lettabot/lettabot/lettabot.yaml"
CHAT_ID = "8385420240"
VAULT = Path("/Users/lifeos.nico/Nico/CabinetAgentVault")
STATUS_MD = VAULT / "00-dashboard/status.md"
DAILY_DIR = VAULT / "00-dashboard/daily"
HOME_MD = VAULT / "00-dashboard/home.md"

MAX_CHARS = 3800  # keep under Telegram limits


def get_token() -> str:
    content = Path(YAML_PATH).read_text()
    m = re.search(r"^\s+token:\s+(\S+)", content, re.MULTILINE)
    if not m:
        raise ValueError("Telegram token not found in YAML")
    return m.group(1)


def read_status_text() -> str:
    return STATUS_MD.read_text()


def extract_section(text: str, header: str) -> str:
    # crude but effective: grab from header to next '## '
    pattern = rf"^##\s+{re.escape(header)}\s*$"
    m = re.search(pattern, text, re.MULTILINE)
    if not m:
        return ""
    start = m.end()
    rest = text[start:]
    n = re.search(r"^##\s+", rest, re.MULTILINE)
    section = rest[: n.start()] if n else rest
    return section.strip()


def pick_top_tasks(status_text: str, limit: int = 3) -> list[str]:
    # Prefer 'Active This Week' table rows with P1/P2 that aren't struck-through.
    sec = extract_section(status_text, "🔴 Active This Week")
    if not sec:
        sec = extract_section(status_text, "Active This Week")
    tasks: list[str] = []
    for line in sec.splitlines():
        if "|" not in line:
            continue
        if "| P" not in line:
            continue
        if line.strip().startswith("| Priority") or line.strip().startswith("|---"):
            continue
        if "~~" in line or "✅" in line:
            continue
        cols = [c.strip() for c in line.split("|") if c.strip()]
        if len(cols) >= 3:
            priority, owner, task = cols[0], cols[1], cols[2]
            tasks.append(f"{priority} {owner} {task}")
        if len(tasks) >= limit:
            break
    return tasks


def pick_vincent_actions(status_text: str, limit: int = 3) -> list[str]:
    sec = extract_section(status_text, "👤 Vincent's Actions (Blocking Nico)")
    if not sec:
        sec = extract_section(status_text, "Vincent's Actions (Blocking Nico)")
    actions: list[str] = []
    for line in sec.splitlines():
        line = line.strip()
        if line.startswith("- [ ]"):
            actions.append(line.replace("- [ ]", "-", 1).strip())
        if len(actions) >= limit:
            break
    return actions


def latest_daily_file(suffix: str) -> str | None:
    files = sorted(DAILY_DIR.glob(f"*_ {suffix}.md".replace(" ", "")))
    return files[-1].relative_to(VAULT).as_posix() if files else None


def update_home_links():
    text = HOME_MD.read_text()

    def newest(glob_pat: str) -> str | None:
        files = sorted(DAILY_DIR.glob(glob_pat))
        return files[-1].relative_to(VAULT).as_posix() if files else None

    morning = newest("*_morning-report.md")
    night = newest("*_nighttime-report.md")
    eod = newest("*_eod-wrapup.md")

    def mk(label: str, path: str | None) -> str:
        if not path:
            return f"- {label}: (none yet)"
        # Convert to Obsidian link
        target = path[:-3] if path.endswith(".md") else path
        return f"- [[{target}|{label}]]"

    block = "\n".join(
        [
            "## Daily Reports",
            mk("Morning Report (latest)", morning),
            mk("Nighttime Report (latest)", night),
            mk("EOD Wrap Up (latest)", eod),
        ]
    )

    new_text, n = re.subn(r"## Daily Reports\n(?:- .*\n?)+", block + "\n", text)
    if n == 0:
        # If block not found, append it.
        new_text = text.rstrip() + "\n\n" + block + "\n"

    HOME_MD.write_text(new_text)


def write_obsidian_note(date_str: str, title: str, body_text: str, filename: str):
    path = DAILY_DIR / filename
    content = (
        "---\n"
        f"title: \"{title}\"\n"
        f"date: {date_str}\n"
        "tags: [daily, report]\n"
        "type: daily\n"
        "status: draft\n"
        "source: nico\n"
        "---\n\n"
        f"# {title}\n\n"
        "## Telegram Copy\n"
        f"{body_text.strip()}\n"
    )
    path.write_text(content)


def send_telegram(token: str, text: str):
    url = f"https://api.telegram.org/bot{token}/sendMessage"
    data = json.dumps({"chat_id": CHAT_ID, "text": text}).encode()
    req = urllib.request.Request(url, data=data, headers={"Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=15) as resp:
        return json.load(resp)


def main():
    now = datetime.now()
    date_str = now.strftime("%Y-%m-%d")
    day = now.strftime("%a")

    status_text = read_status_text()
    current_state = extract_section(status_text, "Current State")
    current_state_line = ""
    for line in current_state.splitlines():
        line = line.strip()
        if line:
            current_state_line = line
            break

    top_tasks = pick_top_tasks(status_text, 3)
    vincent_actions = pick_vincent_actions(status_text, 3)

    parts = [f"Morning Report ({day} {date_str})"]
    if current_state_line:
        parts.append(f"Current: {current_state_line}")

    if top_tasks:
        parts.append("Top 3:")
        parts.extend([f"- {t}" for t in top_tasks])

    if vincent_actions:
        parts.append("Needs you:")
        parts.extend(vincent_actions)

    msg = "\n".join(parts).strip()[:MAX_CHARS]

    # Obsidian artifacts
    write_obsidian_note(
        date_str=date_str,
        title=f"Morning Report — {date_str}",
        body_text=msg,
        filename=f"{date_str}_morning-report.md",
    )
    update_home_links()

    if os.environ.get("DRY_RUN") == "1":
        print(msg)
        return

    token = get_token()
    result = send_telegram(token, msg)
    msg_id = result.get("result", {}).get("message_id")
    print(f"Sent OK: {result.get('ok')}, msg_id: {msg_id}")


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)
