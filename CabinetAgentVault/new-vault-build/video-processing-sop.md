---
title: "Letta Video Processing SOP"
date: 2026-03-01
tags: [letta, sop, research, process]
status: active
type: note
project: nico-agent
---

# Letta Video Processing SOP

Repeatable process for pulling, processing, and verifying Letta YouTube videos into research notes. Applies to new videos as they're published and backlog videos in [[video-catalog-full]].

---

## Overview

There are three stages:

1. **Pull** — Get the transcript from YouTube
2. **Process** — Deep-read and write a research note
3. **Verify** — Cross-reference against latest GitHub docs

Each stage has its own checklist. All three must be completed before a video is considered done.

---

## Stage 1 — Pull Transcript

### For backlog videos (⏳ in catalog)

Run the pipeline script from the M1:

```bash
bash ~/Nico/Scripts/letta-knowledge-pipeline.sh
```

Script copies from: `~/Nico/CabinetAgentVault/30-resources/letta/letta-knowledge-pipeline.sh`

Transcripts land in: `CabinetAgentVault/30-resources/letta/transcripts/`

File naming convention: `<video-id>.md` (e.g., `j1agWxBx54E.md`)

### For new videos (as they're published)

Same script — run it periodically (weekly or after seeing a new video). It pulls any transcripts not already present.

### Manual fallback

If the script isn't available or fails, use `yt-dlp`:

```bash
yt-dlp --write-auto-sub --skip-download --sub-format vtt \
  "https://www.youtube.com/watch?v=<VIDEO_ID>" -o "%(id)s.%(ext)s"
```

Then convert the `.vtt` to plain text and save as `<video-id>.md` in the transcripts folder.

---

## Stage 2 — Process Transcript into Research Note

### File naming

Output note: `new-vault-build/<video-id>-<slug>.md`

Slug = 2-5 word kebab-case description of the video topic.

Examples:
- `BroTeuvX0es-lettabot-tutorial.md`
- `R_4r_NNjg1M-context-repositories.md`

### Required frontmatter

```yaml
---
title: "Letta — [Video Title]"
date: YYYY-MM-DD
tags: [letta, research, <topic-tags>]
status: active
type: research
project: nico-agent
source: "https://www.youtube.com/watch?v=<VIDEO_ID>"
---
```

### Required sections (every note must have all of these)

```
# [Video Title]

## TL;DR
3-5 bullet summary of the most important things.

## ⚠️ What This Changes for Nico
Changes to locked decisions, architecture, or install plan.
If nothing changes, write "No changes to locked decisions."

## 🛠️ Section [N] — [Topic]
One section per major topic covered in the video.
Use direct quotes from the transcript where possible.
Highlight key commands, config, and gotchas.

## 🏗️ Extracted Architecture Decisions for Nico
Numbered list of concrete decisions this video informs.
Each item should be actionable (install sequence, config setting, behavior to expect).
```

### Depth standard

- Read the full transcript, not just headlines
- Capture exact commands, not paraphrases
- Flag anything that contradicts a locked decision with ⚠️
- Note anything marked experimental or "coming soon" — label clearly, don't build on it

### Gotcha: large transcripts

Some transcripts are a single long line (no newlines). The Read tool won't paginate correctly. Use:

```bash
cut -c1-20000 path/to/transcript.md
cut -c20001-40000 path/to/transcript.md
# etc.
```

---

## Stage 3 — Cross-Reference Against GitHub Docs

### Docs to check (always)

| Repo | Key files |
|------|-----------|
| `letta-ai/lettabot` | `SKILL.md`, `docs/getting-started.md`, `docs/configuration.md`, `docs/features.md` |
| `letta-ai/letta` | `README.md`, Letta Code docs |
| `docs.letta.com` | `/letta-code/memory`, `/letta-code/models` |

Fetch via: `https://raw.githubusercontent.com/letta-ai/lettabot/main/<file>`

### What to check for

- Commands shown in video — are they still current?
- Env vars mentioned — have any been removed?
- Install steps — does the doc sequence match?
- Config fields — still present and named correctly?
- Any features marked beta/experimental in the video — now GA or removed?

### Output

For each video processed, add a row to [[github-docs-vs-videos-gap]] under the appropriate section (CRITICAL / IMPORTANT / NOTED).

If a gap is found that affects an already-processed note, update that note with a `⚠️ GitHub Docs Correction` block.

---

## Stage 4 — Update Tracking

After completing all three stages for a video:

1. Update [[video-catalog-full]]: change ⏳ to ✅
2. Update [[research-verification]]: add the note to the processed list, note any decision conflicts
3. If any locked decisions changed: update `CLAUDE.md` (Locked Decisions section)

---

## Batching

Processing multiple videos in one session:

- Stage 1 (pull) all videos first, confirm transcripts exist
- Stage 2 (process) one at a time — do not batch into parallel until Stage 2 is proven reliable
- Stage 3 (cross-reference) can be batched: pull all docs once, then check all new notes against them
- Stage 4 (tracking) after each video

---

## Kickoff Prompt

See [[video-processing-kickoff-template]] for the copy-paste prompt to start any video processing session.

---

## Backlog

36 videos currently marked ⏳ in [[video-catalog-full]]. These need transcripts pulled (Stage 1) before processing can begin.

Priority order (process most recent first — highest signal for current architecture):
1. `adQT094jY94` — Letta Office Hours: December 4th, 2025
2. `tsTOJ3d5ijk` — Digital Humans: Building an AI agent coworker
3. `zHx_MeIupQs` — Stateful Agents Meetup: Collective Artificial Intelligence
4. `TC-Q2ulTPhw` — Letta Code: A Memory-First Coding Agent
5. `Nhhj_BPwdKg` — Letta Office Hours: Letta Code Demo, Agent Skills, Claude Code Proxy
6. Then remaining in reverse-chronological order
