---
title: "Create stateful background agents using GitHub Actions"
date: 2026-03-01
tags: [letta, github-actions, stateful-agents, background-agents, memory, ci-cd, nico-agent]
status: active
type: research
project: nico-agent
video_id: j1agWxBx54E
video_url: https://youtu.be/j1agWxBx54E
relevance: high
presenter: Letta team (unnamed presenter)
processed: 2026-03-01
raw_transcript: "30-resources/letta/transcripts/Create_stateful_background_agents_using_GitHub_Actions.md"
---

# Create Stateful Background Agents Using GitHub Actions

> [!info] Context
> This video demonstrates the Letta Code GitHub Action — a feature that turns any Letta Code agent into a background agent that can respond to GitHub events (issues, PRs) via `@letta-code` mentions. The agent runs inside a GitHub Actions runner but retains persistent memory across all runs through Letta's context repository system. Key relevance to Nico: this is the mechanism by which a Letta agent can operate autonomously on code events without requiring a local machine to be running.

---

## 1. What the Letta Code GitHub Action Does

The Letta Code GitHub Action converts any existing Letta Code agent into a background worker that triggers on GitHub events. The core value proposition is:

- An agent can be invoked from any GitHub issue or PR by tagging `@letta-code`
- The agent runs inside the GitHub Actions runner (no local machine required)
- The agent's memory persists across all invocations because it is backed by a remote Letta server
- Conversations can be resumed locally using the Letta CLI

> "This makes it really easy to turn any existing Letta Code agent into basically a background agent. So you can get the agent to run on different issues or review PRs and it all runs inside of GitHub Actions."

---

## 2. Installation Process

The setup is a wizard-driven process via the Letta CLI. Prerequisites and steps:

**Prerequisites:**
- Letta Code already installed (`letta code`)
- GitHub CLI installed and authenticated with correct credentials

**Installation command:**
```bash
letta code install-github-app
```

This wizard prompts for:
1. Target repository (select from your repos)
2. Whether to use an existing agent or create a new one

> "I can actually use my current existing agent. I would actually generally recommend this because your current agent probably already has a lot of memory and information about your repository."

The wizard then:
- Retrieves repository information
- Creates a branch
- Opens a pull request that adds the GitHub Actions workflow file to the repo

Once that PR is merged, the action is live.

---

## 3. How Invocation Works

After installation, triggering the agent is simple:

- Open or comment on any GitHub issue or PR
- Tag `@letta-code` with a task description
- A GitHub Actions job fires, installs Letta Code, and invokes the agent

**Example issue body used in demo:**
```
Move all sub agents to use opus 4.6. Work on this and create a PR.
```

> "In general, you're going to want to add a lot more detail than I'm actually adding here. Think of it as delegating a task to a human. You want to ideally be as specific as you can and be very instructive."

The agent posts progress updates back to the issue as it works, and when done, opens a PR.

---

## 4. Conversation Model and Statefulness

This is the critical architectural detail: each invocation creates or continues a conversation, and that conversation is tied to the agent's persistent memory.

**Rules:**
- First invocation on an issue = new conversation
- First invocation on a PR = new conversation
- If the agent creates a PR from an issue, subsequent `@letta-code` on that PR = same conversation continues
- Every conversation has a unique ID visible in the Letta UI

> "Every single time you invoke the agent from an issue, it'll actually create a new conversation. So you can see that these are basically the issues that we've had the agent work on. You can see the unique conversation ID. So you can even resume this conversation locally using this ID."

**To resume a conversation locally:**
```bash
letta --agent <agent-id> --conversation <conversation-id>
```
(or copy the resume command directly from the Letta UI)

---

## 5. Memory Initialization and Bootstrapping

A freshly created agent has empty memory. The presenter demonstrates the recommended initialization flow:

**Step 1 — Check memory:**
```bash
letta --agent <agent-id>
```
Inspect the core memory section — a new agent will have nothing.

**Step 2 — Enable MESSES (new memory feature):**
The presenter checks that the new memory system (`messes`) is enabled. Notes it should be on by default for GitHub Actions agents.

**Step 3 — Run `init`:**
```bash
> init
```
This triggers the agent to explore the repository, build its initial memory structure, and begin learning about the codebase and preferences.

> "I generally recommend running this with all agents. You want your agents to have some time to kind of process the existing repository for memories, decide all their memory structure, and ideally it's like a very interactive process. This is kind of some time that you should spend with new agents to help them kind of learn about your work and your preferences."

