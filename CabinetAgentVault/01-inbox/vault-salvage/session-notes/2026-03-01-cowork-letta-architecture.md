---
title: "Cowork Session — Letta Architecture Research & Knowledge Pipeline"
date: 2026-03-01
tags: [letta, architecture, research, session-note]
status: complete
type: note
project: nico-agent
---

# Cowork Session — 2026-03-01
**Tool:** Claude Cowork (M3)
**Topic:** LettaBot architecture review, YouTube knowledge pipeline, living manual plan

---

## What Was Decided

### 1. Root Cause of LettaBot Problems
The LettaBot conversation (screenshot reviewed) confirmed: stale memory blocks are the core issue. Claude Code sessions fixed things (Obsidian, Slack, auth) but never wrote those updates into Letta's memory blocks. The two agents operated in parallel without a handoff protocol. Result: LettaBot always reported old state.

**Fix:** Fresh Letta agent with sleep-time compute enabled from day one. Sleep-time agent reads vault (status.md) automatically and keeps memory current without manual intervention.

### 2. Architecture Decision: Vault as Bridge
- **Claude Code** = sole writer of operational files (status.md, session notes, configs)
- **LettaBot** = reads vault via sleep-time agent, writes only to its own Letta memory blocks
- **01-inbox/** = only shared write space (capture staging)
- **No direct Claude Code ↔ LettaBot communication** — vault is the bridge
- **M1** = always-on server (LettaBot 24/7, Claude Code CLI for autonomous work)
- **M3** = thinking/planning machine (Cowork, git sync to vault)

### 3. Headless Mode Is the Key
LettaBot can spawn Claude Code in headless mode. This enables the real CoS pattern:
- Vincent → LettaBot (Telegram): gives task
- LettaBot → Claude Code (headless): delegates execution
- Claude Code → vault: writes result + updates status.md
- LettaBot sleep-time → vault: reads update, incorporates into memory
- LettaBot → Vincent (Telegram): confirms completion

Vincent never touches terminal. This is Phase 7 of the roadmap — now unblocked by headless capability.

### 4. File Structure Discipline (must be baked into CLAUDE.md + LettaBot persona)
Every file needs a declared owner. One writer, multiple readers. This rule must be in both agents' instructions from day one. See architecture doc for full spec.

### 5. Fresh LettaBot = Right Call
Start new agent in Letta ADE with:
- `enable_sleeptime: true`
- Memory blocks: persona, human, vault-state, projects, decisions
- Content populated from current status.md
- DO NOT clone old Memo agent — too much stale data

### 6. New Letta Features to Use
- **MemFS** — git-backed file storage (solves file collision problem, Letta gets its own namespace)
- **Sleep-time compute** — auto memory consolidation
- **Built-in multi-agent tools** — `send_message_to_agent_async`, `send_message_to_agents_matching_all_tags`
- **Shared memory blocks** — team agents share org context without duplication

---

## What Was Built This Session

### YouTube Knowledge Pipeline
- **15 transcripts pulled** (136,000 words) from Letta's channel, Dec 2025–Mar 2026
- Saved to: `30-resources/letta/transcripts/` (as JSON corpus)
- Processed into: `30-resources/letta-youtube-research.md` (full synthesis by topic)
- Full video catalog (51 videos): `30-resources/letta/video-catalog-full.md`

### M1 Pipeline Script
- Location: `30-resources/letta/letta-knowledge-pipeline.sh`
- Must be copied to `~/Nico/Scripts/` on M1 and run there
- Does: pulls all transcripts (residential IP = no YouTube blocking), fetches docs, fetches GitHub releases, commits to vault
- Run: `bash ~/Nico/Scripts/letta-knowledge-pipeline.sh`

### Weekly Scheduled Task (Cowork)
- Task: `letta-knowledge-update`
- Runs: Every Sunday at 9am
- Does: checks for new videos, refreshes docs, writes weekly-update.md report, flags new videos for M1 pull

### Remaining 36 Videos (need M1 pull)
All listed in `video-catalog-full.md`. Most important to pull first:
- `LX-qO5o8iRQ` — Building Multi-Agent Systems with Letta ⭐
- `hFNWhrXukc0` — Archival Memory: Build AI that remembers everything ⭐
- `0nfNDrRKSuU` — The Memory Tool: Letta Agents That Redesign Their Own Architecture ⭐
- `6baCKzLmslQ` — How to talk to your AI agent with Telegram ⭐
- `o4boci1xSbM` — AI Memory Architecture: How to Use Memory Blocks ⭐
- `OzSCFR0Lp5s` — Agent Development Environment (ADE) Walkthrough ⭐

---

## Next Sessions (In Order)

### Session A — M1: Run the Pipeline
```bash
# SSH to M1 first
ssh lifeos.nico@100.87.182.78

# Copy script from vault
cp ~/Nico/CabinetAgentVault/30-resources/letta/letta-knowledge-pipeline.sh ~/Nico/Scripts/
chmod +x ~/Nico/Scripts/letta-knowledge-pipeline.sh

# Run it (pulls all 51 videos, docs, GitHub)
bash ~/Nico/Scripts/letta-knowledge-pipeline.sh
```

### Session B — Cowork: Build the Implementation Plan
Start prompt: *"You are Nico. Read 30-resources/letta-youtube-research.md and 30-resources/letta/video-catalog-full.md in the vault. Then read all transcript files in 30-resources/letta/transcripts/ and the docs in 30-resources/letta/docs/. Cross-reference everything and produce a complete implementation plan for: (1) fresh LettaBot setup with sleep-time compute, (2) file structure discipline and CLAUDE.md updates, (3) headless Claude Code integration pattern, (4) multi-agent team for SaaS startup. Save as 10-projects/nico-agent/letta-implementation-plan.md"*

### Session C — Cowork: Build the Interactive Manual
After plan is approved, build an HTML artifact — the living Letta manual. Navigable by topic, includes code patterns, architecture decisions, setup steps. Regenerated whenever vault updates.

### Session D — M1 Claude Code: Execute the Fresh Setup
Run the actual LettaBot fresh setup using the implementation plan as the spec.

---

## Key Files Created This Session
- `30-resources/letta-youtube-research.md` — 15-video research digest
- `30-resources/letta/video-catalog-full.md` — complete 51-video catalog
- `30-resources/letta/letta-knowledge-pipeline.sh` — M1 pipeline script
- Cowork scheduled task: `letta-knowledge-update` (Sundays 9am)

---

## Open Questions for Next Session
1. Should LettaBot write morning briefings directly to a daily note in vault, or send via Telegram only?
2. MemFS vs vault — exactly which files does Letta own vs Claude Code owns?
3. Multi-agent SaaS team: how many agents to start with? Coordinator + 2 workers or full org chart immediately?
