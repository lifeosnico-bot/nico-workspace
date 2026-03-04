#!/bin/bash
set -euo pipefail

STATUS_FILE="/Users/lifeos.nico/Nico/CabinetAgentVault/00-dashboard/status.md"
STATE_DIR="/Users/lifeos.nico/Nico/Logs"
LAST_SENT_FILE="$STATE_DIR/phase0g-status-last.txt"

# LettaBot credentials (read from local config; do NOT print)
LETTA_CONFIG="/Users/lifeos.nico/Nico/lettabot/lettabot/lettabot.yaml"
TELEGRAM_BOT_TOKEN="$(/usr/bin/awk '/^[[:space:]]*token:[[:space:]]*/{print $2; exit}' "$LETTA_CONFIG")"
LETTABOT_API_KEY="$(/usr/bin/awk '/^[[:space:]]*apiKey:[[:space:]]*/{print $2; exit}' "$LETTA_CONFIG")"

if [ ! -f "$STATUS_FILE" ]; then
  exit 0
fi

BLOCK="$((/usr/bin/python3 - <<'PY'
from pathlib import Path

p = Path('/Users/lifeos.nico/Nico/CabinetAgentVault/00-dashboard/status.md')
text = p.read_text(encoding='utf-8', errors='replace').splitlines()

start = None
for i, line in enumerate(text):
    if line.strip().startswith('### Phase 0G:'):
        start = i
        break

if start is None:
    print('')
    raise SystemExit(0)

out = []
for line in text[start:]:
    if line.startswith('### ') and out and not line.strip().startswith('### Phase 0G:'):
        break
    out.append(line)

block = '\n'.join(out).strip()
print(block)
PY
) || true)"

if [ -z "$BLOCK" ]; then
  exit 0
fi

# Only ping when Phase 0G has unfinished items
if ! echo "$BLOCK" | /usr/bin/grep -q "\- \[ \]"; then
  exit 0
fi

/bin/mkdir -p "$STATE_DIR"

NOW="$(/bin/date '+%Y-%m-%d %H:%M %Z')"

MSG="Phase 0G status ping ($NOW)\n\n$BLOCK"

TELEGRAM_BOT_TOKEN="$TELEGRAM_BOT_TOKEN" LETTABOT_API_KEY="$LETTABOT_API_KEY" /opt/homebrew/bin/npm exec lettabot-message -- send --text "$MSG" --channel telegram --chat "8385420240" >/dev/null 2>&1 || true

printf "%s\n\n%s" "$NOW" "$BLOCK" > "$LAST_SENT_FILE"

echo "$NOW sent Phase 0G status ping"