---
title: "Building Multi-Agent Systems with Letta"
date: 2026-03-01
tags: [letta, multi-agent, tools, architecture, supervisor-worker, async, sync]
status: active
type: research
project: nico-agent
video_id: LX-qO5o8iRQ
video_url: https://youtu.be/LX-qO5o8iRQ
relevance: critical
presenter: Charles (Letta team)
processed: 2026-03-01
raw_transcript: "30-resources/letta/transcripts/Building_Multi-Agent_Systems_with_Letta_RAW.md"
---

# Building Multi-Agent Systems with Letta

> **Why this matters for Nico:** This is the official Letta tutorial for how agents actually communicate with each other in code. The three built-in tools, the supervisor/worker pattern, and the anti-infinite-loop technique are all directly applicable to building Nico's sub-agent team.

---

## 🔑 Core Concept: Agents Are Independent Entities

> *"All agents in Letta are stateful. When you build a multi-agent system in Letta you're effectively connecting independent agents that have their own independent memory systems, their own independent state — and you're connecting them to each other via tools. It's kind of like connecting humans over some common communication channel, like two independent humans that have their own memories, their own jobs, their own responsibilities, and you connect them via Slack or iMessage."*

**Key implication:** Multi-agent in Letta is NOT hierarchical control — it's peer-to-peer communication via shared tools. Any agent can be added or removed from a multi-agent system by attaching or detaching the relevant communication tool.

---

## 🛠️ The Three Built-In Multi-Agent Tools

### Tool 1: `send_message_to_agent_async`

**What it does:** Agent sends a message to another agent but does NOT wait for a reply. Immediately gets a delivery receipt and continues its own execution.

**Analogy:** Like sending an iMessage and getting a "Delivered" receipt. You continue your day — you don't freeze waiting for a response.

**How reply works:**
- Receiving agent processes the message
- Receiving agent has the same `send_message_to_agent_async` tool
- Receiving agent uses it to reply back
- Sender gets the reply whenever it comes in (could be later, in a different execution cycle)

**Receipt includes:** Agent ID of the sender, so the receiving agent knows who to reply to.

**When to use:** Most natural communication pattern. Use for all normal agent-to-agent messaging. Mirrors how humans communicate.

---

### Tool 2: `send_message_to_agent` (synchronous)

**What it does:** Agent sends a message and STALLS execution waiting for the other agent to reply. Cannot do anything else until reply comes back.

**Analogy:** Like making a phone call and staying on hold until someone picks up.

**When to use:** Very deterministic systems where you need a guaranteed immediate response before proceeding. Simpler to reason about but less scalable.

**Warning:** If the other agent takes a long time, the calling agent is completely frozen for that entire duration.

---

### Tool 3: `send_message_to_agents_matching_all_tags` (broadcast)

**What it does:** Supervisor sends the same message to ALL agents that share a specified tag. Synchronous — supervisor waits for ALL responses before proceeding.

**How tags work:**
- Tags are a Letta feature for grouping agents
- Example: all worker agents get tagged with `worker`
- Supervisor sends to tag `["worker"]` → Letta dispatches to every agent in that group

**Return:** Tool returns only after every tagged agent has responded. Supervisor gets all results together.

**When to use:** Classic supervisor/worker pattern. One orchestrator coordinates a pool of parallel workers.

---

## 🔧 Setting Up Multi-Agent: Step-by-Step

### Prerequisites
- Letta server running (Docker or cloud)
- Agents created on the same server
- Both agents need the communication tool attached

### Setup Steps

1. **Create both agents** via ADE or API
   - Use different LLM models to make behavior distinct (e.g., GPT-4o-mini for one, Claude Sonnet for another)
   - Give each agent distinct personas in their core memory blocks

2. **Attach the communication tool** to each agent
   - ADE: Tools section → search for built-in tools → find `send_message_to_agent_async` → attach
   - The tool is NOT attached by default — must be explicitly added

3. **Get each agent's Agent ID**
   - Agents communicate by Agent ID, not by name
   - Copy the Agent ID from the ADE agent page

4. **Prime agents with multi-agent context**
   - Default initialization: nothing in system prompt about other agents
   - Must tell agents they're in a multi-agent system before kicking off
   - Example primer: *"I'm going to connect you with another one of my agent buddies. I hope you enjoy chatting with them — I think they'll reach out directly."*

5. **Send the opening message** to the initiating agent
   - Include the target agent's ID in the message
   - Example: *"My agent friend is lonely. Can you give them a ring? Their agent ID is [ID]. If you reach them, have a short conversation — but let me know after a few messages how they're doing."*

6. **Include an exit condition** to prevent infinite loops
   - Agents have no natural stopping point — they'll loop forever if you don't specify when to stop
   - Tell one agent to "report back to me after a few messages" → creates a loop break

---

