#!/bin/bash
set -euo pipefail

WIZARD_FILE="/Users/lifeos.nico/Nico/CabinetAgentVault/30-resources/letta-manual/build-me/build-update-nico_wizard.md"
STATE_DIR="/Users/lifeos.nico/Nico/Logs"
LAST_SENT_FILE="$STATE_DIR/wizard-status-last.txt"

if [ ! -f "$WIZARD_FILE" ]; then
  exit 0
fi

# Extract the checklist block
CHECKLIST="$((/usr/bin/python3 - <<'PY'
import re
from pathlib import Path
p = Path("/Users/lifeos.nico/Nico/CabinetAgentVault/30-resources/letta-manual/build-me/build-update-nico_wizard.md")
text = p.read_text(encoding="utf-8", errors="replace").splitlines()
start = None
for i,line in enumerate(text):
    if line.strip() == "## 4.0 Wizard progress checklist (update on every completion)":
        start = i+1
        break
if start is None:
    print("")
    raise SystemExit(0)
# Capture until the next blank line after the list/rules block begins to end.
block = []
for line in text[start:]:
    if line.strip() == "":
        # stop after we already collected something
        if block:
            break
        continue
    block.append(line)
print("\n".join(block).strip())
PY
) || true)"

if [ -z "$CHECKLIST" ]; then
  exit 0
fi

# Only ping when something is in progress
if ! echo "$CHECKLIST" | /usr/bin/grep -q "🟨"; then
  exit 0
fi

/bin/mkdir -p "$STATE_DIR"

NOW="$(/bin/date '+%Y-%m-%d %H:%M %Z')"

# Keep message Telegram-safe: no markdown headers, no backticks.
MSG="Wizard status ping ($NOW)\n\n$CHECKLIST"

# Send to Vincent's Telegram DM
/opt/homebrew/bin/npm exec lettabot-message -- send --text "$MSG" --channel telegram --chat "8385420240" >/dev/null 2>&1 || true

# Record last-sent content (with timestamp)
printf "%s\n\n%s" "$NOW" "$CHECKLIST" > "$LAST_SENT_FILE"

# Debug breadcrumb (launchd captures stdout)
echo "$NOW sent wizard status ping"