# Task Board
**Last updated**: 2026-02-23 12:30 EST | **Updated by**: Nico (Claude Code) | **Session**: CC-5 handoff

_This file is rewritten by Nico at every session start and end. Do not edit manually._
_Source of truth: [[status]] · Full plans: [[2026-02-23_task-architecture-plan]]_

---

## 🔴 P1 — Critical

| Owner | Task | Status |
|---|---|---|
| [N] | 50% context window alert hook | Next up |
| [V] | Telegram bot token rotation (BotFather /revoke) | 🔴 Security — do ASAP |
| [V] | Create Slack workspace + bot token | Waiting on Vincent |
| [V] | Final comms decision | Partially done |

---

## 🟠 P2 — This Week

| Owner | Task | Status |
|---|---|---|
| [N] | Phase 0E — metadata standards enforcement | Queued |
| [N] | LettaBot Telegram poller fix | Queued |
| [V] | Obsidian Phase 2 (sign in, sync, plugins) | Waiting on Vincent |
| [V] | 1Password setup | Waiting on Vincent |

---

## 👤 Vincent's Actions

1. 🔴 Telegram: open @BotFather → `/revoke` → get new token → paste to Nico
2. Create Slack workspace → copy bot token → paste to Nico in terminal
3. Obsidian: sign in, enable Sync, enable plugins (Nico preps, Vincent flips switches)
4. [1Password](https://1password.com) — create account, install desktop app

---

## 📥 Inbox

**25 items** (8 closed, 23 remaining) — see [[status#📥 Inbox — Unprocessed Captures|Inbox in status.md]]

---

## ✅ Completed Recently (CC-5)

- Full status.md audit — 13+ stale items marked complete
- 31 inbox items triaged (8 closed, 23 assigned P/owner)
- PR #6 merged (all CC-3/4/5 work on master)
- Peekaboo MCP disabled (saves 9.8k tokens/session)
- `/peekaboo` skill built (toggle on/off)
- `atl` rule fixed — inbox write only, no execution
- Vault `.trash/` configured (trashOption: local)
- Alert script, /handoff, task-board, vault housekeeping, Phase 1 Obsidian all confirmed done