**Step 4 — Add persona customization:**
The presenter asks the agent to create code review guidelines in its persona or a dedicated memory file. The agent creates a new memory file for itself.

**Memory sync:**
Memories created locally are synchronized to the remote server. Future GitHub Actions runs will have access to all locally built memory.

> [!warning] Memory Recompilation Delay
> "The agent will not necessarily always immediately see the new memories, since we sometimes will delay the recompilation of the system prompt to avoid cache evictions. It's only on compactions, new conversations, or message resets that all the memory gets reflected."
> Practical impact: build memory before the first real task run. New issues always create new conversations, so memory will be fresh on the next run.

---

## 6. Viewing Agent Progress

During a run, the GitHub Actions log links to the Letta UI for live progress viewing:

- System reminder (built-in instructions) visible
- Full action trace: file reads, edits, decisions
- Can edit the agent model or prompts from the UI mid-run (normal Letta Code behavior)

> [!warning] UI is View-Only for Conversations
> "I would kind of recommend using the AD [agent dashboard] for viewing only." For actual interaction or feedback, resume the conversation locally via the CLI. The UI can display the conversation but the agent won't have an execution environment to run in.

---

## 7. Memory Architecture — Context Repositories

Memory persistence across GitHub Actions runs is handled by Letta's context repositories (git-backed memory). All memories are synchronized through this system whether created locally or remotely.

> "The Letta Code agents running through the GitHub Action will also of course have access to the same memories that it builds up locally or remotely because all the memories are synchronized through the context repositories."

This means:
- Local memory work carries forward to all future CI runs
- The agent does not start from scratch on each GitHub Actions invocation
- Memory built during one task informs all future tasks

---

## 8. Extracted Architecture Decisions for Nico

| Decision | Detail |
|---|---|
| Background agent trigger | `@letta-code` mention in GitHub issue or PR |
| Stateful memory mechanism | Context repositories (git-backed, synced local + remote) |
| Conversation continuity | New conversation per issue/PR; same conversation continues if agent creates the PR from an issue |
| Local resume | Any GitHub Actions conversation can be resumed locally via CLI with conversation ID |
| Memory initialization | Run `init` command after creating a new agent; spend interactive time before first real task |
| Memory recompilation | Only on compactions, new conversations, or message resets — not instantaneous |
| MESSES | New memory feature; should be enabled by default for GitHub Actions agents |
| UI use | Letta UI is view-only for active runs; use CLI for interaction |
| Model editable mid-run | Yes, via Letta UI — same as any Letta Code agent |

---

## What This Means for Nico

**Can Nico run as a background agent on GitHub events?**

Yes, with qualifications. The Letta Code GitHub Action is designed for software development tasks — PR review, issue resolution, codebase changes. Nico's use case is a personal CoS on an Obsidian vault, not a code repository. However, several patterns transfer directly:

**Directly applicable:**
- The memory persistence model is identical to what Nico needs: stateful agent with memory that accumulates over time, accessible whether running locally or in a triggered environment
- The `init` / memory bootstrapping workflow is the right model for onboarding a new Nico agent — spend interactive time building memory before live operation
- The conversation resume pattern (copy ID, resume locally) is a workflow Nico should support: Vincent should be able to resume any prior conversation for inspection or feedback

**Not directly applicable to current Nico build:**
- Nico is not being triggered from GitHub events (no code repo to watch)
- The `@letta-code` trigger mechanism is specific to the Letta Code GitHub Action, not LettaBot
- Vault operations are Claude Code's lane (read/write), not Letta's

**Potential future use:**
If Nico's scope expands to include the SaaS codebase, the Letta Code GitHub Action is a known-working path to background code agents with full statefulness. The architecture is already proven.

> 🎯 Verdict: This video is primarily valuable for understanding how Letta's memory persistence works in non-local triggered contexts, and for the memory bootstrapping workflow. The GitHub Actions mechanism itself is not part of the current Nico build, but the memory architecture patterns apply directly.

---

## Related Notes

- [[BroTeuvX0es-lettabot-tutorial|LettaBot Tutorial]]
- [[p7So3IM75WY-memfs-letta-chat|MemFS, Letta Chat]]
- [[LX-qO5o8iRQ-building-multi-agent-systems|Building Multi-Agent Systems]]
