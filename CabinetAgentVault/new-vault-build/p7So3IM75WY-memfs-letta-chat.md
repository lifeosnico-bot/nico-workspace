---
title: "Letta Office Hours: MemFS, Letta Chat, and the future of AI agent memory"
date: 2026-03-01
tags: [letta, office-hours, letta-remote, lettabot, memfs, obsidian, multi-agent, onboarding, memory-hygiene, ezra, railway, sleep-time]
status: active
type: research
project: nico-agent
video_id: p7So3IM75WY
video_url: https://youtu.be/p7So3IM75WY
relevance: critical
presenter: Cameron (Letta team)
processed: 2026-03-01
processing_version: v2-full-reprocess
raw_transcript: "30-resources/letta/transcripts/Letta_Office_Hours_MemFS_Letta_Chat_and_the_future_of_AI_agent_memory.md"
---

# Letta Office Hours: MemFS, Letta Chat, and the future of AI agent memory

> **Why this file exists:** This is the fully processed deep-read of the MemFS Office Hours video. The 17m30s–20m30s section contains the definitive statement from Cameron (Letta team) on how LettaBot actually works, how Letta Remote differs, and how to think about deployment. This is the architectural foundation for the fresh LettaBot setup.
>
> **Previous processed note:** Was incomplete — missed key LettaBot/Letta Remote section details, Ezra architecture, and onboarding guidance. This version is a full re-process of the raw transcript.

---

## 🗂️ Video Summary

Office hours hosted by Cameron. ~60 min. Structure: slides overview of recent product updates → live demos → Q&A. Most valuable material for Nico project: 17m–22m (deployment decisions), 45m–50m (Obsidian demo), 58m–end (Ezra architecture + agent onboarding).

---

## 📦 Section 1 — Product Updates Overview

**What Cameron covers at the start:**
- Letta Code = the core engine. Powers LettaBot, the code SDK, and all the other surfaces. Where most Letta engineering effort goes.
- MemFS = biggest memory innovation in a while (full details below)
- GPT-5.3 codecs is out on the OpenAI API — mentioned for coding tasks
- **Memory Palace** = new UI for viewing what's inside agent memory. Built for MemFS but usable generally.
- **Slash command for GitHub Actions**: can now tag `@letta-code` in issues/PRs → agent goes and does the work automatically
- **Letta Remote** = new product surface (Cameron will demo later)

> *"Our number one thing is obviously Letta Code. We spend a lot of time working on that. It's kind of the core primitive that we have to make it so that your agents are deployable in local environments. You can use it as a coding agent, but it also powers LettaBot and the code SDK and all of those things."*

---

## 🧠 Section 2 — MemFS: What It Is and How It Works

**Old system:** Server-side memory blocks. You attach/detach them. They live on the Letta server. Clean, simple, but limited.

**MemFS shift:** Move memory from server-side blocks to something that looks like git. Instead of structured blocks, you check in a bunch of markdown files.

> *"The goal of MemFS is to move that memory to something that looks like git. And when you move to something that looks like git, you just check in a bunch of markdown files and your agent can do just like crazy memory operations because they're just like a bunch of files."*

**Two types of memory with MemFS:**
1. **Always-in-context memory** (system folder) — same concept as old memory blocks. Stuff the agent needs to know at all times: how to find information, general standing context, conventions.
2. **Out-of-context memory** (external files) — notes the agent can look up later using tools. No context window overhead.

**Why MemFS is better:**
- Full git versioning of all memory changes
- Agents must write commit messages to update memory → enforces intentionality
- Multiple agents can work on the same context repository simultaneously
- Git-style conflict resolution
- Letta Cloud handles syncing across devices

> *"It is git. So you can always just like check — you can make it so the agents have to write commit messages basically to update memory and you can parallelize any number of agents you want to work on the same context repository and everything is like versioned and has like git style conflict resolution."*

**⚠️ Self-hosted caveat — critical for Nico setup:**

Confirmed in live Q&A from community member "Signo":
> *"MemFS is not working yet for self-hosted. The GET endpoint is still not there."*

Cameron confirmed this. He had not tested MemFS on self-hosted himself.

**Decision for Nico:** Do NOT build fresh LettaBot setup around MemFS if running on M1 (self-hosted). Use regular memory blocks (core/recall/archival) + sleep-time compute. MemFS is cloud-only until further notice.

**Memory blocks in Context Repositories (for cloud users):**
- System directory of context repo = memory blocks
- They go directly into the context window exactly as before
- Agent can look at them via tools any time
- Standard development and memory policies as memory blocks

---

