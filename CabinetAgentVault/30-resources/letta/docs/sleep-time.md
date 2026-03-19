---
title: "Letta Sleep-time Agents"
date: 2026-03-15
tags: [letta, docs, sleeptime, architecture]
status: active
type: research
source: "https://docs.letta.com/guides/agents/architectures/sleeptime"
---

# Sleep-time Agents

## Overview

Sleep-time agents are experimental features in Letta that operate as background processes sharing memory with primary agents. They function as "a special form of multi-agent architecture, where all agents in the system share one or more memory blocks."

## Core Functionality

When activated with `enable_sleeptime: true`, the system automatically generates:

- A primary agent with `conversation_search` and `archival_memory_search` tools
- A background sleep-time agent managing the primary agent's memory blocks

## Memory Blocks

The system uses memory blocks to store "learned context" derived from original context like conversation histories. These labeled sections have character limits and can be shared across multiple agents. Sleep-time agents write reflective summaries to these blocks for use by other agents.

## Configuration

### Enabling on Existing Agents

The feature can be activated via API/SDK using the `enable_sleeptime` parameter, or through the Agent Development Environment by selecting "Enable Sleeptime" from agent options.

### Update Frequency

Sleep-time agents trigger every N steps (default: 5) to refresh memory blocks. Adjust this using the `sleeptime_agent_frequency` parameter. The documentation recommends "keeping the frequency relatively high (e.g. 5 or 10)" to balance efficiency against token costs.

## Resources

- [Blog post](https://www.letta.com/blog/sleep-time-compute)
- [Research paper](https://arxiv.org/abs/2504.13171)
