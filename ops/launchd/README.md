# launchd (Nico)

This folder tracks sanitized `LaunchAgent` plists and install/uninstall scripts.

## Install

Run:
- `./install.sh`

## Uninstall

Run:
- `./uninstall.sh`

## Notes
- Plists are copied into `~/Library/LaunchAgents/`.
- These jobs are user-scoped (`gui/<uid>`), not system daemons.