## 🖥️ Section 3 — ADE (Agent Development Environment) / Letta Chat

**What it is:**
- The IDE but with left and right bars removed
- Just: agent + context in the middle + "some magic stuff"
- Model selector added — can select reasoning model
- Reasoning toggle visible in bottom right
- In preview as of this video — not publicly released yet

> *"It looks like this. It's basically just the IDE but we removed all of the left and right bars. It's just super simple. You have an agent and you have stuff in the middle and some kind of magic stuff. We added model selectors. You can select reasoning now."*

**Letta Remote is integrated into ADE:**
- Environment selector in bottom left
- You create a named environment, assign an agent to it, then the agent runs in that environment
- ADE becomes your interface into a remote Letta Code instance

---

## 🚀 Section 4 — Letta Remote: Full Demo Notes

**Why Letta Remote exists:**
- Anthropic shipped Claude Code remote mode
- Letta had already built their own remote mode "like two or three days before that"

> *"We were irritated to see Anthropic come out with remote mode because we'd basically built our own remote mode like two or three days before that."*

**What Letta Remote actually is:**
- `letta remote` command → turns a Letta Code instance into a remote listener
- You can send it messages from Letta Chat, phone, or any interface
- The agent then operates on its machine
- Very clean, minimal — stays close to Letta Code

**Live demo steps Cameron walks through:**
1. Enter environment name (he names it "office hours")
2. Create agent: `letta new` (he names agent "office hours")
3. In ADE bottom left: select the environment
4. Point it at a git folder (he uses the SARS folder)
5. Agent runs bash commands inside that server
6. Agent can see files, run code, write output back to disk

**Concrete demo:** He asks the agent to write a pirate-haiku report about LA. Agent writes the file to disk on the server. He then reads it back — confirms agent has write access to the server filesystem.

**Railway Q&A — critical clarification:**

Community question: "How do you connect Letta Code with Railway? That's where I'm deploying LettaBot."

Cameron's answer:
> *"If you're using LettaBot you just have Letta Code — the underlying thing is Letta Code, that's like the engine. So anything you can do that you would do with Letta Code you can just do it through Discord."*

Another Q: "Can agents write/change files in their own VM instead of my machine?"
> *"That's Railway. Like, your Railway already has this. It's already a sandbox. So you know you have your agent named Flux — you can just say Flux like go edit stuff on this — it lives, it has its own computer that is LettaCode. So anything that you would want to do with LettaCode that agent can just do right. It has its own house with everything."*

**Current best deployment path:**
> *"Right now the best way is just like LettaBot — that's how you deploy remote instances. You already have what you're looking for."*

---

## ⚡ Section 5 — LettaBot vs Letta Remote: THE DEFINITIVE STATEMENT (~17m30s–20m30s)

This is the section that was missed in previous processing. Cameron's complete explanation:

**What Letta Remote IS:**
- Very focused, very precise
- Meant to manage a Letta Code instance that is "over there" that you can remote-control
- That's it — nothing more
- Stays super close to Letta Code
- Very direct experience
- Currently accessible through Letta Chat

**What LettaBot IS:**
- A consumer application
- Designed to build a personal assistant with access to lots of capabilities
- Glues a bunch of stuff on top of Letta Code: Telegram, Signal, attachments, connectors, direct response directives
- Trying to do what OpenClaw does but better ("with a server principle")
- OpenClaw = opinionated, lots of integrations, lots of opinions

> *"Let a bot is just Let a code with bells and whistles to make it easy to communicate from wherever. Letta remote is just a much much much simpler version of that."*

> *"Let a bot is a consumer application. It's a thing that is like designed to build a personal assistant that has access to lots of capabilities. So, let a bot is gluing a bunch of stuff on top so that it has a lot of power to make it a positive thing."*

**Will they merge?**
> *"I personally don't think they should merge because Letta Remote is very focused... meant to manage a Letta Code instance that is over there that you can remote control. That's it. LettaBot is a consumer application designed to build a personal assistant with access to lots of capabilities."*

**The deployment reality:**
- Letta Remote will get more connectors over time, but intentionally minimal for now
- LettaBot on Railway is currently the recommended way to get Letta Code remotely
- Over time Letta Remote will have more ways to access remote instances

### 🎯 Verdict for Nico Architecture

| Use Case | Tool |
|---|---|
| Vincent's personal CoS on M1 | **LettaBot** — Telegram, heartbeats, morning reports, personal assistant |
| Scale deployment / SaaS agents on Railway | **LettaBot on Railway** → will eventually use **Letta Remote** when connectors added |
| Lightweight intake agent | **Ezra Prime pattern** (lightweight, limited powers, escalates) |
| Heavy-duty power agent | **Ezra Super pattern** (LettaBot on Railway, Opus, full superpowers) |

