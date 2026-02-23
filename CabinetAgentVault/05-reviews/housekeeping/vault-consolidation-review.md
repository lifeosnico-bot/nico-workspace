---
title: Vault Consolidation Review
type: decision
status: draft
created: 2026-02-23
source: nico
tags: [housekeeping, obsidian, vault]
---

# Vault Consolidation Review

**Created:** 2026-02-23 | **Action needed:** Vincent review + decide

We currently have two Obsidian vaults. One needs to be chosen as canonical and the other archived or merged.

---

## Vault A — `~/Nico/Vault/` (older)

**Created:** ~Feb 22, 2026 (earlier session)

**Structure (TitleCase folders):**
```
00-Home.md
00-Inbox/
01-Projects/
  Lucavo-Design/index.md
  SaaS-Portal/index.md
  Nico-Agent/index.md
02-Areas/
  Business-Ops, Clients, Development
03-Resources/
04-Archive/
05-Templates/  ← 6 templates: research-note, daily-note, meeting-note, project-note, decision-note, client-note
06-Daily/
07-Canvas/
CLAUDE.md  ← vault-specific agent context
```

**Has:**
- 6 well-defined templates
- CLAUDE.md with CLI gotchas and full frontmatter schema
- Broader area coverage (Finance, Marketing missing from Vault B)

**Missing:**
- Doesn't match PARA naming conventions in memory (`obsidian.md`)
- No 50-clippings folder
- TitleCase filenames conflict with kebab-case convention

---

## Vault B — `~/Nico/CabinetAgentVault/` (newer)

**Created:** Feb 22, 2026 (later session)

**Structure (lowercase/PARA):**
```
00-dashboard/home.md
01-inbox/_index.md
10-projects/
  lucavo-design/_index.md
  cabinet-agent-saas/_index.md
  nico-agent/_index.md
20-areas/
  clients, development, business-ops, marketing, finance
30-resources/
  research/_index.md
  reference/_index.md
40-archive/_index.md
50-clippings/_index.md
```

**Has:**
- Matches naming conventions documented in `~/.claude/projects/.../memory/obsidian.md`
- Has 50-clippings (web captures)
- Better frontmatter on files (title, type, status, created, source)
- Home dashboard with correct wikilinks

**Missing:**
- No templates folder
- No CLAUDE.md

---

## Key Differences

| | Vault A (`Vault/`) | Vault B (`CabinetAgentVault/`) |
|---|---|---|
| Naming | TitleCase | lowercase-kebab ✅ |
| PARA folders | 00-06 | 00/10/20/30/40/50 ✅ |
| Templates | 6 templates ✅ | none |
| CLAUDE.md | yes ✅ | no |
| Matches memory conventions | no | yes ✅ |
| Obsidian Sync active | unknown | unknown |
| Git repo | unknown | unknown |

---

## Home Dir Cleanup (Related)

These files in `~/` are old planning docs from Feb 15 setup — all superseded:

| File | Status | Action |
|---|---|---|
| `NICO-FINAL-SETUP-PLAN.md` | Duplicate of v4 below | → trash |
| `nico-setup-plan-v4-2026-02-15.md` | Identical duplicate | → trash (keep 1) |
| `nico-task-dashboard.html` | Superseded by status.md | → trash |
| `obsidian-setup-plan.md` | Earlier draft of final plan | → trash |
| `obsidian-final-setup-plan.md` | Near-identical to -plans.md | → trash (keep 1) |
| `obsidian-final-setup-plans.md` | 1-line diff from above | → archive or trash |
| `obsidian-cli-capability-audit.md` | Still useful reference | → `30-resources/reference/` |

---

## `~/Nico/Memory/` Loose Files

| File | Notes |
|---|---|
| `yt-transcript.en.vtt` | Raw YouTube transcript (video-50-days-ai-agent) |
| `yt-transcript-clean.txt` | Cleaned version of above |
| `video-50-days-ai-agent.md` | Notes on the 50-day AI agent video |
| `cos-plan.md` | Chief of Staff plan — review if superseded by status.md |
| `cost-audit-48h.md` | 48h cost audit — still relevant? |
| `snapshots/` | Review contents |

---

## Recommended Decision

**Keep Vault B (`CabinetAgentVault/`) as canonical.** It matches all documented conventions.

**Action items:**
1. Copy templates from Vault A → `CabinetAgentVault/05-templates/` (create folder)
2. Copy CLAUDE.md from Vault A → `CabinetAgentVault/CLAUDE.md`
3. Move `obsidian-cli-capability-audit.md` → `CabinetAgentVault/30-resources/reference/`
4. Trash all other home dir planning docs
5. Archive/trash `~/Nico/Vault/` (move to `~/Nico/.trash/CC/`)
6. Rename `CabinetAgentVault/` → `Vault/` (cleaner path, matches memory docs)

**Or:** Keep the name as-is and update `obsidian.md` memory to point to `CabinetAgentVault/`.

---

## Decision

> _Vincent to fill in:_

- [ ] Vault B confirmed as canonical
- [ ] Rename or keep current name?
- [ ] Trash home dir files confirmed
- [ ] Memory loose files — what to do with video notes?
