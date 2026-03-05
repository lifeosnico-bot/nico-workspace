---
title: "Research Verification Checklist — All 14 Letta Videos"
date: 2026-03-01
tags: [verification, research, letta, nico-agent, session-6]
status: active
type: note
project: nico-agent
---

# Research Verification Checklist — All 14 Letta Videos

Created in Session 6. Confirms all 14 videos have been processed into research notes before building deliverables.

---

## ✅ Original 7 (Sessions 1-3)

| # | Video ID | Title | Note File | Has Required Sections |
|---|----------|-------|-----------|----------------------|
| 1 | p7So3IM75WY | MemFS, Letta Chat, and the future of AI agent memory | `p7So3IM75WY-memfs-letta-chat.md` | ✅ |
| 2 | LX-qO5o8iRQ | Building Multi-Agent Systems with Letta | `LX-qO5o8iRQ-building-multi-agent-systems.md` | ✅ |
| 3 | OzSCFR0Lp5s | Agent Development Environment (ADE) Walkthrough | `OzSCFR0Lp5s-ade-walkthrough.md` | ✅ |
| 4 | hFNWhrXukc0 | Archival Memory: Build AI that remembers everything | `hFNWhrXukc0-archival-memory.md` | ✅ |
| 5 | 0nfNDrRKSuU | The Memory Tool: Letta Agents That Redesign Their Own Architecture | `0nfNDrRKSuU-memory-tool.md` | ✅ |
| 6 | 6baCKzLmslQ | How to talk to your AI agent with Telegram | `6baCKzLmslQ-telegram-integration.md` | ✅ |
| 7 | o4boci1xSbM | AI Memory Architecture: How to Use Memory Blocks | `o4boci1xSbM-memory-blocks.md` | ✅ |

---

## ✅ 7 Newly Processed (Session 6) — 8 Most Recent Videos

| # | Video ID | Title | Note File | Has Required Sections |
|---|----------|-------|-----------|----------------------|
| 8 | BroTeuvX0es | LettaBot Tutorial: create a personal AI assistant with memory | `BroTeuvX0es-lettabot-tutorial.md` | ✅ |
| 9 | LKRnP-ptC4c | Opus 4.6, Lettabot Updates, Agent File Directory, and More | `LKRnP-ptC4c-lettabot-updates.md` | ✅ |
| 10 | M8LNa3FKE4k | Introducing LettaBot + Claude Subconscious Demo | `M8LNa3FKE4k-introducing-lettabot.md` | ✅ |
| 11 | YtZgsw9x8l8 | Combine Letta Code with Obsidian | `YtZgsw9x8l8-letta-code-obsidian.md` | ✅ |
| 12 | j1agWxBx54E | Create stateful background agents using GitHub Actions | `j1agWxBx54E-github-actions.md` | ✅ |
| 13 | fr61XHf6Zzw | Letta Chat, GitHub Action, Letta Code, and more! | `fr61XHf6Zzw-letta-chat-github-action.md` | ✅ |
| 14 | R_4r_NNjg1M | Context Repositories: Git-backed Memory for Coding Agents | `R_4r_NNjg1M-context-repositories.md` | ✅ |

**14 of 14 videos processed. Research base complete.**

---

## ⚠️ Critical Gaps — GitHub Docs vs. Video Transcripts

Identified in Session 6 cross-reference. Full details in [[github-docs-vs-videos-gap]].

### G1. Heartbeat Silent Mode (CRITICAL)
Heartbeats do NOT auto-deliver agent text responses to Telegram. Agent must explicitly call `lettabot-message send --text "..."` inside the heartbeat to send anything. Bash tool must be enabled; user must have messaged the bot at least once. Without this, Nico's morning reports silently execute but never arrive.

### G2. `LETTA_MODEL` Env Var Removed (CRITICAL)
The `LETTA_MODEL` environment variable is confirmed removed. Model is set via `lettabot model set <handle>`. Do not use the model field in `lettabot.yaml` or any env var for model selection.

### G3. Install Command Incomplete (CRITICAL)
Videos showed `npm ci`. SKILL.md (authoritative) requires: `npm install && npm run build && npm link`. `npm link` creates the global `lettabot` command — without it `lettabot onboard` and `lettabot server` don't work as bare commands.

### G4. DM Policy Defaults to `pairing` (CRITICAL)
Not in any video. Default `dmPolicy: pairing` — users must be approved before bot responds. Vincent must self-pair after starting the server: `lettabot pairing approve telegram <code>`.

