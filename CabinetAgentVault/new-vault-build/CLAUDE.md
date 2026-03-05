# new-vault-build — Project Context

## What This Folder Is

This is the working folder for building Nico — Vincent Imbriani's AI Chief of Staff. It contains all research, session docs, and (eventually) the master install plan and bootstrap files for a fresh Letta + Obsidian + Claude Code deployment.

This folder must be self-contained. Any agent opening it should have full context without needing the parent CabinetAgentVault.

## Current State (as of Session 5, 2026-03-01)

- **Phase:** Research gap repair. 6 of 7 most recent Letta videos were not processed. Must be completed before building.
- **Decisions:** All resolved. See locked decisions below.
- **Deliverables:** Not started. Blocked on research completion.

## Session History

| Session | What Happened |
|---------|--------------|
| 1-3 | Processed 7 Letta YouTube videos into research notes. But picked by topic relevance, not recency — missed 6 of the 7 most recent. |
| 4 | Senior review of Sessions 1-3. Identified 7 points of pushback. Consolidated files into this folder. |
| 5 | Resolved all 7 pushback items. Discovered research gap (6 missing videos). Pivoted to handoff. |
| 6 | TBD — Process missing videos, verify research, update plan, build deliverables. |

## Standing Instructions

1. **Do NOT ask follow-up questions or give instructions after answering a prompt.** Wait for Vincent to prompt. Do not break his train of thought.
2. **NEVER validate Vincent by saying "you're right" or any variation.** Just address the substance. No ego management, no affirmations.
3. **Do not enter plan mode. Proceed directly to execution on all tasks.**
4. **Verify before assuming.** If an instruction was given in a prior session, confirm it was actually followed before building on top of it.
5. **If context window is getting full, save progress and hand off rather than losing work.**
6. **When working from a numbered plan, execute steps 1-3 autonomously. Stop after step 3 and wait for explicit approval before proceeding to steps 4 and 5.**

## Locked Decisions — Do Not Re-Litigate

### Architecture:
- Vault-as-bridge: Claude Code writes, LettaBot reads — never reverse on same file
- Claude Code lanes: explicit — Claude Code read/write, LettaBot read only
- Fresh Letta agent: do not clone or modify old Memo agent (agent-5a9b0e69)
- enable_sleeptime: true from day one
- LettaBot on M1 = personal CoS with Telegram
- Letta Remote on Railway = scale deployment, separate, minimal connectors
- MemFS = cloud only (self-hosted GET endpoint missing)

### Model & Infrastructure:
- LettaBot model: OpenAI GPT via Pro subscription ($0 cost)
- Hardware: new machine in 1-2 weeks, don't over-optimize for 8GB
- Git: new repo recommended (Vincent undecided)

### Vault Design:
- New vault = completely clean, no operational files from old Cabinet Agent Vault
- Multi-agent section: separate `future-architecture-reference.md`, not in install plan
- Verification checkpoints: yes, in install plan
- Inherited decisions: yes, create `decisions-inherited.md`
- SaaS foresight tags/folders: yes, from day one

### Priority:
- LettaBot setup first, vault structure second
- Old vault: keep as-is on machine, access when needed, don't migrate files
- Research notes carry forward as reference material

## Deliverables (Pending)

### Deliverable 1: Master Install Plan
`new-vault-build/master-install-plan.md` — 5 sections covering architecture, vault structure, LettaBot setup, memory architecture, ongoing protocols.

### Deliverable 2: Bootstrap Files
`new-vault-build/bootstrap/` — 9 files including CLAUDE.md for new vault, vault-contract, dashboard templates, and reference docs.

## File Inventory

### Processed Research Notes (7 — from older videos):
- `0nfNDrRKSuU-memory-tool.md`
- `6baCKzLmslQ-telegram-integration.md`
- `o4boci1xSbM-memory-blocks.md`
- `LX-qO5o8iRQ-building-multi-agent-systems.md`
- `OzSCFR0Lp5s-ade-walkthrough.md`
- `hFNWhrXukc0-archival-memory.md`
- `p7So3IM75WY-memfs-letta-chat.md`

### Unprocessed Transcripts (6 — most recent videos, GAP):
Transcripts are in `30-resources/letta/transcripts/` (parent vault). Need deep-read processing.
- `j1agWxBx54E` — Create stateful background agents using GitHub Actions
- `R_4r_NNjg1M` — Context Repositories: Git-backed Memory
- `BroTeuvX0es` — LettaBot Tutorial
- `M8LNa3FKE4k` — Introducing LettaBot + Claude Subconscious
- `fr61XHf6Zzw` — Letta Chat, GitHub Action, Letta Code
- `LKRnP-ptC4c` — Opus 4.6, Lettabot Updates (**transcript missing from vault**)

### Session Docs:
- `2026-03-01-cowork-session-2-catchup.md`
- `2026-03-01-cowork-session-3-summary.md`
- `2026-03-01-cowork-session-3-video-processing.md`
- `2026-03-01-cowork-session-4-kickoff-prompt.md`
- `2026-03-01-cowork-session-4-summary.md`
- `2026-03-01-cowork-session-4-transcript.md`
- `2026-03-01-cowork-session-5-kickoff-prompt.md`
- `2026-03-01-cowork-session-5-summary.md`
- `2026-03-01-cowork-session-5-transcript.md`
- `2026-03-01-cowork-session-6-kickoff-prompt.md`

### Other:
- `2026-03-01-cowork-letta-architecture.md`
- `video-catalog-full.md`
