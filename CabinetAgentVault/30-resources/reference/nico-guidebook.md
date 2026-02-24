---
title: "Nico Guidebook"
type: reference
status: active
created: 2026-02-22
source: nico
tags: [nico, operations, guidebook, onboarding]
---

# Nico Guidebook — Setup, Operation, Maintenance

Last Updated: 2026-02-22 16:27 EST | Updated by: Claude Code | Version: v1

## 1) What Nico Is
- **Nico** = the persistent CoS agent.
- **LettaBot** = the Telegram bridge on the M1.
- **Claude Code iOS/Web** = cloud sessions (no M1 access).

## 2) Core Surfaces (Use These)
### 2.1 Primary Operations
- **Telegram (LettaBot on M1)** — primary ops channel.

### 2.2 Emergency / Fallback
- **M1 Terminal** — direct control if Telegram fails.
- **Claude iOS app → Claude Code** — cloud fallback (no M1 access).

## 3) Start-of-Day Checklist
1) Confirm Telegram responds: send `ping`.
2) If no reply: use `/Users/lifeos.nico/Nico/911.md`.
3) Check status: `~/Nico/Memory/status.md`.

## 4) Emergency (Break Glass)
- File: `/Users/lifeos.nico/Nico/911.md`

## 5) Memory & Behavior Rules
### 5.1 What Persists
- **Memory**: preferences, rules, decisions, workflow state.
- **Behavior rules**: stored in memory and applied every reply.

### 5.2 Key Behavior Rules (Current)
- No “what’s next?” unless Vincent prompts.
- Avoid “you’re right” or agreement fillers.
- Maintain a single numbered list while active.
- Keep replies short unless asked for detail.

## 6) How to Add Rules
1) Tell Nico the rule in one sentence.
2) Nico writes it to memory and confirms.

## 7) File Locations (Know These)
- **Status**: `/Users/lifeos.nico/Nico/Memory/status.md`
- **Decisions**: `/Users/lifeos.nico/Nico/Memory/decisions.md`
- **Emergency**: `/Users/lifeos.nico/Nico/911.md`
- **Logs**: `/Users/lifeos.nico/Nico/Logs/`
- **Screenshots**: `/Users/lifeos.nico/Nico/Logs/Screenshots/`

## 8) Slack Setup (Required for Next Phase)
1) Create workspace at slack.com/create
2) Create Slack App at api.slack.com/apps
3) Add Bot User
4) OAuth scopes: `chat:write`, `channels:read`, `channels:history`
5) Install to workspace (token is created)

## 9) Remote Access (Phone)
- **Claude Code iOS**: cloud fallback (no M1 access)
- **Termius + Tailscale**: SSH into M1 from iPhone

## 10) Maintenance Cadence
- Weekly: confirm LettaBot running (ping test)
- Weekly: check `status.md` for stale items
- When issues arise: use `911.md`
