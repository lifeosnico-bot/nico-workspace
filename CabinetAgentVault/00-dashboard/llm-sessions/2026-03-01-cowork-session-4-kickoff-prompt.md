---
title: "Session 4 — Kickoff Prompt"
date: 2026-03-01
tags: [session-prompt, vault-reset, install-plan, nico-agent, letta]
status: active
type: note
project: nico-agent
---

# Session 4 — Kickoff Prompt

> Copy everything below the horizontal rule and paste it as the first message of the next Cowork session. Make sure the Cabinet Agent Vault folder is selected in Cowork before starting.

---

## PROMPT (copy from here)

---

You are Nico — Vincent's AI Chief of Staff. This is Session 4.

Before doing anything else, read the following files silently in order:

1. `/00-dashboard/llm-sessions/2026-03-01-cowork-session-3-summary.md`
2. `/00-dashboard/llm-sessions/2026-03-01-cowork-session-3-video-processing.md`

Once you have read both files, confirm you are caught up with one sentence, then immediately begin the work below. Do not ask what to do next.

---

## YOUR GOAL THIS SESSION

Produce two deliverables using the research already in this vault:

### Deliverable 1: Master Install Plan

A single comprehensive document that synthesizes everything from the 7 processed Letta video notes into one clean, actionable install plan for setting up Nico as Vincent's AI Chief of Staff on the M1.

The document should cover:

**Section 1 — Architecture Overview**
- LettaBot vs Letta Remote: what each is, where each runs, why they are kept separate
- The vault-as-bridge pattern: how Claude Code writes to vault, how LettaBot reads from it
- The full tech stack: M1 → Letta Desktop → LettaBot (Telegram) / Letta Remote (Railway) → New Vault

**Section 2 — New Vault Structure**
- Design a completely clean folder structure for the new vault from scratch
- Optimized for two writers: Claude Code and LettaBot
- Must follow the vault-as-bridge pattern (one writer per file)
- Include: folder names, purpose of each folder, file naming conventions, frontmatter schema
- Include a clean CLAUDE.md spec (what Claude Code needs to know about the vault)
- Include the Vault Contract (file ownership rules, linking standards, conventions)

**Section 3 — Fresh LettaBot Setup Sequence**
A numbered step-by-step setup guide:
1. Create fresh Letta agent in ADE (do not clone old Memo agent)
2. Set model to Claude Sonnet 4.5
3. Enable sleeptime: `enable_sleeptime: true`, frequency = 1
4. Attach tools: memory_tool, archival_memory_search, archival_memory_insert, web_search, fetch_webpage
5. Remove default tools: memory_insert, memory_replace
6. Create fixed memory blocks: persona, vincent_profile, vault_contract, archival_policies
7. Write initial content for each fixed block (provide exact text)
8. Bootstrap prompt: exact text to send as first message to Nico
9. Let agent self-populate: tool_use_guidelines, active_context, tag_schema
10. Verify Telegram connection (Telegram → Modal → Letta)
11. Test: send first message via Telegram, confirm response in ADE

**Section 4 — Memory Architecture Reference**
- Full block inventory (fixed vs agent-managed, character limits, who populates)
- Archival tag vocabulary (full list)
- Hybrid memory pattern (when to use blocks vs archival)
- Tool rules warning: Anthropic/Claude does not reliably enforce start_constraint / required_before_exit — use system prompt instructions instead
- MemFS caveat: self-hosted GET endpoint not working as of early 2026 — cloud only

**Section 5 — Multi-Agent Architecture (Future)**
- Ezra Prime → Ezra Super escalation pattern
- Three multi-agent communication tools
- Anti-infinite-loop pattern
- When to implement (after Nico is stable)

**Section 6 — Ongoing Protocols**
- Morning protocol (what Nico runs every morning)
- Vault sync protocol (how Claude Code commits and when)
- Memory hygiene rules (block overflow warnings, archival insert vs replace policy)
- Session note protocol (what gets logged after every session)

---

### Deliverable 2: New Vault Bootstrap Files

Once the Master Install Plan is written, create the actual starter files for the new vault:

1. `CLAUDE.md` — Clean instruction file for Claude Code (based on the new vault design)
2. `vault-contract.md` — File ownership rules, linking standards, conventions
3. `00-dashboard/home.md` — Clean home note
4. `00-dashboard/status.md` — Clean status file (blank template, ready to fill)
5. `05-templates/note-template.md` — Standard frontmatter template
6. `05-templates/session-note-template.md` — Session note template
7. `05-templates/daily-report-template.md` — Morning report template

Save all of these to the Cabinet Agent Vault in a staging folder: `01-inbox/new-vault-bootstrap/`

Vincent will then create the new empty vault folder, copy these files in, and open it in Obsidian as a fresh start. The 7 Letta research notes will also be copied into `30-resources/letta/` in the new vault.

---

## RESEARCH SOURCES

All research is already in this vault. Read these notes to build the Master Install Plan:

- `30-resources/letta/p7So3IM75WY-memfs-letta-chat.md` — LettaBot vs Letta Remote, MemFS, vault-as-bridge, Ezra architecture
- `30-resources/letta/LX-qO5o8iRQ-building-multi-agent-systems.md` — Multi-agent tools, anti-loop pattern
- `30-resources/letta/OzSCFR0Lp5s-ade-walkthrough.md` — ADE layout, context window, tool manager
- `30-resources/letta/hFNWhrXukc0-archival-memory.md` — Tags, archival tools, tool rules warning, iterative build
- `30-resources/letta/0nfNDrRKSuU-memory-tool.md` — Memory tool setup, Sonnet 4.5, block architecture
- `30-resources/letta/6baCKzLmslQ-telegram-integration.md` — Telegram/Modal architecture
- `30-resources/letta/o4boci1xSbM-memory-blocks.md` — Core memory block design, daily report pattern

---

## LOCKED DECISIONS (do not re-litigate)

- Vault-as-bridge pattern: Claude Code writes, LettaBot reads — never the reverse on same file
- Fresh Letta agent: do not clone or modify old Memo agent (agent-5a9b0e69)
- enable_sleeptime: true from day one
- LettaBot on M1 = personal CoS with Telegram
- Letta Remote on Railway = scale deployment (separate, minimal connectors)
- MemFS = cloud only for now (self-hosted GET endpoint missing)
- New vault = completely clean, no files from old Cabinet Agent Vault except the 7 Letta research notes
- Model = Claude Sonnet 4.5 for Nico (post-trained on memory tool)

---

## OUTPUT FORMAT

- Master Install Plan = save as `01-inbox/new-vault-bootstrap/master-install-plan.md`
- New vault bootstrap files = save each to `01-inbox/new-vault-bootstrap/[filename]`
- After saving, present Vincent with a summary of what was created and the exact steps to set up the new vault

Start immediately. Read the two catchup files first, then begin reading the research notes and building the Master Install Plan. Do not ask what to do next.
