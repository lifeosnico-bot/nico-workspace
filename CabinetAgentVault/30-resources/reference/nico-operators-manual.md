---
title: "Nico Operators Manual"
type: reference
status: active
created: 2026-02-22
modified: 2026-02-23
source: nico
tags: [nico, operations, reference, onboarding]
---

# Nico Operators Manual

## A) What Nico Is
- **Nico** = the persistent CoS agent (Claude Code on M1)
- **LettaBot** = the Telegram bridge on the M1 (not an agent itself)
- **Memo** = legacy name for Nico's Letta memory agent (same agent ID)
- **Claude Code iOS/Web** = cloud sessions (no M1 access)

## B) Daily Operations

### B1. Start of day
1. Confirm Telegram responds: send `ping`
2. If no reply → open [[../../911]] and follow steps
3. Check status: [[status]]

### B2. During the day
- Use Telegram for commands and updates
- Use `atl [description]` to add tasks from any surface
- If a new rule or preference appears, tell Nico in one sentence

### B3. End of day
- Ask Nico for current list status (`sts`)
- Ensure any blockers are noted in status.md

## C) Primary Interfaces
- **Telegram (LettaBot on M1)** = real Nico with M1 access
- **Claude Code terminal** = direct control, full access
- **Claude iOS / claude.ai/code** = cloud fallback only (no M1 access)
- **Obsidian** = vault access on any device via Sync

## D) Emergency Procedures

### D1. Telegram unresponsive
Follow `~/Nico/911.md`

### D2. Can't reach the M1
Use Claude iOS app → Claude Code (cloud). Guidance only — no M1 access.

### D3. Restore live logs
```
tail -f ~/Nico/Logs/lettabot.log
```

### D4. Check LettaBot is running
```
pgrep -fl "lettabot"
```

## E) Behavior Rules
- No "what's next?" unless Vincent prompts
- Avoid "you're right" or agreement fillers
- Keep replies short unless asked for detail
- `atl` = inbox write only — never execute, research, or decompose

## F) Key File Locations
- **Status**: [[status]] (`~/Nico/CabinetAgentVault/00-dashboard/status.md`)
- **Decisions**: `~/Nico/Memory/decisions.md`
- **Emergency**: `~/Nico/911.md`
- **Logs**: `~/Nico/Logs/`
- **Vault**: `~/Nico/CabinetAgentVault/`
- **Scripts**: `~/Nico/Scripts/`

## G) Remote Access
- **M3 → M1**: `ssh lifeos.nico@100.87.182.78`
- **iPhone → M1**: Tailscale + Termius (SSH)
- **M1 Tailscale IP**: 100.87.182.78

## H) Maintenance
- Weekly: `ping` test in Telegram
- Weekly: check status.md for stale items
- Use `911.md` for any disruptions
