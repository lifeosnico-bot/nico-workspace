#!/bin/bash
# slack-read.sh — Read recent messages from a Slack channel
# Usage: ./slack-read.sh "#channel" [count]
# Returns messages in chronological order

ENV_FILE="$HOME/Nico/Projects/slack-bot/.env"

if [ -f "$ENV_FILE" ]; then
    SLACK_BOT_TOKEN=$(grep '^SLACK_BOT_TOKEN=' "$ENV_FILE" | cut -d'=' -f2)
fi

if [ -z "$SLACK_BOT_TOKEN" ]; then
    echo "ERROR: SLACK_BOT_TOKEN not found"
    exit 1
fi

CHANNEL="${1:-#ceo-desk}"
COUNT="${2:-10}"

# Channel name → ID map
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
else
    CHANNEL_ID="$CHANNEL"
fi

if [ -z "$CHANNEL_ID" ]; then
    echo "ERROR: Unknown channel $CHANNEL"
    exit 1
fi

curl -s -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
    "https://slack.com/api/conversations.history?channel=$CHANNEL_ID&limit=$COUNT" \
    | SLACK_BOT_TOKEN="$SLACK_BOT_TOKEN" python3 -c "
import sys, json, os, urllib.request

data = json.load(sys.stdin)
if not data.get('ok'):
    print('ERROR:', data.get('error'))
    sys.exit(1)

# Resolve user IDs to names (cache)
token = os.environ.get('SLACK_BOT_TOKEN','')
user_cache = {}
def get_username(uid):
    if uid in user_cache:
        return user_cache[uid]
    try:
        req = urllib.request.Request(
            f'https://slack.com/api/users.info?user={uid}',
            headers={'Authorization': f'Bearer {token}'}
        )
        resp = json.loads(urllib.request.urlopen(req).read())
        name = resp.get('user',{}).get('real_name', resp.get('user',{}).get('name', uid))
        user_cache[uid] = name
        return name
    except:
        return uid

msgs = data.get('messages', [])
for msg in reversed(msgs):
    user = msg.get('user', msg.get('bot_id', '?'))
    username = get_username(user) if not msg.get('bot_id') else 'Nico (bot)'
    text = msg.get('text', '').replace('<@' + user + '>', '@' + username)
    ts = msg.get('ts', '')
    from datetime import datetime
    time_str = datetime.fromtimestamp(float(ts)).strftime('%H:%M') if ts else '??:??'
    print(f'[{time_str}] {username}: {text}')
"
