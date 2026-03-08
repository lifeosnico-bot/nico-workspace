#!/usr/bin/env bash
set -euo pipefail

LOG_FILE="/Users/lifeos.nico/Nico/Logs/lettabot.log"
OUT_LOG="/Users/lifeos.nico/Nico/Logs/lettabot-watchdog.log"
AGENT_STATE="/Users/lifeos.nico/Nico/lettabot/lettabot/lettabot-agent.json"
LETTABOT_PLIST="/Users/lifeos.nico/Library/LaunchAgents/com.nico.lettabot.plist"
LETTABOT_LABEL="com.nico.lettabot"
API_PORT="8088"
STATE_FILE="/Users/lifeos.nico/Nico/Logs/lettabot-watchdog.state"
RESTART_COOLDOWN_SECS=300
# Number of consecutive restarts before clearing conversationId
CLEAR_CONV_THRESHOLD=3

STAMP() { date '+%Y-%m-%d %H:%M:%S'; }

if [[ ! -f "$LOG_FILE" ]]; then
  echo "[$(STAMP)] watchdog: missing log file: $LOG_FILE" >> "$OUT_LOG"
  exit 0
fi

# Look at the most recent tail only to avoid slow scans.
TAIL="$(tail -n 350 "$LOG_FILE" 2>/dev/null || true)"

# Load persistent state (last restart timestamp + consecutive restart count)
LAST_RESTART_TS=0
CONSECUTIVE_RESTARTS=0
if [[ -f "$STATE_FILE" ]]; then
  LAST_RESTART_TS="$(head -1 "$STATE_FILE" 2>/dev/null || echo 0)"
  CONSECUTIVE_RESTARTS="$(sed -n '2p' "$STATE_FILE" 2>/dev/null || echo 0)"
fi
if ! [[ "$LAST_RESTART_TS" =~ ^[0-9]+$ ]]; then
  LAST_RESTART_TS=0
fi
if ! [[ "$CONSECUTIVE_RESTARTS" =~ ^[0-9]+$ ]]; then
  CONSECUTIVE_RESTARTS=0
fi

# Detect known stuck states.
# 1) Approval block that is actually blocking delivery
# 2) Conflict: cannot send a new message
# 3) Repeated API timeouts / llm_api_error loops
#
# NOTE:
# "Pending approval detected at session startup" is an *expected* recovery path.
# Treating it as "stuck" causes a restart loop where the bot gets killed before
# it can finish recovering and reply.

CONFLICT_COUNT=$(echo "$TAIL" | grep -E 'CONFLICT: Cannot send a new message' | wc -l | tr -d ' ')
APPROVAL_COUNT=$(echo "$TAIL" | grep -E 'waiting for approval|PENDING_APPROVAL' | wc -l | tr -d ' ')

# Require stronger evidence before restarting for conflict/approval paths.
# Single stale conflict lines in the log tail should not trigger a reboot.
if [[ "${CONFLICT_COUNT:-0}" -ge 2 ]] || [[ "${APPROVAL_COUNT:-0}" -ge 3 ]]; then
  REASON="approval_or_conflict"
elif echo "$TAIL" | grep -qE 'llm_api_error|APIConnectionTimeoutError|Request timed out'; then
  # Only treat as stuck if we see it multiple times in the tail
  COUNT=$(echo "$TAIL" | grep -E 'llm_api_error|APIConnectionTimeoutError|Request timed out' | wc -l | tr -d ' ')
  if [[ "${COUNT:-0}" -ge 3 ]]; then
    REASON="timeouts"
  else
    exit 0
  fi
else
  # No stuck state detected — reset consecutive restart counter
  if [[ "$CONSECUTIVE_RESTARTS" -gt 0 ]]; then
    echo "$LAST_RESTART_TS" > "$STATE_FILE"
    echo "0" >> "$STATE_FILE"
  fi
  exit 0
fi

# If we get here, we think it's stuck.
echo "[$(STAMP)] watchdog: detected stuck state ($REASON)" >> "$OUT_LOG"

# Cooldown guard to prevent restart thrash loops.
NOW_TS=$(date +%s)
if (( NOW_TS - LAST_RESTART_TS < RESTART_COOLDOWN_SECS )); then
  REMAINING=$((RESTART_COOLDOWN_SECS - (NOW_TS - LAST_RESTART_TS)))
  echo "[$(STAMP)] watchdog: cooldown active (${REMAINING}s remaining), skipping restart" >> "$OUT_LOG"
  exit 0
fi

# Increment consecutive restart counter
CONSECUTIVE_RESTARTS=$((CONSECUTIVE_RESTARTS + 1))

# Only clear conversationId after multiple consecutive restarts.
# This preserves tool context on transient failures while still recovering
# from genuinely stuck conversations.
if [[ "$CONSECUTIVE_RESTARTS" -ge "$CLEAR_CONV_THRESHOLD" ]]; then
  if [[ -f "$AGENT_STATE" ]]; then
    BAK="$AGENT_STATE.bak-$(date '+%Y%m%d-%H%M%S')"
    cp "$AGENT_STATE" "$BAK"
    python3 - <<'PY'
import json
p='/Users/lifeos.nico/Nico/lettabot/lettabot/lettabot-agent.json'
obj=json.load(open(p))
for name in list(obj.get('agents', {}).keys()):
    obj['agents'][name].pop('conversationId', None)
json.dump(obj, open(p, 'w'), indent=2)
PY
    echo "[$(STAMP)] watchdog: cleared conversationId after $CONSECUTIVE_RESTARTS consecutive restarts (backup: $BAK)" >> "$OUT_LOG"
  fi
  # Reset counter after clearing
  CONSECUTIVE_RESTARTS=0
else
  echo "[$(STAMP)] watchdog: restart $CONSECUTIVE_RESTARTS/$CLEAR_CONV_THRESHOLD (preserving conversationId)" >> "$OUT_LOG"
fi

# Restart LettaBot
launchctl bootout "gui/$(id -u)/$LETTABOT_LABEL" 2>/dev/null || true
sleep 2

# Kill any orphaned letta-code CLI subprocesses that hold resources
pkill -f "letta-code.*--conversation" 2>/dev/null || true
sleep 1

# Wait for the API port to be released to avoid EADDRINUSE restart loops.
for _ in {1..15}; do
  if ! lsof -nP -iTCP:${API_PORT} -sTCP:LISTEN >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

# Last resort: if still listening, kill the lingering main process.
if lsof -nP -iTCP:${API_PORT} -sTCP:LISTEN >/dev/null 2>&1; then
  pkill -f "/Users/lifeos.nico/Nico/lettabot/lettabot/dist/main.js" 2>/dev/null || true
  sleep 3
fi

launchctl bootstrap "gui/$(id -u)" "$LETTABOT_PLIST"

# Persist restart timestamp + consecutive restart count
echo "$NOW_TS" > "$STATE_FILE"
echo "$CONSECUTIVE_RESTARTS" >> "$STATE_FILE"

echo "[$(STAMP)] watchdog: restarted $LETTABOT_LABEL (consecutive: $CONSECUTIVE_RESTARTS)" >> "$OUT_LOG"
