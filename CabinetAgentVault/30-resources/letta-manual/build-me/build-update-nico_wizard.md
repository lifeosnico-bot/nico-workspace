---
title: "Build/Update Nico — Wizard (Working Draft)"
type: manual
status: draft
created: 2026-03-01
modified: 2026-03-03
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

# 1.1 Mission statement (do not delete)
- To use the most modern data available (YouTube transcripts and/or blog posts) to compare against the most documented data (GitHub and/or website docs) to consistently reconcile what system + features need to be added to Nico and future agents so they stay the best versions of themselves.

# 2) Inputs (This Folder Only)
- Folder: `30-resources/letta-manual/build-me/`
- Transcripts:
  - 8 Letta videos (2026-01-16 → 2026-02-26)
  - plus 1 older video (2025-03-03)
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
- Apply to Nico (exact changes to our operating loop)

# 4) Videos (Latest → Oldest)

## 4.0 Wizard progress checklist (update on every completion)

- ✅ 4.1 `p7So3IM75WY` — MemFS Office Hours (done)
- ✅ 4.2 `j1agWxBx54E` — GitHub Actions background agents (done)
- ✅ 4.3 `R_4r_NNjg1M` — Context Repositories deep dive (done; reconciled)
- ✅ 4.4 `BroTeuvX0es` — LettaBot tutorial (done)
- ✅ 4.5 `LKRnP-ptC4c` — Office Hours (done)
- ⬜ 4.6 `M8LNa3FKE4k` — Office Hours (queued)
- ⬜ 4.7 `fr61XHf6Zzw` — Office Hours (queued)
- ⬜ 4.8 `YtZgsw9x8l8` — Obsidian + Letta Code (queued)
- ⬜ 4.9 `LX-qO5o8iRQ` — Multi-agent systems (queued)

- Rule: only one item can be marked **in progress** at a time.
- Rule: mark **done** only after commit + push.

- Each video gets one section.
- Status is either `pending` or `done`.

# 4.1 (done) Letta Office Hours: MemFS, Letta Chat, and the future of AI agent memory — 2026-02-26 `p7So3IM75WY`

## Summary (1 paragraph)
- Office hours update covering Letta Code as the core local harness, MemFS as the current memory architecture shift (git-backed context repositories), and new surfaces/features like memory visualization (“memory palace”) and a slash command to install a GitHub integration for remote debugging.

## Claims (what the video asserts)
- MemFS is a git-backed memory management system (context repositories) that enables versioning and collaboration.
- MemFS shifts from server-side memory blocks (attach/detach) to a git-like repo of markdown files.
- Agents can manage both:
  - pinned memory (always in system prompt)
  - out-of-context notes (looked up later)
- Because memory changes are git-tracked, agents can be required to write commit messages, and multiple agents can work on the same memory with conflict resolution.
- There is a UI/surface for viewing agent memory (“memory palace”) designed for MemFS.
- There is a slash command to install a GitHub action/integration so you can tag Letta Code on an issue/PR to do work remotely.

## Rules (how to operate if you adopt it)
- Treat MemFS as production state:
  - changes must be committed + pushed to be durable
  - use informative commit messages
- Keep pinned memory high-signal; push long notes out of pinned memory and rely on the tree + lookup.
- Use git workflow discipline if multiple agents/subagents can write memory.

## Failure modes (how it breaks)
- Confusion between server state and the local working copy (thinking local edits are “cloud saved” without push).
- Pinned memory bloat → noisy context.
- Parallel writers without merge discipline → conflicts or drift.

## Verification gates (commands that prove reality)
- Gate: MemFS is healthy and synced
  - `letta memfs status --agent <agent-id>` expects `dirty=false`, `aheadOfRemote=false`
- Gate: pinned vs unpinned hierarchy exists
  - `ls ~/.letta/agents/<agent-id>/memory/system/`
- Gate: memory changes are actually versioned
  - `git -C ~/.letta/agents/<agent-id>/memory log -n 5 --oneline`

## Apply to Nico (our concrete changes)
- Enforce our definition: “Saved memory” = committed + pushed.
- Add a monthly “pinned memory size” review (prevent bloat).
- If we adopt GitHub remote tagging, treat it as a controlled lane (PR/issue only, with review).

## Present-day truth sources checked (documented)
- Docs:
  - https://docs.letta.com/letta-code/memory/
  - https://docs.letta.com/letta-code/changelog/
- GitHub:
  - https://github.com/letta-ai/letta-code

