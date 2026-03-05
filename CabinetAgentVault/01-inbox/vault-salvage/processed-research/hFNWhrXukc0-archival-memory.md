---
title: "Archival Memory: Build AI that remembers everything"
date: 2026-03-01
tags: [letta, archival-memory, memory-architecture, tool-rules, tags, iterative-design, agent-building]
status: active
type: research
project: nico-agent
video_id: hFNWhrXukc0
video_url: https://youtu.be/hFNWhrXukc0
relevance: critical
presenter: Cameron (Letta team)
processed: 2026-03-01
raw_transcript: "30-resources/letta/transcripts/Archival_Memory_Build_AI_that_remembers_everything.md"
---

# Archival Memory: Build AI that remembers everything

> **Why this matters for Nico:** This is Cameron's definitive walkthrough of how to actually build an agent that remembers everything. The tool rules, tag system, hybrid memory approach, and iterative agent-building pattern are all immediately applicable to Nico's setup. This video directly addresses the "agent filling up with gunk" problem from the MemFS Office Hours.

---

## 🧠 What Archival Memory Is

Memory blocks = the agent's working state. Always in context. Defines personality, purpose, capabilities.

Archival memory = the infinite offload bucket for everything else.

> *"If you have a really long-lived agent, there's no way it's going to remember every single interaction it's ever had. Your agent can use archival memory to offload particular pieces of information into a big bucket that it can retrieve later."*

**Key property:** NOT in the context window. Zero context overhead. Effectively unlimited size. Accessible only when agent explicitly calls `archival_memory_search`.

---

## 🛠️ The Two Archival Memory Tools

### `archival_memory_search`

**Parameters:**
- `query` (string) — natural language query, semantic/vector search
- `tags` (optional) — filter results to specific tags
- `tag_match_mode` — how to match tags (any vs. all)
- `n_results` — number of entries to return
- `start_datetime` / `end_datetime` — filter by time range

**Use case for time filters:** Very long-lived agents can query "only the last week" or specific date ranges.

### `archival_memory_insert`

**Parameters:**
- `content` (string) — any arbitrary text
- `tags` (optional) — string array for organization

**⚠️ Both tools are NOT attached by default.** You must manually attach them in ADE → Tools → Base Tools.

---

## 🏷️ Tag System

**What tags are:** Optional string arrays attached to each archival entry. One entry can have multiple tags.

**How they work:**
- Tags are preserved with entries and returned during searches
- Can filter searches to specific tags
- Agent always knows which tags exist in its archive → makes search more reliable

**Why to use tags:** Prevents agents from generating too many unique tags that become unfindable. Structure the tag vocabulary early.

**Example tag vocabulary for a knowledge agent:**
```
user_info, professional, personal, childhood, family
documentation, comprehensive, atomic
research, technical
news, current_events
project_status, decision
```

**Agent best practice:** Create a `tag_usage` block in core memory. Have the agent populate it with its tagging schema. The agent maintains this schema actively.

---

## 📋 Memory Block Architecture for Archival Agents

Cameron builds the following block structure for his librarian agent:

| Block Name | Purpose | Who Populates |
|---|---|---|
| `persona` | Agent's personality and interaction style | Agent (given starter prompt) |
| `human` | Information about the user | Agent (from conversation) |
| `tool_use_guidelines` | How to use archival tools effectively | Agent (from self-exploration) |
| `tag_usage` | Tag vocabulary and categorization rules | Agent (from self-exploration) |
| `policies_and_best_practices` | How archival memory should function | Agent (from dialogue) |
| `archival_performance_metrics` | Tracks frequently searched topics, success rates | Agent (from self-evaluation) |
| `cross_reference_mapping` | Relationships between archived information | Agent (from self-evaluation) |
| `proactive_information_management` | What information is missing, what to watch for | Agent (from self-evaluation) |
| `information_quality_assessment` | Source credibility and reliability | Agent (from self-evaluation) |

