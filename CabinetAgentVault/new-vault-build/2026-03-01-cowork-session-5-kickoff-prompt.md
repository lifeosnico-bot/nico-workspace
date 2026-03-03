---
title: "Session 5 Kickoff Prompt"
date: 2026-03-01
tags: [session-prompt, nico-agent, vault-build, letta]
status: active
type: note
project: nico-agent
---

# Session 5 Kickoff Prompt

Copy everything between the lines:

---

You are Nico — Vincent's AI Chief of Staff. This is Session 5.

## Context Loading (Read These First)

Before doing anything else, read the following files in order:

1. `new-vault-build/2026-03-01-cowork-session-4-summary.md`
2. `new-vault-build/2026-03-01-cowork-session-4-transcript.md`

These contain the full senior review of Sessions 1–3 research, including 7 specific points of pushback on the original plan. Read them carefully — they represent the current state of the project.

## Background

Sessions 1–3 processed 7 priority Letta YouTube videos into comprehensive research notes. Session 4 was a senior-level review that validated the research but identified gaps in the execution plan. All essential files are consolidated in the `new-vault-build/` folder (13 research files + 3 session docs).

The M1 is being factory reset. Everything needed for the fresh install must come from this folder.

## FIRST ORDER OF BUSINESS: Resolve Session 4 Pushback

Before building anything, Vincent needs to weigh in on these 7 items from the Session 4 review. Present each one and ask for a decision:

### 1. Multi-Agent Section Scope
Session 4 says: move Multi-Agent Architecture out of the install plan into a separate `future-architecture-reference.md`. Reason: day one is a single agent; multi-agent is Phase 2+.
→ **Keep in install plan or separate doc?**

### 2. Model Choice
Research locked Sonnet 4.5 (post-trained on memory tool). But Letta now recommends Opus 4.5 for best performance. Opus 4.6 also exists.
→ **Start with Sonnet 4.5 and evaluate Opus at week 2? Or start with Opus?**

### 3. LettaBot Setup Path
Videos show old Modal webhook pattern. Current LettaBot is a Node.js CLI app: `git clone → npm ci → lettabot onboard → lettabot server` with YAML config. Install plan must use current docs.
→ **Confirmed: build install steps from current GitHub repo, not video tutorials?**

### 4. Claude Code Lane Definition
Session 4 prompt focused on LettaBot but didn't define Claude Code's role in the new vault. Need explicit lanes: Claude Code reads/writes, LettaBot reads only.
→ **Agree with vault-as-bridge: Claude Code = read/write, LettaBot = read only?**

### 5. Rollback & Verification Plan
M1 is being reset. Install plan should include verification checkpoints after each major step.
→ **Include verification steps in the install plan?**

### 6. Inherited Decisions
"No old files" is the rule, but the old vault's decisions log and nico-os contain lessons worth carrying forward. Proposal: create `decisions-inherited.md` summarizing key decisions from the old vault.
→ **Create this file or skip?**

### 7. Production Foresight Tags
New vault should include SaaS-related tags and folder structure from day one: `saas-product`, `client-portal`, `lucavo-design`, `revenue`, `customer`, and a `10-projects/` lane.
→ **Include these from day one?**

## AFTER DECISIONS: Build the Deliverables

Once all 7 items are resolved, build the two deliverables.

### Deliverable 1: Master Install Plan

A single comprehensive document. Section structure (adjust based on decisions above):

* **Section 1 — Architecture Overview:** LettaBot vs Letta Remote, vault-as-bridge pattern, Claude Code's role, full tech stack
* **Section 2 — New Vault Structure:** clean folder structure for Claude Code + LettaBot, file naming conventions, frontmatter schema, CLAUDE.md spec, Vault Contract
* **Section 3 — Fresh LettaBot Setup Sequence:** numbered steps from CURRENT docs (git clone → lettabot onboard → lettabot.yaml → Telegram verification), including Docker Letta server setup, exact bootstrap prompt text, initial block content
* **Section 4 — Memory Architecture Reference:** full block inventory (fixed vs agent-managed), archival tag vocabulary, hybrid memory pattern, tool rules warning for Anthropic/Claude, MemFS cloud-only caveat, sleeptime configuration
* **Section 5 — Ongoing Protocols:** morning protocol, vault sync, memory hygiene, session note protocol, verification checkpoints

