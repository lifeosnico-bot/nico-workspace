#!/bin/bash
# slack-poll.sh — Background poller for #vincent-to-nico channel
# Watches for new human messages and writes alerts for Claude Code statusline
# Designed to run as a LaunchAgent (KeepAlive)

CHANNEL_ID="C0AGM1DR5DK"  # #vincent-to-nico
POLL_INTERVAL=15
STATE_FILE="$HOME/Nico/.slack-poll-state"
ALERT_FILE="$HOME/Nico/.slack-poll-alert"
LOG_FILE="$HOME/Nico/Logs/slack-poller.log"
ENV_FILE="$HOME/Nico/Projects/slack-bot/.env"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Load token
SLACK_BOT_TOKEN=""
if [ -f "$ENV_FILE" ]; then
    SLACK_BOT_TOKEN=$(grep '^SLACK_BOT_TOKEN=' "$ENV_FILE" | cut -d'=' -f2)
fi
if [ -z "$SLACK_BOT_TOKEN" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') ERROR: No SLACK_BOT_TOKEN" >> "$LOG_FILE"
    exit 1
fi

# Initialize state file with current timestamp if missing
if [ ! -f "$STATE_FILE" ]; then
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

    # Single python call: fetch, parse, return results
    RESULT=$(SLACK_BOT_TOKEN="$SLACK_BOT_TOKEN" CHANNEL_ID="$CHANNEL_ID" LAST_TS="$LAST_TS" python3 << 'PYEOF'
import os, json, urllib.request, sys

token = os.environ['SLACK_BOT_TOKEN']
channel = os.environ['CHANNEL_ID']
oldest = os.environ['LAST_TS']

try:
    url = f"https://slack.com/api/conversations.history?channel={channel}&oldest={oldest}&limit=10"
    req = urllib.request.Request(url, headers={"Authorization": f"Bearer {token}"})
    data = json.loads(urllib.request.urlopen(req, timeout=10).read())
except Exception as e:
    print(f"ERROR:fetch:{e}", file=sys.stderr)
    sys.exit(1)

if not data.get("ok"):
    err = data.get("error", "unknown")
    if err == "ratelimited":
        print("RATELIMITED")
        sys.exit(0)
    print(f"ERROR:api:{err}", file=sys.stderr)
    sys.exit(1)

msgs = data.get("messages", [])
if not msgs:
    print("OK")
    sys.exit(0)

new_ts = "0"
human_msgs = []

for msg in msgs:
    ts = msg.get("ts", "0")
    if float(ts) > float(new_ts):
        new_ts = ts
    if msg.get("bot_id") or msg.get("subtype"):
        continue
    uid = msg.get("user", "?")
    text = msg.get("text", "")[:200]
    try:
        req2 = urllib.request.Request(
            f"https://slack.com/api/users.info?user={uid}",
            headers={"Authorization": f"Bearer {token}"}
        )
        resp = json.loads(urllib.request.urlopen(req2).read())
        name = resp.get("user", {}).get("real_name", uid)
    except:
        name = uid
    human_msgs.append(f"{name}: {text}")

if human_msgs:
    print(f"NEW:{new_ts}")
    for m in human_msgs:
        print(m)
else:
    print(f"TS:{new_ts}")
PYEOF
    )
    PY_EXIT=$?

    if [ $PY_EXIT -ne 0 ]; then
        log "WARN: poll failed (exit $PY_EXIT) result='$RESULT'"
        sleep "$POLL_INTERVAL"
        continue
    fi

    FIRST_LINE=$(echo "$RESULT" | head -1)

    case "$FIRST_LINE" in
        RATELIMITED)
            log "WARN: Rate limited, backing off 60s"
            sleep 60
            continue
            ;;
        OK)
            # No new messages
            ;;
        TS:*)
            # Only bot messages, update timestamp
            echo "${FIRST_LINE#TS:}" > "$STATE_FILE"
            ;;
        NEW:*)
            NEW_TS="${FIRST_LINE#NEW:}"
            MESSAGES=$(echo "$RESULT" | tail -n +2)
            echo "$NEW_TS" > "$STATE_FILE"
            log "NEW: $MESSAGES"
            echo "$MESSAGES" > "$ALERT_FILE"
            "$SCRIPT_DIR/slack-post.sh" "#alerts" "📨 New #vincent-to-nico message: $MESSAGES" 2>/dev/null &
            ;;
    esac

    # Heartbeat every 20 cycles (~5 min)
    if [ $((POLL_COUNT % 20)) -eq 0 ]; then
        log "heartbeat: $POLL_COUNT polls, last_ts=$LAST_TS"
    fi

    sleep "$POLL_INTERVAL"
done