### G5. `LETTA_AGENT_ID` — How to Point LettaBot at Existing Agent (CRITICAL)
Set via env var `LETTA_AGENT_ID` or `agent.id` in `lettabot.yaml`. The Letta agent must be created first, ID captured, then set here. Install plan must include this sequence.

### G6. `/connectcodex` Not in Public Docs (IMPORTANT)
Confirmed in video (LKRnP-ptC4c) but absent from `docs.letta.com`. Must be done interactively in Letta Code, cannot be scripted. GPT model prefix `chatgpt-plus-...` is documented as valid.

---

## ⚠️ Decision Conflicts & Updates from New Videos

The following items from the 7 newly processed videos require attention before finalizing the install plan:

### 1. Context Repositories vs. Memory Blocks (SIGNIFICANT)

**Old research** (o4boci1xSbM, hFNWhrXukc0, 0nfNDrRKSuU): Memory architecture = memory blocks (fixed + agent-managed), archival memory, tool rules.

**New research** (R_4r_NNjg1M, BroTeuvX0es): Context repositories are now the standard. Memory is a git-backed local filesystem. Agent edits via bash, not JSON patches. The `/system/` folder = core memory in context window. Files outside `/system/` = external memory fetched on demand.

**Verdict:** The older memory block architecture is superseded for Letta Code agents. The install plan's Memory Architecture section must be rewritten around context repositories as the primary pattern. Memory blocks still exist and the old research is relevant background, but context repositories are what Nico will actually use.

### 2. LettaBot Setup Path — Confirmed + Refined

**Old research** (6baCKzLmslQ): Telegram integration via Modal webhook pattern (outdated).

**New research** (BroTeuvX0es, M8LNa3FKE4k, LKRnP-ptC4c): Current LettaBot = Node.js CLI. `git clone → npm ci → lettabot onboard → lettabot server`. Confirmed as authoritative. No npm package (intentional).

**Verdict:** Session 5 kickoff prompt's setup path is correct. No conflict.

### 3. OpenAI GPT via `/connectcodex` (NEW INFO)

**New research** (LKRnP-ptC4c): The confirmed OAuth path for using OpenAI GPT via Pro subscription at $0 cost inside Letta is `/connectcodex`. This is the specific command/flow Vincent needs.

**Action:** Install plan must include `/connectcodex` as the model setup step.

### 4. Shared Human Memory Block (GOTCHA)

**New research** (YtZgsw9x8l8): On by default across all Letta Code agents on the same machine. If not explicitly managed, multiple agents share a human memory block and can contaminate each other's understanding of the user.

**Action:** Install plan must include an explicit step to verify and isolate Nico's human memory block.

### 5. Heartbeat Model Behavior

**New research** (BroTeuvX0es): Default Sonnet → boring heartbeats ("no reply"). Opus → proactive memory reflection. Vincent's locked decision is GPT via Pro subscription. GPT behavior during heartbeats is unknown — may require prompt tuning to get proactive behavior.

**Action:** Flag in install plan. Include heartbeat prompt guidance.

### 6. YOLO Mode — Do Not Enable by Default

**New research** (YtZgsw9x8l8): YOLO mode = auto-approve all agent actions on vault files. Dangerous. Hard no for Nico.

**Action:** Include as explicit warning in install plan.

### 7. Claude Subconscious — Defer

**New research** (M8LNa3FKE4k, fr61XHf6Zzw): Experimental, intermittent reliability issues as of this session. Not production-ready.

**Verdict:** Defer to Phase 2+. Document in `future-architecture-reference.md`.

### 8. Note Tool / Vault Successor

**New research** (fr61XHf6Zzw): Cameron uses a note tool + pull/push CLI to sync memory blocks with Obsidian. A "Vault" successor with cross-agent memory block tags is in development.

**Verdict:** Current Nico build uses context repositories (git-backed) + vault-as-bridge (Claude Code writes markdown, LettaBot reads). The note tool is an alternative pattern — compatible but not required for Phase 1.

---

## Required Sections Checklist (Per Note)

Each note should have: frontmatter, context callout, sections with emoji headers, block quotes, warnings/verdicts, extracted decisions, "What This Means for Nico", related notes wikilinks.

All 14 notes confirmed to have required structure. ✅

---

## Status

- [x] All 14 videos processed
- [x] Decision conflicts identified and documented
- [x] GitHub docs cross-reference complete — [[github-docs-vs-videos-gap]]
- [x] Affected research notes updated (BroTeuvX0es, LKRnP-ptC4c, this file)
- [ ] Install plan and bootstrap files — PENDING APPROVAL (Steps 4-5)
