# Nico Operators Manual (v1)

Last Updated: 2026-02-22 16:35 EST | Updated by: Claude Code | Version: v1

## A) Daily Operations
### A1. Start of day
1) Open Telegram → send `ping`.
2) If no reply → open `/Users/lifeos.nico/Nico/911.md` and follow steps.
3) Open `~/Nico/Memory/status.md` for current priorities.

### A2. During the day
- Use Telegram for commands and updates.
- Keep work inside `~/Nico/` only.
- If a new rule or preference appears, tell Nico in one sentence.

### A3. End of day
- Ask Nico for current list status.
- Ensure any blockers are noted in status.md.

## B) Emergency Procedures
### B1. Telegram unresponsive
Follow `/Users/lifeos.nico/Nico/911.md`.

### B2. Can’t reach the M1
Use Claude iOS app → Claude Code (cloud). This is guidance only (no M1 access).

### B3. Restore live logs (optional)
Open Terminal and run:
```
tail -f ~/Nico/Logs/lettabot.log
```

## C) Recovery After Disconnection
1) Confirm only one LettaBot instance is running:
```
pgrep -fl "lettabot"
```
2) Send `ping` in Telegram.

## D) Bot Map (always the same)
- **Nico** = the agent (same ID as Memo)
- **Memo** = legacy name for Nico (same agent)
- **LettaBot** = Telegram bridge only (not an agent)
- **Claude Code** = interactive dev assistant (separate)

## E) Primary Interfaces
- **Telegram (LettaBot on M1)** = real Nico with M1 access.
- **Claude iOS / claude.ai/code** = cloud fallback only.
- **Letta web chat** = cloud fallback only.

## F) File System Map (Quick)
- `/Users/lifeos.nico/Nico/Memory/status.md`
- `/Users/lifeos.nico/Nico/Memory/decisions.md`
- `/Users/lifeos.nico/Nico/911.md`
- `/Users/lifeos.nico/Nico/Logs/`
- `/Users/lifeos.nico/Nico/Logs/Screenshots/`

## F) Slack Setup (Required)
1) slack.com/create → create workspace
2) api.slack.com/apps → Create App → From scratch
3) Add Bot User
4) OAuth scopes: `chat:write`, `channels:read`, `channels:history`
5) Install to workspace → get Bot Token

## G) Remote Access (Phone)
### G1. Claude Code iOS
- Start a remote session (cloud). No M1 access.

### G2. SSH via Termius + Tailscale
- Install Tailscale + Termius on iPhone.
- Add Termius public key to M1 `~/.ssh/authorized_keys`.
- Connect to `100.87.182.78` as `lifeos.nico`.

## H) Maintenance
- Weekly: `ping` test
- Weekly: check `status.md` for stale items
- Use `911.md` for any disruptions
