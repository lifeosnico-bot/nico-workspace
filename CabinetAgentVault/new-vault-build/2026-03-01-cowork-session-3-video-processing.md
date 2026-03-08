---
title: "Session 3 — Letta Video Processing Complete"
date: 2026-03-01
tags: [session-note, letta, video-processing, nico-agent, vault-build]
status: complete
type: note
project: nico-agent
---

# Session 3 — Letta Video Processing Complete

## Session Summary

Completed the full video processing backlog for the Letta research corpus. All 7 priority starred videos now have comprehensive processed notes in the vault. This was the critical prerequisite before building the fresh LettaBot architecture.

---

## What Was Done

### Videos Processed (7 total)

| Video ID | Title | Note Location |
|---|---|---|
| p7So3IM75WY | MemFS Office Hours — Memory Hygiene | [[p7So3IM75WY-memfs-letta-chat]] (v2 full reprocess) |
| LX-qO5o8iRQ | Building Multi-Agent Systems with Letta | [[LX-qO5o8iRQ-building-multi-agent-systems]] |
| OzSCFR0Lp5s | ADE Walkthrough | [[OzSCFR0Lp5s-ade-walkthrough]] |
| hFNWhrXukc0 | Archival Memory — Build AI that Remembers Everything | [[hFNWhrXukc0-archival-memory]] |
| 0nfNDrRKSuU | The Memory Tool: Agents That Redesign Their Own Architecture | [[0nfNDrRKSuU-memory-tool]] |
| 6baCKzLmslQ | How to Talk to Your AI Agent with Telegram | [[6baCKzLmslQ-telegram-integration]] |
| o4boci1xSbM | AI Memory Architecture: How to Use Memory Blocks | [[o4boci1xSbM-memory-blocks]] |

### Transcripts Pulled (2 missing ones)
- LX-qO5o8iRQ raw transcript — pulled with youtube-transcript-api, saved to [[30-resources/letta/transcripts/]]
- OzSCFR0Lp5s raw transcript — pulled with youtube-transcript-api, saved to [[30-resources/letta/transcripts/]]
- All other starred video transcripts were already present (pulled by Claude Code in a prior session)

---

## Key Knowledge Extracted

### Architecture Decisions Confirmed

**LettaBot vs Letta Remote (from p7So3IM75WY):**
- LettaBot = LettaCode + consumer application layer (Telegram, heartbeats, daily briefings) — runs on M1
- Letta Remote = bare-bones LettaCode as remote listener — accessed via Letta Chat/ADE
- These are NOT to be merged. Different purposes.

**Memory Stack for Nico:**
- Core memory blocks (always in context) → persona, vincent_profile, vault_contract, archival_policies
- Archival memory (out of context, retrieved via tool) → decisions, meetings, research, history
- MemFS (git-backed markdown) → currently cloud-only (self-hosted GET endpoint missing)
- Memory tool → attaches to Nico for autonomous block management

**Tool Rules Warning:**
- `start_constraint` and `required_before_exit` = strictly enforced on Gemini/OpenAI only
- Anthropic/Claude = best-effort, may not follow
- Solution: use system prompt instructions instead of tool rules for Claude-based agents

**The Memory Tool (0nfNDrRKSuU):**
- Agents can now create/modify/delete/rename their own memory blocks
- Best with Claude Sonnet 4.5 (post-trained on it)
- Tradeoff: flexibility vs. predictability
- Use for: personal agents, long-lived agents. Avoid for: fixed-behavior production agents

**Multi-Agent Architecture (LX-qO5o8iRQ):**
- 3 built-in tools: `send_message_to_agent_async`, `send_message_to_agent`, `send_message_to_agents_matching_all_tags`
- Anti-infinite-loop: tell one agent to "report back after a few messages"
- Agents are independent — multi-agent capability comes from attaching the tool, not from hard-coding

**Telegram Integration (6baCKzLmslQ):**
- Architecture: Telegram → Modal webhook → Letta server → Modal → Telegram
- Modal = serverless relay (avoids maintaining infrastructure)
- Async processing: acknowledge immediately, process separately, stream results back
- Same agent, same history — accessible from ADE, Telegram, Discord simultaneously

---

## Nico's Block Architecture (Finalized This Session)

**Fixed blocks (do not give memory tool authority):**
```
persona              — Nico identity and CoS role
vincent_profile      — Deep user profile
vault_contract       — Operational rules, Obsidian structure, vault lanes
archival_policies    — When/how to use archival memory + hybrid pattern
```

**Agent-managed blocks (memory tool + sleeptime fills):**
```
tool_use_guidelines  — Agent populates from self-exploration
active_context       — Current sprint/project/task context
tag_schema           — Archival tag vocabulary
daily_report         — Pre-compiled morning briefing
performance_notes    — What search/recall patterns work, what doesn't
```

**Archival Tag Vocabulary (from hFNWhrXukc0 + p7So3IM75WY):**
```
vincent, cabinet-design, saas-startup, nico-agent
decision, action-item, blocker
meeting, research, status
tech-letta, tech-claude, tech-obsidian
priority-1, priority-2, priority-3
```

---

## What Comes Next

With the video processing complete, the next session should begin the fresh LettaBot setup:

1. Create fresh Letta agent (don't clone old Memo agent)
2. Configure `enable_sleeptime: true` from day one
3. Attach tools: archival_memory_search, archival_memory_insert, memory_tool
4. Attach web tools: web_search, fetch_webpage
5. Set up memory block architecture (fixed blocks above)
6. Bootstrap persona prompt → let agent self-populate tool_use_guidelines
7. Let agent explore archival memory + build tag_schema
8. Feed key context (this vault, project state, Vincent profile)
9. Verify Telegram integration connects to the new agent

Reference: [[p7So3IM75WY-memfs-letta-chat]] → Section "LettaBot vs Letta Remote" and "Cameron's Obsidian Setup" for the exact pattern to follow.

---

## Session Notes

- All processed notes are in `30-resources/letta/` with proper frontmatter
- Each note has a "What This Means for Nico" section with direct action items
- Wikilinks between notes are set up (related notes sections)
- Raw transcripts preserved in `30-resources/letta/transcripts/`
- No GitHub push this session (processing only, no config changes)
