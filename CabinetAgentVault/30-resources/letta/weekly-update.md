---
title: "Letta Knowledge Base — Weekly Update"
date: 2026-03-15
tags: [letta, research, update]
status: active
type: research
---

# Letta Weekly Update — 2026-03-15

## New Videos (need M1 transcript pull)

| ID | Title |
|---|---|
| 3npYYBU9NN4 | ⏳ Letta Devlog: Adding computer use to Claude Subconscious |
| rCOHloFHgMs | ⏳ Letta Office Hours: March 12, 2026 |
| -SwpYxjGRdg | ⏳ Letta Office Hours: Letta Remote, Claude Subconscious Demo, and Lettabot |

3 new videos found since last catalog update (2026-03-01).

## Docs Updated

| Page | File | Status |
|---|---|---|
| Introduction | [[overview]] | ✅ Refreshed |
| Memory Blocks | [[memory-blocks]] | ✅ Refreshed |
| Multi-Agent | [[multi-agent]] | ✅ Refreshed |
| Sleep-time | [[sleep-time]] | ✅ Refreshed |
| LettaBot | [[lettabot]] | ⚠️ 404 — page may have moved |

## Latest GitHub Releases

**v0.16.6** (2026-03-04) — Major update:
- Conversations API expanded with default conversation / agent-direct mode
- System message compiled at conversation creation time
- New model support: `gpt-5.3-codex`, `gpt-5.3-chat-latest`
- Context window default bumped 32k → 128k
- Core memory block char limit bumped 20k → 100k
- Anthropic `effort="max"` support added

Previous: v0.16.5 (2026-02-24), v0.16.4 (2026-01-29), v0.16.2 (2026-01-12), v0.16.1 (2025-12-18)

## Action Required

Run on M1:
```bash
bash ~/Nico/Scripts/letta-knowledge-pipeline.sh --new
```

New video IDs for transcript pull:
- `3npYYBU9NN4`
- `rCOHloFHgMs`
- `-SwpYxjGRdg`
