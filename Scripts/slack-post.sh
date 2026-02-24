#!/bin/bash
# slack-post.sh — Post a message to a Slack channel
# Usage: ./slack-post.sh "#channel" "message"
# Or:    ./slack-post.sh "CHANNEL_ID" "message"

ENV_FILE="$HOME/Nico/Projects/slack-bot/.env"

if [ -f "$ENV_FILE" ]; then
    SLACK_BOT_TOKEN=$(grep '^SLACK_BOT_TOKEN=' "$ENV_FILE" | cut -d'=' -f2)
fi

if [ -z "$SLACK_BOT_TOKEN" ]; then
    echo "ERROR: SLACK_BOT_TOKEN not found in $ENV_FILE"
    exit 1
fi

CHANNEL="${1}"
MESSAGE="${2:-🤖 Nico update from M1.}"

# Resolve channel name to ID
resolve_channel() {
    local name="$1"
    case "$name" in
        general)        echo "C0AG7FFN1EF" ;;
        random)         echo "C0AGDT1PM8S" ;;
        chief-of-staff) echo "C0AGDT3GMUJ" ;;
        status)         echo "C0AGHBRREQK" ;;
        tasks)          echo "C0AGHBXSSAX" ;;
        ceo-desk)       echo "C0AGLB0M6BX" ;;
        decisions)      echo "C0AGMMM6Z46" ;;
        nico-internal)  echo "C0AGTBXAUSG" ;;
        dev)            echo "C0AH2LZ6BLZ" ;;
        alerts)         echo "C0AHJ298FNU" ;;
        *)              echo "" ;;
    esac
}

if [[ "$CHANNEL" == \#* ]]; then
    CHANNEL_ID=$(resolve_channel "${CHANNEL:1}")
    if [ -z "$CHANNEL_ID" ]; then
        echo "ERROR: Unknown channel $CHANNEL"
        exit 1
    fi
else
    CHANNEL_ID="$CHANNEL"
fi

PAYLOAD=$(MSG="$MESSAGE" CID="$CHANNEL_ID" python3 -c "
import os, json
print(json.dumps({'channel': os.environ['CID'], 'text': os.environ['MSG']}))
")

RESPONSE=$(curl -s -X POST "https://slack.com/api/chat.postMessage" \
    -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
    -H "Content-Type: application/json" \
    -d "$PAYLOAD")

OK=$(echo "$RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin).get('ok',False))" 2>/dev/null)

if [ "$OK" = "True" ]; then
    echo "$(date '+%Y-%m-%d %H:%M EST') — Slack post to $CHANNEL: $MESSAGE"
else
    echo "ERROR: Slack post failed — $RESPONSE"
    exit 1
fi
