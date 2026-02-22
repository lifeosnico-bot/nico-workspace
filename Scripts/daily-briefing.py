#!/usr/bin/env python3
"""Daily briefing script — sends morning briefing from Nico to Telegram."""
import re
import subprocess
import urllib.request
import json
import sys

YAML_PATH = "/Users/lifeos.nico/Nico/lettabot/lettabot/lettabot.yaml"
NICO_AGENT = "agent-5a9b0e69-1f30-476d-a89a-30c8e21c9668"
CHAT_ID = "8385420240"
LETTA = "/opt/homebrew/bin/letta"
MAX_CHARS = 4000

BRIEFING_PROMPT = (
    "Generate a concise morning briefing. "
    "Read ~/Nico/Memory/status.md for current project status. "
    "Include: (1) Today's date and day, (2) What is currently in progress, "
    "(3) Top 3 priorities for today, (4) Any blockers. "
    "Keep it under 200 words. Plain text only, no markdown."
)


def get_token():
    with open(YAML_PATH) as f:
        content = f.read()
    m = re.search(r"^\s+token:\s+(\S+)", content, re.MULTILINE)
    if not m:
        raise ValueError("Telegram token not found in YAML")
    return m.group(1)


def get_briefing():
    result = subprocess.run(
        [LETTA, "-p", "--agent", NICO_AGENT, BRIEFING_PROMPT],
        capture_output=True,
        text=True,
        timeout=120,
    )
    text = result.stdout.strip()
    if not text and result.stderr:
        raise RuntimeError(f"letta error: {result.stderr.strip()}")
    return text[:MAX_CHARS]


def send_telegram(token, text):
    url = f"https://api.telegram.org/bot{token}/sendMessage"
    data = json.dumps({"chat_id": CHAT_ID, "text": text}).encode()
    req = urllib.request.Request(url, data=data, headers={"Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=15) as resp:
        return json.load(resp)


if __name__ == "__main__":
    try:
        token = get_token()
        briefing = get_briefing()
        if not briefing:
            briefing = "Daily briefing: Agent returned no response."
        result = send_telegram(token, briefing)
        msg_id = result.get("result", {}).get("message_id")
        print(f"Sent OK: {result.get('ok')}, msg_id: {msg_id}")
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)
