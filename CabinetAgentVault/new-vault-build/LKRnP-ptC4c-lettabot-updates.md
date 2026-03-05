---
title: "Letta Office Hours: Opus 4.6, Lettabot Updates, Agent File Directory, and More"
date: 2026-03-01
tags: [letta, office-hours, lettabot, opus-4-6, agent-file-directory, updates, nico-agent]
status: active
type: research
project: nico-agent
video_id: LKRnP-ptC4c
video_url: https://youtu.be/LKRnP-ptC4c
relevance: critical
presenter: Cameron (Letta team)
processed: 2026-03-01
raw_transcript: "30-resources/letta/transcripts/Letta_Office_Hours_Opus_46_Lettabot_Updates_Agent_File_Directory_and_More.md"
---

# Letta Office Hours: Opus 4.6, Lettabot Updates, Agent File Directory, and More

> [!info] Context
> This is a processed research note from a Letta Office Hours livestream hosted by Cameron. It covers the release of Opus 4.6, the current state of LettaBot, the new Agent File Directory, multi-agent collaboration patterns, model cost/performance benchmarks, and live Q&A from the community. This is the most recent video in the Letta research set and is directly relevant to building Nico. Many features described here were not present in earlier videos.

---

## 1. Opus 4.6 Compatibility and Performance

Opus 4.6 was released the morning of this office hours session. Cameron confirmed a pull request to make it available on Letta Cloud went out the same day.

> "Opus 4.6 came out and like this morning, like a few hours ago, we have a pull request to put it up on Letta cloud, which means it will be broadly available for you if you're using the Letta API. It may already be available on self-hosted."

