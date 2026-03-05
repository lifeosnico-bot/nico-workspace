# Overnight Runner (nico-workspace)

**Source of truth:** `ops/overnight/queue.json`

**Purpose:** run one queued job per night, safely.

## Non-negotiables
- Never commit directly to `master`
- Always branch → push → PR
- No secrets in logs or PR bodies

## Schedule
Default: daily at 02:00 local time (America/New_York)

## LaunchAgent
Template: `ops/overnight/com.nico.overnight-runner.plist`

Install step (manual): copy to `~/Library/LaunchAgents/` and `launchctl load`.
