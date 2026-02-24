---
title: "Setup Consolidation — Current State"
type: reference
status: active
created: 2026-02-23
source: nico
tags: [setup, infrastructure, reference]
---

# Setup Consolidation — Current State
**Date**: 2026-02-23
**Source**: Claude Code (Nico)
**Purpose**: Single reference replacing all old setup docs. Read this instead of anything else.

---

## 1. What's Done

### Infrastructure
- M1 factory reset + fresh macOS (Feb 14, 2026)
- Apple ID: lifeos.nico@gmail.com
- macOS hardened (FileVault ON, Location OFF, Siri OFF)
- Homebrew, Git, gh CLI installed
- Git identity: "Nico (LifeOS Agent)" <lifeos.nico@gmail.com>
- Tailscale M1↔M3 connected (M1 IP: 100.87.182.78)
- SSH M1↔M3 working both directions
- Passwordless sudo enabled
- Termius + Tailscale SSH from iPhone working

### Claude Code
- Installed + authenticated
- YOLO alias (`--dangerously-skip-permissions`) configured
- Peekaboo MCP installed and working (screen recording permission granted)
- Disabled cloud MCP connector sync (was burning 17.8k tokens/session)

### Letta / Memory
- Letta/Memo agent connected (agent-5a9b0e69-1f30-476d-a89a-30c8e21c9668)
- LettaBot stabilized (single instance)
- ~/Nico workspace structure created
- CLAUDE.md written and configured
- Memory system initialized: status.md, decisions.md
- status.md consolidated as single task list (no duplicates)
- Task decomposition + dependency tracking rules in CLAUDE.md
- Metadata standards added
- Quick commands configured: adl, sts, done, blocker, pri, note
- Cowork session tracking created

### GitHub
- GitHub account + gh auth login (lifeos.nico@gmail.com)
- nico-workspace repo created
- Auto-backup every 6hrs to `backup` branch
- Git credential helper fixed
- Branch protection ON (master protected — never push direct)
- Phase 0E (git workflow) complete

### Obsidian
- Catalyst License purchased ($25)
- Obsidian Sync upgraded (multi-vault capable)
- Full CLI capability audit completed
- Vault architecture designed + setup plan finalized
- Obsidian installed
- CabinetAgentVault open and working (THIS SESSION)
- Vault structure confirmed: 00-dashboard, 01-inbox, 05-reviews, 05-templates, 10-projects, 20-areas, 30-resources, 40-archive, 50-clippings, CLAUDE.md
- 6 templates exist in 05-templates/
- 05-reviews/vault-consolidation-review.md created (awaiting Vincent decision)

### Cleanup (THIS SESSION)
- Old ~/Nico/Vault/ trashed to ~/Nico/.trash/CC/2026-02-23_Vault
- Home directory cleaned — stray .md/.html files moved to trash
- Chat project files imported

---

## 2. What's Pending

### Priority 1 — Blockers (Vincent action required)
| # | Task | Owner | Est. Time |
|---|------|-------|-----------|
| 1 | Create Slack workspace + get bot token | Vincent | 5 min |
| 2 | Create 1Password account + CLI setup | Vincent | 8 min |
| 3 | Sign in to iMessage on M1 | Vincent | 2 min |

### Priority 2 — Nico can execute (no blocker)
| # | Task | Notes |
|---|------|-------|
| 4 | Obsidian plugins + Obsidian Sync configuration | Vault open, sync not yet configured |
| 5 | Vault Git backup repo (separate from nico-workspace) | Not yet set up |
| 6 | Seed notes in vault (10-projects, 20-areas) | Waiting on plugins/sync first |
| 7 | Fix Nico headless memory writes | Tool use blocked in -p mode |
| 8 | Phase 0A: Consolidate remaining chat data | In progress this session |
| 9 | Phase 0C: Verify cloud MCP sync fix after restart | Quick verification needed |
| 10 | status.md split: CEO track vs CoS track | Structural improvement |

### Priority 3 — Agent Layer
| # | Task | Notes |
|---|------|-------|
| 11 | Research Director agent (Letta) | Architecture defined, not built |
| 12 | Ops Manager agent (Letta) | Architecture defined, not built |

