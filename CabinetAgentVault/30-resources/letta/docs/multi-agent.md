---
title: "Letta Multi-Agent Patterns"
date: 2026-03-15
tags: [letta, docs, multi-agent]
status: active
type: research
source: "https://docs.letta.com/guides/agents/multi-agent"
---

# Multi-Agent Patterns in Letta

Letta enables developers to build multi-agent systems through built-in cross-agent communication tools supporting both synchronous and asynchronous messaging, along with shared memory capabilities.

## Communication Tools

Three primary tools facilitate inter-agent communication:

1. **`send_message_to_agent_async`** - Asynchronous messaging that returns immediately after delivery, allowing agents to process messages independently without blocking the sender.

2. **`send_message_to_agent_and_wait_for_reply`** - Synchronous request-response pattern where the sender waits for the target agent's response before continuing.

3. **`send_message_to_agents_matching_all_tags`** - Broadcasting mechanism enabling a supervisor to send messages to multiple agents matching specified tags, collecting responses from all matched agents.

## Coordination Approaches

The documentation outlines five established patterns:

- **Supervisor-worker** - Hierarchical routing with tag-based agent grouping
- **Parallel execution** - Multiple agents analyzing tasks simultaneously from different angles
- **Round-robin** - Sequential task distribution across agent pools
- **Producer-reviewer** - Iterative refinement cycles with feedback integration
- **Hierarchical teams** - Multi-level coordination spanning executives, managers, and operational workers

## Additional Resources

Developers can leverage shared memory blocks for state synchronization between agents and explore detailed memory management through core concept guides and step-by-step tutorials.
