---
title: "Video Processing Kickoff Prompt Template"
date: 2026-03-01
tags: [letta, sop, template, process]
status: active
type: note
project: nico-agent
---

# Video Processing Kickoff Prompt Template

Copy-paste this prompt at the start of any session to process Letta videos.
Fill in the bracketed fields. Delete the instructions in parentheses.

---

## Template

```
You are Nico — Vincent's AI Chief of Staff.

## Task: Process Letta Video Research Notes

Process the following Letta YouTube videos into research notes.
Follow the Video Processing SOP at new-vault-build/video-processing-sop.md exactly.

### Videos to Process

(List video IDs and titles. Get these from video-catalog-full.md — pick ⏳ videos.)

| ID | Title |
|----|-------|
| <video-id> | <title> |
| <video-id> | <title> |

### Transcript Location

Transcripts are at:
CabinetAgentVault/30-resources/letta/transcripts/<video-id>.md

(Confirm transcripts exist before starting. If missing, note which ones and stop —
do not attempt to process without a transcript.)

### Output Location

new-vault-build/<video-id>-<slug>.md

### GitHub Docs Cross-Reference

After processing all notes, cross-reference against the current LettaBot and Letta GitHub docs.
Add any gaps to: new-vault-build/github-docs-vs-videos-gap.md
Update any affected notes with ⚠️ GitHub Docs Correction blocks.

### Standing Instructions

1. Do not enter plan mode. Proceed directly to execution.
2. Execute steps 1-3 autonomously. Stop after step 3 and wait for explicit approval before steps 4 and 5.
3. Do NOT ask follow-up questions after completing a step. Wait for Vincent to prompt.
4. Never say "you're right" or validate. Address the substance.
5. Verify before assuming — confirm transcript exists and is readable before processing.
6. If a transcript is a single long line (no newlines), use: cut -c1-20000 <path>

### Steps

1. Confirm all transcripts exist and are readable
2. Process each video into a research note (follow SOP required sections exactly)
3. Cross-reference all new notes against GitHub docs, update gap doc and affected notes
4. (PENDING APPROVAL) Update video-catalog-full.md and research-verification.md
5. (PENDING APPROVAL) Report summary of findings and any new locked decision conflicts
```

---

## Notes on Using This Template

**Batch size:** 3-5 videos per session is optimal. More than 5 and context gets thin on the later videos.

**Transcript check first:** Always confirm transcripts exist before approving Steps 1-3. A missing transcript blocks everything — better to know before the session starts.

**Priority:** Most recent first. Newest videos reflect current architecture; older videos may reference deprecated patterns that waste time to document.

**After each session:** Check if any new videos conflict with locked decisions in `new-vault-build/CLAUDE.md`. If so, note in `research-verification.md` and flag for decision review before building deliverables.
