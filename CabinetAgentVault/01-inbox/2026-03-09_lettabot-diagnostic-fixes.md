---
title: LettaBot Diagnostic — Full Fix Checklist
type: task
status: active
created: 2026-03-09
source: Claude Code
tags: [lettabot, telegram, letta, diagnostic]
---

# LettaBot Diagnostic — Full Fix Checklist

**Created:** 2026-03-09 | **Source:** Claude Code session CC-13
**Agent:** Nico (`agent-5a9b0e69-1f30-476d-a89a-30c8e21c9668`)
**Model:** gpt-5.3-codex via chatgpt_oauth | **Temp:** 1.0 | **Context:** 128k

---

## Critical — Conversation Drift & Forgetfulness

- [ ] 1. Lower temperature from 1.0 → 0.4
- [ ] 2. Attach `memory` tool (edit own memory blocks)
- [ ] 3. Attach `archival_memory_insert` tool
- [ ] 4. Attach `archival_memory_search` tool
- [ ] 5. Enable sleeptime agent (background memory consolidation)
- [ ] 6. Reset shared conversation (clear 256-message evicted backlog)
- [x] 7. Isolate Telegram DM into its own conversation — switched `conversations.mode: per-channel` + `heartbeat: dedicated` (done 2026-03-09)
- [ ] 8. Seed/review memory blocks — 86% capacity unused, `persona/learned_behaviors` still default
- [ ] 9. Consider switching model from `gpt-5.3-codex` to a conversational model

## Server-Side Agent Config

- [ ] 10. Attach `send_message_to_agent_and_wait_for_reply` (Nico ↔ Librarian)
- [ ] 11. Attach `semantic_search_files`
- [ ] 12. Attach GitHub MCP tools (selectively: `search_code`, `get_file_contents`, `create_pull_request`, `push_files`, `list_commits`, `create_branch`)
- [ ] 13. Attach research tools (`create_research_plan`, `reset_research`)
- [ ] 14. Set agent timezone to actual timezone (currently UTC)
- [ ] 15. Lower/tune reasoning effort (currently `medium`)

## lettabot.yaml Config

- [ ] 16. Enable `telegram.streaming: true`
- [ ] 17. Enable `telegram.features.images: true`
- [ ] 18. Set `telegram.allowedUsers` with Vincent's Telegram user ID
- [ ] 19. Add `telegram.mentionPatterns: ["nico"]`
- [ ] 20. Enable `features.memfs: true` (git-backed memory filesystem)
- [ ] 21. Set `features.sendFileDir` to `~/Nico/`
- [ ] 22. Add `heartbeat.promptFile` (editable prompt without restart)
- [ ] 23. Write custom heartbeat prompt focused on specific tasks
- [ ] 24. Reduce heartbeat interval 15 → 60 min (or fix todo bloat first)
- [ ] 25. Set `agents[].workingDir` to `~/Nico/`
- [ ] 26. Enable transcription (`transcription.provider: openai`) for voice messages
- [ ] 27. Consider TTS (`tts.provider: elevenlabs` or `openai`) for voice replies
- [ ] 28. Enable Gmail polling (`features.gmail.enabled: true`)
- [ ] 29. Consider adding Slack channel to LettaBot (replace custom slack-bot)
- [ ] 30. Consider `features.display.showToolCalls: true`
- [ ] 31. Add `providers[]` for BYOK API keys

## Todo Store Cleanup

- [ ] 32. Purge 60+ duplicate/stale todos from heartbeat store
- [ ] 33. Remove session-scaffolding todos (appear 5-8x each)
- [ ] 34. Agent needs to use `due`, `snoozed_until`, `recurring` fields (all zero usage)

## Cron Jobs to Create

- [ ] 35. Morning briefing (daily 8am) — read status.md, summarize priorities
- [ ] 36. Daily note triage (daily 9am) — process daily note Dump items
- [ ] 37. Weekly review (Friday 5pm) — summarize completed work, open blockers
- [ ] 38. Status.md sync (every 4 hours) — ensure no stale in-progress items
- [ ] 39. Overnight YouTube processing (2am)

## Skills

- [ ] 40. Install `obsidian` skill to agent scope
- [ ] 41. Install `github` skill to agent scope
- [ ] 42. Set `googleEnabled: true` in skills config
- [ ] 43. Consider `1password` skill
- [ ] 44. Consider `apple-reminders` skill

## Conversation Architecture

- [ ] 45. Consider `conversations.mode: per-chat` if adding more channels
- [ ] 46. Add `conversations.perChannel` overrides if keeping shared mode + Slack
- [ ] 47. Set `conversations.maxSessions` if switching to per-chat

---

## Notes

- Items 1-9 are the root cause of the conversation drift/forgetfulness
- Items 1-7 can be done via API calls without restarting LettaBot
- Items 16-31 require editing `lettabot.yaml` and restarting the bot
- Items 35-39 can be created via `lettabot-schedule create` at any time
- "Consider" items are optional enhancements, not fixes