## Doc / GitHub deltas (video says → present-day docs/code)
- Video: MemFS is git-backed markdown repo → Docs confirm MemFS = git-backed context repo; `system/` pinned.
- Video: memory edits require commit+push to be reflected → Docs explicitly state commit+push required.
- Video: GitHub action install via slash command → Docs/changelog should be checked for exact command name + current behavior (confirm when we run it).

# 4.2 (done) Create stateful background agents using GitHub Actions — 2026-02-26 `j1agWxBx54E`

## Summary (1 paragraph)
- This video shows the Letta Code GitHub Action workflow that turns an existing Letta Code agent into a background agent that can run inside GitHub Actions when tagged on issues/PRs, create branches + PRs, and be monitored via the ADE UI using the action run links.

## Claims (what the video asserts)
- There is a Letta Code GitHub Action that can run an agent inside GitHub Actions to work issues / review PRs.
- Letta Code includes a wizard-like command to install/setup the GitHub action in a repo.
- Setup flow includes:
  - selecting a repo
  - choosing an existing agent (recommended) or creating a new one
  - creating a branch + opening a PR that adds the workflow files
  - merging the PR to enable the action
- Invoking the agent:
  - tag Letta Code on an issue
  - a GitHub Actions workflow runs and the agent works the task
  - you can monitor the run and open the ADE view to see full progress
- Each issue invocation creates a new conversation ID; if a PR is created from that issue, the conversation continues.

## Rules (how to operate if you adopt it)
- Use an existing agent when possible so the background agent already has repo memory.
- Treat issue prompts like delegating to a human:
  - be specific about desired outcome, constraints, and acceptance criteria
- Use PR-based changes (branch + PR) so output is reviewable.
- Keep GitHub CLI (`gh`) installed and authenticated wherever you run installs.

## Failure modes (how it breaks)
- Bad prompts → bad PRs (unclear scope, missing acceptance criteria).
- Secrets exposure if tokens are mishandled in repo/workflows.
- Confusion about conversations: each issue gets a new conversation; PR continues the same.

## Verification gates (commands that prove reality)
- Gate: workflow installed
  - confirm repo has `.github/workflows/...` for Letta Code action
- Gate: tagging triggers run
  - tag agent on a test issue → confirm Actions run starts
- Gate: agent outputs PR
  - confirm a branch + PR are created
- Gate: monitoring works
  - open run link → open ADE link → see agent progress

## Apply to Nico (our concrete changes)
- Use the same "queue is canonical" discipline for background agents:
  - background agents propose PRs; Nico promotes to canon.
- If we adopt GitHub Actions background agents, add an explicit security checklist (tokens, permissions).

## Present-day truth sources checked (documented)
- Docs:
  - https://docs.letta.com/letta-code/memory/
  - https://docs.letta.com/letta-code/changelog/
- GitHub:
  - https://github.com/letta-ai/letta-code

## Doc / GitHub deltas (video says → present-day docs/code)
- Video: "install GitHub app" wizard exists → Changelog/docs should be used to confirm the current slash-command name and the exact install flow in the current Letta Code version.

# 4.3 (done) Context Repositories: Git-backed Memory for Coding Agents (Deep Dive) — 2026-02-25 `R_4r_NNjg1M`

## Summary (1 paragraph)
- Context Repositories are a rebuild of Letta Code memory: expose memory as a local, git-tracked filesystem so agents can reorganize and maintain large memory systems using normal tools (files + bash), while keeping the “true” agent state on the server.

## Claims (what the video asserts)
- Context Repositories = git-based memory for Letta Code.
- They replace “memory tools only” workflows (memory blocks append/replace/delete) with file + bash workflows.
- The agent’s state still lives on the server; the local repo is a synced working copy.
- The file tree is always in context; the `system/` directory is pinned (always fully loaded).
- Git tracking gives a clean “who changed what” log, which is especially useful with reflection agents.
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

## Present-day truth sources checked (documented)
- Blog:
  - https://www.letta.com/blog/context-repositories
- Docs:
  - https://docs.letta.com/letta-code/memory/
  - https://docs.letta.com/letta-code/changelog/
- GitHub:
  - https://github.com/letta-ai/letta-code

## Doc / GitHub deltas (video says → present-day docs/code)
- Video: “the `system/` directory is pinned” → Docs confirm: `system/` is pinned; outside `system/` is visible but omitted.
- Video: “must commit + push to save memory edits” → Docs explicitly state commit + push are required for memory edits to be reflected.
- Video: “use /remember to actively direct memory updates” → Docs describe `/remember` as manual memory trigger.
- Video: “sleep-time / reflection agents run” → Docs include `/sleeptime` configuration and explain reminder-only vs auto-launch.

