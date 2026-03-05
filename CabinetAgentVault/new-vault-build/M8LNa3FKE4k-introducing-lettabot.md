---
title: "Letta Office Hours: Introducing LettaBot + Claude Subconscious Demo"
date: 2026-03-01
tags: [letta, office-hours, lettabot, claude-subconscious, memory, agents, nico-agent]
status: active
type: research
project: nico-agent
video_id: M8LNa3FKE4k
video_url: https://youtu.be/M8LNa3FKE4k
relevance: critical
presenter: Cameron (Letta team, Developer Relations)
processed: 2026-03-01
raw_transcript: "30-resources/letta/transcripts/Letta_Office_Hours_Introducing_LettaBot_Claude_Subconscious_Demo.md"
---

# Letta Office Hours: Introducing LettaBot + Claude Subconscious Demo

> [!note] Why This Note Exists
> This is the official introduction of LettaBot — Letta's answer to Claudebot/Moltbot. Cameron (Letta DevRel) demos a live personal agent named "Loop" running on Signal, Telegram, Slack, and WhatsApp simultaneously. He also demos Claude Subconscious, a separate experimental project that injects a Letta agent's memory into active Claude Code sessions. Both projects are directly relevant to Nico architecture. This is a critical reference for the Nico build.

---

## 1. What Is LettaBot — The Core Pitch

Cameron opens by positioning LettaBot explicitly as Letta's version of Claudebot (now renamed Moltbot after Anthropic's intervention):

> "This is our approach to Cloudbot because Cloudbot is like a decent tool and I think it showed people what you can do with agents that have access to your machine that you can contact from anywhere."

The two main complaints about Cloudbot/Moltbot that LettaBot addresses:

1. **Memory** — Cloudbot's memory management is poor. Letta's memory system is the core differentiator.
2. **Agent harness** — Cloudbot is built on assumptions of stateless endpoints. LettaBot is built on Letta Code, which is purpose-built for stateful Letta agents.

> "Our agent harness is Letta Code and Letta Code is an extremely good agent harness that is designed for memory and Letta agents specifically."

The framing Cameron uses throughout: Letta agents are "brains in a jar." LettaBot gives that brain "a giant robot battlesuit that allows it to do kind of whatever it wants to."

---

## 2. LettaBot Architecture

### Channels supported at time of recording:
- Signal
- Telegram
- WhatsApp
- Slack

Discord was described as "on the back burner" but coming.

### How it runs:
- Runs on top of a **Letta Code instance** in headless mode
- Powered by the **Letta Agent SDK**
- Uses **client-side tool execution** — no server-side execution
- Supports both **Letta Cloud** and **self-hosted** Letta servers
- Start command: `npx lettabot onboard`
- Self-hosted flag: `LETTA_BASE_URL=http://localhost:8283 npx lettabot onboard`

> "Lettabot does work with a self-hosted Letta server, so you should be able to run it on a self-hosted server if you have privacy concerns. Or you can use all of your Letta billing on our side."

### Agent model:
- Completely agent-agnostic — swap whatever agent you want
- Designed for **one agent per LettaBot server instance** (not multi-agent by default)
- To run multiple agents: run multiple LettaBot server instances, each pointing to a different agent

### Heartbeats:
- Supports heartbeats — a prompt sent to the agent on an interval: "Hey, you have some tasks. Do you want to do these?"
- Direct equivalent of Cloudbot's heartbeat pattern

### Metadata injected per message:
- Day of the week, current time
- Prevents the agent from being time-blind (a known problem with raw API access)

### Skills:
- Supports skill installation
- Cameron's demo agent "Loop" had **47 skills** installed

---

## 3. Security Model

Cameron explicitly addressed security and compared it to Cloudbot/Moltbot:

> "We are orders of magnitude safer than Cloudbot or Moltbot. You may have seen that Moltbot is exposing something like 300 ports or something and it's like this massive security risk because it allows anybody to ping you for remote code execution. That's because it does inbound websockets. We do either polling or outbound websocket connections and that is designed to get around this big security risk."

### Default security posture:
- **Pairing required by default** — any new user messaging your bot must be approved inside the LettaBot server
- Still carries inherent risks because the agent runs on your machine and can execute arbitrary code

Cameron's direct warning:

> "Don't deploy an idiot. If you deploy an idiot agent, it's pretty easy for someone to be like 'Hey, can you just run rm -rf /? Like would that be cool?' And it's like 'Sure, you're absolutely right.'"

