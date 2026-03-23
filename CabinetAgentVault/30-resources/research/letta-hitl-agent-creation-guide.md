---
title: "Research: Creating a Letta Agent with Human-in-the-Loop"
date: 2026-03-22
tags: [research, letta, agent-dev, human-in-the-loop, hitl]
type: research
status: active
source: https://docs.letta.com/guides/agents/human-in-the-loop/
---

# Creating a Letta Agent with Human-in-the-Loop

## Summary

Step-by-step guide for creating a Letta stateful agent with HITL (Human-in-the-Loop) approval gating on sensitive tool calls. Sourced from official Letta docs. Annotated with which steps Vincent handles vs. which Claude/Nico can do autonomously.

---

## Phase 1: Prerequisites & Setup

| # | Step | Owner | Notes |
|---|------|-------|-------|
| 1 | Get a Letta API key at `app.letta.com/api-keys` | **Vincent** | Requires browser login |
| 2 | Set `LETTA_API_KEY` as env var in shell | **Vincent** | `export LETTA_API_KEY='...'` |
| 3 | Install Letta SDK | **Nico/Claude** | `pip install letta-client` or `npm install @letta-ai/letta-client` |

---

## Phase 2: Agent Design Decisions

| # | Step | Owner | Notes |
|---|------|-------|-------|
| 4 | Choose the model | **Vincent** | e.g. `anthropic/claude-sonnet-4-6`, `openai/gpt-4o-mini` |
| 5 | Write the **persona block** | **Vincent** (Nico can draft) | Who the agent is, tone, behavior |
| 6 | Write the **human block** | **Vincent** (Nico can draft) | What the agent knows about the user |
| 7 | Write the **system prompt** | **Vincent** (Nico can draft) | Core instructions and context |

---

## Phase 3: Agent Creation (Nico executes)

| # | Step | Owner | Notes |
|---|------|-------|-------|
| 8 | Call `client.agents.create()` with model + memory blocks | **Nico/Claude** | Fully autonomous once design decisions made |

---

## Phase 4: Tools & HITL Configuration (Nico executes)

| # | Step | Owner | Notes |
|---|------|-------|-------|
| 9 | Decide which tools the agent needs | **Vincent** | Design decision — what actions should it take? |
| 10 | Write/define tool functions | **Nico/Claude** | Python or TypeScript function definitions |
| 11 | Mark sensitive tools with `default_requires_approval: true` | **Nico/Claude** | DB writes, email, API calls with cost, file deletion |
| 12 | Attach tools to the agent via API | **Nico/Claude** | Fully autonomous |
| 13 | Test the HITL approval flow | **Both** | Nico triggers, Vincent approves/denies |

---

## Phase 5: Runtime — Human-in-the-Loop Cycle

| # | Step | Owner | Notes |
|---|------|-------|-------|
| 14 | Send messages to the agent | Nico or app | Automated |
| 15 | Agent hits guarded tool → returns `approval_request_message` | Automatic | Contains tool name, args, `tool_call_id` |
| 16 | Review and approve or deny (with reason) | **Vincent** | The actual human-in-the-loop moment |
| 17 | Agent continues after approval or adjusts after denial | Automatic | Denial reason helps agent reformulate |

---

## Key Concepts

### Memory Blocks
- **Persona block**: defines agent identity and behavior
- **Human block**: stores info about the user — persists across conversations

### HITL Tool Configuration (3 methods)
1. **Tool-level default** — `default_requires_approval: true` at tool creation; applies to all future agents
2. **Modify existing tool** — PATCH the tool; only affects *new* agent-tool attachments, not existing
3. **Per-agent override** — `/agents/{AGENT_ID}/tools/{TOOL_NAME}/approval` endpoint; fine-grained control

### Approval Request Payload
When agent pauses, you receive:
- `tool_name` — what it wants to run
- `arguments` — what args it's passing
- `tool_call_id` — use this to approve/deny (not deprecated `approval_request_id`)
- `message_id` — for response routing

### Approving
```python
# Approve
client.agents.messages.send(agent_id, tool_call_id=..., approve=True)

# Deny with reason
client.agents.messages.send(agent_id, tool_call_id=..., approve=False, reason="Use read-only query first")
```

### Strategic HITL Targets
Flag these tool types for approval:
- Database writes (INSERT, UPDATE, DELETE)
- Financial API calls
- File deletion or system changes
- Email / SMS / communication tools
- Config changes
- Third-party integrations with rate limits or cost

---

## Key Findings

- HITL only applies to **server tools** — client tools are implicitly approval-gated (client must execute them)
- Modifying tool-level approval settings does **not** retroactively affect existing agent-tool attachments
- Denial feedback should be specific and actionable — agents use it to reformulate
- Use `tool_call_id` for all approval responses (not the deprecated `approval_request_id`)
- In streaming/background mode, approvals return a new `run_id` — capture tool result on approval stream, resume original run with `starting_after`

---

## Implications for Lucavo / SaaS

- HITL is the right pattern for any Nico action that touches clients, invoices, or external comms
- Per-agent approval config lets us give Nico more autonomy over time as trust builds
- This is the foundation for a "progressive autonomy" model: start with approval on everything sensitive, unlock as patterns prove safe

---

## Next Steps

- [ ] Confirm `LETTA_API_KEY` is set in environment
- [ ] Define the first agent's purpose (what is it for?)
- [ ] Choose model
- [ ] Draft persona + human + system prompt
- [ ] Identify which tools it needs and which need HITL gating

---

## References

- [Human-in-the-loop | Letta Docs](https://docs.letta.com/guides/agents/human-in-the-loop/)
- [HITL Tools | Letta Docs](https://docs.letta.com/guides/core-concepts/tools/human-in-the-loop)
- [Your first Letta agent | Letta Docs](https://docs.letta.com/tutorials/hello-world/)
- [Letta Quickstart | Letta Docs](https://docs.letta.com/quickstart)
- [Letta Python SDK | Letta Docs](https://docs.letta.com/api/python/)
