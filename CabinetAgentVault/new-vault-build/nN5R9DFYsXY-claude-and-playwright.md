---
title: "Letta Research Intake — nN5R9DFYsXY"
date: 2026-03-09
tags: [librarian, video-intake, claude, playwright, testing]
status: active
type: research
project: nico-agent
source: "https://youtu.be/nN5R9DFYsXY?si=clf_COg_h3sirUNs"
---

# Letta Research Intake — nN5R9DFYsXY

## TL;DR
- Video compares Playwright CLI skill vs Playwright MCP in Claude workflows.
- Demonstrates ticket verification flow with browser automation, screenshots, and generated reports.
- Emphasis is on reproducible QA output: issue state, repro steps, evidence, and recommendations.

## What matters for Nico
- Strong fit for overnight deterministic validation loops:
  1) pull task/ticket context
  2) run browser checks
  3) capture screenshots each step
  4) emit machine-readable + human-readable report
- Aligns with our proof-gate requirement before marking done.

## Extracted patterns
1. **Tool path branching**: same task can run via CLI toolchain or MCP toolchain.
2. **Evidence-first execution**: screenshot capture at each stage.
3. **Report standardization**: fixed outputs for pass/partial/fail + findings.
4. **Handoff-ready artifacts**: report folders can be fed to sub-agents for follow-up fixes.

## Practical application to Nico
- Add strict report schema for automation jobs: status, repro, screenshots, findings, recommendations.
- Keep execution artifacts grouped per run for downstream agent handoff.
- Require completion proof from artifacts, not text claims.

## References
- Transcript: `30-resources/letta/transcripts/nN5R9DFYsXY.md`
- Source: `https://youtu.be/nN5R9DFYsXY?si=clf_COg_h3sirUNs`
