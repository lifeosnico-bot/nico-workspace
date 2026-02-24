#!/bin/bash
# slack-post.sh — Post a message to a Slack channel
# Usage: ./slack-post.sh "#channel" "message"
# Or:    ./slack-post.sh "channel-id" "message"

SCRIPT_DIR="$(dirname "$0")"
ENV_FILE="$HOME/Nico/Projects/slack-bot/.env"

# Load bot token from .env
if [ -f "$ENV_FILE" ]; then
    SLACK_BOT_TOKEN=$(grep '^SLACK_BOT_TOKEN=' "$ENV_FILE" | cut -d'=' -f2)
fi

if [ -z "$SLACK_BOT_TOKEN" ]; then
    echo "ERROR: SLACK_BOT_TOKEN not found in $ENV_FILE"
    exit 1
fi

CHANNEL="${1}"
MESSAGE="${2:-"🤖 Nico update from M1."}"

# If channel starts with #, look up ID
if [[ "$CHANNEL" == \#* ]]; then
    CHANNEL_NAME="${CHANNEL:1}"
    CHANNEL_ID=$(curl -s -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
        "https://slack.com/api/conversations.list?types=public_channel,private_channel&limit=200" \
        | python3 -c "
import sys, json
data = json.load(sys.stdin)
for ch in data.get('channels', []):
    if ch['name'] == '$CHANNEL_NAME':
        print(ch['id'])
        break
" 2>/dev/null)
    if [ -z "$CHANNEL_ID" ]; then
        echo "ERROR: Channel #$CHANNEL_NAME not found"
        exit 1
    fi
else
    CHANNEL_ID="$CHANNEL"
fi

RESPONSE=$(curl -s -X POST "https://slack.com/api/chat.postMessage" \
    -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"channel\": \"$CHANNEL_ID\", \"text\": $(python3 -c "import json; print(json.dumps('$MESSAGE'))" 2>/dev/null || echo "\"$MESSAGE\"")}")

OK=$(echo "$RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin).get('ok','false'))" 2>/dev/null)

if [ "$OK" = "True" ]; then
    echo "$(date '+%Y-%m-%d %H:%M EST') — Slack post to $CHANNEL: $MESSAGE"
else
    echo "ERROR: Slack post failed — $RESPONSE"
    exit 1
fi
