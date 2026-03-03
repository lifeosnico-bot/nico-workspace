---
title: "LettaBot Tutorial: create a personal AI assistant with memory"
date: 2026-03-01
tags: [letta, lettabot, tutorial, telegram, heartbeats, cron-jobs, skills, context-repositories, memory, setup, nico-agent]
status: active
type: research
project: nico-agent
video_id: BroTeuvX0es
video_url: https://youtu.be/BroTeuvX0es
relevance: critical
presenter: Sarah (Letta team)
processed: 2026-03-01
raw_transcript: "30-resources/letta/transcripts/LettaBot_Tutorial_create_a_personal_AI_assistant_with_memory.md"
---

# LettaBot Tutorial: create a personal AI assistant with memory

> **Why this note exists:** This is the official LettaBot setup tutorial — the most critical video for Nico's install plan. Covers what LettaBot is, how it relates to Letta Code, the full onboarding flow, heartbeats, cron jobs, skills, and context repositories. Prior sessions missed this entirely.

---

## 📦 Section 1 — What LettaBot Is

LettaBot is a server that wraps Letta Code (a coding CLI agent) to create a proactive personal assistant accessible via messaging channels.

> "LettaBots are essentially a wrapper around Letta Code to make it possible to create these personal agents that you can communicate through whatever channel you want — Telegram, Slack, Discord, etc. They're agents that can do work for you, are always there, and can even run on their own through cron jobs and heartbeats."

**What the server adds on top of Letta Code:**
- **Channel management** — Telegram, Slack, Discord, WhatsApp, Signal routing
- **Heartbeats** — periodic prompts sent to agent on a timed interval, triggers autonomous action
- **Cron jobs** — agent-scheduled recurring or future tasks
- **Polling** — e.g., Gmail monitoring for new email triggers
- **Skill management** — bundled and installable skills (CLI-based)

> "Basically anything you can do on your computer, your agent can probably do at this point."

**LettaBot vs OpenClaw:** Both are personal agent servers wrapping coding CLIs. LettaBot is built on Letta Code. OpenClaw is built on pyi (lightweight). Same concept.

---

## 🛠️ Section 2 — Setup Walkthrough (Exact Steps)

### Clone and Install

> "We don't have a package. The reason for that is it's actually a lot easier to use a fast-moving project like this when you can vibe code changes through LettaBot itself."

```bash
git clone https://github.com/letta-ai/lettabot.git
cd lettabot
npm ci          # (or npm install)
```

No published npm package — clone required. Intentional: lets agent modify its own server code.

> ⚠️ **GitHub Docs Correction (SKILL.md authoritative):** `npm ci` is incomplete. Full install path:
> ```bash
> npm install && npm run build && npm link
> ```
> `npm link` creates the global `lettabot` command. Without it, `lettabot onboard` and `lettabot server` will not work as bare commands. `getting-started.md` also uses `npm ci` but separately notes `npm run build && npm link` for the interactive path. Use SKILL.md as authoritative.

### Onboarding Wizard

```bash
npx lettabot onboard
```

Interactive steps observed:
1. Create new agent (or use existing)
2. Choose agent name (default: `lettabot`)
3. **Choose model** — Sarah picked Sonnet 4.5, noted miniax models also good
4. Choose channel — **Telegram** selected
5. Enter Telegram bot token (obtained from BotFather — "speak to this strange agent on Telegram")
6. Enable/disable **heartbeats** — Sarah set 30 min; recommended to increase interval to control costs
7. Enable/disable **cron jobs**
8. Connect **Google Workspace** (optional — enables gog/Gmail/Calendar skills)
9. Save and finish — creates a Letta agent

### Start Server

```bash
npx lettabot server
```

This starts the orchestration server managing channels, heartbeats, polling, and skill execution.

---

## 💓 Section 3 — Heartbeats

Heartbeats are periodic prompts sent to the agent on a timed interval, triggering autonomous action even without a user message.

> "Heartbeats are basically triggers — a prompt that gets sent to the agent on some periodic interval. It'll trigger the agent to run on its own, kind of like have its own hobbies."

