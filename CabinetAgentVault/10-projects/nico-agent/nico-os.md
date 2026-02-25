---
title: "Nico OS — Running List"
type: project
status: active
created: 2026-02-25
modified: 2026-02-25
source: nico
tags: [nico-os, operating-system, agents]
---

# Nico OS — Running List

## Purpose
A single running list of upgrades that make Nico more useful over time: better systems, better memory, better automation, clearer reporting, and tighter coordination across agents.

## Operating Rhythm (Daily)
- **Morning (15 min):** read Overnight outputs + produce Morning Report (Telegram + Obsidian) + set Today Top 3.
- **EOD (15 min):** capture what changed + blockers + decisions + update backlog + EOD Wrap Up.

## Improvement Loop (What we do every day)
1. **Capture**: new friction, new idea, new bug, new gap.
2. **Classify**: System / Tooling / Process / Knowledge / Product.
3. **Decide**: fix now vs schedule.
4. **Implement**: smallest possible change.
5. **Verify**: did it work.
6. **Record**: update status + session note.

## Backlog (Running)
### 1) Coordination Architecture (TOP)
- [ ] Define canonical artifacts and rules (status.md + llm-sessions + daily reports).
- [ ] Define work-item ID system (GitHub issue vs status task IDs).
- [ ] Define claim/lock protocol (prevent duplicate work).
- [ ] Define branch/worktree policy for multi-agent coding.

### 2) Reporting System
- [ ] Morning Report template + delivery automation (Telegram + Obsidian).
- [ ] EOD Wrap Up template + delivery automation.
- [ ] Weekly review template (what moved, what’s stuck, what to kill).

### 3) Video-to-Execution System
- [x] Video research template created.
- [ ] Automate: given `vid:` link, create note + summary + checklist.
- [ ] Create “implement / evaluate / runbook” tagging convention.

### 4) Communication Layer Experiments
- [ ] Discord pilot: server + bot + minimal bridge.
- [ ] Slack pilot: test the “crazy Slack” capability you found; document requirements.
- [ ] Decide: Slack vs Discord vs both.

### 5) Engineering Foundation for Agentic Coding
- [ ] Repo guardrails: branch protection, PR templates, CODEOWNERS.
- [ ] CI gates: lint/format/typecheck/tests.
- [ ] Security automation: CodeQL, Dependabot, secret scanning.
- [ ] Preview deploy per PR.

### 6) Memory and Knowledge Upgrades
- [ ] Add a “Known Facts / Defaults” note for fast reuse (stack, hosting, tools).
- [ ] Create decision log discipline: every decision gets a note + date.
- [ ] Periodic memory defragment (monthly).

## Decision Points (Need Vincent)
- Work item IDs: GitHub Issues vs status.md IDs.
- Comms platform: Slack vs Discord vs both.
- Stack/hosting once we start portal build.
