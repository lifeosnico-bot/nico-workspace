---
title: "Letta Memory Blocks (Core Memory)"
date: 2026-03-15
tags: [letta, docs, memory, core-memory]
status: active
type: research
source: "https://docs.letta.com/guides/agents/memory-blocks"
---

# Memory Blocks (Core Memory)

## Overview

Memory blocks are persistent, structured sections of an agent's context window that remain visible across all interactions without requiring retrieval. They function as prepended XML-like structures in the LLM's prompt.

## Core Characteristics

**Key Properties:**
- Agent-managed: Agents autonomously organize information using block labels
- Flexible: Applicable for knowledge storage, guidelines, state tracking, or scratch space
- Shareable: Multiple agents can access the same block for coordinated updates
- Always visible: Blocks remain in context without retrieval overhead

## Memory Block Structure

Each block consists of:
- **Label**: Unique identifier for the block
- **Description**: Explains the block's purpose (critical for agent understanding)
- **Value**: The actual content/data stored
- **Limit**: Character size constraint

The description field is particularly important—without clear guidance, agents may struggle to use blocks effectively.

## Block Configuration Options

**Read-Only Blocks**: Set `read_only: true` to prevent agent modifications while maintaining read access. This protects shared organizational data from unintended changes.

**Default Descriptions**: Letta auto-generates descriptions for standard labels (`persona`, `human`) unless overridden.

## Creating and Managing Blocks

### Creation Methods

1. **With Agent Creation**: Specify `memory_blocks` during agent initialization
2. **Independent Creation**: Create persistent blocks attachable to multiple agents via `block_ids`

### Core Operations

- **Retrieval**: Access block contents by ID for external use (reports, code outputs)
- **Listing**: Query all blocks with optional filtering by label or search text
- **Modification**: Update value, limit, or description (note: full replacement, not append)
- **Deletion**: Remove blocks from all attached agents
- **Inspection**: View which agents reference specific blocks

## Agent-Scoped Operations

- List all blocks attached to an agent
- Retrieve blocks by label without requiring block ID
- Modify blocks through agent-specific endpoints
- Detach blocks while preserving the block itself

## Important Considerations

When updating block values directly, the entire content is replaced—concurrent modifications result in last-write-wins behavior. To prevent data loss, consider setting frequently-modified shared blocks to read-only or ensuring controlled modification scenarios.
