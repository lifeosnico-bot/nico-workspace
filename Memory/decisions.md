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

## 2026-02-14

### Initialized Memory System
- Created decisions.md and status.md to track work and decisions
- Following CLAUDE.md workspace structure
