# 50 Days Running an AI Agent — Key Lessons
**Source**: https://youtu.be/NZ1mKAWJPr4
**Processed**: 2026-02-22 | Claude Code | Session CC-1

---

## 3 Foundational Principles
1. **Markdown first** — everything in plain text files, no proprietary databases. Data is portable, readable by any tool, no lock-in.
2. **Separate contexts** — one channel per workflow type. Never mix research, analytics, daily tasks, and bookmarks in one conversation.
3. **Match model to task** — Opus only for deep thinking, cheap models for routine work.

---

## What Worked Best
- **Morning briefing** — scans feeds, writes to Obsidian, compounds value over time as agent starts connecting dots
- **Heartbeat every 30 min** — proactively catches emails, calendar events, service failures without being asked
- **Parallel sub-agents for research** — orchestrator spawns 5+ agents simultaneously, each gets own context window, produced 50+ pages of structured research in minutes
- **File-based memory** — ~3,000 Obsidian notes, semantic search via QMD, never relies on conversation context alone
- **Per-channel model routing** — biggest single cost and quality improvement. Different model per Discord channel based on what that channel actually does
- **Agent gets better over time** — 50 days in it anticipates needs, has internalized style and preferences. Compounds.
- **Nightly backup cron** — full restore in 30 min from any failure. Backs up config, workflows, cron schedules, memory/soul files

---

## Biggest Pitfalls
- **Silent context compaction** — context fills up, agent silently forgets things mid-task. No warning. Mitigation: write everything to files as it happens, monitor context %, start new session at 50%, run `/compact` manually before system does it
- **Cost without model routing** — Opus everywhere becomes "scary" expensive fast
- **Browser automation** — 5/10 reliability. Sessions drop, agent goes silent. Not reliable for complex tasks yet
- **Complex multi-step tasks need babysitting** — simple tasks 8/10 reliable, complex tasks need check-ins
- **"What do I automate" problem** — tool won't invent workflows for you. Only valuable if you already have systems

---

## Technical Architecture

### Channel Structure (Discord)
- One channel per workflow type
- Start with 2-3, add only when genuinely needed
- Per-channel model routing: Opus for research, cheap for heartbeats/bookmarks/routine

### Sub-agent Orchestration
- Main agent = orchestrator
- Spawns parallel sub-agents for research, each with own context window
- Keeps main agent context clean

### Cron Jobs
- **4am** — auto-update: updates packages, restarts services, reports failures
- **4:30am** — backup: config, workflows, cron schedules, soul/memory files
- **Every 30 min** — heartbeat: email scan, calendar check, service monitoring

### Security
- Draft-only mode for email (no sending without approval)
- Command deny list for destructive actions (require explicit approval)
- Treat email content as hostile input (prompt injection risk)
- Tailscale for private networking — no public-facing connectivity

---

## Cost Optimization
- Opus: deep research, complex reasoning, synthesis only
- Cheap model: heartbeats, sub-agents, bookmark processing, routine tasks
- Context management also reduces cost — shorter contexts = fewer tokens billed

---

## Evolution Timeline
- **Week 1**: Testing, using like ChatGPT
- **Week 3**: Building automations, starts feeling useful
- **Week 5**: Hit a wall — context pollution, everything mixed. Need to separate contexts
- **Week 7**: Per-model routing kicks in, costs drop, feels like a system not a chatbot
- **Week 8+**: Stop using the tool, start designing how you interact with it

---

## His "Start Here" Recommendation
1. Draft-only email triage with urgent alerts
2. Daily briefing that writes to a markdown file
3. One inbox channel for bookmarks — drop links, agent enriches and builds knowledge base

---

## Directly Applicable to Nico-Agent Setup
- Already have the right base: Tailscale, Obsidian, markdown-first, status.md as single source of truth
- Context separation is next priority when Slack is live — one channel per workflow from day one
- Heartbeat checks: low effort, high value — build early
- Sub-agent orchestration for any research tasks
- Draft-only email mode when email automation is built
- Backup cron already running — good. Consider adding soul/memory files to backup scope
- Reliability expectation: simple tasks 8/10, browser automation 5/10. Design for failure cases.
- "5% of the ceiling" — worth building now. Compounding value from accumulated context means earlier = more valuable
