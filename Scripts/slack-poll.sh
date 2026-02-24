#!/bin/bash
# slack-poll.sh — Background poller for #chief-of-staff channel
# Watches for new human messages and writes alerts for Claude Code statusline
# Designed to run as a LaunchAgent (KeepAlive)

set -u

CHANNEL_ID="C0AGDT3GMUJ"  # #chief-of-staff
POLL_INTERVAL=15
STATE_FILE="$HOME/Nico/.slack-poll-state"
ALERT_FILE="$HOME/Nico/.slack-poll-alert"
LOG_FILE="$HOME/Nico/Logs/slack-poller.log"
ENV_FILE="$HOME/Nico/Projects/slack-bot/.env"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Load token
if [ -f "$ENV_FILE" ]; then
    SLACK_BOT_TOKEN=$(grep '^SLACK_BOT_TOKEN=' "$ENV_FILE" | cut -d'=' -f2)
fi
if [ -z "${SLACK_BOT_TOKEN:-}" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') ERROR: No SLACK_BOT_TOKEN" >> "$LOG_FILE"
    exit 1
fi

# Initialize state file with current timestamp if missing
if [ ! -f "$STATE_FILE" ]; then
    # Use current time so we don't alert on old messages
    printf "%.6f" "$(date +%s)" > "$STATE_FILE"
fi

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$LOG_FILE"
}

POLL_COUNT=0

log "Poller started (PID $$)"

while true; do
    POLL_COUNT=$((POLL_COUNT + 1))
    LAST_TS=$(cat "$STATE_FILE" 2>/dev/null || echo "0")

    # Fetch messages newer than last seen
    RESPONSE=$(curl -s -m 10 \
        -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
        "https://slack.com/api/conversations.history?channel=$CHANNEL_ID&oldest=$LAST_TS&limit=10" 2>/dev/null) || {
        log "WARN: curl failed"
        sleep "$POLL_INTERVAL"
        continue
    }

    # Check for rate limiting
    if echo "$RESPONSE" | python3 -c "
import sys, json
d = json.load(sys.stdin)
if d.get('error') == 'ratelimited':
    sys.exit(2)
if not d.get('ok'):
    print(d.get('error','unknown'), file=sys.stderr)
    sys.exit(1)
sys.exit(0)
" 2>/dev/null; then
        : # OK
    else
        EXIT_CODE=$?
        if [ "$EXIT_CODE" -eq 2 ]; then
            log "WARN: Rate limited, backing off 60s"
            sleep 60
            continue
        else
            log "WARN: API error"
            sleep "$POLL_INTERVAL"
            continue
        fi
    fi

    # Process new human messages (skip bot messages)
    RESULT=$(echo "$RESPONSE" | SLACK_BOT_TOKEN="$SLACK_BOT_TOKEN" python3 -c "
import sys, json, os, urllib.request

data = json.load(sys.stdin)
msgs = data.get('messages', [])
if not msgs:
    sys.exit(0)

token = os.environ.get('SLACK_BOT_TOKEN', '')
new_ts = '0'
human_msgs = []

for msg in msgs:
    ts = msg.get('ts', '0')
    if float(ts) > float(new_ts):
        new_ts = ts
    # Skip bot messages (have bot_id or subtype)
    if msg.get('bot_id') or msg.get('subtype'):
        continue
    uid = msg.get('user', '?')
    text = msg.get('text', '')[:200]
    # Resolve username
    try:
        req = urllib.request.Request(
            f'https://slack.com/api/users.info?user={uid}',
            headers={'Authorization': f'Bearer {token}'}
        )
        resp = json.loads(urllib.request.urlopen(req).read())
        name = resp.get('user',{}).get('real_name', uid)
    except:
        name = uid
    human_msgs.append(f'{name}: {text}')

# Output: first line is new_ts, rest are messages
print(new_ts)
for m in human_msgs:
    print(m)
" 2>/dev/null) || {
        log "WARN: Python processing failed"
        sleep "$POLL_INTERVAL"
        continue
    }

    if [ -n "$RESULT" ]; then
        NEW_TS=$(echo "$RESULT" | head -1)
        MESSAGES=$(echo "$RESULT" | tail -n +2)

        # Update state if we got a newer timestamp
        if [ -n "$NEW_TS" ] && [ "$NEW_TS" != "0" ]; then
            echo "$NEW_TS" > "$STATE_FILE"
        fi

        # If there are human messages, alert
        if [ -n "$MESSAGES" ]; then
            log "NEW: $MESSAGES"
            # Write alert file for statusline
            echo "$MESSAGES" > "$ALERT_FILE"
            # Post to #alerts
            "$SCRIPT_DIR/slack-post.sh" "#alerts" "📨 New #chief-of-staff message: $MESSAGES" 2>/dev/null &
        fi
    fi

    # Heartbeat every 20 cycles (~5 min)
    if [ $((POLL_COUNT % 20)) -eq 0 ]; then
        log "heartbeat: $POLL_COUNT polls, last_ts=$LAST_TS"
    fi

    sleep "$POLL_INTERVAL"
done
