---
title: "Agent Development Environment (ADE) Walkthrough"
date: 2026-03-01
tags: [letta, ade, tools, archival-memory, core-memory, context-window, data-sources, custom-tools]
status: active
type: research
project: nico-agent
video_id: OzSCFR0Lp5s
video_url: https://youtu.be/OzSCFR0Lp5s
relevance: high
presenter: Charles (Letta team)
processed: 2026-03-01
raw_transcript: "30-resources/letta/transcripts/Agent_Development_Environment_ADE_Walkthrough_RAW.md"
---

# Agent Development Environment (ADE) Walkthrough

> **Why this matters for Nico:** The ADE is how you build and debug Letta agents visually before scripting them. Understanding the ADE layout is essential for diagnosing memory issues, inspecting context window usage, and creating custom tools. Every section of the ADE corresponds to a specific part of Letta's architecture.

---

## 🗺️ ADE Overview

**What it is:** A visual development environment for designing and debugging Letta agents.

**Access:** `app.letta.com` — requires a running Letta server.

**Connecting to servers:**
- Local: start with Docker first, then visit app.letta.com
- Remote: provide server URL + password in the ADE server settings
- Supports Railway, AWS, GCP, any Letta server

**Starting local server (Docker):**
```bash
docker run \
  -e OPENAI_API_KEY=<your-key> \
  -e ANTHROPIC_API_KEY=<your-key> \
  letta/letta:latest
```

---

## 🖥️ ADE Layout: Left Panel Sections

### 1. Agent Settings (Top)

- **Agent Name** — editable
- **Model** — dropdown, changes based on providers you've configured
- **System Instructions** — the base system prompt (distinct from core memory blocks)

### 2. Tools

All built-in Letta tools visible here:
- `core_memory_append` — adds to a core memory block
- `core_memory_replace` — replaces content in a core memory block
- `archival_memory_search` — semantic search over archival memory
- `archival_memory_insert` — adds to archival memory
- `send_message` — sends message to user

**Custom tools:**
- Click `+` to open the Tool Explorer
- 7,000+ pre-made tools available
- Can create new tools from scratch
- Tool editor: live code editing + test execution inline

