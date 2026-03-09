---
title: "Letta Research Intake — KtG5Ez7KujE"
date: 2026-03-09
tags: [librarian, video-intake, claude, orchestration, multi-agent]
status: active
type: research
project: nico-agent
source: "https://youtu.be/KtG5Ez7KujE?si=6-9jHwHrI1YqWYDE"
---

# Letta Research Intake — KtG5Ez7KujE

## TL;DR
- Demo shows multi-instance Claude orchestration with role-like task zones.
- Core pattern: spin up separate agents for research, writing, analytics in parallel.
- Human supervises and reviews outputs as agents return from background work.

## What matters for Nico
- Reinforces strict orchestration loop:
  1) assign one clear task per agent
  2) run in parallel
  3) review/proof each output before next action
- Supports Lucavo direction toward deterministic multi-agent operations.

## Extracted patterns
1. **Parallel specialization**: separate instances handle different work types simultaneously.
2. **Task-to-seat metaphor**: useful UI abstraction for who is doing what.
3. **Supervisor checkpoint**: work is not done until reviewed and accepted.
4. **Re-query loop**: operator asks follow-up question on returned outputs.

## Practical application to Nico
- Keep queue items atomic and role-tagged (research/writing/analysis).
- Require proof path per finished job.
- Preserve one source of truth for status transitions.

## References
- Transcript: `30-resources/letta/transcripts/KtG5Ez7KujE.md`
- Source: `https://youtu.be/KtG5Ez7KujE?si=6-9jHwHrI1YqWYDE`