**Manual trigger for testing:**
```
/heartbeat
```
This bypasses the timer and fires a heartbeat immediately.

### Heartbeat behavior by model

> Default Sonnet response to heartbeat: "No reply." — boring.

> Opus response: "Good moment to reflect on my first real experience with Sarah and update my memory." — proactive memory update without prompting.

**Key insight:** Opus uses downtime to reflect and update memory. Sonnet does not. For a personal CoS that should proactively grow and learn, Opus (or a capable model) matters for heartbeats.

⚠️ **Cost note:** Heartbeats invoke the model on every tick. At 30-min intervals with a long-running server, this adds up. Sarah recommended increasing the interval if cost is a concern.

### ⚠️ GitHub Docs Correction — Heartbeat Silent Mode (CRITICAL)

Heartbeats run in **Silent Mode**. The agent's text responses do NOT auto-deliver to Telegram. To send a message during a heartbeat, the agent must explicitly call:

```bash
lettabot-message send --text "Your message here"
```

**Two prerequisites for this to work:**
1. Bash tool must be enabled (`features.allowedTools` must include `Bash`)
2. The user must have messaged the bot at least once

**Impact on Nico:** Without this, Nico's morning reports and heartbeat check-ins silently execute but never arrive in Telegram. The bootstrap prompt and heartbeat prompt must explicitly instruct Nico to call `lettabot-message send`.

### Heartbeat YAML Config (from docs, not in video)

```yaml
features:
  heartbeat:
    enabled: true
    intervalMin: 60
    skipRecentUserMin: 5
    prompt: "Check your task list and send Vincent a morning briefing."
    promptFile: ~/.lettabot/heartbeat-prompt.md
```

`skipRecentUserMin: 5` — heartbeat skips if the user messaged in the last 5 minutes (prevents interrupting active conversations). `promptFile` allows maintaining a separate markdown file for the heartbeat prompt.

---

## 📅 Section 4 — Cron Jobs and Scheduling

The agent has a built-in `cron` skill that lets it schedule tasks for itself.

> "One of the built-in skills the agent has is this cron skill — basically a pre-built CLI that we've bundled inside of LettaBot for the agent to use for this explicit purpose: scheduling things for itself."

Example from demo:
- User told agent: "In a few hours around 11pm, remember to text me to go to bed."
- Agent used cron skill to create a scheduled task — no human config needed.

Scheduled tasks persist locally. Agent can list them:
> Agent: "I have one bedtime reminder scheduled."

---

## 🎯 Section 5 — Skills

Skills extend the agent's capabilities via CLI tools.

**Built-in LettaBot skills (bundled):**
- `gog` — Google CLI (Gmail, Calendar, Drive, Sheets)
- `cron` — scheduling CLI

**Letta Code skills (included by default, can disable):**
- Memory-specific tools designed for Letta agent memory hygiene

**Global skills (pre-installed by user):**
- Any skill the user or agent has previously installed

**Skill installation options:**
1. `skills.sh` — community skills repo
2. `cloudub` — large number of pre-built skills
3. Agent self-installs: tell the agent what you want, it finds or creates the skill

> "I would in general recommend just having your agent add skills to itself because there's really no need for you as a human to do it."

**Skill acquisition flow (observed):**
1. Tell agent: "I want you to learn how to use Linear. Find yourself a skill."
2. Agent researches the API / reads docs
3. Agent designs CLI for the skill
4. Agent tells you what API keys it needs
5. Agent creates and installs the skill itself

🎯 **Verdict for Nico:** Skills are self-managed. Minimal human setup. Just tell Nico what integrations you want and let it configure itself.

---

## 🧠 Section 6 — Context Repositories (Memory Architecture)

> "A lot of Letta Code agents essentially now use something called context repositories. They have a local copy of their memory filesystem on the local machine. They will push it over time — once they push their changes to their memory repository, it'll show up in the ADE."

**Architecture:**
- Agent memory = a local git repository (file system of memory files)
- "In system" files = always in context window
- Files outside "system" = accessible but not always pinned to system prompt
- Agent edits memory via bash commands (not JSON patches)
- Changes are pushed to server — ADE shows server's copy (slightly stale)

