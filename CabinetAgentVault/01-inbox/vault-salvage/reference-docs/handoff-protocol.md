---
title: "Nico Handoff Protocol (End of Session)"
type: process
status: active
created: 2026-02-25
modified: 2026-02-25
source: nico
tags: [handoff, sessions, protocol]
---

# Nico Handoff Protocol (End of Session)

## When required
Run this at the end of any work block that changed state (code, config, decisions, blockers, artifacts).

## Steps (manual v1)
1) Write a session note
- Create: `00-dashboard/llm-sessions/YYYY-MM-DD_session-<surface>-N.md`
- Sections: Completed | Decisions | Notes / Blockers | Next

2) Update dashboards
- Update `00-dashboard/home.md` links if needed (today’s Morning, Nighttime, EOD)
- Update `00-dashboard/status.md` if priorities or blockers changed

3) File artifacts
- Templates -> `05-templates/`
- Daily reports -> `00-dashboard/daily/`
- Video research -> `50-clippings/youtube/`
- Vendor/tool notes -> `30-resources/vendors/` or `30-resources/tools/`
- If unsure -> `01-inbox/`

4) Nico OS improvement loop
- Add new improvements to `10-projects/nico-agent/nico-os.md`

5) Git (only if approved)
- Commit vault changes on a feature branch and push to GitHub.

## Claude Code /handoff reference
Claude Code has a dedicated skill:
- Path: `~/.claude/skills/handoff/SKILL.md`
We can mirror the same behavior for Nico with a script once you approve.