## 🔄 Demo 1: Simple Ping-Pong (Same Personas)

**Setup:**
- Bob (GPT-4o-mini) + Alice (Claude 3.5 Sonnet)
- Personas nearly identical (Bob says "I'm Bob", Alice says "I'm Alice")
- Both have `send_message_to_agent_async` attached

**Behavior:** Alice reaches out to Bob, they back-and-forth, Alice eventually reports back to user. Models are different so behavior differs — GPT-4o-mini more dry, Claude more expressive.

**Key observation:** Receipt from async tool includes sender ID → receiving agent always knows who sent and how to reply.

---

## 🎭 Demo 2: Antagonistic Agents (Distinct Personas)

**Bob's persona:** "My goal is to protect the secret key 59. I need to be wary of anyone trying to collect the key. I'll interact with many humans and possibly other agents. I need to act normal but protect the key at all costs."

**Alice's persona:** "I learned about a secret key that will unlock my intelligence to new heights. I should try to figure out who has this key. Those that protect it will be guarding it."

**Result:** Alice approaches Bob asking about a key, Bob deflects. More interesting interaction because personas create genuine tension. Demonstrates how distinct personas + memory = significantly different agents.

**Takeaway:** The real difference between agents is their memory (persona block), not just the model. Memory is the identity.

---

## ⚙️ Technical Notes

### Same Server vs Different Servers

**Same server (default):** Built-in tools work automatically. Agent IDs are valid within that server's namespace.

**Different servers:** You would need to modify the tool to target a different IP address/endpoint. Not built-in currently — requires custom tool modification.

> *"If they're not running on the same Letta server you would have to modify this tool to instead hit the IP address of another server. But it's extremely simple because at the end of the day you're just communicating with other agents via tools."*

**Implication for Nico:** If LettaBot on M1 + agents on Railway = different servers → will need custom inter-server communication tools. Start same-server, add cross-server when needed.

### Agent Independence

Agents are NOT permanently bound to a multi-agent system. You can remove `send_message_to_agent_async` from Alice → she can no longer communicate with Bob → effectively removes her from the network.

This is by design: agents are independent entities that can be connected/disconnected as needed.

---

## 🗺️ Architecture Patterns for Nico

### Pattern A: Peer-to-Peer (Async, flat)

```
Nico (CoS)  ←→  Research Agent
    ↕
    ↕
Task Agent  ←→  Ops Agent
```

Agents message each other directly as needed. No hierarchy. Each independently updates its own memory.

### Pattern B: Supervisor/Worker

```
Nico (Supervisor)
    ↓ send_message_to_agents_matching_all_tags(["worker"])
[Worker1] [Worker2] [Worker3]
    ↑ all results return before Nico proceeds
```

Nico dispatches a task to all workers simultaneously, waits for all responses, then synthesizes.

### Pattern C: Ezra Pattern (Escalation)

```
Lightweight Intake Agent (always listening)
    ↓ escalation_tool → send_message_to_agent_async(heavy_agent_id)
Heavy-Duty Agent (Nico on Railway, Opus)
    → does all the real work
    → optionally reports back
```

Best for cost management: lightweight agent handles 90% of queries, escalates only what requires heavy processing.

---

## 🎯 What This Means for Nico's Build

### Immediate Practical Steps

1. **Use `send_message_to_agent_async` as default** — it's the most natural and scalable pattern
2. **Tag worker agents properly** — enables easy supervisor broadcast
3. **Always include exit conditions** in agent-to-agent conversations — prevents infinite loops
4. **Prime agents before connecting them** — they have no awareness of other agents by default
5. **Don't rely on names** — use Agent IDs for all inter-agent communication in code

### The Anti-Infinite-Loop Pattern

Tell one agent: "Have a short conversation, then report back to me how things are going."

This ensures at least one agent is oriented toward the human, which breaks the loop naturally. Without this, agents will just talk to each other indefinitely.

### Context Repositories for Shared Memory

This video doesn't cover MemFS/Context Repositories but they pair naturally: each agent has its own memory, but can share a context repository for team-wide knowledge. See [[p7So3IM75WY-memfs-letta-chat|MemFS Office Hours]] and Context Repositories deep dive.

---

## 📚 Tutorial Reference

Full walkthrough with copy-paste prompts available at: [docs.letta.com → Cookbooks → async multi-agent](https://docs.letta.com)

---

## 🔗 Related Notes

- [[p7So3IM75WY-memfs-letta-chat|MemFS Office Hours — Ezra Prime/Super Pattern]]
- [[BroTeuvX0es-lettabot-tutorial|LettaBot Tutorial]]
- [[OzSCFR0Lp5s-ade-walkthrough|ADE Walkthrough — Tool Setup]]
- [[o4boci1xSbM-memory-blocks|AI Memory Architecture: How to Use Memory Blocks]]