---

## 🗂️ Section 6 — Cameron's Obsidian Setup (Live Demo)

**What Cameron shows:**

- Opens his actual Obsidian vault on screen
- His vault is "just a bunch of markdown files" — no MemFS
- Has a daily notes section, a "mosh pit" note (random thoughts), topic clusters (one called "Letta")

**The morning report:**
> *"My LettaBot creates a morning report for me and I can go look at the morning report. It gives me a bunch of AI news. It reads a bunch of RSS feeds. And these are connected and so one file references another file and it has a graph representation but it is maintained as a bunch of markdown files."*

**How wikilinks work in his vault:**
- `[[filename|display name]]` — square bracket syntax
- Files reference each other by path
- Obsidian shows graph view of all connections
- Cameron: "This is actually very easy. This is a super simple representation. It's just files under the hood."

**What Cameron's Obsidian vault reveals:**
- He does NOT use MemFS for his personal Obsidian vault
- Just vanilla Obsidian with markdown files + wikilinks
- LettaBot writes morning reports directly to the vault
- No special Obsidian plugin required on the Letta side

> *"My personal agent knows exactly how my Obsidian vault functions. It knows where things should go. It knows conventions about how I want notes handled, what kind of notes I want added and when."*

**Directly validates Nico's architecture.** The exact same stack: LettaBot → morning report → Obsidian vault with wikilinks.

---

## ⚠️ Section 7 — Memory Hygiene Warning

**Cameron's explicit warning about bad memory:**

> *"In places where it could be a hindrance is where your memory is bad. So, if you don't take care of your memory or your agent is an idiot and it fills it with gunk, or stuff that is outdated and it hasn't had an opportunity to clear up its memory, then it may just be very confused and do dumb things."*

**The reflection agent:**
- There is a built-in reflection agent in LettaBot
- Should be set up early — Cameron recommends it
- Purpose: reviews memory, identifies outdated entries, cleans up
- Cameron shows live: asks his agent to create a "memory loading guide" inside its own system prompt

**The memory loading guide concept:**
- Agent prepares instructions for itself on how to load/use external memory
- Goes in the system folder (always-in-context section)
- Helps the agent know where to look for things
- This is how agents bootstrap their own memory management

**Subconscious pattern (Cameron describes):**
- Sleep-time agent runs every other transaction
- Checks for memories that should be in archival memory
- Interjects a "thought" into the conversation context
- Cameron's setup: connects archival memory between sleep-time agent and primary agent
- Sleep-time agent reads archival memory for useful things, regularly updates a subconscious block
- Primary agent gets "messages from the subconscious"

> *"You can add a subconscious file to system that should be used by the reflection sub-agents to surface any useful information."*

---

## 🌐 Section 8 — Ezra Architecture: Multi-Agent Blueprint (~58m mark)

**Cameron reveals his own production multi-agent setup:**

**Ezra Prime:**
- Lightweight Discord agent
- Lives on the documentation (docs.letta.com "Ask Ezra" button)
- Server-side agent, NOT LettaBot
- Currently: no real powers
- One special tool: **escalation** — can send a message to Ezra Super
- Most memory management has been abstracted away from Ezra Prime

**Ezra Super:**
- LettaBot running on Railway
- Uses Opus model
- Has "a bunch of superpowers"
- Manages everything in the Letta org: documentation agent, Discord community responses, memory management
- Combs through conversations and manages knowledge

> *"Ezra Prime is the one that lives on the documentation... it has no real powers but it will soon. It has an escalation tool where it can send a message to Ezra Super. Ezra Super is a LettaBot that runs on Railway that runs on Opus that has a bunch of superpowers basically."*

**Note:** As of the Q&A section, Ezra is currently running on Kimi K2 (not Opus) due to cost constraints. Cameron says it's "annoying" — Kimi K2 ignores formatting instructions and writes excessive code. They're working on it.

### Direct mapping to Nico/SaaS org chart:

```
LIGHTWEIGHT INTAKE AGENT (Ezra Prime pattern)
  → lives on communication channel (Telegram/Discord/Slack)
  → minimal memory, minimal powers
  → one special tool: escalate to Heavy Agent
  ↓
HEAVY-DUTY AGENT (Ezra Super pattern)
  → LettaBot on Railway, Opus model
  → full superpowers, memory management
  → answers to Vincent, manages sub-agents
  → handles all the complex work
```

