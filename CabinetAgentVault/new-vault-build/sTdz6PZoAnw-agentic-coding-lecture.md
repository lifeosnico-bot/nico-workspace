---
title: "Letta Research Intake — sTdz6PZoAnw"
date: 2026-03-09
tags: [letta, research, video-intake, coding-agents]
status: active
type: research
project: nico-agent
source: "https://youtu.be/sTdz6PZoAnw?si=euE3isO7CYAQkCXg"
---

# Letta Research Intake — sTdz6PZoAnw

## TL;DR
- Video explains practical use of coding agents for end-to-end code changes.
- Demonstrates tool-call flow: read/edit files, run commands, verify output.
- Emphasizes permission boundaries for safer autonomous execution.
- Reinforces git-backed review workflow for agent-generated edits.

## ⚠️ What This Changes for Nico
- Confirms current direction: allow autonomous file edits with explicit shell-command review gates.
- Supports overnight plan requirement for deterministic tool execution plus proof output.

## 🛠️ Section 1 — Coding Agent Workflow
- Transcript shows a live “task to completion” cycle: prompt -> read file -> edit -> run mypy -> run script.
- Core insight: coding agents behave like chat models plus tool access and execution loop.

## 🛠️ Section 2 — Safety/Permissions Model
- Speaker highlights separate control levels for tools.
- Recommended pattern aligns with Nico constraints: tighter approval for high-risk system commands.

## 🏗️ Extracted Architecture Decisions for Nico
1. Keep execution logs/proof for each completed task step.
2. Preserve approval gates for risky shell actions even when edit autonomy is enabled.
3. Continue git-based review pattern for autonomous modifications.

## References
- Transcript: `30-resources/letta/transcripts/sTdz6PZoAnw.md`
- Source: `https://youtu.be/sTdz6PZoAnw?si=euE3isO7CYAQkCXg`
