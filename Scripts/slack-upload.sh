#!/bin/bash
# slack-upload.sh — Upload a file to Slack
# Usage: ./slack-upload.sh "#channel" "/path/to/file" "optional title" "optional comment"

ENV_FILE="$HOME/Nico/Projects/slack-bot/.env"

if [ -f "$ENV_FILE" ]; then
    SLACK_BOT_TOKEN=$(grep '^SLACK_BOT_TOKEN=' "$ENV_FILE" | cut -d'=' -f2)
fi

if [ -z "$SLACK_BOT_TOKEN" ]; then
    echo "ERROR: SLACK_BOT_TOKEN not found in $ENV_FILE"
    exit 1
fi

CHANNEL="${1}"
FILE_PATH="${2}"
TITLE="${3:-$(basename "$FILE_PATH")}"
COMMENT="${4:-📄 File uploaded by Nico}"

if [ ! -f "$FILE_PATH" ]; then
    echo "ERROR: File not found: $FILE_PATH"
    exit 1
fi

# Resolve channel name to ID (reuse from slack-post.sh)
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
        vincent-to-nico) echo "C0AGM1DR5DK" ;;
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

# Step 1: Get upload URL
FILE_SIZE=$(stat -f%z "$FILE_PATH")
FILENAME=$(basename "$FILE_PATH")

PAYLOAD=$(FILENAME="$FILENAME" FILE_SIZE="$FILE_SIZE" python3 -c "
import os, json
filename = os.environ['FILENAME']
file_size = int(os.environ['FILE_SIZE'])
print(json.dumps({'filename': filename, 'length': file_size}))
")

GET_URL_RESPONSE=$(curl -s -X POST "https://slack.com/api/files.getUploadURLExternal" \
    -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
    -H "Content-Type: application/json; charset=utf-8" \
    -d "$PAYLOAD")

GET_URL_OK=$(echo "$GET_URL_RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin).get('ok',False))" 2>/dev/null)

if [ "$GET_URL_OK" != "True" ]; then
    echo "ERROR: Failed to get upload URL — $GET_URL_RESPONSE"
    exit 1
fi

UPLOAD_URL=$(echo "$GET_URL_RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin).get('upload_url',''))" 2>/dev/null)
FILE_ID=$(echo "$GET_URL_RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin).get('file_id',''))" 2>/dev/null)

# Step 2: Upload file to the URL
UPLOAD_RESPONSE=$(curl -s -X POST "$UPLOAD_URL" -F "file=@$FILE_PATH")

# Step 3: Complete the upload
COMPLETE_RESPONSE=$(curl -s -X POST "https://slack.com/api/files.completeUploadExternal" \
    -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"files\":[{\"id\":\"$FILE_ID\",\"title\":\"$TITLE\"}],\"channel_id\":\"$CHANNEL_ID\",\"initial_comment\":\"$COMMENT\"}")

COMPLETE_OK=$(echo "$COMPLETE_RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin).get('ok',False))" 2>/dev/null)

if [ "$COMPLETE_OK" = "True" ]; then
    echo "$(date '+%Y-%m-%d %H:%M EST') — File uploaded to $CHANNEL: $TITLE"
    echo "Note: File may take a moment to appear due to Slack's security scanning"
else
    echo "ERROR: File upload completion failed — $COMPLETE_RESPONSE"
    exit 1
fi