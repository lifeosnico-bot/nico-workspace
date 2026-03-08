#!/usr/bin/env bash
set -euo pipefail

LA_DIR="/Users/lifeos.nico/Library/LaunchAgents"
UID="$(id -u)"

uninstall_label() {
  local label="$1"
  /bin/launchctl bootout "gui/${UID}/${label}" 2>/dev/null || true
  rm -f "$LA_DIR/${label}.plist" || true
}

uninstall_label "com.nico.overnight-runner"
uninstall_label "com.nico.nighttime-report"
uninstall_label "com.nico.phase0g-status-ping"
uninstall_label "com.nico.heartbeat-healthcheck"

# Optional
uninstall_label "com.nico.wizard-status-ping"

printf "Uninstalled launch agents from %s\n" "$LA_DIR"
