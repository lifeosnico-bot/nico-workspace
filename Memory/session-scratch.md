# Session Scratch — 2026-02-27

**Session start:** 19:20 EST
**Channel:** Letta Code CLI
**Agent:** Nico
**Machine:** M1 (nico-agent)

## Discoveries This Session

- Root cause of 3-day Telegram outage: stuck pending tool approval on conversation `conv-1e78bf80-...`
- `agent.pending_approval` API returns null BUT `messages.create` returns 409 PENDING_APPROVAL — inconsistent server state
- LettaBot's orphaned approval recovery logged "No orphaned approvals found" but the approval was there
- Error logs only show `error=error, stopReason=error` — the 409 detail is swallowed
- Fix: delete `conversationId` from `lettabot-agent.json`, restart bot, fresh conversation created

## Decisions Made

- Filed 3 bug reports:
  - letta-ai/lettabot#438: Orphaned approval recovery fails
  - letta-ai/lettabot#439: Error logs hide root cause
  - letta-ai/letta#3206: Stuck approvals permanently block agent (no server-side timeout)
- Cleaned up `lettabot-agent.json` — removed stale LettaBot and Librarian entries
- Cleared error logs for fresh start

## Decisions Pending

- None

## Open Questions

- None

## Wrote to Memory Today

- Updated `system/ai-assistant/lettabot.md` with stuck conversation runbook
- Updated `system/human.md` with beginner terminal instruction preference

## Session End (fill in at close)

- What was accomplished: Fixed 3-day Telegram outage. Root cause was stuck pending approval on corrupted conversation. Filed 3 bug reports.
- Decisions made: Single-agent Nico architecture stays. Report bugs upstream.
- First thing next session: Verify Telegram still stable. Check bug report responses.
