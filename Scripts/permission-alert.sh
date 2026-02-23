#!/bin/bash
# permission-alert.sh — Alert Vincent via Telegram when Claude Code needs approval
# Fired by Notification hook on permission_prompt

SCRIPT_DIR="$(dirname "$0")"
COOLDOWN_FILE="/tmp/claude-permission-alert-cooldown"
COOLDOWN_SECONDS=120

# Rate limit: don't spam if multiple prompts fire quickly
if [ -f "$COOLDOWN_FILE" ]; then
    LAST=$(cat "$COOLDOWN_FILE")
    NOW=$(date +%s)
    DIFF=$((NOW - LAST))
    if [ "$DIFF" -lt "$COOLDOWN_SECONDS" ]; then
        exit 0
    fi
fi

date +%s > "$COOLDOWN_FILE"
"$SCRIPT_DIR/imessage-alert.sh" "🔔 Claude Code is waiting for your approval on M1."