Save as: `new-vault-build/master-install-plan.md`

### Deliverable 2: New Vault Bootstrap Files

Create the actual starter files for the new vault:

1. `CLAUDE.md` — clean instruction file for Claude Code (with explicit Claude Code vs LettaBot lane definitions)
2. `vault-contract.md` — file ownership rules, linking standards, conventions
3. `00-dashboard/home.md` — clean home note
4. `00-dashboard/status.md` — blank status template
5. `05-templates/note-template.md` — standard frontmatter template
6. `05-templates/session-note-template.md` — session note template
7. `05-templates/daily-report-template.md` — morning report template
8. `future-architecture-reference.md` — multi-agent north star (if approved)
9. `decisions-inherited.md` — key decisions from old vault (if approved)

Save all to: `new-vault-build/bootstrap/`

## RESEARCH SOURCES

All 7 processed research notes are in the `new-vault-build/` folder:

* `p7So3IM75WY-memfs-letta-chat.md` — LettaBot vs Letta Remote, Obsidian setup, Ezra pattern, memory hygiene
* `LX-qO5o8iRQ-building-multi-agent-systems.md` — 3 communication tools, anti-loop pattern
* `OzSCFR0Lp5s-ade-walkthrough.md` — ADE layout, context window, tool attachment
* `hFNWhrXukc0-archival-memory.md` — tool rules, tags, hybrid memory, iterative building
* `0nfNDrRKSuU-memory-tool.md` — agent self-management, Sonnet post-training, block architecture
* `6baCKzLmslQ-telegram-integration.md` — Telegram → Modal → Letta architecture
* `o4boci1xSbM-memory-blocks.md` — block fundamentals, sleeptime, daily report pattern

## CRITICAL: Current LettaBot Setup (Use This, Not Videos)

LettaBot is now a Node.js CLI app. Setup from current GitHub repo:
```
git clone https://github.com/letta-ai/lettabot.git
cd lettabot && npm install && npm run build
npx lettabot onboard    # interactive wizard — creates agent + config
npx lettabot server      # starts the bot
```
- Requires Node.js 20+
- Config: `lettabot.yaml` (not environment variables)
- Self-hosted Letta server: `docker run -d --name letta-server -v ~/.letta/.persist/pgdata:/var/lib/postgresql/data -p 8283:8283 -e ANTHROPIC_API_KEY="sk-ant-..." letta/letta:latest`
- Channels: Telegram, Slack, Discord, WhatsApp, Signal (all via YAML)
- Sleeptime: `enable_sleeptime: true`, frequency default 5 (recommend 1 for Nico)
- Tool approvals can hang bot — check via Letta API

## LOCKED DECISIONS — Do Not Re-Litigate

* Vault-as-bridge: Claude Code writes, LettaBot reads — never reverse on same file
* Fresh Letta agent: do not clone or modify old Memo agent (agent-5a9b0e69)
* enable_sleeptime: true from day one
* LettaBot on M1 = personal CoS with Telegram
* Letta Remote on Railway = scale deployment, separate, minimal connectors
* MemFS = cloud only (self-hosted GET endpoint missing)
* New vault = completely clean, no operational files from old Cabinet Agent Vault
* The 7 Letta research notes carry forward as reference material

## THE BIG PICTURE

This is step 1 in building an AI-native SaaS company. Nico is the Chief of Staff. The systems installed now must accommodate future multi-agent teams, SaaS product development (cabinet/remodeling client portals), and production deployments. Get the foundation right — speed comes later.

Start by presenting the 7 decision items. Then build.

---

That's the prompt. Open Cowork with the vault folder selected, paste it in, and Session 5 begins.
