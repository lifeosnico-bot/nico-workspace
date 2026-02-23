#!/bin/bash
# context-monitor.sh — Claude Code statusline script
# Receives JSON on stdin with context_window data
# Shows context % in status bar, fires Telegram alert at 50%

ALERT_THRESHOLD=50
ALERT_SENT_FILE="/tmp/claude-context-alert-sent"
SCRIPT_DIR="$(dirname "$0")"

# Read JSON from stdin
INPUT=$(cat)

# Extract used_percentage from context_window
USED_PCT=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    cw = data.get('context_window', {})
    print(int(cw.get('used_percentage', 0)))
except:
    print(0)
" 2>/dev/null)

# Build status line output
echo "ctx: ${USED_PCT}%"

# Fire alert at threshold (once per session)
if [ "$USED_PCT" -ge "$ALERT_THRESHOLD" ] 2>/dev/null; then
    if [ ! -f "$ALERT_SENT_FILE" ]; then
        touch "$ALERT_SENT_FILE"
        "$SCRIPT_DIR/imessage-alert.sh" "⚠️ Context window at ${USED_PCT}% — consider /compact or starting a new session."
    fi
fi
