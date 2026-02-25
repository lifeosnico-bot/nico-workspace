---
title: "Vault Contract — How Agents Use Obsidian"
date: 2026-02-25
tags: [vault, process, agents]
type: process
status: active
source: nico
---

# Vault Contract — How Agents Use Obsidian

## Purpose
Prevent agent drift. Different agents can think differently, but they must leave artifacts in the same places, in the same format, with the same rules.

## The Only 5 Notes Vincent Needs Daily
1. `[[00-dashboard/home|Home dashboard]]`
2. `[[00-dashboard/status|Status]]`
3. `[[00-dashboard/daily/2026-02-25_morning-report|Morning Report (today)]]`
4. `[[00-dashboard/daily/2026-02-25_nighttime-report|Nighttime Report (today)]]`
5. `[[00-dashboard/daily/2026-02-24_eod-wrapup|EOD Wrap Up (yesterday)]]`

Everything else exists for audit trail + agent handoffs.

## Canonical Artifact Lanes (No Freelancing)
- **Backlog / priorities:** `00-dashboard/status.md`
- **Session notes (append-only):** `00-dashboard/llm-sessions/`
- **Daily reports:** `00-dashboard/daily/`
- **Templates:** `05-templates/`
- **Video research:** `50-clippings/youtube/`
- **Project work:** `10-projects/<project>/`
- **Unsorted:** `01-inbox/` (if unsure, put it here)

## Session Note Rule (When Required)
Write a session note at the end of any work block that changed state:
- code/config/automation changed
- important file created/moved/renamed
- decision made
- blocker discovered
- access/security/integrations changed

## Naming Rules (Keep It Searchable)
- Daily reports: `YYYY-MM-DD_morning-report.md`, `YYYY-MM-DD_nighttime-report.md`, `YYYY-MM-DD_eod-wrapup.md`
- Video research: `YYYY-MM-DD_<topic>_youtube.md`
- Avoid duplicate concepts across folders; link instead.

## Coordination Rules (Prevent Collisions)
- Active work lives in `status.md`.
- When an item becomes “do it now”, it must be in `status.md` and claimed.
- One work item -> one branch/PR.

## Defaults
- If an agent is unsure where a thing belongs: put it in `01-inbox/`.
- If a thing is repeatable: create/use a template in `05-templates/`.
