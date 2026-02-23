#!/bin/bash
# imessage-alert.sh — Send iMessage to Vincent when Nico needs attention
# Usage: ./imessage-alert.sh "Your message here"
# Usage: ./imessage-alert.sh (no args = default "Nico needs your attention" message)

PHONE="+1XXXXXXXXXX"  # Vincent's personal phone number — replace before use

MESSAGE="${1:-"🤖 Nico needs your attention on M1. Check Claude Code session."}"

osascript <<EOF
tell application "Messages"
    set targetService to 1st service whose service type = iMessage
    set targetBuddy to buddy "$PHONE" of targetService
    send "$MESSAGE" to targetBuddy
end tell
EOF

echo "$(date '+%Y-%m-%d %H:%M EST') — iMessage sent: $MESSAGE"