This IS the blueprint for the SaaS multi-agent org chart.

---

## 🧪 Section 9 — Agent Onboarding: How to Build Fresh Agent Knowledge

**Key insight on why old agents are better:**

> *"My agent will have a fundamentally better understanding of how Letta works because it's old. My agent is pretty old in terms of message count. I think I've had like maybe $1,200 of Opus credits that power this agent. So it's accumulated a lot of knowledge."*

**Don't manually load memory. Instead:**

> *"If you're on LettaBot you can just say to your agent: 'Hey, I would like you to learn how to use the Letta core API — can you go pull it, make a folder on your machine, go in there and run a bunch of code and play around with it, and use that information to store information you think is useful.' And so that's how you get the agent to learn stuff."*

**Agent onboarding pattern:**
1. Give the fresh agent access to the relevant docs/repos
2. Tell it what you want it to learn
3. It explores, runs code, plays around
4. It decides what information is useful and stores it in memory
5. Sleep-time agent consolidates what it learns
6. Repeat across multiple sessions — agent improves over time

**Note about system prompts for new agents:**
- Letta may now append MemFS instructions to system prompt of new agents automatically
- So new agents have baseline knowledge of the memory system they're working in

**Bottom line:** Don't front-load a fresh agent with everything at once. Give it the right tools and let it build its own understanding. It gets smarter the more you use it.

---

## 🔧 Section 10 — Scale and File Limits

Community Q: "At what point does a brownfield codebase with large amounts of memory start to break?"

Cameron's answer:
- System folder = stuff that should ALWAYS be in context (how to find info, general standing knowledge)
- Everything else = external memory (agent looks up via tools on demand = "progressive disclosure")
- There is no hard file-scale limit — just your file system + git repo size
- Letta hasn't tested it at huge scale, but "it's just a folder full of markdown"
- The system folder DOES have a context window limit — keep it for essential standing knowledge only

> *"The only limit is what's on your file system and the git repository and I think our blob store currently but there isn't really a file scale where it becomes a problem."*

---

## 💬 Key Q&A Nuggets

**Q: "How do you handle secrets for LettaBot environment variables?"**
Cameron: "Exactly the same as environment variables in any other context. The Railway template environment variable setup is clunky — I know it, I need to fix it."

**Q: "Will LettaBot and Letta Remote merge?"**
Cameron: "I personally don't think they should. LettaBot is a consumer application. Letta Remote is very focused on remote control. Different purposes."

**Q: "About Claude, Anthropic, and Palanteer — are you worried?"**
Cameron: "I think many of us are."

---

## 🎯 Extracted Architecture Decisions for Nico

### What this video confirms / locks in:

1. **LettaBot on M1 = correct.** It IS the best personal assistant platform. Cameron uses it daily. It does what OpenClaw does but better.

2. **LettaBot on Railway = correct for SaaS scale.** "That's currently the best way to deploy LettaCode remotely."

3. **MemFS = NOT for M1 self-hosted yet.** Self-hosted GET endpoint is missing. Use memory blocks + sleep-time.

4. **Fresh agent, not cloned agent.** Stale memory = confused, dumb agent. Start clean.

5. **Obsidian via markdown files, no MemFS needed.** Cameron's own setup uses plain markdown + wikilinks. Nico writes morning reports to vault files.

6. **Reflection agent + memory hygiene = day one.** Set up reflection agent early. Don't let memory fill with gunk.

7. **Ezra Prime/Super = the multi-agent pattern to follow.** Lightweight intake → escalate to heavy-duty Railway agent.

8. **Onboard by exploration, not by manual loading.** Tell agent to explore the docs, run code, store what's useful. Let it learn.

9. **Sleep-time from day one.** `enable_sleeptime: true`. The subconscious pattern starts working immediately.

10. **Agent gets better with use.** Cameron's most expensive agent = his most capable. This is a long game.

---

## 🔗 Related Notes

- [[LX-qO5o8iRQ-building-multi-agent-systems|Building Multi-Agent Systems with Letta]]
- [[BroTeuvX0es-lettabot-tutorial|LettaBot Tutorial: create a personal AI assistant with memory]]
- [[YtZgsw9x8l8-combine-letta-code-obsidian|Combine Letta Code with Obsidian]]
- [[M8LNa3FKE4k-lettabot-claude-subconscious|Letta Office Hours: Introducing LettaBot + Claude Subconscious Demo]]
- [[hFNWhrXukc0-archival-memory|Archival Memory: Build AI that remembers everything]]
- [[o4boci1xSbM-memory-blocks|AI Memory Architecture: How to Use Memory Blocks]]
