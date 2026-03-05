---
title: "How to Talk to Your AI Agent with Telegram"
date: 2026-03-01
tags: [letta, telegram, modal, webhook, agent-interface, mobile-access, integration]
status: active
type: research
project: nico-agent
video_id: 6baCKzLmslQ
video_url: https://youtu.be/6baCKzLmslQ
relevance: high
presenter: Cameron (Letta team)
processed: 2026-03-01
raw_transcript: "30-resources/letta/transcripts/How_to_talk_to_your_AI_agent_with_Telegram.md"
---

# How to Talk to Your AI Agent with Telegram

> **Why this matters for Nico:** This is the exact architecture powering Nico's current Telegram integration. Cameron built it for his own personal knowledge manager — same use case as Nico. The Modal → webhook → Letta pipeline is the pattern already deployed on LettaBot. Understanding this architecture helps diagnose issues and extend it.

---

## 🎯 The Problem This Solves

Cameron has a 20-block personal knowledge manager agent. He wants to interact with it on the go — without opening ADE.

> *"When I'm on the go, I don't really want to open up the ADE. I'm not doing development. I'm just trying to get information into my agent."*

**The solution:** Telegram bot that connects to his Letta agent. Same conversation history. Same agent. Accessible anywhere.

---

## 🏗️ Architecture: How It Works

```
User → Telegram → Modal (webhook relay) → Letta Server → Modal → Telegram → User
```

### Why Not Direct to Letta?
> *"We can't just message the Letta server directly because we can't actually run code inside of Telegram."*

Telegram supports **webhooks** — when you send a message, Telegram can relay it to a server of your choice.

### Modal as the Relay
Cameron uses **Modal** (serverless compute platform) as the relay server:

> *"Modal helps you very easily build infrastructure for serverless environments. In our case, this means we can have a service on Modal where I can point Telegram to, and it will spin up a server temporarily for a few seconds that will route that message back to my agent."*

**Why Modal over a regular server:**
- No infrastructure to maintain
- Spins up on demand, tears down after each message
- Cameron: *"If you've ever tried to do any kind of infrastructure or serverless stuff, you should try Modal because it will just make your life much much easier."*

---

## 📡 Message Flow (Detailed)

### Incoming (User → Agent)
1. User sends message in Telegram
2. Telegram relays to Modal webhook function (~169ms to acknowledge — container may need cold start)
3. Modal receives message, immediately returns `200 OK` to Telegram (prevents Telegram from thinking server is down)
4. Modal queues message for `process_message_async` function
5. `process_message_async` prepends metadata: *"This is coming from Cameron. It's a Telegram message. Here's the content."*
6. Forwards to Letta server
7. Letta processes (agent runs, makes tool calls, generates response) — can take ~20 seconds
8. Each tool call result is relayed back to Telegram as it happens
9. Final response sent to Telegram

### Why Async Processing
> *"Sometimes your agent can run for a very long time. You want your agent to run asynchronously and kind of update you as it goes along."*

Modal immediately acknowledges the webhook, then processes separately. This prevents Telegram timeout errors.

---

## 💬 The User Experience

**In Telegram:**
- Tool calls are visible as messages (shows tool name + arguments)
- Final agent response appears after processing
- Typing indicator visible while processing

**Example sequence:**
```
[User] → could you take a look at this link and let me know what you think? [URL]
[Bot]  → Using tool: fetch_webpage with args: {url: "[URL]"}
[Bot]  → [Agent's full analysis response]
```

**Matching ADE view:** The same conversation history appears in ADE. Same agent, same message history, everywhere.

> *"The advantage of the Letta server is that it centralizes all of the messages that your agent has ever had. It's the same agent no matter where you are."*

---

## 🔄 Same Agent Everywhere

This is the key architectural benefit:

- Talk to Nico in ADE → shows in Telegram history
- Talk to Nico in Telegram → shows in ADE
- Add a new tool in ADE → immediately available in Telegram
- Works with Discord, Slack, Zapier, any platform with an SDK

> *"Anything that you do to improve your agent anywhere else will also be reflected in what's on Telegram, right? Because you're talking to the same agent."*

**Live demo:** Cameron added a `roll_d20` tool in ADE while Telegram was active → immediately usable in Telegram. Removed it → gone from Telegram.

---

## 🔗 Zapier Extension

> *"I also have Zapier integration. So every single social media post I have goes straight into my social media agent so that it understands how I'm thinking and talking."*

Zapier can pipe any social/content platform → Letta agent automatically. Cameron uses it to feed his own social media posts to his agent for context.

**Implication for Nico:** Could pipe Vincent's Slack messages, email summaries, or other content automatically into Nico's archival memory.

---

## 🛠️ Setup Requirements

To replicate this setup you need:

1. **Modal account** — serverless relay server (modal.com)
2. **Telegram Bot** — created via BotFather in Telegram (very straightforward)
3. **Letta Cloud account** (recommended) or self-hosted Letta server
4. **Cameron's webhook code** — available in Letta cookbook/GitHub

> *"You'll need Modal, a server account. I recommend Letta Cloud, but you can self-host if you like. And then you also need to have a Telegram bot set up which is very easy to navigate."*

---

## 📊 Performance Notes

- Cold start: ~169ms Modal container boot time (if idle)
- Warm start: faster
- Message processing: ~20 seconds for a tool-heavy response
- Pattern: acknowledge immediately → process async → stream results back

---

## 🎯 What This Means for Nico

### Current State
Nico already has Telegram integration running on LettaBot (M1 machine). This video documents exactly how that integration works under the hood.

### Key Operational Notes
- When Telegram seems "slow" to respond — this is the Modal cold start + agent processing time, not a bug
- Tool calls visible in Telegram are intentional — shows what the agent is doing
- Adding/removing tools in ADE takes effect immediately in Telegram
- The same conversation history is always available in ADE for debugging

### Extension Ideas
- **Zapier pipeline:** Auto-feed Vincent's key inputs (calendar events, important emails) into Nico's archival memory
- **Webhook metadata:** The prepended "This is from Telegram" message can be expanded with context (time of day, location, urgency flag)
- **Tool visibility toggle:** Could configure to show/hide tool calls in Telegram for cleaner UX

---

## 🔗 Related Notes

- [[p7So3IM75WY-memfs-letta-chat|MemFS Office Hours — LettaBot Architecture Overview]]
- [[hFNWhrXukc0-archival-memory|Archival Memory — Tools Cameron Uses in His Knowledge Manager]]
- [[OzSCFR0Lp5s-ade-walkthrough|ADE Walkthrough — Where to Manage Tools and Agents]]