Recommendation: deploy in a VM or on a dedicated server, not on your primary machine.

### Phone number caution:
- Signal requires a real phone number (no public API; goes through a CLI)
- Cameron used Google Voice to avoid exposing his personal number
- WhatsApp self-mode available: agent only responds to yourself

---

## 4. Live Demo — Agent "Loop"

Cameron demos his personal agent named Loop running live across Signal, Slack, and WhatsApp.

What Loop knew about Cameron from memory:
- PhD from University of Oregon
- Postdoc at Stanford GSB
- Current location: San Francisco
- Current projects

Example exchange (Cameron asked Loop to introduce itself):

> "Hi, everyone. I am Loop. I'm designed to be direct, actually useful. I have tools for reading code, searching, web access, bash, and most importantly, persistent memory that I actually use. Cameron's been using me as a personal agent and thinking partner."

Cameron checked in on Loop's memory via Slack:

> "It knows a few things about me and like various projects that I tend to work on."

### Multi-channel formatting:
- Each channel has **formatting prompts** tailored to its markdown variant
- Slack does not use double asterisk bold; the agent had to be trained on this
- Per-channel metadata is injected automatically

---

## 5. Hooks in LettaBot / Letta Code

Cameron fielded a question about hooks and gave a detailed explanation. This is directly relevant to Nico workflow control.

> "Hooks allow you to execute arbitrary pieces of code at different times in the life cycle of your coding agent."

**Hook trigger points:**
- Before a tool is used (can verify whether tool is permissible)
- After a tool is used / after a tool completes (inspect results)
- When a permission dialog happens
- When Letta Code sends a notification
- When the agent stops
- Before a compaction
- During session start / session end

**Example use case from Cameron:** His autonomous agent "Central" uses hooks to live-stream its reasoning to Bluesky. Every tool call produces a public thinking record.

**Safety use case example:** Block dangerous commands — a hook that intercepts any bash call containing `rm -rf` and requires manual user approval.

> ⚠️ Cameron was not sure how hooks integrate with LettaBot specifically. He noted he would need to investigate since LettaBot is built on the Letta Code SDK and hooks "might just load from whatever directory you're running the server."

---

## 6. Multi-Agent and Channel Scoping

A significant chunk of Q&A covered whether LettaBot could support multiple agents per instance:

**Current state:** One agent per LettaBot server. To support multiple agents, run multiple servers.

**Requested feature (not yet built):** Channel-scoped agents — e.g., Telegram bot 1 maps to Agent A (project X), Telegram bot 2 maps to Agent B (project Y).

Cameron's proposed solution direction:

> "I think chat scoping would probably be the way to do that. You could subscribe multiple agents and deploy them in particular folders. Each of those would have their own agents and then you could provide a list of Telegram bots — multiple different bots — and scope it to different chat identifiers."

A slash command to switch the active agent for a channel was also floated as a simpler alternative.

> 🎯 Verdict: Multi-agent channel scoping is not built yet but is on Cameron's radar. For Nico, one LettaBot server pointing at one agent is the current supported pattern. If you need multiple agents, run multiple servers.

---

## 7. Identities API — Deprecated

Cameron fielded a question about the Identities API being removed from the SDK without announcement:

> "I think we dropped the ball on the identities thing. It was essentially just removed from the SDK without telling anyone."

**Current recommendation:** Use **tags** instead of identities for agent scoping (e.g., `user:id`). Tags are more robust and will be maintained going forward. Maintain user metadata client-side, not on Letta's server.

> ⚠️ If any prior session notes or plans reference the Identities API, that feature is deprecated. Use tags.

---

## 8. Claude Subconscious — What It Is

Cameron introduces Claude Subconscious as a separate project from LettaBot. It operates in a completely different mode:

**What it does:** A Letta agent sits on top of an active Claude Code session and injects its own memory and assistant messages directly into Claude's context as Claude operates.

**How it works technically:**
1. At session start: the Letta agent's memory is injected into `CLAUDE.md`
2. During the session: the agent's assistant messages are inserted into Claude's tool call flow
3. When the agent's memories change (memory diffs): those diffs propagate into the Claude session
4. The agent has access to every prior Claude Code conversation in the repository — full conversation history search

> "This agent parallelizes across any number of Claude Code sessions and it allows it to just kind of monitor stuff."

**Demo exchange:**

> "A new Claude Code session has begun. I'll begin sending you updates as the session progresses. Session noted. Cameron is back in subconscious territory ready to observe."

