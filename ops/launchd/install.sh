#!/usr/bin/env bash
set -euo pipefail

LA_DIR="/Users/lifeos.nico/Library/LaunchAgents"
SRC_DIR="/Users/lifeos.nico/Nico/ops/launchd"
UID="$(id -u)"

mkdir -p "$LA_DIR"

install_one() {
  local name="$1"
  cp "$SRC_DIR/$name" "$LA_DIR/$name"
  /usr/bin/plutil -lint "$LA_DIR/$name" >/dev/null
  /bin/launchctl bootout "gui/${UID}/$(/usr/libexec/PlistBuddy -c 'Print :Label' "$LA_DIR/$name")" 2>/dev/null || true
  /bin/launchctl bootstrap "gui/${UID}" "$LA_DIR/$name"
}

install_one "com.nico.overnight-runner.plist"
install_one "com.nico.nighttime-report.plist"
install_one "com.nico.phase0g-status-ping.plist"
install_one "com.nico.heartbeat-healthcheck.plist"

# Optional (wizard pings)
if [ -f "$SRC_DIR/com.nico.wizard-status-ping.plist" ]; then
  install_one "com.nico.wizard-status-ping.plist"
fi

# Kickstart lightweight ones
/bin/launchctl kickstart -k "gui/${UID}/com.nico.phase0g-status-ping" 2>/dev/null || true
/bin/launchctl kickstart -k "gui/${UID}/com.nico.heartbeat-healthcheck" 2>/dev/null || true

printf "Installed launch agents into %s\n" "$LA_DIR"
