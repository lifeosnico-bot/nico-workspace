#!/bin/bash
set -euo pipefail

# Silent health-check. Only alerts on failure.

STATE_DIR="/Users/lifeos.nico/Nico/Logs"

# LettaBot credentials (read from local config; do NOT print)
LETTA_CONFIG="/Users/lifeos.nico/Nico/lettabot/lettabot/lettabot.yaml"
TELEGRAM_BOT_TOKEN="$(/usr/bin/awk '/^[[:space:]]*token:[[:space:]]*/{print $2; exit}' "$LETTA_CONFIG")"
LETTABOT_API_KEY="$(/usr/bin/awk '/^[[:space:]]*apiKey:[[:space:]]*/{print $2; exit}' "$LETTA_CONFIG")"

ALERT() {
  local msg="$1"
  TELEGRAM_BOT_TOKEN="$TELEGRAM_BOT_TOKEN" LETTABOT_API_KEY="$LETTABOT_API_KEY" /opt/homebrew/bin/npm exec lettabot-message -- send --text "$msg" --channel telegram --chat "8385420240" >/dev/null 2>&1 || true
}

check_keepalive() {
  local label="$1"
  local line
  line="$(launchctl list 2>/dev/null | /usr/bin/grep -E "[[:space:]]${label}$" || true)"
  if [ -z "$line" ]; then
    return 2
  fi

  # launchctl list columns: PID  STATUS  LABEL
  # For keepalive daemons we expect a PID.
  local pid
  pid="$(echo "$line" | /usr/bin/awk '{print $1}')"
  if [ "$pid" = "-" ]; then
    return 3
  fi
  return 0
}

FAIL=0

if ! check_keepalive "com.nico.lettabot"; then
  FAIL=1
  ALERT "Heartbeat alert: LettaBot is not running"
fi

# Slack poller is optional but helpful. Alert if it is down.
if ! check_keepalive "com.nico.slack-poller"; then
  FAIL=1
  ALERT "Heartbeat alert: Slack poller is not running"
fi

# Keep a tiny breadcrumb only on failures
if [ "$FAIL" -ne 0 ]; then
  /bin/mkdir -p "$STATE_DIR"
  echo "$(/bin/date '+%Y-%m-%d %H:%M %Z') heartbeat failure" >> "$STATE_DIR/heartbeat-healthcheck.log" || true
  exit 1
fi

exit 0
