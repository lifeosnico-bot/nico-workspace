#!/bin/bash
# alert.sh — Send Telegram alert to Vincent when Nico needs attention
# Usage: ./imessage-alert.sh "Your message here"

CHAT_ID="8385420240"
MESSAGE="${1:-"Nico needs your attention on M1. Check Claude Code session."}"

# Read secrets from local config file (not tracked in git)
LETTA_CONFIG="/Users/lifeos.nico/Nico/lettabot/lettabot/lettabot.yaml"
TELEGRAM_BOT_TOKEN="$(/usr/bin/awk '/^[[:space:]]*token:[[:space:]]*/{print $2; exit}' "$LETTA_CONFIG")"
LETTABOT_API_KEY="$(/usr/bin/awk '/^[[:space:]]*apiKey:[[:space:]]*/{print $2; exit}' "$LETTA_CONFIG")"

# Send via lettabot-message (keeps payload encoding safe)
TELEGRAM_BOT_TOKEN="$TELEGRAM_BOT_TOKEN" LETTABOT_API_KEY="$LETTABOT_API_KEY" /opt/homebrew/bin/npm exec lettabot-message -- send --text "$MESSAGE" --channel telegram --chat "$CHAT_ID" >/dev/null 2>&1 || true

echo "$(date '+%Y-%m-%d %H:%M %Z') — Telegram alert sent"
