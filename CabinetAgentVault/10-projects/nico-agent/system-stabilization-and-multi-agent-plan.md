---
title: System Stabilization + Multi-Agent Plan
type: project
status: active
created: 2026-02-28
modified: 2026-02-28
source: chat
tags: [nico-agent, operations, stabilization, multi-agent]
---

# System Stabilization + Multi-Agent Plan

# 1) What’s Broken (Symptoms)
- **Stale truth**: I claim something is “done” (Obsidian, routines, lists) but reality disagrees.
- **Missing report sections**: Morning/Night reports omit “Get to know Nico / How to use Nico today” even after discussing it multiple times.
- **No final list**: Work happens, but the “one true list” drifts or doesn’t reflect reality.
- **Telegram instability during Librarian attempts**: multi-agent routing attempts caused confusion/conflicts.

# 2) Root Cause (Not the Model)
- The bottleneck is **loop closure**:
  - Doing work without first capturing it as a task
  - Updating tools/config without writing back to `status.md`
  - Lacking verification checks (“definition of done”) so completion is a guess
- Telegram is fine for **DM CEO desk**, but brittle for **multi-agent group routing** unless engineered.

# 3) Non‑Negotiable Operating Loop (Stops Drift)
- **One List Rule**
  - Canonical source of truth: `~/Nico/CabinetAgentVault/00-dashboard/status.md`
  - If it’s not in `status.md`, it doesn’t exist.
- **Work Intake Rule**
  - Every new request becomes a tracked item (via `atl …`).
  - No work starts until it’s captured.
- **Verification Gate Rule**
  - Nothing is marked “done” unless a check passes (file exists, command returns expected output, service responds, etc.).

# 4) Verification Gates (Concrete)

# 4.1 Obsidian “Done” Gate
- ✅ Obsidian app exists (`/Applications/Obsidian.app`)
- ✅ Vault exists (`~/Nico/CabinetAgentVault/`)
- ✅ Vault config exists (`~/Nico/CabinetAgentVault/.obsidian/*`)
- Optional, only if we depend on it:
  - ✅ Obsidian CLI exists and responds (`obsidian version` returns a version)

**Decision required:**
- **CLI Required** → we install/enable until the CLI check passes.
- **CLI Not Required** → remove CLI dependency from status + reports.

# 4.2 Telegram “Safe” Gate
- ✅ Token is rotated if previously exposed
- ✅ Single poller per bot token
- ✅ Group routing only if engineered (separate bot token per agent OR a router implementation)

# 4.3 Morning/Night Report “Complete” Gate
- ✅ Reports are generated from a single spec file
- ✅ Required sections exist every time (no silent omissions)

# 5) Report Spec (What Must Always Appear)

# 5.1 Morning Report (Required)
- **Today’s focus (Top 3)**
- **Blockers that require Vincent**
- **Nico execution queue (what Nico will do next)**
- **How to use Nico today** (3 bullets)
- **Nico limits today** (3 bullets)
- **Questions for Vincent** (max 3)

# 5.2 Night Report (Required)
- **What got done (with links)**
- **What changed in status.md**
- **What’s blocked and why**
- **Next action (single next step)**

# 6) Multi‑Agent Architecture (When Ready)

# 6.1 What “Persistent Role Agents” Means
- Letta template-based agents that persist across sessions with their own memory.
- Examples:
  - **Librarian / Research Director** (Deep Thought template)
  - **Reflection/Sleeptime agent** (Sleeptime template)
  - **Memory Curator** (Memory Agent template)

# 6.2 Shared vs Role-Specific Memory

## Shared Core (copied to every role agent)
- Project overview (Lucavo goals, high-level stack)
- Vault rules + naming conventions
- Security rules (no secrets in memory)
- Git rules / workflow constraints
- Canonical sources: `status.md`, `decisions.md`

## Role-Specific Memory (unique per agent)
- Persona + mission
- Role checklists and heuristics
- Role’s accumulated learnings

## Canonical Truth Policy
- Specialists **propose**.
- Nico **promotes** into:
  - `status.md`
  - durable shared core memory

# 7) Librarian (Research Director) — Safe Setup Options

# Option 1 — Librarian has its own Telegram bot (separate token)
- Pros:
  - Direct chat lane
  - No Telegram poller conflicts
- Cons:
  - More operational overhead

# Option 2 — No Telegram for Librarian (recommended first)
- Pros:
  - No comms plumbing risk
  - Immediate value: Nico delegates research tasks and relays results
- Cons:
  - You talk to Librarian through Nico, not directly

# Option 3 — Code change (single poller routes by chat_id)
- Pros:
  - One bot, multiple brains
- Cons:
  - Engineering work + testing required

# 8) Agno (agno-agi/agno) — Quick Assessment
- **What it is**: a Python library/framework for building agents (tools, memory, knowledge/RAG, multi-agent teams).
- **What it is not**: a fully managed “CoS control plane” with our exact integrations out of the box.
- Switching to Agno means we must build/host:
  - comms routing (Telegram/Slack)
  - scheduled routines
  - memory persistence policy
  - verification gates
  - deployment/monitoring

**Recommendation:**
- Fix the loop in Letta first (sections 3–5). Consider Agno later for product agents inside Lucavo, not for replacing Nico’s control plane right now.

# 9) Immediate Next Actions (Pick One)
- **A)** Reality Sync: reconcile `status.md` to disk-verified truth (then lock One List Rule)
- **B)** Implement report spec enforcement (Morning/Night) so “get to know Nico” cannot be omitted
- **C)** Close Obsidian gate (decide CLI required or not, then verify accordingly)
