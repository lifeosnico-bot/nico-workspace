---
title: "Overnight Setup Checklist"
type: task-list
status: active
created: 2026-03-09 01:03
modified: 2026-03-09 01:03
source: Nico
---

# Overnight Setup Checklist

## Rule
If task scope is more than 1 item, track it here with checkboxes and update in real time.

## Current Items
- [ ] 1. Switch overnight execution to full 3-job flow (screenshot, video, website)
- [ ] 2. Enforce queue state transitions (`queued -> running -> completed|blocked|failed`)
- [ ] 3. Add proof gate for completion (output file path + timestamp + source)
- [ ] 4. Align schedule to overnight window (3:00 AM to 8:00 AM EST behavior)
- [ ] 5. Generate morning report from queue truth (Completed, Blocked, Failed, Next actions)
- [ ] 6. Add Discord ingestion lane (Discord bot/API first; Playwright/Puppeteer MCP fallback only when API is not available)
- [ ] 7. Add internal skill command for overnight queue execution so wake/alarm calls one deterministic workflow
- [ ] 8. Define primary vs sleeptime memory architecture with shared blocks (`guidance`, `coordination`, `patterns`) and explicit write permissions
- [ ] 9. Implement shared block attach flow for both agents (`LETTA_AGENT_ID`, `SLEEPTIME_AGENT_ID`) and verify both can read shared guidance
- [ ] 10. Lock primary vs sleeptime block ownership matrix (`persona/human/project_context/pending_items` = primary write; `coordination/guidance` = sleeptime write; `patterns` = both append)
- [ ] 11. Add concurrency guardrails (no simultaneous writes to same block; use coordination/guidance handoff path)

## Notes
- This checklist is the live source for overnight setup status.
- Each item must be checked only when fully complete.
