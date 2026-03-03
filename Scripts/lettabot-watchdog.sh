#!/usr/bin/env bash
set -euo pipefail

LOG_FILE="/Users/lifeos.nico/Nico/Logs/lettabot.log"
OUT_LOG="/Users/lifeos.nico/Nico/Logs/lettabot-watchdog.log"
AGENT_STATE="/Users/lifeos.nico/Nico/lettabot/lettabot/lettabot-agent.json"
LETTABOT_PLIST="/Users/lifeos.nico/Library/LaunchAgents/com.nico.lettabot.plist"
LETTABOT_LABEL="com.nico.lettabot"

STAMP() { date '+%Y-%m-%d %H:%M:%S'; }

if [[ ! -f "$LOG_FILE" ]]; then
  echo "[$(STAMP)] watchdog: missing log file: $LOG_FILE" >> "$OUT_LOG"
  exit 0
fi

# Look at the most recent tail only to avoid slow scans.
TAIL="$(tail -n 350 "$LOG_FILE" 2>/dev/null || true)"

# Detect known stuck states.
# 1) Approval block
# 2) Conflict: another request processed / waiting for approval
# 3) Repeated API timeouts / llm_api_error loops
if echo "$TAIL" | grep -qE 'Pending approval detected|waiting for approval|PENDING_APPROVAL|CONFLICT: Cannot send a new message'; then
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
  exit 0
fi

# If we get here, we think it's stuck.
echo "[$(STAMP)] watchdog: detected stuck state ($REASON)" >> "$OUT_LOG"

# Backup and clear conversationId (this forces a fresh conversation thread).
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
  echo "[$(STAMP)] watchdog: cleared conversationId (backup: $BAK)" >> "$OUT_LOG"
else
  echo "[$(STAMP)] watchdog: missing agent state file: $AGENT_STATE" >> "$OUT_LOG"
fi

# Restart LettaBot
launchctl bootout "gui/$(id -u)/$LETTABOT_LABEL" 2>/dev/null || true
sleep 2
launchctl bootstrap "gui/$(id -u)" "$LETTABOT_PLIST"

echo "[$(STAMP)] watchdog: restarted $LETTABOT_LABEL" >> "$OUT_LOG"