## Verification of our environment (commands run)
- `letta memfs status --agent <agent-id>` expects clean (`dirty=false`, `aheadOfRemote=false`)
- Memory repo:
  - `~/.letta/agents/<agent-id>/memory/`
  - `system/` contains pinned files

# 4.4 (done) LettaBot Tutorial: create a personal AI assistant with memory — 2026-02-21 `BroTeuvX0es`

## Summary (1 paragraph)
- LettaBot is an open-source wrapper around Letta Code that turns a terminal coding agent into a persistent personal agent you can talk to over channels (Telegram/Slack/Discord), and that can run proactively via heartbeats and scheduled jobs.

## Claims (what the video asserts)
- LettaBot (and similar tools) are servers/wrappers around coding CLIs.
- The wrapper provides:
  - channels (Telegram/Slack/Discord/etc)
  - scheduling (cron-like jobs)
  - heartbeats (periodic prompts)
  - polling (e.g., checking for updates)
  - skills/integrations management
- Heartbeats are triggers that cause the agent to run on its own.
- Pairing is used to control access.

## Rules (how to operate if you adopt it)
- One bot token → one poller. Never run two pollers on the same Telegram token.
- Keep secrets out of chat:
  - never paste API keys in Telegram
  - store secrets in files/env/1Password
- Use pairing/allowlist for DM access.
- Decide up front what proactive means:
  - heartbeat frequency
  - what the heartbeat prompt tells the agent to do

## Failure modes (how it breaks)
- Telegram 409 conflict when multiple processes poll the same token.
- Noise spam if heartbeat prompts are not tightly scoped.
- Security leakage if secrets or tokens are pasted into chat.
- Confusion when multiple channels are enabled without clear comms lanes.

## Verification gates (commands that prove reality)
- Gate: service is single-instance
  - `launchctl list | grep lettabot` (or your service label)
  - confirm only one poller is running for the Telegram token
- Gate: Telegram pairing works
  - unpaired user gets pairing prompt
  - paired user can message and receive replies
- Gate: heartbeat works and is safe
  - manual trigger (if available): send `/heartbeat`
  - confirm output is short + scoped
- Gate: logs exist and rotate
  - confirm log path is configured and receiving events

## Apply to Nico (our concrete changes)
- Keep Telegram as a single lane (DM only) unless we explicitly engineer routing.
- Define heartbeat prompt as a checklist with limits (no open-ended runs).
- Treat saved memory as committed + pushed.

# 4.5 (done) Letta Office Hours: Opus 4.6, LettaBot Updates, Agent File Directory, and More — 2026-02-06 `LKRnP-ptC4c`

## Summary (1 paragraph)
- Office hours covering Opus 4.6 release (and performance/cost tradeoffs), provider setup via `/connect`, model selection/refresh via `/model`, LettaBot’s role as the “personal agent” wrapper (remote channels + autonomous heartbeats/cron) with strong sandbox/security guidance, and a new/returning “Agent File Directory” concept (shareable snapshots stored in git).

## Claims (what the video asserts)
- Opus 4.6 became available (or imminently available) on the Letta API; may be available self-hosted earlier.
- Opus 4.6 is “subagent-happy” and less token-efficient than 4.5 → can cost more because it opens more context.
- Letta runs internal benchmarks (filesystem benchmark + skills benchmark) and tracks cost vs performance.
- Letta Code now has expanded provider support and onboarding via `/connect` (includes Codex/OpenAI login via OAuth; mentions OpenRouter + Bedrock requests).
- `/model` supports refreshing cached model lists (hit `R`).
- LettaBot/“Letot” (in the transcript) is a server wrapper around a Letta Code instance, enabling remote comms channels (Signal/Telegram/WhatsApp/Discord/Slack).
- LettaBot runs outbound-only connections (polling or outbound websockets), avoiding inbound gateway exposure.
- LettaBot is powerful/unrestricted and is susceptible to prompt injection; recommended deployment is a sandboxed machine.
- LettaBot supports heartbeats (autonomous “do what you want on a timer”), cron-like scheduled jobs, skills, and conversation-history search.
- “Agent File Directory” is simplified: agent files are committed as snapshots in a git repo (not live/synced agents).

## Rules (how to operate if you adopt it)
- Treat Opus 4.6 as higher-risk on cost: expect more context opens/tool calls; monitor usage.
- Use `/connect` for provider setup; treat provider auth as a first-class setup step.
- If `/model` list looks stale: refresh cached models (per video: `R`).
- For LettaBot:
  - deploy on a dedicated sandbox machine (Mac mini / separate host)
  - assume prompt injection risk; restrict what the bot can access
  - prefer outbound-only networking patterns