### Priority 4 — Product (Phase 5+)
| # | Task | Notes |
|---|------|-------|
| 13 | SaaS Client Portal scaffold (Next.js + Supabase) | Phase 5 |
| 14 | Backup & Redundancy system | Phase 6 |
| 15 | LifeOS Agent Evolution | Phase 7 |
| 16 | External App Integrations (TickTick, Apple Notes, Reminders) | Phase 8 |
| 17 | Research Agent | Phase 9 |

---

## 3. What's Outdated / Superseded

| Old Plan | Reality | Action |
|----------|---------|--------|
| Vault path: `~/Nico/Vault/` | Canonical vault is `~/Nico/CabinetAgentVault/` | Old Vault/ trashed 2026-02-23 |
| Vault name: "Nico" (in early docs) | Name is "CabinetAgentVault" | Update any reference found |
| Cloud MCP connector sync enabled | Disabled (cost: 17.8k tokens) | Done |
| Multiple task lists (various .md files) | Single source: `~/Nico/Memory/status.md` | Enforce going forward |
| Daily note file structure in GitHub | Obsidian handles this now | Not needed |

---

## 4. Key Decisions (Canonical — No Re-Asking)

| Topic | Decision |
|-------|----------|
| Agent name | Nico |
| Apple ID | lifeos.nico@gmail.com |
| GitHub account | lifeos.nico@gmail.com |
| Framework | Claude Code (YOLO mode) |
| Memory stack | Letta + CLAUDE.md + Obsidian |
| Secrets manager | 1Password CLI ($3/mo) — account not yet created |
| Vault name | CabinetAgentVault |
| Vault location | ~/Nico/CabinetAgentVault/ |
| Vault structure | PARA: 00-dashboard, 01-inbox, 10-projects, 20-areas, 30-resources, 40-archive, 50-clippings |
| Primary sync | Obsidian Sync (paid, multi-vault) |
| Vault backup | Git (private GitHub repo, separate from nico-workspace) |
| SaaS stack | Next.js + Supabase |
| First product | Lucavo Design client portal |
| Git workflow | nico/{task-name} branches, never push main, branch protection enforced |
| Mobile access | iPhone → Tailscale → Termius SSH |
| Communication | Slack primary, iMessage escalation/urgent only |
| Monthly budget | $200–330/mo |
| Architecture | Build for N agents, not 5+ concurrent |
| Trash policy | Never delete — move to ~/Nico/.trash/{CW,CC,Chat}/ with YYYY-MM-DD_ prefix |
| Task list | Single source: ~/Nico/Memory/status.md only |

---

## 5. Open Questions for Vincent

These are the only things blocking Nico. Nothing else needs input.

1. **Vault name** — Keep "CabinetAgentVault" or rename to something shorter? (see ~/Nico/CabinetAgentVault/05-reviews/vault-consolidation-review.md for context)

2. **Memory loose files** — These exist in ~/Nico/Memory/ and haven't been triaged:
   - yt-transcript.en.vtt
   - yt-transcript-clean.txt
   - video-50-days-ai-agent.md
   - cos-plan.md
   - cost-audit-48h.md
   - snapshots/ directory
   — Keep in place, move to vault, or trash?

3. **Slack** — Has the workspace been created? If yes, bot token?

4. **1Password** — Has the account been created?

5. **iMessage** — Signed in on M1 yet?

---

## Inbox (Untriaged — Not Yet Prioritized)

Items captured but not yet decided on or scheduled:

- GitHub file structure mirroring Obsidian PARA structure
- 50% context window → Telegram alert hook
- Token command to suppress large text output
- Widget boxes on M1/M3 screen for quick status
- Letta writes tasks to Apple Notes (writeback)
- lucavolifeos Google account — separate from lifeos.nico? Clarify.
- Dan Messlier GitHub — research when search restored
- "Watch vid of pa guy in hall in Philly" — personal reminder (Vincent)
- M1 display name: change to "Nico Agent" in System Settings > General > Sharing
- Exa API key (optional — DuckDuckGo working as free fallback)

---

*This document is the consolidation artifact from Phase 0A. All source files remain in ~/Nico/.trash/ or their original locations for reference.*
