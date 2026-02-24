#!/bin/bash
# slack-poll.sh — Background poller for #vincent-to-nico channel
# Watches for new human messages and writes alerts for Claude Code statusline

CHANNEL_ID="C0AGM1DR5DK"  # #vincent-to-nico
POLL_INTERVAL=15
STATE_FILE="/Users/lifeos.nico/Nico/.slack-poll-state"
ALERT_FILE="/Users/lifeos.nico/Nico/.slack-poll-alert"
LOG_FILE="/Users/lifeos.nico/Nico/Logs/slack-poller.log"
ENV_FILE="/Users/lifeos.nico/Nico/Projects/slack-bot/.env"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PYTHON="/usr/bin/python3"

# Load token
SLACK_BOT_TOKEN=""
if [ -f "$ENV_FILE" ]; then
    SLACK_BOT_TOKEN=$(grep '^SLACK_BOT_TOKEN=' "$ENV_FILE" | cut -d'=' -f2)
fi
if [ -z "$SLACK_BOT_TOKEN" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') ERROR: No SLACK_BOT_TOKEN" >> "$LOG_FILE"
    exit 1
fi

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

    log "tick $POLL_COUNT"
    RESULT=$(SLACK_BOT_TOKEN="$SLACK_BOT_TOKEN" CHANNEL_ID="$CHANNEL_ID" LAST_TS="$LAST_TS" \
        "$PYTHON" "$SCRIPT_DIR/slack-poll-check.py" 2>>"$LOG_FILE")
    PY_EXIT=$?
    FIRST_LINE=$(echo "$RESULT" | head -1)
    log "tock $POLL_COUNT ($FIRST_LINE)"

    if [ $PY_EXIT -ne 0 ]; then
        log "WARN: poll failed (exit $PY_EXIT)"
        sleep "$POLL_INTERVAL"
        continue
    fi

    case "$FIRST_LINE" in
        RATELIMITED)
            log "WARN: Rate limited, backing off 60s"
            sleep 60
            continue
            ;;
        OK)
            ;;
        TS:*)
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

    sleep "$POLL_INTERVAL"
done