- Use heartbeats/cron only with tightly-scoped prompts and clear “what success looks like.”

## Failure modes (how it breaks)
- Cost blowups from token-inefficient models opening more context.
- Provider reliability variance (video calls out OpenRouter/provider inconsistency as a known issue class).
- Security incidents if LettaBot runs on a non-sandboxed machine with real credentials + broad filesystem access.
- Heartbeat autonomy can create noise or unintended actions if not constrained.

## Verification gates (commands that prove reality)
- Gate: provider setup is available
  - `/connect` shows provider toggles (Codex/OpenAI, etc.)
- Gate: model refresh works
  - `/model` then press `R` to refresh cached models
- Gate: LettaBot is outbound-only
  - confirm channel adapters use polling/outbound sockets (no inbound ports exposed)
- Gate: heartbeat + cron are functioning
  - verify heartbeat interval + that scheduled tasks run as expected

## Apply to Nico (our concrete changes)
- When considering Opus 4.6: treat it as an “opt-in” for expensive work (don’t default-switch blindly).
- Keep the sandbox rule for our always-on agent machine (already aligned).
- Keep heartbeats constrained and use watchdog pings (we just implemented one for the wizard).

## Present-day truth sources checked (documented)
- Docs:
  - https://docs.letta.com/letta-code/memory/
  - https://docs.letta.com/letta-code/changelog/
- GitHub:
  - https://github.com/letta-ai/letta-code
  - https://github.com/letta-ai/lettabot

## Doc / GitHub deltas (video says → present-day docs/code)
- Video: `/connect` and `/model` flows exist → Docs confirm `/connect` + `/model` are core commands; details may evolve by version.
- Video: LettaBot supports heartbeat/cron + outbound-only networking → LettaBot README confirms heartbeat + scheduling features and outbound-only design.
- Video: Agent File Directory is git-based snapshots → needs confirmation against current Letta Code docs/changelog for the exact current command naming and repo location.

# 4.6 (pending) Letta Office Hours: Introducing LettaBot + Claude Subconscious Demo — 2026-01-30 `M8LNa3FKE4k`
- Status: pending

# 4.7 (pending) Letta Office Hours: Letta Chat, GitHub Action, Letta Code, and more! — 2026-01-26 `fr61XHf6Zzw`
- Status: pending

# 4.8 (pending) Combine Letta Code with Obsidian — 2026-01-16 `YtZgsw9x8l8`
- Status: pending

# 4.9 (pending) Building Multi-Agent Systems with Letta — 2025-03-03 `LX-qO5o8iRQ`
- Status: pending

# 5) Cross-cutting topics (not tied to one video)

# 5.1 Conversations (Where did you go?)

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

# 5.2 Reflection / Sleep-time compute

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

# 5.3 Multi-Agent Systems (Team, without chaos)

## Claims
- Multi-agent works best with:
  - narrow roles
  - shared canonical truth
  - controlled memory writes

## Rules
- Specialists propose; Nico promotes to canon.
- Do not route multiple agents through the same Telegram bot token/poller.

## Failure modes
- Telegram bot conflicts if more than one poller uses same token.
- Drift if multiple agents write “truth” directly.

## Verification gates
- Comms lane audit: only one Telegram poller per token.
- Role audit: which agent is allowed to write which files.

# 5.4 LettaBot / Comms Architecture (stability first)

## Rules
- Telegram DM = Nico only (CEO desk).
- No multi-agent Telegram routing until explicitly engineered.

## Failure modes
- Group privacy + routing confusion.
- Poller conflicts.

## Verification gates
- Telegram is stable for 24h (no polling errors) after any change.

# 6) Source list (newest → oldest)
- 2026-02-26 `p7So3IM75WY` — Letta Office Hours: MemFS, Letta Chat, and the future of AI agent memory
- 2026-02-26 `j1agWxBx54E` — Create stateful background agents using GitHub Actions
- 2026-02-25 `R_4r_NNjg1M` — Context Repositories (Deep Dive)
- 2026-02-21 `BroTeuvX0es` — LettaBot Tutorial
- 2026-02-06 `LKRnP-ptC4c` — Office Hours
- 2026-01-30 `M8LNa3FKE4k` — Office Hours
- 2026-01-26 `fr61XHf6Zzw` — Office Hours
- 2026-01-16 `YtZgsw9x8l8` — Combine Letta Code with Obsidian
- 2025-03-03 `LX-qO5o8iRQ` — Multi-agent systems

# 7) Next
- For each pending video section above:
  - fill: Summary / Claims / Rules / Failure modes / Verification gates / Apply to Nico
  - add doc/GitHub deltas (what changed since the video)