**Benchmark results (Letta's internal leaderboards):**

- **File system benchmark** (agentic search over file systems): Opus 4.6 takes first place at 83% vs GPT-5.2 with extra-high reasoning at 82.61%. Opus 4.5 was in third.
- **Skills benchmark**: Opus 4.6 takes third place, behind GPT-5.2 extra-high and high reasoning, but above Opus 4.5 and Sonnet.

**Cost warning — critical:**

> "4.6 is much more expensive because it's not very token efficient. You can check out the updates thing, but basically it's the same price as Opus, but it's much less token efficient. So it tends to just like kind of open a bunch of stuff."

Cameron explained this is likely because Opus 4.6 has a **1 million token context window and 128,000 output tokens**, and it tends to pack everything into context aggressively. It excels at needle-in-a-haystack tasks and agentic search.

⚠️ **Cost implication for Nico**: Opus 4.6 may cause significantly higher token usage than 4.5. This affects cost planning, especially for a personal CoS agent running on OpenAI GPT via Pro subscription. Monitor token burn carefully if using Anthropic models via bring-your-own-key.

**Sub-agent behavior in 4.6:**

> "I've been told by our research guy that it's really really like sub-agent happy. It tends to invoke a lot of sub-agents."

Cameron notes that with Opus 4.6 via Letta Code, an agent can fork itself and invoke existing agents by ID, enabling massively parallel sub-agent patterns.

**Gemini Flash performance:** Ranked #13 on file system and #17 on skills benchmarks — bottom tier.

**Kimi K2.5 status:** Cameron cautions against using Kimi K2 through Open Router due to consistency issues. First-party provider support for K2.5 still in progress.

---

## 2. LettaBot — Current State and Updates

### What LettaBot Is

Cameron gave the clearest explanation of LettaBot's architecture yet:

> "Letot takes a underlying Letta code instance and teleports a Letta agent on your server into that Letta code instance and then we provide a communication infrastructure on top of that instance. What that means is that you can access that Letta code instance remotely through any channel — through Signal, Telegram, WhatsApp, Discord, and Slack."

The "brain in a jar" analogy:
- A pure Letta agent on a server = brain in a jar. Smart, stateful, but no tools, no powers.
- Letta Code = puts the brain into a Mecha robot. The agent has full bash tools, superpowers, can do anything Letta Code can do.
- LettaBot = lets you **remote-control** the robot from anywhere in the world via messaging channels.

> "Letot converts your stateful Letta agent from a very intelligent persistent brain in a jar to an immortal monster-punching robot that can solve a bunch of problems."

### Configuring an Existing Agent in LettaBot

> "You can basically set the Letta agent ID inside of your configuration file when you start up Letabot and that'll just like port in whatever agent you have. It's just by agent ID."

This is the correct path for Nico: configure LettaBot with an existing agent ID, not create a new default agent from scratch.

### Heartbeat and Cron

Cameron confirmed these features are live and working:

- **Heartbeat**: Configurable timer that fires when nobody has messaged the agent — "do whatever you want on a timer." The agent can mull, think, do autonomous work.
- **Cron**: The agent can schedule its own recurring tasks. Cameron's personal agent scheduled a 7am FastMail email briefing and an 8:30am AI news summary after being asked once.

> "I just like asked my agent. I was like, I use fastmail as my personal email and I said can you go write code to look at my email account and give me an email briefing in the morning... And then I asked it to just do that every morning at like 7:30. And so it set a cron job."

🎯 **Verdict**: Heartbeat and cron are production-ready. These are the backbone of Nico's autonomous behavior. The agent building its own skills and scheduling its own routines is validated as a real workflow.

### Skills

> "Letot has access to any skill. You can even ask it to build a skill."

Cameron's agent built:
- A FastMail JMAP API skill from scratch
- An AI RSS aggregator skill with 13 feeds and a 7-day rolling window
- A Linear ticket-creation skill

Skills can be downloaded from the community or generated on demand.

### Security Model

LettaBot uses **polling or outbound WebSocket connections** — no inbound connections, no exposed ports. This addresses the major OpenClaw security concern (300 exposed ports). However:

> "This is an agent that is running unrestricted tool use, bash commands, bash access, all that stuff on its underlying machine. It is susceptible to prompt injection of tasks. Be careful. We highly recommend deploying on a sandboxed computer, a separate machine that is dedicated for it."

🎯 **Verdict**: Sandboxed machine is the right call for Nico. Confirmed the Railway template is the recommended cloud deployment path. Raspberry Pi is also viable.

### Multi-Agent in LettaBot

Currently: **one LettaBot instance = one agent**. Multiple agents require multiple LettaBot server instances with separate configurations.

> "You can also probably quick deploy a particular agent and switch in case you want to have many agents that have different things. Your agents can also deploy each other as tasks."

Multi-agent support (multiple agents, one server, multiple channels) is in development with existing issues and PRs. Cameron expects it to arrive relatively soon — configuration becomes an array of workspaces.

### Model Field in Config

⚠️ Cameron flagged the model field in the LettaBot config file as misleading/legacy:

> "The preference currently is to not change the model if the agent already exists. So that model field inside of the configuration file isn't actually that actively used."

He opened an issue to remove it. Do not rely on this field for model configuration — manage model selection through the ADE or the `/model` command in Letta Code.

> ⚠️ **GitHub Docs Confirmation:** `LETTA_MODEL` environment variable is confirmed **removed** from current LettaBot. Model is set server-side via:
> ```bash
> lettabot model set <model-handle>
> ```
> Or via `/model` command inside Letta Code. Do not configure model in `lettabot.yaml` or via env var.

---

## 3. Agent File Directory

A new (re-launched) Agent File Directory is live. It is significantly simpler than the old version.

> "The agent file directory is back and it is massively simplified. It's not a thing you can like auto-publish to on Letta Cloud. It is just a git repository with a nice-ish front end on top of it."

Key details:
- Lives at a GitHub repository (agents directory).
- Agents are not live/synced — they are **snapshots** (committed agent files).
- To submit: go into the agents directory, add your GitHub handle as owner ID, agent name, agent file, a README, and a `.webp` image.
- Cameron's practice: ask the agent to prepare its own README explaining why someone would download it.
- You can preview memory blocks, system prompts, and available tools on the directory page.

⚠️ **Version compatibility**: Very old agent files may not import correctly. Recommended fix: upload old agent file to Letta API, download again to get the current format. Going forward, the format should be backwards-compatible.

For Nico: this is where a finalized Nico agent file could eventually be published as a shareable artifact.

---

## 4. Provider Support and Model Selection Updates

### `/connect` Command Expansion

Letta Code now has an expanded `/connect` command with toggles for:
- **Codex / OpenAI Pro** (`/connectcodex` → OAuth into OpenAI, then use models prefixed `chatgpt-plus` or `chatgpt-pro`)
- **Z.AI** (API key)
- **MiniMax** (first-party)
- **Google Gemini** (first-party)
- **Open Router** (first-party, new — some bugs still being resolved)
- **Bedrock** (enterprise contracts)

> "If you are self-hosted, please go either use this through Letta Code to set up Open Router or you can go to the project view inside of the Letta ADE. On the top right you'll see 'Manage LLM Keys'."

Cameron confirms: to use OpenAI via Codex/Pro subscription (no API cost), use `/connectcodex`, OAuth in, then select a `chatgpt-plus-...` prefixed model from the model dropdown.

🎯 **Verdict for Nico**: This is the confirmed setup path for Vincent's plan to use OpenAI GPT via Pro subscription at $0 API cost. No separate OpenAI API key needed.

> ⚠️ **GitHub Docs Note:** `/connectcodex` is not documented in `docs.letta.com` public docs. It appears in this video only. The docs confirm GPT is supported and the `chatgpt-plus-...` model prefix is valid. The OAuth path likely works but must be done interactively in Letta Code — it cannot be scripted. Plan for this step to require an interactive Letta Code session at install time.

---

## 5. Context Repositories / Memory Architecture

Cameron did not introduce new memory architecture changes in this session. However, there was a notable comment about **archival memory strategy for Ezra** (Letta's Discord support agent) that is architecturally relevant:

> "Every time we build the documentation I clear its archive and then re-upload a bunch of archival memories that are each document inside of our documentation. So it can do semantic search across documents."

He also mentioned that **agentic search beats RAG** for retrieval:

> "Boris, who's the Claude Code creator, basically said when they started with Claude Code, they were using all this RAG stuff and indexing and semantic search and blah blah blah and then they just canned it. They just turned it all off because it was confusing and bad and they basically just tilted towards agentic search. Give your agent bash, tell it to look around and it does way better than anything that has to do with RAG."

Cameron agrees with this direction. Letta's position: **statefulness is more important than retrieval**. Memory = the totality of who you are, including how you think, not just what you can look up.

---

## 6. Ezra — Internal Agent Architecture Pattern (Directly Relevant to Nico)

Cameron described a sophisticated pattern for Ezra (Letta's public-facing Discord agent) that has direct relevance to Nico's design:

**The Ezra Split:**
- **Ezra Prime** = the "lobotomized" public-facing Discord agent. Constrained, focused. Runs on Sonnet (downgraded from Opus due to $800-1,000/day cost).
- **Ezra Super** = the internal version, running on LettaBot on a Railway instance. Has a Letta API key, can modify Ezra Prime's memory directly, can run code, can self-modify.

**Ezra Super's role:**
> "I have basically started to lobotomize the Ezra that is on Discord... I have a skill on a heartbeat. It will go look at Ezra's most recent conversations in the Discord and then offer to like help modify things inside of Ezra Prime's memory. The goal is essentially that we're going to have an external monitor to Ezra that is basically like sleep time on crack."

This is **sleeptime on crack**: an external agent monitors the primary agent's conversations, prunes, trains, and improves it asynchronously — without interrupting live sessions.

**Escalation pattern**: When Ezra Prime starts hallucinating or "spinning out," it can escalate to Ezra Super, which has a better model and can run verification code.

🎯 **Verdict**: This is a mature multi-agent architecture pattern worth considering for Nico V2. For now, a single LettaBot agent is correct. But the external monitor / sleeptime-on-crack pattern is worth noting for when Nico grows.

---

## 7. Claude Subconscious — Current Status

Claude Subconscious is Letta's attempt to give Claude a "subconscious" — a separate Letta agent that monitors the transcript and feeds information back during tool calling.

> "A lot of people use it and then I don't get a ton of feedback because it just like kind of just happens to do stuff."

Issues raised in chat:
- Some users reported `claude.md` updates going "psycho" (runaway rewriting).
- Cameron: TTL on updates is a reasonable request — open a PR.
- Community view: the `claude.md` approach is the right direction, needs polish.

For Nico: Claude Subconscious is not part of the initial build plan. Noted as an experimental feature with rough edges.

---

## 8. Letta Co-Work (New Frontend)

Cameron briefly demoed a new frontend called **Letta Co-work** — a fork of Anthropic's Claude Co-work (originally called Open Work).

> "This is just also the agent SDK. So, this can do the exact same stuff that you can do with Letterbot, but it's kind of like a nice Electron framework."

- Open source.
- Letta Code SDK under the hood — full feature parity with LettaBot.
- Mac/Linux/Windows (Electron app).
- Still in early/demo state — conversation backfilling broken, some bugs.
- Cameron asked the community to signal interest if they want Letta to invest more here.

For Nico: not relevant for initial build. Telegram is the interface.

---

## 9. Raycast Extension

A community member (John Wessel) built a Raycast extension for Letta. Cameron demoed it briefly — allows messaging a Letta agent directly from the Mac menubar/Raycast interface. Limitation: only loads 50 most recent agents for client-side filtering (no server-side search). Cameron opened a PR to address agent management in the extension.

---

## 10. Q&A — Key Topics

**ChatGPT history migration:**
Recommended approach: export ChatGPT data, concatenate into a single file, upload to Letta File System, let agent peruse it asynchronously on heartbeat and self-selectively store relevant items to memory blocks.

**OpenAI-compatible endpoint for LettaBot:**
Does not exist yet. Cameron asked Co (his personal agent) to open a GitHub issue. It is a stated priority.

**Can LettaBot be used with a self-hosted Letta server?**
Yes. Works with both self-hosted and Letta Cloud — configured by agent ID.

**Multiple LettaBot workspaces (one server, many agents):**
Not yet supported. In development. Configuration will become an array of workspaces, one entry per agent, each with its own channel assignments.

**Agent self-modifying its model:**
Possible via the Letta API. Cameron's internal agent "central" does this. Can be implemented as a skill that calls the Letta API to change its own model dynamically (e.g., Haiku → Sonnet → Opus depending on task).

**Context window for 1M tokens on Letta Cloud:**
Cameron is not sure if this is available on non-enterprise plans. Letta Cloud may be capped at 200K. He said he would check.

**Letta vs. memory-layer startups (e.g., Mem0, SuperMemory):**
> "They're all retrieval tools. It is semantic search and some really cool retrieval tools, but it is retrieval. We don't have that... Statefulness is significantly more important."

Letta's position is that persistent stateful identity (how you think + what you know) beats pure retrieval layers. Cameron cited the Claude Code team disabling all RAG as validation.

---

## Extracted Architecture Decisions for Nico

1. **Use LettaBot configured with an existing agent ID** — do not create a new default agent; port in the fresh agent by ID from the config file.
2. **Enable heartbeat from day one** — confirmed production-ready. This is where Nico's autonomous behavior lives.
3. **Enable cron scheduling** — Nico can schedule its own recurring tasks (morning report, etc.) without external infrastructure.
4. **Skills are the extension mechanism** — ask Nico to build or download skills as needed. Do not pre-wire complex integrations manually.
5. **Deploy on a sandboxed machine** — Railway template is the recommended cloud path. Do not run LettaBot on a primary machine with unrestricted access.
6. **Model for LettaBot: OpenAI GPT via Pro subscription** — use `/connectcodex`, OAuth in, select `chatgpt-plus-...` model prefix. Zero additional API cost. This path is confirmed and documented in the UI.
7. **Do not rely on the `model` field in the LettaBot config file** — Cameron flagged it as misleading and opened an issue to remove it. `LETTA_MODEL` env var is confirmed removed. Model selection happens via `lettabot model set <handle>` or `/model` command in Letta Code.
8. **Opus 4.6 is available and performs best on agentic tasks** — but is significantly more expensive due to low token efficiency. If using Anthropic models, monitor cost carefully. For Nico's initial build on GPT via Pro, this is not immediately relevant.
9. **Agentic search > RAG** — do not build a retrieval layer for Nico. Let the agent search its own files and memory blocks directly. This is the validated architecture.
10. **Multi-agent is not needed yet** — single LettaBot instance is the correct starting point. The multi-agent patterns (dispatcher, sub-agents, external monitor) are V2+ architecture.

---

## What This Means for Nico

This session confirms that the architecture decisions locked in Sessions 1-5 are aligned with Letta's current direction. There are no contradictions to prior decisions.

The most actionable new information:
- The `/connectcodex` OAuth flow is the correct setup path for GPT via Pro subscription — this needs to be documented step-by-step in the install plan.
- Heartbeat and cron are ready. The install plan should include configuring both from day one, not as optional later steps.
- The agent ID configuration path for LettaBot is confirmed — the install plan should specify that the fresh Letta agent is created first, the ID is captured, and then LettaBot config is set to point at it.
- The Railway template exists and is the recommended path for cloud deployment of LettaBot. Note that it had a standing issue with persistent volumes — verify that the agent's persistent volume is correctly mounted before going live.
- The Agent File Directory is a future artifact destination for a finalized Nico agent file, but is not a build dependency.

The Ezra Super / sleeptime-on-crack pattern is a V2 reference architecture for an external monitor agent. File it in `future-architecture-reference.md`.

---

## Related Notes

- [[BroTeuvX0es-lettabot-tutorial|LettaBot Tutorial]]
- [[p7So3IM75WY-memfs-letta-chat|MemFS, Letta Chat]]
- [[M8LNa3FKE4k-introducing-lettabot|Introducing LettaBot]]
- [[R_4r_NNjg1M-context-repositories|Context Repositories]]
