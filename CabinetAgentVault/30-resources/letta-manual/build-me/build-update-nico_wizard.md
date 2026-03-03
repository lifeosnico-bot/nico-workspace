---
title: "Build/Update Nico — Wizard (Working Draft)"
type: manual
status: draft
created: 2026-03-01
modified: 2026-03-01
source: youtube+docs+github
tags: [letta, manual, wizard, build-me]
---

# Build/Update Nico — Wizard (Working Draft)

# 1) Goal
- Keep Nico up to date with Letta’s newest features and best practices.
- Convert Letta’s latest guidance (YouTube + docs + GitHub) into:
  - operating rules
  - checklists
  - verification gates

# 2) Inputs (This Folder Only)
- Folder: `30-resources/letta-manual/build-me/`
- Transcripts:
  - Last 8 Letta videos (2026-01-16 → 2026-02-26)
  - Plus: 2025-03-03 “Building Multi-Agent Systems with Letta”
- Docs snapshots (reference links):
  - https://docs.letta.com/letta-code/memory/
  - https://docs.letta.com/letta-code/changelog/
  - https://www.letta.com/blog/context-repositories
  - https://github.com/letta-ai/letta-code

# 3) What We Extract From Each Source
- Claims (what Letta says is true)
- Rules (what to do)
- Failure modes (what breaks)
- Verification gates (how to prove reality)
- “Apply to Nico” (exact changes to our operating loop)

# 4) The Wizard (Checklist)

# 4.1 Context Repositories (Git-backed memory) — VIDEO 2026-02-25 `R_4r_NNjg1M`

## Summary (1 paragraph)
- Context Repositories are a rebuild of Letta Code memory: expose memory as a local, git-tracked filesystem so agents can reorganize and maintain large memory systems using normal tools (files + bash), while keeping the “true” agent state on the server.

## Claims (what the video asserts)
- Context Repositories = **git-based memory** for Letta Code.
- They replace “memory tools only” workflows (memory blocks append/replace/delete) with **file + bash** workflows.
- The agent’s state still lives on the server; the local repo is a **synced working copy**.
- The file tree is always in context; the `system/` directory is **pinned** (always fully loaded).
- Git tracking gives a clean “who changed what” log, which is especially useful with sleep-time / reflection agents.
- This enables progressive disclosure: keep only the most important things pinned.
- This enables “memory swarms”: multiple subagents can work in parallel using git worktrees, then merge.

## Rules (how to operate if you adopt it)
- Treat the memory repo like production code:
  - make small changes
  - commit with informative messages
  - push so state is durable
- Keep `system/` small and high-signal.
- Put durable identity + operating constraints in `system/`.
- Put large notes, transcripts, or long references outside `system/`.
- Use the file tree as navigation (folders + filenames).

## Failure modes (how it breaks)
- Drift happens when:
  - important preferences live only in chat history (not pinned)
  - `system/` grows too big → context becomes noisy
  - local memory repo stops syncing (not pushed)
  - multiple agents write without merge discipline
- Confusion happens when people say “saved” but it’s only local.

## Verification gates (commands that prove reality)
- Gate: MemFS is enabled and healthy
  - `letta memfs status --agent <agent-id>` → expects `dirty=false`, `aheadOfRemote=false`
- Gate: Memory repo exists
  - `ls ~/.letta/agents/<agent-id>/memory/`
- Gate: Git sync works (memory repo)
  - `git -C ~/.letta/agents/<agent-id>/memory status -sb`
  - `git -C ~/.letta/agents/<agent-id>/memory pull`
  - `git -C ~/.letta/agents/<agent-id>/memory push`
- Gate: Pinned vs unpinned is understood
  - pinned = `~/.letta/agents/<agent-id>/memory/system/`

## Apply to Nico (our concrete changes)
- Definition of “Saved” for anything called “memory”:
  - saved = committed + pushed (remote)
- Default meaning of “make it a memory”:
  - write to `memory/system/` (pinned) + commit + push
- Add a weekly memory health check item:
  - `letta memfs status` must be clean

## Doc / Blog delta check (what to reconcile)
- Blog: https://www.letta.com/blog/context-repositories
- Confirm in our environment:
  - `system/` is pinned (matches blog + video)
  - memory repo is git-backed (matches blog + video)

# 4.2 Conversations (Where did you go?)

## Claims
- Letta Code supports many conversations per agent.
- Memory is shared across conversations.

## Rules
- Use default conversation for continuity.
- Use new conversations only when you explicitly want parallel threads.

## Failure modes
- Confusion about continuity = user and agent are in different conversations.

## Verification gates
- Use `/resume` to confirm which conversation is active.

# 4.3 Reflection / Sleep-time compute

## Claims
- Reflection subagents can consolidate memory.
- Recommended mode is reminder-only unless you accept autonomous writes.

## Rules
- Default: reminder-only reflection.
- Only enable auto-launch if you accept occasional wrong edits + rollback discipline.

## Failure modes
- Autonomous reflection can write noisy/wrong memories if taxonomy is unstable.

## Verification gates
- Reflection settings reviewed weekly.
- Memory diffs reviewed after reflection run.

# 4.4 Multi-Agent Systems (Team, without chaos)

## Claims
- Multi-agent works best with:
  - narrow roles
  - shared canonical truth
  - controlled memory writes

## Rules
- Specialists propose; Nico promotes to canon.
- Canonical truth lives in vault + pinned rules (not scattered).
- Do not route multiple agents through the same Telegram bot token/poller.

## Failure modes
- Telegram bot conflicts if more than one poller uses same token.
- Drift if multiple agents write “truth” directly.

## Verification gates
- Comms lane audit: only one Telegram poller per token.
- Role audit: which agent is allowed to write which files.

# 4.5 LettaBot / Comms Architecture (stability first)

## Rules
- Telegram DM = Nico only (CEO desk).
- No multi-agent Telegram routing until explicitly engineered.

## Failure modes
- Group privacy + routing confusion.
- Poller conflicts.

## Verification gates
- Telegram is stable for 24h (no polling errors) after any change.

# 5) Current Sources Covered (Newest → Oldest)
- 20260226_p7So3IM75WY (MemFS office hours)
- 20260226_j1agWxBx54E (Background agents via GitHub Actions)
- 20260225_R_4r_NNjg1M (Context Repositories deep dive)
- 20260221_BroTeuvX0es (LettaBot tutorial)
- 20260206_LKRnP-ptC4c (Office hours)
- 20260130_M8LNa3FKE4k (Office hours)
- 20260126_fr61XHf6Zzw (Office hours)
- 20260116_YtZgsw9x8l8 (Obsidian + Letta Code)
- 20250303_LX-qO5o8iRQ (Multi-agent systems)

# 6) Next (What I’m doing next in this folder)
- For each transcript above:
  - extract: claims/rules/failures/gates
  - add any doc/GitHub deltas (what changed since the video)
- Produce a final “Build/Update Nico” wizard that is:
  - scannable
  - checklisted
  - verifiable
