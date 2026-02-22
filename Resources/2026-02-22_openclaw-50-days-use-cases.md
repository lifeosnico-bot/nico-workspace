---
title: OpenClaw — 50 Days of Real Use Cases
type: resource
status: active
created: 2026-02-22
source: https://youtube.com/watch?v=NZ1mKAWJPr4
tags: [openclaw, ai-assistant, workflow, architecture]
---

# OpenClaw — 50 Days of Real Use Cases

**Source**: YouTube `NZ1mKAWJPr4` by the creator of Clawdiverse and the official OpenClaw setup video
**Processed**: 2026-02-22

---

## 3 Core Principles (After 50 Days)

1. **Markdown-first** — Everything in plain text files (Obsidian). No lock-in. Data moves in 5 seconds.
2. **Separate contexts** — One Discord channel per workflow. Research doesn't bleed into analytics.
3. **Match model to task** — Opus for deep thinking, cheap models for routine work. Costs stop being scary.

---

## The 50-Day Evolution

| Phase | What Happens |
|-------|-------------|
| Week 1 | Novelty. Using it like ChatGPT. Decide: markdown-first from day one. |
| Week 3 | Start building automations: morning briefings, background checks. |
| Week 5 | Hit the wall. Everything in one conversation = context pollution. **Migrate to Discord.** |
| Week 7 | Separate contexts. Per-channel model routing. |
| Week 8+ | Stops being a chatbot. Becomes a system. |

---

## 20 Use Cases

### Automated (Daily, No Intervention)

**1. Morning Twitter Briefing (7 AM)**
- Scans followed accounts → picks top 10 → writes to Obsidian + video ideas backlog + sends summary
- Value compounds: connects related content across notes

**2. Historical Image of the Day**
- Fetches Wikipedia "On This Day" → generates woodcut-style image of 10 seconds before the event → pushes to e-ink display (TRMNL)
- Mystery mode: only shows date/location, user guesses the event

**3. Self-Updating (4 AM cron)**
- Pulls ClawHub skill updates → restarts gateway → reports results
- Breaks during update? It tells you.

**4. Daily Backup (4:30 AM cron)**
- Backs up: config files, workflows, cron schedules, SOUL file, MEMORY files, skills
- Server dies → back up in 30 min, not rebuilding from scratch

**5. Heartbeat Checks (Every 30 min)**
- Scans email, checks calendar, monitors services
- Caught: Netflix payment failure, domain renewals, almost-missed meetings, relevant newsletter articles
- **Important**: Email is **draft-only**. Reads, flags, drafts. Never sends without approval. (Security: treat inbox as hostile re: prompt injection)

### Research & Content

**6. Parallel Research Agents**
- Spawn 5 simultaneous sub-agents: Twitter, Reddit, HN, YouTube, forums
- Produced 50+ pages of structured research for one video in minutes
- Define freshness: last 7 days, last 3 months, etc.

**7. YouTube Analytics Channel**
- Natural language queries over API data: "How did my last 5 videos compare on retention?"
- Synthesizes numbers + gives advice. More flexible than YouTube Studio.

**8. Video Idea Research Channel**
- Drop links, articles, tweets, half-formed thoughts throughout the week
- Agent enriches, connects, builds context over time
- By filming day: weeks of accumulated organized research waiting. Don't start from scratch.
- Why separate channels: analytics context isolated, research builds without polluting other conversations.

**9. URL Summarizer**
- `/summarize [URL]` → works on articles, YouTube videos, research papers, PDFs
- Returns: what it's about, core message, key numbers, practical steps
- Then: expand, confirm, or save to Obsidian

### Infrastructure / DevOps

**10. Server Remote Control**
- Migrated from ClawdBot to OpenClaw autonomously (killed zombie process at 160% CPU, fixed 7 days of broken crons)
- Connected to VPS via API → check health, fix apps, restart services — no SSH needed
- **Security**: allow-list + deny-list of commands. Denied commands require explicit approval.

**11. Code from Phone**
- Tell agent: fix bug, build feature, create PR — from phone while away from desk
- Creator's use: quick fixes and testing ideas on the go only. **Main workflow still Claude Code + Codex on desktop.**

### Daily Life

**12. Email Triage**
- Reads inbox → flags important → drafts responses → human reviews and sends
- Can reply same day instead of batching to weekends

