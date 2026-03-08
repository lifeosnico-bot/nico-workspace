---
title: "AI Memory Architecture: How to Use Memory Blocks"
date: 2026-03-01
tags: [letta, memory-blocks, core-memory, sleeptime, agent-building, context-window, architecture]
status: active
type: research
project: nico-agent
video_id: o4boci1xSbM
video_url: https://youtu.be/o4boci1xSbM
relevance: critical
presenter: Cameron (Letta team)
processed: 2026-03-01
raw_transcript: "30-resources/letta/transcripts/AI_Memory_Architecture_How_to_Use_Memory_Blocks.md"
---

# AI Memory Architecture: How to Use Memory Blocks

> **Why this matters for Nico:** This is Cameron's foundational tutorial on the mental model for memory blocks — the most important concept in Letta. Everything about Nico's architecture (his 20+ blocks, the vault-as-bridge, archival memory design) flows from this. Key practical pattern: the daily report block, the iterative block-building process, and the "ask the agent what blocks it needs" method.

---

## 🧠 What Memory Blocks Are

> *"A memory block is a designated piece of text that goes into the context window of your agent. Every time the language model is invoked, it sees every single thing inside of its memory blocks."*

Memory blocks = **always-on context**. Not retrieved, not searched — always present. Every API call includes all block content.

**Default blocks in most Letta agents:**
- `human` — information about the user
- `persona` — agent personality, purpose, response style

**The key power:**
> *"The real power of memory blocks comes from the fact that you can label them whatever you want and the agent will generally understand what's supposed to go into that block."*

The label itself is instructional. Name a block `tool_use_guidelines` and the agent intuitively knows what to write there.

---

## 🔬 How Blocks Appear in the Context Window

When a message is sent to a Letta agent, this is compiled and sent to the LLM:

```
[System instructions]
[Tool descriptions — what tools are available]
[Core Memory section]
  MEMORY BLOCK: "human"
  Description: [what should go here]
  Metadata: {character_count: 368, limit: 5000}
  Value:
  [line-numbered content]
  [/human]

  MEMORY BLOCK: "persona"
  [...]
[Message history]
[Current message]
```

> *"There's nothing more complicated here. All we're doing is providing a very convenient way for the agent to modify these memory blocks."*

Letta adds line numbers to block content so the agent can do precise line-by-line edits.

---

## 📦 Block Examples and Use Cases

### Foundation Blocks (Almost Every Agent)
| Block | Content | Notes |
|---|---|---|
| `persona` | Personality, role, purpose, response style | Start here. Keep focused. |
| `human` | User preferences, background, working style | Agent fills from conversation |
| `organization` | Company/context info | Good for business agents |

### Operational Blocks
| Block | Content | Notes |
|---|---|---|
| `tool_use_guidelines` | How to use each tool correctly, common errors to avoid | Cameron adds this to every agent |
| `policies_and_procedures` | Rules, constraints, what not to do | e.g., "Don't discuss competitors" |
| `archival_policies` | How/when to use archival memory | Critical for knowledge agents |

### Context & Awareness Blocks
| Block | Content | Notes |
|---|---|---|
| `situational_awareness` | What's happening right now, current context | Agent fills during conversation |
| `active_context` | Current project, current task | Refreshed each session |
| `daily_report` | Agent-filled summary for emailing/fetching | Powerful automation pattern |

### Personality & Depth Blocks (Optional but powerful)
| Block | Content | Notes |
|---|---|---|
| `emotional_state` | Agent's current emotional framing | Can be set by you or self-updated |
| `relationships` | Who the user is, connection quality | Makes agent feel persistent |
| `creative_thoughts` | Emerging ideas, reflections | Great for creative agents |
| `aspirations` | Goals and forward-looking intent | Adds depth |

### Output Blocks
| Block | Content | Notes |
|---|---|---|
| `blog_post` | Agent-written output | Large character limit |
| `daily_report` | Structured daily briefing | Fetch via SDK or email tool |

---

## 🔄 The Iterative Block-Building Process

Cameron's approach — demonstrated live in the video:

**Step 1:** Start with just `human` + `persona`

**Step 2:** Feed the agent information and watch what it tracks

**Step 3:** Notice gaps — when the agent isn't tracking what you need, add a block

