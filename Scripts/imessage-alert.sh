#!/bin/bash
# alert.sh — Send Telegram alert to Vincent when Nico needs attention
# Usage: ./imessage-alert.sh "Your message here"

TOKEN="8546244337:AAEoz3Et01vcKG3WiyJnWwNXNhSNwPbJE0c"
CHAT_ID="8385420240"
MESSAGE="${1:-"🤖 Nico needs your attention on M1. Check Claude Code session."}"

curl -s -X POST "https://api.telegram.org/bot${TOKEN}/sendMessage" \
  -H "Content-Type: application/json" \
  -d "{\"chat_id\": $CHAT_ID, \"text\": \"$MESSAGE\"}" > /dev/null

echo "$(date '+%Y-%m-%d %H:%M EST') — Telegram alert sent: $MESSAGE"
