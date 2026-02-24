---
title: "Task Board"
type: dashboard
status: active
created: 2026-02-23
source: nico
---

# Task Board
**Last updated**: 2026-02-23 21:30 EST | **Updated by**: Nico (Claude Code) | **Session**: CC-9

_This file is rewritten by Nico at every session start and end. Do not edit manually._
_Source of truth: [[status]] · Full plans: [[2026-02-23_task-architecture-plan]]_

---

## 🔴 P1 — Critical

| Owner | Task | Status |
|---|---|---|
| [N] | Build background Slack polling (#chief-of-staff) | Next up |
| [V] | Telegram bot token rotation (BotFather /revoke) | 🔴 Security — do ASAP |
| [V] | Final comms decision | Partially done |

---

## 🟠 P2 — This Week

| Owner | Task | Status |
|---|---|---|
| [N] | Phase 0E — metadata standards enforcement | Queued |
| [V] | Obsidian Phase 2 (sign in, sync, CLI) | Waiting on Vincent |
| [V] | 1Password setup | Waiting on Vincent |

---

## 👤 Vincent's Actions

1. 🔴 Telegram: open @BotFather → `/revoke` → get new token → paste to Nico
2. Obsidian: sign in, enable Sync, register CLI (Nico preps, Vincent flips switches)
3. [1Password](https://1password.com) — create account, install desktop app
4. Rename Slack bot from "Nico" to "Slacky" (App Manifest → display_name)

---

## 📥 Inbox

**26 items** — see [[status#📥 Inbox — Unprocessed Captures|Inbox in status.md]]

---

## ✅ Completed This Session (CC-9)

- Slack two-way setup: workspace "Cabinet Agent", 7 channels created
- claude-code-slack-bot cloned, configured, built (Node 22, SDK v1.0.88)
- LaunchAgent for auto-start on boot
- slack-post.sh + slack-read.sh scripts for Nico channel access
- Alert scripts (context-monitor, permission-alert) wired to Slack #alerts
- Auto-default cwd fix (no manual cwd needed after bot restart)
- Node 25 SDK bug filed (github.com/mpociot/claude-code-slack-bot/issues/21)
- Vincent connected from phone — two-way comms verified via #chief-of-staff
