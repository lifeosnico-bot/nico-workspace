---
title: "Decisions Log"
type: decision
status: active
created: 2026-02-14
modified: 2026-02-23
source: nico
tags: [decisions, log]
---

# Decisions Log

## 2026-02-16

### Architecture Principle: Build for N Agents, Not 2 (21:55 | Source: Vincent + Cowork)
Every infrastructure decision must be evaluated against: "does this work with 5+ agents running simultaneously?" Single-agent shortcuts create debt that compounds as the org scales. Specific implications:
- Git: branch protection + PR workflow from day one (Phase 0E) — not "later when we have real code"
- Communication: Slack is infrastructure, not optional — same priority as GitHub (Phase 4B promoted)
- Status.md: remains single source of truth, but real-time coordination moves to Slack. Agents read status.md at session start, post to Slack during work, write back to status.md at session end.
- Quick commands (adl, sts, done): must work from Slack #tasks channel, not just conversation windows
- iMessage: demoted to emergency escalation only. Does not scale to multi-agent.

### Communication Layer: Slack as Agent Backbone (21:55 | Source: Vincent + Cowork)
- Slack replaces iMessage as primary communication layer
- Channel structure mirrors organizational functions (#status, #tasks, #dev, #decisions, #nico-internal)
- #nico-internal = agent-to-agent coordination (Phase 7 dependency)
- Must be operational before sub-agents come online (Phase 7)
- Budget impact: +$0 (free tier) to +$8.75/mo (Pro, if needed for integrations)

### Metadata Standards: Enforce, Don't Just Document (22:10 | Source: Vincent + Cowork)
- Metadata rule (date+time, source, version) exists in CLAUDE.md but agents aren't consistently following it
- Rules without enforcement are suggestions. At 5 agents, suggestions become chaos.
- Fix: audit existing files, tighten the format spec, add to session protocol checklist, build automated validation when Slack is live
- Added as Phase 0E Task 6

### Git Workflow: Enforce Branch Protection Now (21:55 | Source: Vincent + Cowork)
- Both agents (Claude Code + Cowork) and auto-backup script were pushing directly to master
- Violates CLAUDE.md rules that existed but weren't enforced
- Decision: fix now, not later. Phase 0E created as highest priority.

## 2026-02-22

### Platform Decision: Slack (03:00 EST | Source: Vincent + Nico)
After analysis of Discord vs Slack, Vincent chose Slack. Key factors:
- Anthropic has official Slack integration (Claude speaks Slack natively)
- Business perception: Slack is standard for teams, clients, contractors — Discord is gaming
- Slack's ecosystem (enterprise SaaS integrations) is deeper and more maintained
- 90-day free tier history limit → upgrade to Pro ($7.25/mo) once integrations are confirmed working
- Lists/Canvases/Assigned to you (PRO features) are nice-to-have, not the deciding factor
- Discord features noted: better bot API for pure agent setups, completely free, unlimited history
- Final call: Slack for business perception and official AI tooling support

### Autonomy Model: Nico Runs Infrastructure, Vincent Owns Business (03:00 EST | Source: Vincent)
Vincent granted Nico full autonomy over infrastructure, tooling, and agent setup.
Vincent's bottleneck role: account creation (can't do on his behalf), phone installs, payments, business decisions.
Everything else: Nico decides and executes. No approval needed for infrastructure choices.

### Sub-Agent Architecture: Letta + Claude Code Hybrid (03:00 EST | Source: Nico overnight planning)
- Letta agents for roles needing persistent memory: Research Director, Ops Manager
- Claude Code Task agents for execution-only roles: Engineering, Product, CSM
- All agents report through Nico (CoS). Nico is the only persistent orchestrator.
- Full org chart documented in ~/Nico/Memory/cos-plan.md

### Search Infrastructure: DuckDuckGo (free) over Exa (paid shared credits) (03:00 EST | Source: Nico)
- Exa shared credits exhausted — platform limitation
- Solution: ~/Nico/Scripts/search.sh using DuckDuckGo HTML endpoint (free, no API key)
- Exa free tier (1000/mo) still worth getting for the built-in web_search tool
- Both solutions implemented/planned

### Bug: Telegram handoff to wrong agent (12:44 EST | Source: Vincent + Nico)
- Symptom: Telegram chat switched from Nico to a different Letta bot mid-thread; 10am meeting missed.
- Last message before drop: message-e4f03278 (2026-02-22T07:57:02Z).
- Restart/incorrect agent response: message-4845bb08 (2026-02-22T15:10:04Z) and message-0bcd6737 (agent-5f4271f9).
- Impact: missed briefing delivery; user had to re-establish context.
- Action: log GitHub issue in letta-ai/letta-code and record here for internal tracking.

## 2026-02-14

### Initialized Memory System
- Created decisions.md and status.md to track work and decisions
- Following CLAUDE.md workspace structure