**Critical pattern:** Cameron writes NONE of these blocks himself. He asks the agent to populate all of them. Agent explores its tools, writes a report, populates the block.

> *"Notice I didn't write any of these memory blocks. I asked the agent to do it. I just said, 'Hey, could you go update that?' And that allows the agent to understand its own environment."*

---

## ⚗️ Atomistic vs. Comprehensive Memory (Critical Pattern)

**The question:** Should events be stored as one big memory or broken into atomic pieces?

**Atomistic approach:** One fact per archival entry.
- Better for precise retrieval (searching "duct tape prank" finds exactly that memory)
- Better tag granularity
- Loses narrative flow and causal relationships

**Comprehensive approach:** Full narrative/story in one entry.
- Preserves context and causal flow
- Less precise retrieval

**Hybrid approach (Cameron's recommendation):**

> *"Store important information in both atomic and comprehensive formats when appropriate. Tag atomic memories with specific descriptors."*

**Practical implementation:**
1. Store the full narrative/article as one comprehensive entry
2. Also extract and store key atomic facts separately
3. Use the same tags on related entries to link them
4. The agent can compile atomic entries back into context when needed

**Why this matters for Nico:** When storing project decisions or meeting notes, store both the summary (comprehensive) AND individual decision items (atomic). Better recall in both directions.

---

## 🔧 Tool Rules (Critical Feature)

Tool rules force the agent to always use specific tools at specific times in its turn.

### `start_constraint`
- Agent MUST begin its turn with a specified tool call
- Example: Always call `archival_memory_search` at the start of every turn
- Result: Agent is forced to check archival memory before responding — prevents ignoring stored knowledge

### `required_before_exit`
- Agent MUST call a specified tool before ending its turn
- Example: Always call `archival_memory_insert` before finishing
- Result: Agent always stores at least one memory per turn — ensures continuous learning

### ⚠️ CRITICAL WARNING: Anthropic Model Limitation

> *"If you are using any Anthropic models, this may or may not actually hold. The reason is Anthropic does not support formal structured output. You just have to kind of cross your fingers and hope that your agent follows your tool rule."*

**For Gemini, OpenAI:** Tool rules are **strictly enforced**.
**For Claude (Anthropic):** Tool rules are **best-effort only** — agent may not follow them.

**Implication for Nico (Claude-based):** Do NOT rely on `start_constraint` for critical behavior with Claude models. Use prompting instead to encourage archival memory usage.

### Implementation
- ADE: Tool Manager → Rules → Create New Rule
- After setting tool rules: always communicate to the agent what the rules are and why

---

## 🔨 Practical Build Demo: The Archavist Agent

Cameron builds a librarian agent from scratch. Full sequence:

### Step 1: Create agent + attach tools
```
1. Create new agent (Cameron uses Gemini 2.5 Pro, then switches to Claude)
2. Tools → Tool Manager → Base Tools → attach archival_memory_search
3. Tools → attach archival_memory_insert
4. Tools → attach core_memory_rethink (optional, powerful but risky on small models)
```

### Step 2: Bootstrap the persona
```
Prompt: "Here's your role: You're the Archavist. Your job is to store and retrieve
all information I give you. Be detailed, precise, thorough."
→ Agent initializes its persona block
```

### Step 3: Add tool_use_guidelines block
```
Create empty block called "tool_use_guidelines"
Prompt: "Update your tool use guidelines block with everything you know about
your archival memory tools."
→ Agent populates the block from its tool descriptions
```

### Step 4: Let agent explore archival memory
```
Prompt: "Go mess around with these tools and let me know what you learn."
→ Agent tests insert, tests search, finds passage IDs
→ Writes report of its findings
→ Stores findings in tool_use_guidelines block
```

### Step 5: Build tag system
```
Ask agent to explore tag functionality specifically
→ Agent experiments with multiple tags per entry
→ Writes report: "Tags are optional string arrays, each entry can have multiple,
  tags are preserved and returned during searches"
→ Create tag_usage block, ask agent to populate it
```

### Step 6: Feed real data
```
- Paste in a blog post → agent extracts atomic + comprehensive memories
- Give it web access → agent reads articles → stores key information
- Agent automatically tags, organizes, links entries
```

### Step 7: Ask for self-evaluation
```
Prompt: "Is there anything about yourself you would improve? Any new memory blocks
you'd recommend? Any clarifications about your purpose?"
→ Agent identifies gaps: no reliability scoring, no cross-reference mapping, etc.
→ Add those blocks, ask agent to populate them
→ Expand agent's purpose to include synthesis and curation
```

### Step 8: Implement tool rules
```
1. ADE → Tool Manager → Rules → start_constraint: archival_memory_search
2. ADE → Tool Manager → Rules → required_before_exit: archival_memory_insert
3. Tell agent: "You're now required to begin with archival search and end with
   at least one archival insert. This is your behavioral requirement."
```

---

## 🐚 Core Memory Rethink Tool

Additional tool: `core_memory_rethink`
- Rewrites an entire memory block in one pass
- More powerful than append/replace for big restructuring
- **Dangerous on small models** — can accidentally overwrite and lose everything
- Safe on capable models (Gemini 2.5 Pro, Claude Sonnet/Opus)

---

## ⚠️ Latency Warning

Archival memory search is a tool call. It takes time:
1. Query sent to embedding model
2. Semantic search runs
3. Results returned
4. Agent reads results

> *"Be careful about forcing your agent to use archival memory search at the beginning of its turn for agents with latency concerns. If you need your agent to respond immediately, you should note that archival memory search is a tool call — it will take a second."*

**Don't use start_constraint archival search for:** Customer support agents, real-time chat bots, anything requiring sub-second response.

**Do use for:** Knowledge management agents, CoS agents, research agents where a 2-3 second delay is acceptable.

---

## 🎯 What This Means for Nico

### Nico's Archival Memory Design

**What to store in archival memory:**
- Project decisions + rationale (atomic: individual decision, comprehensive: full decision log)
- Meeting notes (atomic: action items, comprehensive: full summary)
- Web research and external articles (extracted key facts + full summary)
- Historical interactions with Vincent — what worked, what didn't
- Letta/Claude Code knowledge (when agent self-learns from docs)

**Tag vocabulary for Nico:**
```
vincent, cabinet-design, saas-startup, nico-agent
decision, action-item, blocker
meeting, research, status
tech-letta, tech-claude, tech-obsidian
priority-1, priority-2, priority-3
```

**Blocks to create:**
- `tool_use_guidelines` (agent populates from self-exploration)
- `archival_policies` (hybrid atomic/comprehensive standard)
- `tag_schema` (maintained vocabulary of tags in use)
- `performance_notes` (agent self-tracking of what search patterns work)

### Tool Rule Note for Nico (Claude-based)

Since Nico uses Claude models, tool rules won't be strictly enforced. Instead:
- Include in Nico's system prompt: "Begin each turn by searching archival memory for relevant context. End each turn by storing any new information learned."
- This is a prompting instruction, not a tool rule — Claude will follow it more reliably than a tool rule it may ignore.

### Self-Improvement Pattern

Once Nico is running:
1. Periodically ask: "Is there anything about your memory architecture you'd improve?"
2. Ask: "Are there any new memory blocks that would help you serve Vincent better?"
3. Ask: "Are there patterns you've noticed in how you're using archival memory that should become policies?"

Cameron's insight: *"You're growing them, not engineering them. This is a dialogue."*

---

## 🔗 Related Notes

- [[p7So3IM75WY-memfs-letta-chat|MemFS Office Hours — Memory Hygiene Warning]]
- [[OzSCFR0Lp5s-ade-walkthrough|ADE Walkthrough — Context Window & Core Memory Overview]]
- [[o4boci1xSbM-memory-blocks|AI Memory Architecture: How to Use Memory Blocks]]
- [[0nfNDrRKSuU-memory-tool|The Memory Tool: Letta Agents That Redesign Their Own Architecture]]
