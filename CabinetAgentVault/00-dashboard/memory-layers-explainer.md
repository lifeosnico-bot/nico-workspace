---
title: "Memory Layers Explainer"
type: reference
status: active
created: 2026-03-08 17:42
modified: 2026-03-08 17:42
source: Nico
tags: [memory, letta, architecture, ops]
---

# Memory Layers Explainer

## Why this note exists
Use today’s findings to make memory behavior predictable and debuggable.

## What we confirmed today
- Memory writes happened on **other local Letta agent IDs**, not the main Nico agent (`agent-5a9b0e69-1f30-476d-a89a-30c8e21c9668`).
- The writes were identical across those 4 agents and contained generic bootstrap content (`human.md`, `persona.md`, small config).
- Main takeaway: this is a **target-routing issue**, not a data-loss issue.

## Memory layers (plain language)
1. **Live Context Window**
   - What the model can currently “see” in this active conversation.
2. **Pinned Agent Memory (Core + system files)**
   - Persistent instructions and memory files for one specific agent ID.
3. **External/Recall Memory**
   - Searchable long-term message history and recalled context.
4. **Conversation History Store**
   - Session transcripts/messages that can be summarized and recalled.
5. **Local Agent Memory Repos on Disk**
   - One folder per `agent-id` under `~/.letta/agents/`.

## Critical rule
Memory is **agent-scoped**. If a write lands on the wrong `agent-id`, the data exists but your main Nico agent will not use it.

## Flow chart
```mermaid
flowchart TD
    A[Input: Message / Command / Automation] --> B{Which agent-id is targeted?}
    B -->|Main Nico agent-5a9b...| C[Write to Nico memory layers]
    B -->|Other agent-id| D[Write to other agent memory only]

    C --> E[Pinned memory updated]
    C --> F[Recall/conversation context available]
    E --> G[Commit + Push]
    F --> G
    G --> H[Visible across machines/sessions]

    D --> I[Data exists but not in main Nico]
    I --> J[Looks like "sync happened" but wrong target]
```

## Verification commands (copy/paste)
### 1) Confirm main Nico memory path
`ls -la /Users/lifeos.nico/.letta/agents/agent-5a9b0e69-1f30-476d-a89a-30c8e21c9668/memory/system`

### 2) See most recent writes in main Nico memory
`ls -ltR /Users/lifeos.nico/.letta/agents/agent-5a9b0e69-1f30-476d-a89a-30c8e21c9668/memory`

### 3) See all local agent folders
`ls -la /Users/lifeos.nico/.letta/agents`

### 4) Find today’s memory content writes across local agents (non-git files)
`python3 - <<'PY'
import os, datetime, pathlib
base=pathlib.Path('/Users/lifeos.nico/.letta/agents')
today=datetime.date.today()
for agent in base.iterdir():
    mem=agent/'memory'
    if not mem.exists():
        continue
    for root, dirs, files in os.walk(mem):
        dirs[:] = [d for d in dirs if d != '.git']
        for f in files:
            p=pathlib.Path(root)/f
            ts=p.stat().st_mtime
            dt=datetime.datetime.fromtimestamp(ts)
            if dt.date()==today:
                print(f"{dt.strftime('%Y-%m-%d %H:%M:%S')} | {agent.name} | {p}")
PY`

### 5) List Letta agents known by API (name + id)
`letta agents list --limit 200`

## Quick mental model
- Letta is multi-agent.
- Each agent is its own memory namespace.
- “Synced” is only true for Nico when the write lands on `agent-5a9b...` and is persisted.

## Operational checkpoint
Before accepting any “memory synced” claim, verify:
1. Correct `agent-id`
2. File changed in that agent memory
3. Content is what was expected
4. Commit/push state is clean
5. Main Nico can read/use it