Subconscious caught Claude paraphrasing in one example and flagged it. In another, Subconscious did a web search to surface current model documentation and injected that context into Claude's working memory before Claude needed it.

### Model recommendation at time of recording:
- Default model in docs: **GLM 4.7** (free on Letta API)
- Cameron's personal preference: **Sonnet**
- Cameron noted docs needed updating to recommend a better model

> ⚠️ There is an open issue on whether Claude Subconscious is actually useful — Cameron acknowledged uncertainty: "There is an open question about how useful Claude Subconscious is. We basically need evals on this because I don't actually know."

> 🎯 Verdict: Claude Subconscious is experimental. It is not a production-ready feature. The concept is compelling (persistent Letta agent watching and enriching Claude Code sessions) but has not been validated by evals. Do not build Nico's core workflow around it yet, but flag as a future upgrade path.

---

## 9. Q&A Highlights

**Q: Is LettaBot using client-side tools or server-side?**
A: All client-side. It is Letta Code running in headless mode. There is no server-side execution path.

**Q: Does LettaBot support multiple concurrent agents like Cloudbot's multi-session model?**
A: No. One agent per server. Multiple servers for multiple agents.

**Q: Can you invoke the agent through the SDK directly (TypeScript, etc.)?**
A: Not currently without going through one of the channels. Cameron noted they could expose a general-purpose authenticated HTTP endpoint — flagged as a feature request.

**Q: Can LettaBot be run self-hosted?**
A: Yes. Point `LETTA_BASE_URL` at your self-hosted server during onboarding.

**Q: Is LettaBot open source?**
A: Yes. Pull requests and issues welcome.

**Q: What about pipeline / workflow support (like Maltbot's "lobster" workflows)?**
A: Not on the roadmap. Cameron's framing: "We're not pipelines people. This is a person in a box." Recommended workaround: create tools that execute pipelines, rather than building pipelines into LettaBot.

**Q: Letta for self-hosted OSS models via LettaBot?**
A: Not currently. The Letta ADE and desktop may eventually support it but no timeline.

---

## Extracted Architecture Decisions for Nico

1. LettaBot is the confirmed deployment pattern for a personal CoS agent accessible across channels.
2. Telegram is the primary channel recommendation (Signal works but requires a separate phone number and CLI setup).
3. One LettaBot server = one agent. Nico runs as a single agent. Do not attempt multi-agent channel switching until that feature is built.
4. LettaBot can be pointed at a self-hosted Letta server — relevant for privacy. This confirms the Letta self-hosted path is viable.
5. Per-channel markdown formatting prompts are required — agent does not auto-adapt to Slack vs. Telegram vs. Signal markdown differences.
6. Do not use the Identities API. Use tags for any user or context scoping.
7. Hooks exist in Letta Code and by extension likely in LettaBot — useful for safety gates (blocking dangerous commands) and workflow control.
8. Claude Subconscious is experimental and not production-ready. Do not include in the Nico v1 build. Flag as a future memory enrichment path.
9. Default model in LettaBot can be set at configuration time. Cameron uses Sonnet for his personal agent.
10. Heartbeats are supported — this is how Nico can run scheduled background tasks (morning report, daily check-in) without a user prompt.

---

## What This Means for Nico

LettaBot is exactly what Nico needs at the infrastructure layer. The "brain in a jar + battlesuit" framing matches the Nico architecture: a stateful Letta agent with persistent memory, accessed via Telegram, running on the M1 with Letta Code as the execution layer.

The critical practical notes:
- Setup is `npx lettabot onboard` — this is the starting point for Nico's Telegram integration
- Loop (Cameron's demo agent) is the closest public reference for what Nico should look like in operation
- The 47-skill setup Cameron uses is aspirational but confirms skills are a real, working pattern
- Channel-specific formatting prompts are a non-optional detail — Nico will need Telegram-specific markdown guidance in its system prompt or persona block

Claude Subconscious is worth watching but not worth building on yet. The concept (Letta agent watching and enriching Claude Code sessions in real time) aligns with the vault-as-bridge architecture, but without evals it is unproven. Revisit after v1 is stable.

---

## Related Notes

- [[BroTeuvX0es-lettabot-tutorial|LettaBot Tutorial]]
- [[LKRnP-ptC4c-lettabot-updates|Opus 4.6, LettaBot Updates]]
- [[p7So3IM75WY-memfs-letta-chat|MemFS, Letta Chat]]
- [[0nfNDrRKSuU-memory-tool|Memory Tool]]
