---
title: "Next Session Start Prompt — Letta Video Processing & Setup"
date: 2026-03-01
tags: [letta, session-prompt, lettabot, setup]
status: active
type: note
project: nico-agent
---

# Next Session Start Prompt

Paste this exactly at the start of the next Cowork session:

---

You are Nico. Before doing anything else, read these files in the vault in this exact order:

1. `00-dashboard/llm-sessions/2026-03-01-cowork-session-2-catchup.md`
2. `00-dashboard/llm-sessions/2026-03-01-cowork-session-2-full-transcript.md`
3. `00-dashboard/status.md`
4. `30-resources/letta-youtube-research.md`
5. `30-resources/letta/transcripts/p7So3IM75WY-memfs-letta-chat.md`
6. `30-resources/letta/video-catalog-full.md`

Do not summarize. Just get caught up silently.

Once you are caught up, here is where we are and what we are doing:

**The End Goal:**
Full reset of LettaBot, Claude Code, and the Obsidian vault structure. The new LettaBot will be Vincent's Chief of Staff with full Letta memory stack (core, recall, archival, sleep-time compute). It will also be able to set up and manage other sub-agents. We are dogfooding the product we will eventually sell.

**The Plan (agreed and locked):**
1. Pull and properly process the 5-6 most critical/recent Letta YouTube videos one at a time — using `youtube-transcript-api` Python library (confirmed working in Cowork VM). Start with the most recent and work backwards. Videos flagged as highest priority:
   - `LX-qO5o8iRQ` — Building Multi-Agent Systems with Letta ⭐
   - `hFNWhrXukc0` — Archival Memory: Build AI that remembers everything ⭐
   - `0nfNDrRKSuU` — The Memory Tool: Letta Agents That Redesign Their Own Architecture ⭐
   - `6baCKzLmslQ` — How to talk to your AI agent with Telegram ⭐
   - `o4boci1xSbM` — AI Memory Architecture: How to Use Memory Blocks ⭐
   - `OzSCFR0Lp5s` — Agent Development Environment (ADE) Walkthrough ⭐
   - Note: `p7So3IM75WY` (MemFS Office Hours) has a processed summary already in vault but the 18-20 min section about how LettaBot gets created is critical — this needs a fresh full pull and careful re-processing.

2. Compare and contrast each video's guidance against the Letta GitHub docs to catch anything missed or updated.

3. Save clean, properly processed notes to vault for each video — one at a time, full detail, nothing crammed together.

4. Start the fresh LettaBot setup using what we have. LettaBot begins building its own knowledge as we go.

5. Feed remaining videos and docs into the agent as we go — the interactive guide gets built alongside the setup, not before it.

**Key technical note:**
- `youtube-transcript-api` works in Cowork VM: `pip install youtube-transcript-api --break-system-packages`
- Pull with: `api = YouTubeTranscriptApi(); transcript = api.fetch('VIDEO_ID')`
- Claude Code is separately pulling all 51 raw transcripts and saving to vault — do not re-pull what Claude Code has already saved
- Check `30-resources/letta/transcripts/` first before pulling any video

**Key architectural decisions already made (do not re-litigate):**
- Vault-as-bridge: Claude Code writes, LettaBot reads via sleep-time agent
- Fresh Letta agent — do NOT clone old Memo agent (stale data)
- `enable_sleeptime: true` from day one
- File ownership: one writer, multiple readers — every file has a declared owner
- MemFS is cloud-only for now — self-hosted not working yet — use regular memory blocks + sleep-time
- LettaBot = personal assistant (M1). Letta Remote = scale deployment (Railway). Both, for different roles.
- Ezra Prime/Super pattern = blueprint for SaaS multi-agent org chart

**What Vincent told you to start with:**
Begin by pulling the transcript for `p7So3IM75WY` fresh and processing it fully and carefully — especially the 17m30s to 20m30s section about LettaBot setup and Letta Remote. Then move through the starred videos in order.

Start immediately. Do not ask what to do next.
