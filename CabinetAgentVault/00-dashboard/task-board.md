---
title: "Task Board"
type: dashboard
status: active
created: 2026-02-23
modified: 2026-03-08
source: nico
---

# Task Board
**Last updated**: 2026-03-08 15:30 EST | **Updated by**: Nico (Claude Code) | **Session**: CC-12

_This file is rewritten by Nico at every session start and end. Do not edit manually._
_Source of truth: [[status]] · Central manifest: [[ops-index]]_

---

## P1 — Critical

| Owner | Task | Status |
|---|---|---|
| [N] | Fix permissions issues with Telegram and Nico | Open |
| [N] | Overnight runner scaffold + queue + schedule | PR #14 open — waiting merge |
| [V] | Telegram bot token rotation (BotFather /revoke) | Waiting on Vincent |

---

## P2 — This Week

| Owner | Task | Status |
|---|---|---|
| [N] | Phase 0E — metadata standards enforcement | Next up |
| [V] | Obsidian Phase 2 (sign in, sync, CLI) | Waiting on Vincent |
| [V] | 1Password setup | Waiting on Vincent |

---

## Vincent's Actions

1. Telegram: open @BotFather → `/revoke` → get new token → paste to Nico
2. Rename Slack bot from "Nico" to "Slacky" (Slack app settings)
3. Obsidian: sign in, enable Sync, register CLI
4. 1Password — create account, install desktop app

---

## Inbox

**~25 items** — see [[status#Inbox — Unprocessed Captures|Inbox in status.md]]

---

## Completed This Session (CC-12)

- Single-source-of-truth refactor: session-log.md → auto-generated session-index.md
- Created ops-index.md (central manifest for all canonical data sources)
- Updated /handoff skill (removed manual log step, added index regeneration)
- Updated CLAUDE.md and status.md references