**13. Calendar + Family Management**
- WhatsApp group (for non-Telegram/Discord family)
- Drop: "Schedule dentist Thursday 3 PM" → done
- Wife can add events, check schedule, get reminders — same chat interface

**14. Voice Note Transcription**
- Voice message on WhatsApp/Telegram/Discord → Whisper model transcribes → responds in text
- Quick thoughts while driving, shopping lists walking, meeting notes
- Important things → saves to Obsidian or drafts email automatically

**15. Local Search (Google Places API)**
- "Find coffee shop within walking distance" → ratings, reviews, walking time, prices
- Used for: finding snowboard boots in size (large foot) → checked 3 shops for availability → bought in 20 min

**16. Weather (Context-Aware)**
- Not just "tomorrow is sunny" — warned about -19°C cold snap incoming

**17. Smart Reminders**
- Rehab exercises with snooze, meeting reminders before weekly calls

**18. Friend Tech Support**
- Added friend to WhatsApp group with agent → agent guided 3.5-hour OpenClaw setup in non-English language
- Read error screenshots, explained fixes, gave next steps
- Agent answered 90% of questions. Non-technical user (accounting company) now running automations.

**19. Family Group Chat**
- Agent adds jokes and second opinions in family group
- Fun use case, not just utility

### Architecture & Knowledge

**20. Discord Channel Architecture + Model Routing**
- Replaced: Raindrop (paid bookmark app) with a Discord `#inbox` channel
- Drop any link → agent summarizes, extracts key info, creates tags, builds knowledge graph → saves to Obsidian → cheaper model
- Canceled Raindrop. Doesn't miss it.

---

## Discord Architecture (Migrated from Telegram at Week 5)

Why not Telegram: "Switching to Discord wasn't about the app itself. It was about the architecture."

| Channel | Purpose | Model |
|---------|---------|-------|
| `#general` / daily | Daily assistant tasks | Cheap |
| `#youtube-analytics` | YouTube API queries | Cheap (data retrieval) |
| `#video-research` | Video idea accumulation | Medium |
| `#research` | Deep research (parallel agents) | Opus |
| `#inbox` | Bookmarks / link processing | Cheap |
| `#devops` | Server control | As needed |

Rule: Only add a new channel when you really, really need it.

---

## Knowledge Base (Obsidian)

- ~3000 notes
- Agent indexes all notes nightly using **QMD for semantic search**
- Semantic (not keyword): "What did I decide about thumbnail design last month?" → finds exact note
- Most workflows feed output into Obsidian as markdown

---

## Honest Failure Modes (From Transcript)

- **Week 5 context pollution**: Everything in one conversation. Solution: Discord channels.
- **Self-update breakage**: Sometimes updates break things. Solution: automated reporting, easy restore from backup.
- **Email prompt injection risk**: No robust solution yet. Keep email in draft-only mode indefinitely.
- **Phone coding is limited**: Only quick fixes. Desktop still needed for real development.

---

## Relevance to Our Stack

| Theirs | Ours | Gap |
|--------|------|-----|
| OpenClaw on VPS | Nico (Letta) on M1 | Different runtime, same concept |
| Discord channels | Currently: Telegram DM | **Action: Move to Discord** |
| Markdown + Obsidian | Obsidian vault (M3) | Need M1 sync |
| Nightly Obsidian indexing | Not yet | Future: QMD semantic search |
| 30-min heartbeat | Not yet | **Action: Build heartbeat** |
| Morning briefing | Not yet | **Action: Build briefing** |
| Parallel research agents | Not yet | Future capability |
| Email draft-only | Not yet | **Action: Add email with draft-only mode** |
| Daily auto-backup | 6-hr GitHub backup ✓ | Already covered |
| Markdown-first | Obsidian ✓ | Already covered |

---

## Recommended Next Actions (Priority Order)

1. **Discord architecture** — Build channel structure with per-channel model routing
2. **Morning briefing** — Daily summary cron (7 AM)
3. **Heartbeat checks** — 30-min routine scan (email, calendar, services)
4. **URL summarizer skill** — `/summarize [URL]`
5. **Email integration** — Read/draft only, never auto-send
6. **Obsidian semantic search** — Future: QMD nightly indexing