**Observed in demo:**
- Sarah said her name
- Agent used bash to edit memory file: changed "I don't know anything about this person yet" → "This is Sarah"
- Git log showed the commit: memory edit during Opus heartbeat reflection

> "This is all like a normal git repo. You can see all those changes."

⚠️ **Important update vs. old research:** Context repositories appear to be the new standard replacing traditional memory blocks for Letta Code agents. This is a significant architecture shift — detailed in `R_4r_NNjg1M`.

---

## 🔌 Section 7 — Accessing Agent via Multiple Surfaces

The same Letta agent can be accessed from:
1. **Telegram** (or other channels) — via LettaBot server
2. **ADE (Agent Development Environment)** — web UI, see memory, message (limited tools)
3. **Letta Code CLI** — direct terminal access using agent ID

```bash
letta agent <agent-id>
/memory          # view memory blocks
/search linear   # search conversation history
```

Messages via LettaBot are on a **separate conversation thread** (not the main thread). This is by design — the server routes messages into specific conversations.

> "Whenever you're talking to the agent through LettaBot, it's actually through a conversation — not on the main thread."

⚠️ **ADE caution:** The ADE only has server-side tools. Messaging from the ADE means the agent can't access your local machine. Always use Telegram (or LettaBot channels) for full-capability sessions.

---

## 🏗️ Extracted Architecture Decisions for Nico

1. **LettaBot setup = clone → `npm install && npm run build && npm link` → lettabot onboard → lettabot server** — `npm link` required for global `lettabot` command
2. **No npm package** — always clone and run from source
3. **Heartbeat Silent Mode** — agent must call `lettabot-message send --text "..."` to deliver messages; Bash tool must be enabled; user must have messaged first
4. **Heartbeat interval: recommend > 30 min for cost control** — start at 60 min, tune from there
5. **Heartbeat prompt configurable in YAML** — use `features.heartbeat.prompt` or `promptFile` for Nico's morning briefing instructions
6. **Enable cron jobs from day one** — core capability for a personal CoS
7. **Skills are agent-managed** — tell Nico what to learn, let it self-install
8. **gog CLI** = the right path for Google Workspace integration (Gmail, Calendar)
9. **Context repositories = current memory architecture** — memory is a local git repo, not just blocks
10. **Opus gives richer heartbeat behavior** — Sonnet is passive, Opus is proactive during downtime; GPT behavior during heartbeats unknown — may require prompt tuning
11. **ADE is read-heavy** — don't primary-work from it; use Telegram/LettaBot channels
12. **Telegram token = BotFather** — quick setup, no API key required beyond bot token

---

## 💡 What This Means for Nico

- The install plan's LettaBot setup section needs to follow the onboarding wizard flow exactly as shown here — this is the authoritative source
- Skills are not a one-time config job — they're an ongoing capability the agent grows itself
- The Google Workspace connection at onboarding is the unlock for Gmail/Calendar automation
- Heartbeat design matters: prompt the agent during downtime on what to do (e.g., reflect on memory, review task list)
- Context repositories confirm that Nico's memory lives as a local git repo — this integrates with the vault-as-bridge pattern (Claude Code writes files, LettaBot reads them via its memory repo)
- Model choice for heartbeats: GPT (Vincent's locked choice) should behave similarly to Sonnet — may need prompt tuning to get proactive heartbeat behavior

---

## 🔗 Related Notes

- [[p7So3IM75WY-memfs-letta-chat|MemFS, Letta Chat — LettaBot vs Letta Remote]]
- [[M8LNa3FKE4k-introducing-lettabot|Introducing LettaBot + Claude Subconscious Demo]]
- [[LKRnP-ptC4c-lettabot-updates|Opus 4.6, LettaBot Updates — current state]]
- [[R_4r_NNjg1M-context-repositories|Context Repositories — memory architecture deep dive]]
- [[6baCKzLmslQ-telegram-integration|Telegram Integration (older pattern)]]