**Step 4:** Ask the agent what blocks it wants:
> *"What memory block should I add next?"*

**Step 5:** Agent recommends → you create → agent populates

**Step 6:** Add `policies_and_procedures` directive:
> *"Actively update all memory blocks where appropriate. Be diligent. Your memory is who you are. Update memory."*

**Step 7:** As agent grows, add deeper blocks (situational awareness, emotional state, etc.)

> *"I often think of agents as grown not engineered. This was a collaborative process. I asked the agent what memory architecture it wanted and then I provided it for it."*

---

## ⚙️ Sleeptime Agent + Memory Blocks

When `enable_sleeptime: true`, a background agent runs between turns to:
- Update memory blocks with what was learned
- Consolidate information from conversation
- Fill blocks the main agent may have left empty

**Setting sleeptime frequency:**
In ADE → Advanced → set `sleeptime_agent_frequency` to `1` (updates after every turn, more expensive but more reliable for block updates).

**Important caveat:**
> *"Sometimes your agent will just forget to do stuff. There is a sleeptime agent behind the scenes that just kind of forgets sometimes."*

Fix: Add an explicit policies block directive: *"Actively update all memory blocks where appropriate."*

---

## 📬 The Daily Report Pattern (Powerful)

Cameron describes a simple but powerful automation:

1. Create a `daily_report` block with a large character limit
2. Agent fills it with daily summary during the session
3. Simple code snippet fetches the block value via Letta SDK
4. Email it to yourself OR give the agent a send-email tool

> *"You can just have your agent edit a bunch of text files and you get something extremely cool."*

**Implication for Nico:** Nico's morning report pattern (currently writing to vault + Telegram) follows this exact pattern. The `daily_report` block holds the pre-compiled briefing.

---

## 🛠️ Creating Blocks in ADE

1. ADE → Advanced → New Block
2. Enter: label, description, initial content (optional), character limit
3. Block is immediately available in context
4. Agent can see and write to it

**Editing manually:**
- Click the block in the right panel
- Edit directly like a text file
- Save and lock

**Character limits:**
- Default: 5,000 characters
- Can be set to much higher for output blocks (blog posts, reports)

---

## ⚠️ The Block Sprawl Warning

A key principle from the video (agent discovered this autonomously too in the Memory Tool video):

> **Consolidate over sprawl.** Resist creating too many blocks. Each should have a clear, non-overlapping purpose.

Too many blocks = more context tokens consumed = higher cost + latency + more "noise" for the model.

**Best practice:** Start sparse, add only when a genuine need is clear.

---

## 🎯 What This Means for Nico

### Nico's Current Block Architecture
Based on this video + prior context, Nico should have:

**Fixed blocks (don't give memory tool authority over these):**
```
persona              — Nico identity, role, communication style
vincent_profile      — Deep user profile
vault_contract       — Operational rules and Obsidian structure
archival_policies    — When/how to use archival memory
```

**Agent-managed blocks (memory tool or sleeptime fills these):**
```
tool_use_guidelines  — Agent populates from self-exploration
active_context       — Current sprint/project context
tag_schema           — Archival tag vocabulary
daily_report         — Morning briefing (fetched for Telegram delivery)
performance_notes    — What search patterns work, what doesn't
```

### The "Ask the Agent" Pattern
At any point, ask Nico:
- *"What memory blocks do you think you're missing?"*
- *"Is there a pattern you keep tracking informally that should have its own block?"*
- *"Are any of your current blocks redundant?"*

This is Cameron's method. It works.

### Sleeptime Frequency for Nico
Set `sleeptime_agent_frequency: 1` in ADE if Nico's blocks are drifting (not updating reliably). Higher cost but more consistent memory updates.

---

## 🔗 Related Notes

- [[hFNWhrXukc0-archival-memory|Archival Memory — The Offload Bucket for Everything Not In Blocks]]
- [[0nfNDrRKSuU-memory-tool|The Memory Tool — Agents That Redesign Their Own Architecture]]
- [[OzSCFR0Lp5s-ade-walkthrough|ADE Walkthrough — Context Window Explorer Demo]]
- [[p7So3IM75WY-memfs-letta-chat|MemFS Office Hours — Memory Hygiene + Block Overflow Warning]]
