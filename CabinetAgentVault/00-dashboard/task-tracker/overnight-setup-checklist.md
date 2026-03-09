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

## Notes
- This checklist is the live source for overnight setup status.
- Each item must be checked only when fully complete.
