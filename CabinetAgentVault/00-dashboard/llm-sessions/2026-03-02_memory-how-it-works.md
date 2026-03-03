---
title: "Memory — How It Works (Nico)"
type: resource
status: active
created: 2026-03-02
platform: telegram
tags: [memory, letta, obsidian, workflow]
---

# Memory — How It Works (Nico)

- This doc explains *exactly* how “memory” works in our current setup.
- It uses our real examples: the **“don’t say certain phrases”** rule, and the **build-me files disappearing**.

# 1) The simplest mental model

- There are *four places* information can live.

```text
A) Short-term context  (what I can see right now)
B) Pinned memory       (always-loaded rules + facts)
C) Vault + repos       (saved files / notes)
D) Chat history        (past messages stored, searchable)
```

- If something only lives in **D**, it can still be forgotten in day-to-day replies.
- If something lives in **B**, it shows up every time.

# 2) Diagram — what happens when you message me on Telegram

```text
Vincent (Telegram DM)
   |
   v
LettaBot (bridge on M1)
   |
   v
Nico (agent runtime)
   |
   +--> loads B) pinned memory blocks (automatic)
   +--> sees A) recent messages (automatic)
   +--> can read C) files (only if Nico opens/reads them)
   +--> can search D) history (only if Nico searches)
   |
   v
Telegram reply
```

- “Pinned memory” is automatic.
- “Files in the vault” are not automatic; they require an explicit read.

# 3) Why “make it a memory” is ambiguous

- In practice, you might mean one of these:

- Permanent rule
  - Example: “Never use phrase X.”
- Task list item
  - Example: “Add this to the tight list for this week.”
- Saved note
  - Example: “Write this up so we can reference it later.”

# 4) Our real storage locations (current reality)

- Pinned operating rules (startup rules)
  - `~/Nico/CLAUDE.md`

- Canonical task list
  - `~/Nico/CabinetAgentVault/00-dashboard/status.md`

- Session notes
  - `~/Nico/CabinetAgentVault/00-dashboard/llm-sessions/`

- Long reference docs
  - Example folder: `~/Nico/CabinetAgentVault/30-resources/`

# 5) Example A — banned phrase rule

- What happened:
  - You told me multiple times in chat: “don’t say certain phrases.”
  - That lived mostly in **D) chat history**.

- Why it still slipped:
  - The exact phrase ban was not written as a single explicit “never” line in `~/Nico/CLAUDE.md` until today.
  - Telegram conversations can resume midstream, so relying on “history” is not enough.

- Fix:
  - Put the rule in **pinned startup rules** (CLAUDE.md) as an explicit “never” rule.

# 6) Example B — build-me wizard files “disappeared”

- What happened:
  - The vault is backed up using Git.
  - A vault backup commit accidentally included deletions under:
    - `~/Nico/CabinetAgentVault/30-resources/letta-manual/build-me/`
  - Obsidian then reflected that deletion.

- Key point:
  - Obsidian did not randomly delete them.
  - Git *recorded* deletions that happened locally.

- Fix:
  - Restore from Git history and push the restoration.

# 7) What to say (copy/paste scripts)

- Permanent rule
  - `PERMANENT RULE: Never say the phrase: "<phrase>". Hard constraint.`

- Task list
  - `TIGHT LIST: [P2][N] <task>`

- Save a note
  - `SAVE NOTE: Create a vault doc under <folder> and link it from status.md.`

# 8) What I will do going forward

- When you say “make it a memory” I will reply with a short clarification:
  - `Rule` vs `Task` vs `Saved note`

- Default behavior (unless you say otherwise):
  - If it sounds like a *personal preference / communication rule* → treat it as a **pinned rule**.
  - If it sounds like an action item → treat it as a **task list** entry.
  - If it sounds like reference material → treat it as a **saved note**.
