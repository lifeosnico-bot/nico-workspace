---
title: "Telegram Misc List (Pending Approval)"
type: review
tags: [telegram, misc-list, triage, tasks]
status: review
created: 2026-03-04
source: nico
---

# Telegram Misc List (Pending Approval)

## Purpose
Extract *every* potentially important item from the Telegram transcript (tasks, projects, lists, suggestions, decisions, blockers) into a single reviewable list **before** merging anything into `00-dashboard/status.md`.

## How to Review (Vincent)
1. Scan Phase P1→P5.
2. For each item, confirm:
   - keep / drop
   - owner: `[N]` Nico or `[V]` Vincent
   - priority: P1–P5
3. Reply in Telegram with:
   - `approve Telegram Misc List` (or)
   - specific edits (e.g., “Move P3-2 to P1, owner Vincent”).

## Notes / Limits
- This list is reconstructed from stored Telegram-ingested history (message IDs + timestamps where available). Some outgoing Nico message IDs are not recorded; evidence is included when possible.
- Items that appear to already be implemented are marked `Status: started/done?` so you can decide whether to keep them as tracked tasks.

---

# Phase P1 — Critical reliability / unblockers

## P1 — Nico-owned [N]

1. **Stabilize Telegram responsiveness / eliminate silent gaps**
   - Subtasks:
     - Identify root causes of “no ping / disconnected / hour gap” reports.
     - Ensure watchdog + ping mechanisms work even during tool approvals/reconnects.
   - Evidence (examples):
     - Msg 1515 (2026-03-03 2:36 PM): “There is a full hour of time”
     - Msg 1565 (2026-03-03 3:53 PM): “no pings no pong for an hour”

2. **Prereqs discipline: when blocked, say “Blocked: <x>” immediately (don’t keep going silently)**
   - Evidence: Msg 1334 (2026-03-02 2:08 PM): “if there were other prerequisites… why not tell me that”

3. **Telegram crash recovery: document + automate the pending-approval/conversationId reset path**
   - Status: started (watchdog exists)
   - Evidence: Msg 30b6c185 (2026-03-02 ~4:55 PM): clear `conversationId` + restart LettaBot

## P1 — Vincent-owned [V]

1. **Confirm/complete Telegram bot token rotation**
   - Evidence: status list item + repeated references
   - (Note: needs verification on disk; do not paste the full token in chat.)

---

# Phase P2 — Process guardrails (stay on the path)

## P2 — Nico-owned [N]

1. **Enforce “single active item” rule + explicit states** (`queued / in progress / done (committed + pushed)`)
   - Status: started (used in wizard)

2. **Progress reporting rule**
   - Start ping → checkpoint pings every 10–15 min while in progress → done ping + proof snapshot
   - Evidence: Msg 1549 (2026-03-03 3:08 PM): start/progress/done expectations

3. **Completion proof**
   - After each completion, paste checklist snapshot (proof) into Telegram
   - Evidence: Msg 1542 (2026-03-03 2:47 PM): “add a screenshot of the list”

4. **Tight list discipline**
   - Keep a tight list of what’s being done + when it’s completed
   - Evidence: Msg 1377 (2026-03-02 5:16 PM): “make sure we are keeping a very tight list…”

## P2 — Vincent-owned [V]

1. **Decide: allow PRs for overnight runner or report-only**
   - Evidence: Msg 1363 (2026-03-02 5:04 PM): “allow prs”

2. **Decide: should we do both (cron and launchd, or two lanes) — clarify what “both” means**
   - Evidence: Msg 1363 (2026-03-02 5:04 PM): “Should we do both”

---

# Phase P3 — Overnight autonomy build-out (not just pings)

## P3 — Nico-owned [N]

1. **Overnight runner scaffolding + queue (repo-based)**
   - Status: started (exists; currently report-only)

2. **Definition-of-done gates** for overnight jobs

3. **Report spec enforcement** (morning/night reports cannot omit required sections)

4. **Auth alignment checks** (LETTA_API_KEY env, lettabot.yaml apiKey, memfs git)

5. **Memory sync health checks** (git status/pull/push + alert)

6. **Log rotation + disk space monitoring**

## P3 — Vincent-owned [V]

1. **Choose the overnight runner fire time** (default discussed: 02:00 local)
   - Evidence: Msg 1376 (2026-03-02 5:14 PM)

---

# Phase P4 — Reporting + docs consolidation

## P4 — Nico-owned [N]

1. **Consolidate all extracted items into a single approved flow (after your approval)**
   - Merge approved items into `00-dashboard/status.md` and pinned memory where appropriate.

2. **Write/maintain the canonical manual(s)**
   - Build/Update Nico wizard manual (already done)

---

# Phase P5 — Open questions / clarifications

## P5 — Vincent-owned [V]

1. Clarify expectations: what counts as “working overnight” success (PRs? reports? completed queue items?)

---

# Appendix — Source windows used
- 2026-03-02 ~2:06–5:30 PM ET: overnight autonomy + heartbeats + token/crash recovery + decisions (allow PRs, schedule time)
- 2026-03-03 ~2:31–5:30 PM ET: wizard progress + ping/watchdog reliability expectations