**Tool Editor capabilities:**
- Write Python functions directly in browser
- Run the function to test it in real time
- Example shown: D20 die roll tool (imports `random`, returns `random.randint(1,20)`)
- Can use environment variables for API keys (set in agent's "variable" section)

**Attaching tools:**
- Must explicitly attach — tools do NOT auto-attach
- Critical mistake: forgetting to attach a tool = agent can't use it

### 3. Data Sources

**What they are:** Files you upload to the Letta server that get chunked, embedded, and loaded into archival memory.

**How to add:**
1. Create new data source
2. Upload file(s) to the data source
3. Server chunks the file + creates embeddings
4. Chunks appear as entries in the agent's archival memory
5. Agent can search them via `archival_memory_search`

**Example used in video:** `dream_diary.txt` → chunked into 4 pieces → 4 archival memory entries

**Key property:** Data sources = archival memory entries. They are NOT in the context window by default. Only accessible when agent explicitly calls `archival_memory_search`.

### 4. Context Window Viewer

**Shows the complete breakdown of what's in the agent's context window:**

| Component | Example Token Count |
|---|---|
| System instructions | ~1,000 tokens |
| Tool descriptions | ~600 tokens |
| External summary | ~300 tokens (summary of out-of-context data) |
| Core memory blocks | ~300 tokens |
| Messages | ~180 tokens (fresh agent, 1 message) |

**Context window limit:** Set to the underlying LLM's maximum by default.
- Claude 3.5 Sonnet → 200k tokens (configurable)
- Can artificially lower it in ADE

**Why you'd lower the context limit deliberately:**
> *"200k tokens — it can be extremely expensive, it can be extremely slow, it can also be a lot of distractor tokens for the agent, so it might actually reduce performance. Even though we have 200k tokens, Letta actually allows you to artificially constrain the limit."*

**Recommendation:** Set to ~20k unless you have a specific reason for more. Better performance, lower cost.

**External summary:** This is how Letta handles data that's OUT of the context window — it generates a summary of archival memory / data sources and includes a small summary token. Keeps the agent aware that external data exists without putting it all in context.

### 5. Core Memory

**What it is:** Blocks of memory that are ALWAYS in the agent's context window. Every single time the agent is invoked, this information is present.

**Default blocks:**
- `human` — information about the user/operator
- `persona` — the agent's own identity and personality

**Properties:**
- Editable directly in ADE (developer can edit), OR
- Agent edits them via `core_memory_append` / `core_memory_replace`
- Can add/remove blocks arbitrarily
- Each block has a character limit (default: 5,000 chars)

**Live example from video:**
- Human block: "My name is Charles, I was doing X, now I'm doing Y, I'm uploading a dream diary to archival memory"
- Persona block: AI companion sci-fi persona
- After demo: told agent "call me Chuck not Charles" → agent calls `core_memory_replace` → updates human block → confirmed in ADE

### 6. Archival Memory

**What it is:** Infinite out-of-context data store for the agent.

**Properties:**
- NOT in context window (no context overhead)
- Effectively unlimited size
- Agent reads/writes freely
- Only appears in context when agent explicitly calls `archival_memory_search`
- Semantic search (not keyword) — embedding-based

---

## 🤖 Agent Simulator (Middle Panel)

### Interactive Mode (Default for Developers)

Shows all three layers:
1. **Reasoning steps** — what the agent is thinking internally
2. **Tool calls** — every tool invoked, with arguments and results, including errors
3. **Final messages** — what gets sent to the user

**Why this matters:** Shows you exactly what the agent did, including failures and recovery. Without this, you'd never see that the agent made an error and recovered.

### Simple Mode (What End Users See)

Shows only final messages to the user. No reasoning, no tool calls.

**Use case:** Shows you what your production chat app would show to a user if you stripped out the internal steps.

---

## 🔬 Key Demo: Tool Error + Recovery

Instructor asked agent to search dream diary in archival memory. The agent:
1. Calls `archival_memory_search` with an **empty query** → error
2. Agent **sees the error** in its reasoning step
3. Agent **recovers autonomously** — calls the tool again with a proper query ("exploration")
4. Gets valid results back
5. Proceeds to generate image

> **Lesson:** Agents can self-recover from tool failures. In interactive mode you see the full error-recovery loop. In simple mode it looks like one seamless step.

---

## 🔌 ADE ↔ API Equivalence

The ADE is a UI on top of the Letta REST API. Every action in the ADE corresponds to an API call.

**Example:** You can copy the exact API call for any message in the ADE and run it in the terminal — same result:
```bash
# Example copied from ADE
curl -X POST https://localhost:8283/v1/agents/{agent_id}/messages/stream \
  -H "Content-Type: application/json" \
  -d '{"messages": [{"role": "user", "content": "Hey I love this image"}]}'
```

**Implication:** You can use ADE for development/debugging, then switch to pure API calls in production. Same agents, same state.

---

## 📋 End-to-End Example: Dream Diary Agent

**What the demo builds:**
1. Agent with GPT-4o-mini
2. Custom persona block (sci-fi AI companion)
3. Human block with name + hint about dream diary
4. Data source: `dream_diary.txt` (4 chunks in archival memory)
5. Custom tool: `create_image` (calls fal.ai API, returns image URL)
6. Environment variable: `FAL_KEY` set in agent's variable section

**Task given:** "Make an image based on what you know about me from my diary entries. Choose the entry based on your own interest."

**Agent's behavior:**
1. Searches archival memory for interesting entries
2. Picks one (Memory Gardians entry — "speaks to themes of memory and fragility of Human Experience")
3. Generates detailed image prompt from the entry
4. Calls `create_image` with the prompt
5. Returns image URL in final message

**Cost note:** GPT-4o-mini used for this demo — "pretty good function calling, extremely cheap, pretty fast."

---

## 🎯 Implications for Nico Setup

### Context Window Management
- Check context window viewer after configuring Nico to see actual token usage
- Artificially limit to ~20k to reduce cost and distraction tokens
- Core memory blocks + tools take up ~2k tokens baseline before any conversation

### Core Memory Design for Nico
Minimum blocks:
- `persona` — who Nico is, tone, values, operating style
- `human_profile` — Vincent's name, company, preferences, priorities
- `vault_context` — Obsidian vault path, conventions, wikilink format, where to write

Optional blocks (if frequently referenced):
- `project_status` — current top priorities
- `memory_loading_guide` — how to find information in external memory

### Archival Memory for Nico
- Vault files → can be uploaded as data sources OR agent reads via bash
- Key operational docs → seed into archival on setup
- Agent searches when needed — keeps core memory clean

### Custom Tools for Nico
Candidates:
- Vault write tool (writes a markdown file to vault with proper frontmatter)
- Slack post tool
- Telegram send tool (may already exist in LettaBot)
- Calendar read tool (future)

### Common Mistakes to Avoid
1. **Forgetting to attach tools** — they don't auto-attach. Check the tools section.
2. **Setting context limit too high** — 200k context = expensive + slow + performance risk
3. **Not using interactive mode when debugging** — you won't see tool errors
4. **Empty `archival_memory_search` queries** — agent might attempt this; include guidance in system prompt to always provide a non-empty search query

---

## 🔗 Related Notes

- [[p7So3IM75WY-memfs-letta-chat|MemFS Office Hours — Memory Architecture Deep Dive]]
- [[LX-qO5o8iRQ-building-multi-agent-systems|Building Multi-Agent Systems — Tool Attachment Steps]]
- [[o4boci1xSbM-memory-blocks|AI Memory Architecture: How to Use Memory Blocks]]
- [[hFNWhrXukc0-archival-memory|Archival Memory: Build AI that remembers everything]]
