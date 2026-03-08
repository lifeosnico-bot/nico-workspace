---
title: "Master Task Rollup"
type: rollup
status: active
created: 2026-03-08
source: letta-code-subagent
tags: [tasks, rollup, status, master-list]
---

# Master Task Rollup

**Generated:** 2026-03-08 18:26 UTC | **By:** Letta Code subagent (automated extraction)
**Files scanned:** 225 .md files across all vault directories
**Task items extracted:** ~280 items across 18 source files with actionable content
**Canonical task source:** `00-dashboard/status.md` (authoritative — do not duplicate edits here)

> **Reading order:** Start with § Status Tight List for open items, then § Task Board for P1/P2 snapshot, then dive into phases by priority.

---

## TABLE OF CONTENTS

1. [STATUS.MD — Tight List (Open)](#statusmd--tight-list-open) ← **most current open items**
2. [STATUS.MD — Active This Week](#statusmd--active-this-week)
3. [STATUS.MD — Vincent's Actions (Blocking Nico)](#statusmd--vincents-actions-blocking-nico)
4. [STATUS.MD — Nico's Queue](#statusmd--nicos-queue)
5. [STATUS.MD — Phase 0G: Overnight Autonomy Daily Checklist](#statusmd--phase-0g-overnight-autonomy-daily-checklist)
6. [STATUS.MD — Phase 0F: Agent Access & Communication](#statusmd--phase-0f-agent-access--communication)
7. [STATUS.MD — Phase 0E: Fix Git Workflow](#statusmd--phase-0e-fix-git-workflow)
8. [STATUS.MD — Phase 0C: Audit Claude Code Context Loading](#statusmd--phase-0c-audit-claude-code-context-loading)
9. [STATUS.MD — Phase 0A: Consolidate Chat Data](#statusmd--phase-0a-consolidate-chat-data)
10. [STATUS.MD — Phase 0B: Secrets & Security — 1Password](#statusmd--phase-0b-secrets--security--1password)
11. [STATUS.MD — LettaBot Section (Open Items)](#statusmd--lettabot-section-open-items)
12. [STATUS.MD — Phase 2: Obsidian Manual Setup](#statusmd--phase-2-obsidian-manual-setup)
13. [STATUS.MD — Phase 3: Post-Launch Verification](#statusmd--phase-3-post-launch-verification)
14. [STATUS.MD — Phase 5: SaaS Client Portal Scaffold](#statusmd--phase-5-saas-client-portal-scaffold)
15. [STATUS.MD — Phase 6: Backup & Redundancy](#statusmd--phase-6-backup--redundancy)
16. [STATUS.MD — Phase 7: Overnight Autonomy (Canonical Top-20)](#statusmd--phase-7-overnight-autonomy-canonical-top-20)
17. [STATUS.MD — Phase 7: LifeOS Agent Evolution](#statusmd--phase-7-lifeos-agent-evolution)
18. [STATUS.MD — Phase 8: External App Integrations](#statusmd--phase-8-external-app-integrations)
19. [STATUS.MD — Phase 9: Research Agent](#statusmd--phase-9-research-agent)
20. [STATUS.MD — Inbox — Unprocessed Captures (Remaining Open)](#statusmd--inbox--unprocessed-captures-remaining-open)
21. [TASK-BOARD.MD — P1/P2 Snapshot](#task-boardmd--p1p2-snapshot)
22. [TELEGRAM-MISC-LIST — Pending Approval (2026-03-04)](#telegram-misc-list--pending-approval-2026-03-04)
23. [NICO-OS.MD — Running Improvement Backlog](#nico-osmd--running-improvement-backlog)
24. [NEW-VAULT-BUILD — Pending Deliverables (Session 6)](#new-vault-build--pending-deliverables-session-6)
25. [ARCHIVED: CoS Plan Roadmap (2026-02-22)](#archived-cos-plan-roadmap-2026-02-22)
26. [ARCHIVED: Setup Consolidation Pending Items (2026-02-23)](#archived-setup-consolidation-pending-items-2026-02-23)
27. [SESSION NOTES — Next-Action Captures](#session-notes--next-action-captures)

---

## STATUS.MD — Tight List (Open)

**Source:** `00-dashboard/status.md` | **Section:** Tight List | **Last updated:** 2026-03-04 17:32 EST (Session TG-03)

- [ ] **[P1][N]** Fix permissions issues with Telegram and Nico (Plan Mode + any other tool denies) *(added 2026-03-04)*
- [ ] **[N]** Overnight runner scaffold + queue + schedule (PR #14 open) — *waiting merge*
- [ ] **[N]** Add PR-opening capability to overnight runner (gated)
- [ ] **[N]** Phase 0E — metadata standards enforcement
- [ ] **[V]** Telegram bot token rotation (BotFather → `/revoke` → new token applied on M1)
- [ ] **[V]** Obsidian Phase 2 manual setup (Sync + enable CLI)
- [ ] **[V]** 1Password setup (account + desktop app)

---

## STATUS.MD — Active This Week

**Source:** `00-dashboard/status.md` | **Section:** 🔴 Active This Week

| Priority | Owner | Task |
|----------|-------|------|
| ~~P1~~ | ~~[N]~~ | ~~50% context window alert hook~~ ✅ |
| P1 | [V] | Telegram bot token rotation (BotFather → /revoke → new token to Nico) |
| ~~P1~~ | ~~[V]~~ | ~~Create Slack workspace + bot token~~ ✅ |
| ~~P2~~ | ~~[N]~~ | ~~LettaBot Telegram poller fix~~ ✅ No conflict found (CC-8) |
| P2 | [N] | Phase 0E — metadata standards enforcement |
| P2 | [V] | Obsidian Phase 2 manual setup |
| P2 | [V] | 1Password setup (secrets management) |

---

## STATUS.MD — Vincent's Actions (Blocking Nico)

**Source:** `00-dashboard/status.md` | **Section:** 👤 Vincent's Actions

- [ ] **P1** Telegram bot token rotation: open @BotFather → `/revoke` → get new token → paste to Nico *(security — old token exposed in compaction summaries)*
- [x] **P1** Create Slack workspace → copy bot token → paste in terminal to Nico ✅ *(done 2026-02-23)*
- [ ] **[P1][N]** Add Telegram memory command cheat sheet to master list + pinned memory
- [ ] **[P3][N]** Pilot GitHub Actions background agent lane (tag Nico/Letta Code on issues/PRs) — choose repo + security mode first
- [ ] **P2** 1Password: create account at 1password.com, install desktop app
- [ ] **P2** Obsidian Phase 2: manual setup (sign in, enable Sync, register CLI, enable plugins) — Nico will prep everything, Vincent flips the switches
- [x] **P3** Exa API key: free tier at dashboard.exa.ai (1000/mo) ✅ 2026-03-04
- [ ] **P4** Review `05-reviews/housekeeping/vault-consolidation-review.md` in Obsidian — one decision needed
- [ ] **P5** "Watch vid of pa guy in hall in Philly" — personal reminder

---

## STATUS.MD — Nico's Queue

**Source:** `00-dashboard/status.md` | **Section:** 🤖 Nico's Queue

1. ~~iMessage alert script~~ ✅ Built (working via Telegram, 2026-02-23)
2. ~~Vault housekeeping~~ ✅ Done (2026-02-23)
3. ~~task-board.md~~ ✅ Built (2026-02-23)
4. ~~Master list consolidation~~ ✅ Done (2026-02-23)
5. ~~Obsidian Phase 1~~ ✅ Mostly done
6. ~~50% context window alert hook~~ ✅ Done
7. ~~Telegram bot token rotation~~ → moved to Vincent's Actions
8. **[P2]** Phase 0E remaining — metadata standards enforcement
9. ~~LettaBot Telegram poller conflict~~ ✅ No conflict
10. ~~Obsidian Phase 1 remaining~~ ✅ All configs done (CC-7)
11. **[P3]** Phase 0A — consolidate Chat Imports, deduplicate docs

---

## STATUS.MD — Phase 0G: Overnight Autonomy Daily Checklist

**Source:** `00-dashboard/status.md` | **Section:** Phase 0G | **Status:** ✅ COMPLETE

- [x] ✅ **0G-1** Define overnight scope + gates
  - Allowed overnight: create vault stub notes, update local logs, run read-only scans
  - Forbidden overnight (until later phase): git commits/PRs, memory edits, wizard edits, Slack posts, deleting/moving files
- [x] ✅ **0G-2** Confirm nightly runner behavior (2am launchd) + logs + idempotency
  - Job: `~/Library/LaunchAgents/com.nico.overnight-runner.plist`
  - Script: `~/Nico/Scripts/overnight-runner.py`
  - Output: `CabinetAgentVault/50-clippings/youtube/<video-id>-untriaged.md`
- [x] ✅ **0G-3** Add 15-minute status pings (only while checklist has 🟨 items)
- [x] ✅ **0G-4** Heartbeat policy: silent health-check only (no daytime chatter)
- [x] ✅ **0G-5** Track launchd as code in GitHub (sanitized plists + install/uninstall scripts)
- [x] ✅ **0G-6** Acceptance test: kickstart all jobs; verify correct outputs + no spam

**Definition of Done (all ✅):**
- 2am job runs and produces expected artifacts in the vault
- Status pings work and are quiet when nothing is active
- Heartbeat runs without generating noise unless there is a failure
- launchd configs/scripts tracked in GitHub without secrets

---

## STATUS.MD — Phase 0F: Agent Access & Communication

**Source:** `00-dashboard/status.md` | **Section:** Phase 0F | **Owner:** [V+N] P1

*Dependency: None. #1 PRIORITY after Nico's overnight tasks.*

- [ ] **1. [P1][V]** QUICK WIN: Claude Code remote sessions from phone (~5 min)
  - [ ] 1a. Open claude.ai/code in Safari on iPhone — can you launch remote sessions?
  - [ ] 1b. Open Claude iOS app — check for session monitoring
  - [ ] 1c. Test: start remote session from phone, give it a task, confirm it runs
- [x] **2. [P1][V]** QUICK WIN: Slack workspace + iPhone app ✅ (done 2026-02-23)
  - [x] 2a. Create Slack workspace ("Cabinet Agent") ✅
  - [x] 2b. Install Slack on iPhone ✅
  - [x] 2c. Create bot + copy token → paste to Nico via terminal ✅
- [x] **3. [P1][N]** Connect agents to Slack ✅ (done 2026-02-23)
  - [ ] 3a. Connect Cowork to Slack (MCP connector) — future
  - [x] 3b. Claude Code ↔ Slack: claude-code-slack-bot (Socket Mode, two-way DM) ✅
  - [x] 3c. Slack posting script (slack-post.sh) + alert hooks wired ✅
  - [x] 3d. Channels created: #ceo-desk, #status, #tasks, #dev, #decisions, #alerts, #nico-internal, #vincent-to-nico ✅
  - [ ] 3e. Test: Vincent posts `atl: something` in #tasks from phone → Nico picks it up — future
  - [x] 3f. Bot responds to DMs, posts to channels ✅
- [ ] **4. [P2][V]** SSH from phone (fallback)
  - [ ] 4a. Tailscale already on iPhone ✅
  - [ ] 4b. Termius already on iPhone ✅
  - [ ] 4c. Test: SSH from phone → M1 → run `claude` in terminal
- [ ] **5. [P1][N]** iMessage escalation channel (see Phase 0-Alerts — building tonight)
- [ ] **6. [P4][N]** Advanced multi-device options (research after basics work)
  - [ ] 6a. Can Claude Code Desktop on M3 SSH remote into M1 workspace?
  - [ ] 6b. Can Cowork on M3 mount ~/Nico/ via Tailscale/SSHFS?
  - [ ] 6c. Evaluate Happy Coder and other mobile Claude Code apps
- [ ] **7. [P2][N]** Document access architecture
  - [ ] 7a. iPhone: Slack + claude.ai/code + SSH/Termius · M3: Cowork + Claude Code + Slack · M1: Claude Code CLI + Slack
  - [ ] 7b. Update CLAUDE.md under "Remote Access"

---

## STATUS.MD — Phase 0E: Fix Git Workflow

**Source:** `00-dashboard/status.md` | **Section:** Phase 0E | **Owner:** [N] P2 (Mostly Done)

- [x] 1. Protect master branch ✅ (done 2026-02-22)
- [x] 2. Update auto-backup script to backup branch only ✅ (done 2026-02-22)
- [x] 3. Update agent workflow + CLAUDE.md ✅ (done 2026-02-22)
- [x] 4. Migrate + first proper PR cycle ✅ (done 2026-02-22)
- [x] 5a. Direct push blocked ✅ · 5b. Branch→PR→merge works ✅
- [ ] **5c. [P3][N]** Verify auto-backup runs on next cycle correctly
- [ ] **6. [P2][N]** Enforce metadata standards
  - [ ] 6a. Audit existing files: status.md, decisions.md, session-log.md — add missing timestamps
  - [ ] 6b. Define exact format per document type (timezone, source label)
  - [ ] 6c. Add metadata checklist to CLAUDE.md Session Protocol
  - [ ] 6d. Future: Slack bot validates metadata before accepting #status posts

---

## STATUS.MD — Phase 0C: Audit Claude Code Context Loading

**Source:** `00-dashboard/status.md` | **Section:** Phase 0C | **Owner:** [N] P3 (Mostly Done)

- [x] 1. Identified problem: Craft MCP loading 17.8k tokens/session ✅ (done 2026-02-16)
- [x] 2. Disabled cloud MCP sync ✅ (done 2026-02-16)
- [x] 3. Verify fix ✅ (done 2026-02-23 CC-8)
  - [x] 3a. Confirmed: no Craft tools loading, GitHub plugin disabled ✅
  - [x] 3b. Confirmed: settings.json clean, no unexpected MCP servers ✅
- [ ] **4. [P3][N]** Permanent fix documentation
  - [ ] 4a. Document in CLAUDE.md: "Cloud MCP sync disabled — do not re-enable without token audit"
- [ ] **5. [P3][N]** Audit remaining context usage
  - [ ] 5a. Review 13 .mcp.json plugin files — are any loading unexpectedly?
  - [ ] 5b. Document baseline context usage in CLAUDE.md

---

## STATUS.MD — Phase 0A: Consolidate Chat Data

**Source:** `00-dashboard/status.md` | **Section:** Phase 0A | **Owner:** [N+V] P3

- [ ] **1. [P3][V]** Confirm: is anything still in Chat that hasn't been exported?
- [ ] **2. [P3][N]** Deduplicate Chat Imports
  - [ ] 2a. NICO-FINAL-SETUP-PLAN.md vs nico-setup-plan-v4 — keep best, trash duplicate
  - [ ] 2b. obsidian-final-setup-plan.md vs obsidian-final-setup-plans.md — keep newest, trash other
  - [ ] 2c. Move surviving files to vault (30-resources/reference/) with proper naming
  - [ ] 2d. Add README.md to Chat Imports/ explaining what each file is/was
- [ ] **3. [P3][N]** Extract any decisions not yet in Key Decisions section

---

## STATUS.MD — Phase 0B: Secrets & Security — 1Password

**Source:** `00-dashboard/status.md` | **Section:** Phase 0B | **Owner:** [V] P2

*Dependency: Blocks any task requiring stored API keys.*

- [ ] **1. [P2][V]** Create 1Password account
  - [ ] 1a. Go to 1password.com → sign up with lifeos.nico@gmail.com (Individual, $2.99/mo)
  - [ ] 1b. Save Secret Key safely
  - [ ] 1c. Download + install desktop app on M1
- [ ] **2. [P2][N]** Install 1Password CLI (after Vincent creates account)
  - [ ] 2a. `brew install 1password-cli`
  - [ ] 2b. `op signin`
  - [ ] 2c. Verify: `op vault list`
- [ ] **3. [P2][N]** Store secrets
  - [ ] 3a. Anthropic API key
  - [ ] 3b. GitHub token (if needed beyond SSH)
  - [ ] 3c. Test retrieval

---

## STATUS.MD — LettaBot Section (Open Items)

**Source:** `00-dashboard/status.md` | **Section:** LettaBot | **Owner:** [N+V]

*~~LettaBot: Install + Configure on M1~~ ✅ COMPLETE (2026-02-22)*

- [ ] **[P2][N]** Guard rails for Telegram crashes / multiple instance prevention
- [ ] **[P2][N]** Reduce Telegram chatter — filter what gets posted, clean up noise

---

## STATUS.MD — Phase 2: Obsidian Manual Setup

**Source:** `00-dashboard/status.md` | **Section:** Phase 2 | **Owner:** [V] P2

*Dependency: Phase 1 complete. Claude Code preps everything, Vincent flips switches (~10 min).*

- [ ] **1. [V]** Open Obsidian → "Open folder as vault" → select `~/Nico/CabinetAgentVault/`
- [ ] **2. [V]** Sign in to Obsidian account (Catalyst license — lifeos.nico account)
- [ ] **3. [V]** Enable Obsidian Sync
  - [ ] 3a. Settings → Sync → Log in
  - [ ] 3b. Create new remote vault → name it "CabinetAgent"
  - [ ] 3c. Wait for initial sync
  - [ ] 3d. Install Obsidian on iPhone → log into same account → vault appears
- [x] **4. [V]** Enable community plugins ✅ (done 2026-02-23)
- [ ] **5. [N]** Register CLI (after Vincent enables it)
  - [ ] 5a. Settings → Command Line Interface → toggle ON
  - [ ] 5b. Verify: `obsidian version`

---

## STATUS.MD — Phase 3: Post-Launch Verification

**Source:** `00-dashboard/status.md` | **Section:** Phase 3 | **Owner:** [N] P2

*Dependency: Phase 2 complete (Vincent has done manual setup).*

- [ ] **1. [N]** Verify CLI working
  - [ ] 1a. `obsidian version` · `obsidian vault` · `obsidian files total`
- [ ] **2. [N]** Test CLI operations
  - [ ] 2a. Files list, read, search, tasks
  - [ ] 2b. Create today's daily note via CLI
  - [ ] 2c. Verify obsidian-claude-code-mcp running on port 22360
- [ ] **3. [N]** Configure Obsidian Git plugin
  - [ ] 3a. Auto-commit every 10 min, auto-pull every 10 min, pull on boot
- [ ] **4. [N]** Run smoke test
  - [ ] 4a. Vault structure ✓ · Git initialized ✓ · CLI responds ✓ · Search works ✓ · Tasks work ✓
- [ ] **5. [N]** Update CLAUDE.md with Obsidian section
  - [ ] 5a. Vault location, sync info, CLI version

---

## STATUS.MD — Phase 5: SaaS Client Portal Scaffold

**Source:** `00-dashboard/status.md` | **Section:** Phase 5 | **Owner:** [N] P3

*Dependency: Phase 0B (1Password for credentials). The actual product build.*

- [ ] **1. [N]** Project setup
  - [ ] 1a. Create `~/Nico/Projects/cabinet-portal/`
  - [ ] 1b. Branch: `nico/scaffold-portal`
  - [ ] 1c. Initialize Next.js with App Router
  - [ ] 1d. Install dependencies (Supabase client)
- [ ] **2. [N]** Supabase configuration
  - [ ] 2a. Create Supabase project (store in 1Password)
  - [ ] 2b. Configure client
  - [ ] 2c. Design schema: users, projects, documents
  - [ ] 2d. Run initial migrations
- [ ] **3. [N]** Auth flow
  - [ ] 3a. Login + Signup pages
  - [ ] 3b. Supabase Auth integration
  - [ ] 3c. Protected routes / middleware
- [ ] **4. [N]** Dashboard
  - [ ] 4a. Layout + sidebar
  - [ ] 4b. Project listing view
- [ ] **5. [N]** PDF handling (placeholder)
  - [ ] 5a. PDF upload component
  - [ ] 5b. Storage bucket in Supabase
  - [ ] 5c. Document listing view
- [ ] **6. [N]** Ship it
  - [ ] 6a. Push branch → open PR
  - [ ] 6b. Create session note in vault summarizing what was built

---

## STATUS.MD — Phase 6: Backup & Redundancy

**Source:** `00-dashboard/status.md` | **Section:** Phase 6 | **Owner:** [N+V] P3

*Dependency: Phase 3 complete.*

- [ ] **1. [N]** GitHub repos
  - [ ] 1a. nico-vault (private) — vault backup ✅ (in progress)
  - [ ] 1b. nico-workspace (private) — ~/Nico/ backup ✅ (exists)
  - [ ] 1c. cabinet-portal (private) — SaaS code (Phase 5)
- [ ] **2. [N]** Automated backup schedule
  - [ ] 2a. Obsidian Git plugin: auto-commit vault every 10 min
  - [ ] 2b. Verify workspace auto-backup (every 6hrs via launchd) still working
- [ ] **3. [V]** Sync verification
  - [ ] 3a. Obsidian Sync working M1 → iPhone
  - [ ] 3b. GitHub repos accessible from M3
- [ ] **4. [N]** Disaster recovery plan
  - [ ] 4a. Document: how to restore from GitHub if M1 dies
  - [ ] 4b. Save to vault: `30-resources/reference/disaster-recovery.md`

---

## STATUS.MD — Phase 7: Overnight Autonomy (Canonical Top-20)

**Source:** `00-dashboard/status.md` | **Section:** Phase 7 (appears twice) | **Owner:** [N] P3

*Dependency: Phase 0E metadata standards enforcement + token rotation complete.*
*Current reality (as of 2026-03-04): Overnight runner exists but is report-only (no PR creation). LettaBot heartbeat enabled; cron disabled. Nighttime report LaunchAgent exists but script is missing.*

**Top-20 checklist (canonical):**
- [ ] 1) Overnight runner (actual work engine)
- [ ] 2) Cron enabled (if using LettaBot cron)
- [ ] 3) Single task queue (one source of truth)
- [ ] 4) Definition-of-done checks (verification gates)
- [ ] 5) Report spec enforcement (morning/night cannot omit sections)
- [ ] 6) Autonomy scope rules
- [ ] 7) Auth alignment (LETTA_API_KEY / lettabot.yaml / MemFS git)
- [ ] 8) Stable memory sync health checks
- [ ] 9) Pinned memory policy (keep `system/` small)
- [ ] 10) Reflection policy (sleep-time compute)
- [ ] 11) Defragmentation routine
- [ ] 12) Disk space monitoring
- [ ] 13) Log location + rotation
- [ ] 14) Comms lane rules
- [ ] 15) Escalation channel for blockers
- [ ] 16) Subagent policy
- [ ] 17) Canonical Build/Update Nico manual (wizard)
- [ ] 18) Weekly ingestion updater
- [ ] 19) Repo workflow gates (branch-only, PR-only)
- [ ] 20) Backup + restore drills

**Immediate action items:**
- [ ] Upgrade overnight runner from report-only → branch + PR (gated)
- [ ] Decide: LettaBot cron vs launchd-only for scheduled work
- [ ] **[P2][N]** Fix nighttime report job (missing `Scripts/nighttime-report.py`)

---

## STATUS.MD — Phase 7: LifeOS Agent Evolution

**Source:** `00-dashboard/status.md` | **Section:** Phase 7 (LifeOS) | **Owner:** [N] P4

*Dependency: Phases 0-3 complete. Future — scope after infrastructure is stable.*

- [ ] **1. [N]** Define full scope
  - [ ] 1a. Write "what does full LifeOS agent mean" in vault
  - [ ] 1b. Identify first automations beyond Lucavo
- [ ] **2. [N]** MCP server configuration
  - [ ] 2a. Evaluate which MCP servers to enable
  - [ ] 2b. Configure obsidian-claude-code-mcp (port 22360)
- [ ] **3. [N]** Multi-agent architecture
  - [ ] 3a. Research Claude Code Agent SDK
  - [ ] 3b. Define agent roles + access scope
  - [ ] 3c. Build agent registry (which agents exist, status, scope)
  - [ ] 3d. Slack #nico-internal as inter-agent channel
  - [ ] 3e. Define escalation rules: when does sub-agent escalate to Nico or Vincent?
- [ ] **4. [N]** Spin up agent layer
  - [ ] 4a. Research Director (Letta agent — builds knowledge over time)
  - [ ] 4b. Operations Manager (Letta agent — monitoring, alerts, scheduled tasks)
  - [ ] 4c. Engineering Director pattern (Claude Code Task template — stateless per task)
- [ ] **5. [N]** GitHub as agent management layer
  - [ ] 5a. Evaluate GitHub Actions for agent-triggered workflows
  - [ ] 5b. Evaluate GitHub Projects v2 as visual board for Nico
  - [ ] 5c. Design: agents as contributors, PRs as deliverables, Issues as assignments

---

## STATUS.MD — Phase 8: External App Integrations

**Source:** `00-dashboard/status.md` | **Section:** Phase 8 | **Owner:** [N+V] P4

*Dependency: Phase 3 complete. Note: No Apple Notes or Apple Reminders integrations — Obsidian is the sole task/notes front-end.*

- [ ] **1. [N]** TickTick integration (if still in use)
  - [ ] 1a. Research TickTick API (REST, OAuth, webhooks?)
  - [ ] 1b. Define sync direction and what syncs
  - [ ] 1c. Build integration → TickTick tasks appear in vault inbox
- [ ] **2. [N]** Google Calendar integration
  - [ ] 2a. Gmail API access (lifeos.nico@gmail.com)
  - [ ] 2b. Agent reads calendar before morning briefing
  - [ ] 2c. Calendar events appear in daily notes
- [ ] **3. [N]** M3 → M1 data migration sweep
  - [ ] 3a. Audit M3 for scattered content: Stickies, Desktop files, Downloads, old Obsidian vault
  - [ ] 3b. Pull everything into CabinetAgentVault/01-inbox/ via SSH or Obsidian Sync
  - [ ] 3c. Verify: nothing important left on M3 that isn't in vault
- [ ] **4. [V+N]** lucavolifeos Google account decision
  - [ ] 4a. Separate account for business or consolidate? Vincent decides.

---

## STATUS.MD — Phase 9: Research Agent

**Source:** `00-dashboard/status.md` | **Section:** Phase 9 | **Owner:** [N] P5

*Dependency: Phase 3 + Phase 7 Task 3 + Phase 8. Autonomous content organization into vault.*

- [ ] **1. [N]** Define scope + behavior
  - [ ] 1a. Sources: YouTube saves, Reddit saves, web clips, Obsidian Inbox
  - [ ] 1b. Output: organized notes in vault with frontmatter, tags, wikilinks
- [ ] **2. [N]** Build ingestion pipelines
  - [ ] 2a. YouTube: saved videos → research note in 30-resources/
  - [ ] 2b. Reddit: saved posts → research note
  - [ ] 2c. Web clips → clipping in 50-clippings/
  - [ ] 2d. Obsidian 01-inbox/: unsorted → auto-categorize and move
- [ ] **3. [N]** Build organization engine
  - [ ] 3a. Auto-tag by content analysis
  - [ ] 3b. Auto-link to related notes (wikilinks)
  - [ ] 3c. Auto-assign to project (Lucavo, SaaS Portal, Nico Agent)
  - [ ] 3d. Generate executive summary (3 bullets max)
- [ ] **4. [N]** Build review workflow
  - [ ] 4a. Organized items land in 01-inbox/ with proposed categorization
  - [ ] 4b. Vincent approves/rejects via Obsidian
  - [ ] 4c. Agent learns from corrections (via Letta memory)

---

## STATUS.MD — Inbox — Unprocessed Captures (Remaining Open)

**Source:** `00-dashboard/status.md` | **Section:** 📥 Inbox | *Triaged 2026-02-23 CC-5*

### New (Open)
- [x] **[P1][N]** Build background Slack polling ✅ (done 2026-02-23)
- [ ] **[P1][N]** Add Telegram memory command cheat sheet to master list + pinned memory
- [ ] **[P3][N]** Pilot GitHub Actions background agent lane (tag Nico/Letta Code on issues/PRs) — choose repo + security mode first
- [ ] **[P3][N]** Troubleshoot copy and paste issues in Claude Code, including image pasting capability *(added 2026-02-24)*

### Remaining (25 items, triaged)
- [ ] **[P1][V]** Final comms decision: pick canonical channel (Telegram vs iMessage vs other) — partially done, needs final pick
- [ ] **[P3][N]** Session log gap: Feb 21 CC session not logged — add entry
- [ ] **[P3][N]** "Why so many Nico bots" — document all bots/agents and their roles
- [ ] **[P3][N]** Claude Code hooks discipline — verify SessionStart/Stop scripts still working
- [ ] **[P3][N]** Search token cost audit — how much is search costing per session?
- [ ] **[P3][N]** Bookmarked/pinned task-board in Obsidian — Vincent opens instantly on any device *(Phase 2 area)*
- [ ] **[P3][N]** Emergency standard setup list — define "emergency reset" for the whole system *(Phase 6 area)*
- [ ] **[P4][N]** GitHub file structure mirroring Obsidian structure *(Phase 6 area)*
- [ ] **[P4][N]** Daily note file structure in GitHub before Obsidian CLI is live *(Phase 6 area)*
- [ ] **[P4][N]** Token command to stop massive text output mid-session *(research)*
- [ ] **[P4][N]** `/remote-env` slash command — research and evaluate *(research)*
- [ ] **[P4][N]** Discord audit — community sentiment, hacks *(research)*
- [ ] **[P4][N]** Update Screenshots folder — organize Logs/Screenshots/ *(cleanup)*
- [ ] **[P4][N]** Docker Desktop: install on M1 *(Phase 5 prereq)*
- [ ] **[P4][V+N]** M1 display name → "Nico Agent" in System Settings *(requires Vincent)*
- [ ] **[P4][V]** Caffeinate dims on M3 — investigate *(M3 issue, Vincent's machine)*
- [ ] **[P4][N]** Google Workspace evaluation for lifeos.nico@gmail.com *(Phase 8 area)*
- [ ] **[P4][N]** Where does live chat go if Claude Code disconnects? *(research)*
- [ ] **[P5][N]** Widget boxes on M1/M3 screen for quick status *(someday)*
- [ ] **[P5][N]** Dan Messlier GitHub — research *(someday)*
- [ ] **[P5][N]** Session logs: research how software cos structure engineering logs *(someday)*
- [ ] **[P5][N]** Cursor Mac-to-Mac issue — investigate *(someday)*
- [ ] **[P5][N]** Heartbeat + cron: "OpenClaw"-style agent loop *(Phase 7 scope)*
- [ ] **[P3][N]** Revisit Obsidian Sync setup (excluded from current Obsidian setup)
- [ ] **[P3][N]** Research how to trigger Peekaboo MCP on-demand from Claude Code — enable GUI automation without keeping it always-on (saves ~9.8k tokens)

---

## TASK-BOARD.MD — P1/P2 Snapshot

**Source:** `00-dashboard/task-board.md` | **Last updated:** 2026-02-23 22:40 EST (Session CC-10)

> *This file is rewritten by Nico at every session start and end. May be stale — use status.md as canonical source.*

### 🔴 P1 — Critical

| Owner | Task | Status |
|---|---|---|
| [V] | Telegram bot token rotation (BotFather /revoke) | 🔴 Security — do ASAP |
| [V] | Final comms decision | Partially done |

### 🟠 P2 — This Week

| Owner | Task | Status |
|---|---|---|
| [N] | Phase 0E — metadata standards enforcement | Next up |
| [V] | Obsidian Phase 2 (sign in, sync, CLI) | Waiting on Vincent |
| [V] | 1Password setup | Waiting on Vincent |

### 👤 Vincent's Actions (from task-board.md)
1. 🔴 Telegram: open @BotFather → `/revoke` → get new token → paste to Nico
2. Rename Slack bot from "Nico" to "Slacky" (Slack app settings → App Home → display name)
3. Obsidian: sign in, enable Sync, register CLI (Nico preps, Vincent flips switches)
4. [1Password](https://1password.com) — create account, install desktop app

### ✅ Completed This Session (CC-10)
- Background Slack polling: slack-poll.sh + slack-poll-check.py + LaunchAgent
- New channel #vincent-to-nico created
- context-monitor.sh updated: 📨 Slack msg indicator in statusline
- Channel maps updated in slack-post.sh + slack-read.sh
- Slacky ignore list added/reverted

---

## TELEGRAM-MISC-LIST — Pending Approval (2026-03-04)

**Source:** `05-reviews/tasks/2026-03-04_telegram-misc-list.md` | **Status:** review (pending Vincent approval)

> *Vincent must approve this list before items merge into status.md. Review instructions: reply in Telegram with `approve Telegram Misc List` or specific edits.*

### Phase P1 — Critical

**P1 — Nico-owned [N]**
1. [ ] **Stabilize Telegram responsiveness / eliminate silent gaps**
   - Identify root causes of "no ping / disconnected / hour gap" reports
   - Ensure watchdog + ping mechanisms work during tool approvals/reconnects
   - *(Evidence: Msg 1515: "full hour of time"; Msg 1565: "no pings no pong for an hour")*
2. [ ] **Prereqs discipline: when blocked, say "Blocked: <x>" immediately** *(Evidence: Msg 1334)*
3. [ ] **Telegram crash recovery: document + automate pending-approval/conversationId reset path**
   - Status: started (watchdog exists)

**P1 — Vincent-owned [V]**
1. [ ] **Confirm/complete Telegram bot token rotation**

### Phase P2 — Process Guardrails

**P2 — Nico-owned [N]**
1. [ ] **Enforce "single active item" rule + explicit states** (queued / in progress / done committed+pushed) — Status: started (used in wizard)
2. [ ] **Progress reporting rule**: Start ping → checkpoints every 10-15 min → done ping + proof snapshot *(Evidence: Msg 1549)*
3. [ ] **Completion proof**: After each completion, paste checklist snapshot into Telegram *(Evidence: Msg 1542)*
4. [ ] **Tight list discipline**: Keep tight list of what's being done + when completed *(Evidence: Msg 1377)*

**P2 — Vincent-owned [V]**
1. [ ] **Decide: allow PRs for overnight runner or report-only** *(Evidence: Msg 1363: "allow prs")*
2. [ ] **Decide: should we do both (cron and launchd, or two lanes)** *(Evidence: Msg 1363: "Should we do both")*

### Phase P3 — Overnight Autonomy Build-Out

**P3 — Nico-owned [N]**
1. [ ] **Overnight runner scaffolding + queue (repo-based)** — Status: started (exists; currently report-only)
2. [ ] **Definition-of-done gates** for overnight jobs
3. [ ] **Report spec enforcement** (morning/night reports cannot omit required sections)
4. [ ] **Auth alignment checks** (LETTA_API_KEY env, lettabot.yaml apiKey, memfs git)
5. [ ] **Memory sync health checks** (git status/pull/push + alert)
6. [ ] **Log rotation + disk space monitoring**

**P3 — Vincent-owned [V]**
1. [ ] **Choose the overnight runner fire time** (default discussed: 02:00 local) *(Evidence: Msg 1376)*

### Phase P4 — Reporting & Docs Consolidation

**P4 — Nico-owned [N]**
1. [ ] **Consolidate all extracted items into approved flow** (after Vincent approval)
2. [ ] **Write/maintain canonical manual(s)** — Build/Update Nico wizard manual

### Phase P5 — Open Questions

**P5 — Vincent-owned [V]**
1. [ ] Clarify expectations: what counts as "working overnight" success (PRs? reports? completed queue items?)

---

## NICO-OS.MD — Running Improvement Backlog

**Source:** `01-inbox/vault-salvage/reference-docs/nico-os.md` | **Status:** active | **Created:** 2026-02-25

### 1) Coordination Architecture (TOP)
- [ ] Define canonical artifacts and rules (status.md + llm-sessions + daily reports)
- [ ] Define work-item ID system (GitHub issue vs status task IDs)
- [ ] Define claim/lock protocol (prevent duplicate work)
- [ ] Define branch/worktree policy for multi-agent coding

### 2) Reporting System
- [ ] Morning Report template + delivery automation (Telegram + Obsidian)
- [ ] EOD Wrap Up template + delivery automation
- [ ] Weekly review template (what moved, what's stuck, what to kill)

### 3) Video-to-Execution System
- [x] Video research template created ✅
- [ ] Automate: given `vid:` link, create note + summary + checklist
- [ ] Create "implement / evaluate / runbook" tagging convention

### 4) Communication Layer Experiments
- [ ] Discord pilot: server + bot + minimal bridge
- [ ] Slack pilot: test the "crazy Slack" capability; document requirements
- [ ] Decide: Slack vs Discord vs both

### 5) Engineering Foundation for Agentic Coding
- [ ] Repo guardrails: branch protection, PR templates, CODEOWNERS
- [ ] CI gates: lint/format/typecheck/tests
- [ ] Security automation: CodeQL, Dependabot, secret scanning
- [ ] Preview deploy per PR

### 6) Memory and Knowledge Upgrades
- [ ] Add a "Known Facts / Defaults" note for fast reuse (stack, hosting, tools)
- [ ] Create decision log discipline: every decision gets a note + date
- [ ] Periodic memory defragment (monthly)

### Decision Points (Need Vincent)
- Work item IDs: GitHub Issues vs status.md IDs
- Comms platform: Slack vs Discord vs both
- Stack/hosting once we start portal build

---

## NEW-VAULT-BUILD — Pending Deliverables (Session 6)

**Source:** `new-vault-build/2026-03-01-cowork-session-6-summary.md` + `new-vault-build/research-verification.md`
**Status:** Awaiting approval before build begins

> All 14 Letta research videos processed ✅. Research base complete. Steps 4-5 pending explicit Vincent approval.

### Step 4 — Master Install Plan (PENDING APPROVAL)
`new-vault-build/master-install-plan.md` — 5-section document:
- [ ] Section 1: Architecture overview (vault-as-bridge, Claude Code lanes)
- [ ] Section 2: Vault structure
- [ ] Section 3: LettaBot setup sequence (full ordered steps, all corrections incorporated)
- [ ] Section 4: Memory architecture (context repositories, sleeptime, MemFS)
- [ ] Section 5: Ongoing protocols (heartbeat, cron, skills, session notes)

### Step 5 — Bootstrap Files (PENDING APPROVAL)
`new-vault-build/bootstrap/` — 9 files:
- [ ] `CLAUDE.md` — Claude Code instructions with explicit lane definitions
- [ ] `vault-contract.md` — file ownership rules, linking standards
- [ ] `00-dashboard/home.md` — clean home note
- [ ] `00-dashboard/status.md` — status template
- [ ] `05-templates/note-template.md` — standard frontmatter
- [ ] `05-templates/session-note-template.md` — session note template
- [ ] `05-templates/daily-report-template.md` — morning report template
- [ ] `future-architecture-reference.md` — multi-agent north star
- [ ] `decisions-inherited.md` — key decisions carried from old vault

### Research Verification Checklist (reference)
- [x] All 14 videos processed ✅
- [x] Decision conflicts identified and documented ✅
- [x] GitHub docs cross-reference complete ✅
- [x] Affected research notes updated ✅
- [ ] Install plan and bootstrap files — **PENDING APPROVAL (Steps 4-5)**

### Critical Gaps Found (G1-G6) — Must Be in Install Plan
- **G1** Heartbeat Silent Mode — agent must call `lettabot-message send` explicitly
- **G2** `LETTA_MODEL` env var removed — use `lettabot model set <handle>`
- **G3** Install command: `npm install && npm run build && npm link` (not `npm ci`)
- **G4** DM policy defaults to `pairing` — Vincent must self-pair after server start
- **G5** `LETTA_AGENT_ID` — must set after creating agent via env var or `lettabot.yaml`
- **G6** `/connectcodex` not in public docs — must be done interactively in Letta Code

### Pending Decisions (from Session 5)
- [ ] **[V]** Git repo strategy: new repo vs reuse existing nico-workspace?
- [ ] **[V]** Missing transcript for `LKRnP-ptC4c` — pull or skip?

---

## ARCHIVED: CoS Plan Roadmap (2026-02-22)

**Source:** `40-archive/2026-02-22_cos-plan-archived.md` | **Status:** ARCHIVED *(superseded by status.md phases)*

> *This was the original roadmap document. Retained for historical context. Open items from this doc should be verified against status.md — most have been migrated.*

### Phase 0 — Infrastructure (NOW, weeks 1-2) *(archived state)*
- [x] GitHub backup, auto-backup to branch ✅
- [x] SSH M1↔M3 ✅
- [x] LettaBot + Telegram ✅
- [x] Daily briefings (8am weekday / 10am weekend) ✅
- [x] Git workflow (branch protection, PR process) ✅
- [ ] ~~Slack workspace + bot token~~ → ✅ done
- [ ] ~~Brave Search / Exa API key~~ → ✅ DuckDuckGo working; Exa optional
- [ ] ~~Obsidian install + vault setup~~ → ✅ Phase 1 complete
- [ ] ~~1Password CLI~~ → still pending (Phase 0B)
- [ ] ~~Termius on iPhone~~ → ✅ done

### Phase 1 — Agent Layer (weeks 2-3) *(archived state)*
- [ ] Research Director spun up (Letta agent, configured) → Phase 7 LifeOS
- [ ] Operations Manager spun up (Letta agent, scheduled monitoring) → Phase 7 LifeOS
- [ ] Engineering director pattern established (Claude Code Task template) → Phase 7 LifeOS
- [ ] All agents connected to Slack → Phase 7 LifeOS
- [ ] Quick commands working from iPhone via Slack → Phase 7 LifeOS

### Phase 2 — Product Build (weeks 3-8) *(archived state)*
- [ ] Lucavo Client Portal scaffold (Next.js + Supabase) → Phase 5
- [ ] Auth flow (client login) → Phase 5
- [ ] PDF viewer (cabinet drawings) → Phase 5
- [ ] Client management dashboard → Phase 5
- [ ] First internal test with Lucavo Design data → Phase 5

### Phase 3 — First Client (weeks 8-12) *(archived state)*
- [ ] Onboard first Lucavo Design client to portal
- [ ] CSM agent handles onboarding communication
- [ ] Collect feedback, iterate
- [ ] Document what works (this becomes the sales playbook)

### Phase 4 — First External Revenue (months 3-4) *(archived state)*
- [ ] 2-3 beta customers in kitchen/cabinet industry
- [ ] Pricing: $X/mo per company (TBD — Vincent decides)
- [ ] Payment processing (Stripe integration)
- [ ] First invoice paid = first software revenue

---

## ARCHIVED: Setup Consolidation Pending Items (2026-02-23)

**Source:** `30-resources/reference/setup-consolidation.md` | **Status:** active reference | **Created:** 2026-02-23

> *Snapshot from Phase 0A consolidation session. Many items now tracked in status.md. Items below are as captured; verify against status.md for current state.*

### Priority 1 — Blockers (Vincent action required)
| # | Task | Owner | Est. Time |
|---|------|-------|-----------|
| 1 | Create Slack workspace + get bot token | Vincent | 5 min → ✅ done |
| 2 | Create 1Password account + CLI setup | Vincent | 8 min → still pending |
| 3 | Sign in to iMessage on M1 | Vincent | 2 min → status unknown |

### Priority 2 — Nico can execute
| # | Task | Notes |
|---|------|-------|
| 4 | Obsidian plugins + Obsidian Sync configuration | Phase 2 pending |
| 5 | Vault Git backup repo (nico-vault) | ✅ created |
| 6 | Seed notes in vault (10-projects, 20-areas) | ✅ done |
| 7 | Fix Nico headless memory writes | still blocked |
| 8 | Phase 0A: Consolidate remaining chat data | P3 open |
| 9 | Phase 0C: Verify cloud MCP sync fix after restart | ✅ verified CC-8 |
| 10 | status.md split: CEO track vs CoS track | not done |

### Inbox (Untriaged as of 2026-02-23)
- GitHub file structure mirroring Obsidian PARA structure
- 50% context window → Telegram alert hook → ✅ done
- Token command to suppress large text output
- Widget boxes on M1/M3 screen for quick status
- Letta writes tasks to Apple Notes (writeback)
- lucavolifeos Google account — separate from lifeos.nico? Clarify.
- Dan Messlier GitHub — research when search restored
- "Watch vid of pa guy in hall in Philly" — personal reminder (Vincent)
- M1 display name: change to "Nico Agent" in System Settings > General > Sharing
- Exa API key (optional — DuckDuckGo working) → ✅ done

---

## SESSION NOTES — Next-Action Captures

**Source:** Multiple session notes | Preserved for context

---

### Session CC-10 (2026-02-23) — Next Session
**Source:** `01-inbox/vault-salvage/session-notes/2026-02-23_session-CC-10.md`

- [ ] Phase 0E metadata standards enforcement (top priority for Nico)
- [ ] Vincent: Telegram token rotation, rename Slack bot to "Slacky", Obsidian Phase 2, 1Password

---

### Session CC-11 (2026-02-24) — Next Session
**Source:** `01-inbox/vault-salvage/session-notes/2026-02-24_session-CC-11.md`

- [ ] Phase 0E metadata standards enforcement (top priority)
- [ ] Vincent: Telegram token rotation, rename Slack bot "Slacky", Obsidian Phase 2, 1Password

---

### Session TG-1 (2026-02-25) — Next Session
**Source:** `01-inbox/vault-salvage/session-notes/2026-02-25_session-TG-1.md`

- [ ] Pilot Glue Phase 1: incoming webhooks to post daily reports and alerts as threads
- [ ] Decide lane structure for Glue pilot: role-based vs project-based
- [ ] Define Nico end-of-session "handoff" procedure (Letta equivalent) and optionally automate

---

### Cowork Session — Architecture (2026-03-01) — Open Questions
**Source:** `01-inbox/vault-salvage/session-notes/2026-03-01-cowork-letta-architecture.md`

**Session A — M1: Run the Pipeline** (pending)
```bash
ssh lifeos.nico@100.87.182.78
cp ~/Nico/CabinetAgentVault/30-resources/letta/letta-knowledge-pipeline.sh ~/Nico/Scripts/
chmod +x ~/Nico/Scripts/letta-knowledge-pipeline.sh
bash ~/Nico/Scripts/letta-knowledge-pipeline.sh
```

**Session B — Cowork: Build the Implementation Plan** (pending)
- Read all Letta research notes → produce implementation plan → save as `10-projects/nico-agent/letta-implementation-plan.md`

**Session C — Cowork: Build Interactive Manual** (pending)
- After plan approved: build HTML artifact — living Letta manual

**Session D — M1 Claude Code: Execute Fresh Setup** (pending)
- Run actual LettaBot fresh setup using implementation plan as spec

**Open questions (unanswered):**
1. Should LettaBot write morning briefings directly to daily note in vault, or send via Telegram only?
2. MemFS vs vault — exactly which files does Letta own vs Claude Code owns?
3. Multi-agent SaaS team: how many agents to start with?

---

### Cowork Session 4 — Decisions Pending (2026-03-01)
**Source:** `new-vault-build/2026-03-01-cowork-session-4-summary.md`

- [ ] **[V]** Agree/disagree on each of the 7 pushback points (documented in Session 4 summary)
- [ ] **[V]** Model choice: keep Sonnet 4.5 or start with Opus 4.5? → *resolved: OpenAI GPT via Pro subscription*
- [ ] **[V]** Git repo strategy (new vs reuse — Vincent thinking about it)
- [ ] **[V]** Missing transcript for `LKRnP-ptC4c` — needs to be pulled or skipped → *Session 6: processed*

---

### Daily Note — March 7 2026
**Source:** `00-dashboard/daily/March 7 2026.md`

> *(Raw capture, unprocessed — Vincent's voice)*
> - Trying to get nico set up
> - It has been a lot of work
> - I feel like I'm going backwards

*→ Nico note: Vincent expressing frustration with setup complexity. This is dogfooding the product.*

---

## REFERENCE: Key Decisions Log Summary

**Source:** `00-dashboard/decisions.md` | *No tasks — for context only*

| Topic | Decision |
|-------|----------|
| Agent name | Nico |
| Framework | Claude Code (YOLO/dangerously-skip-permissions mode) |
| Memory | Letta (Memo agent) + CLAUDE.md + Obsidian vault |
| Secrets | 1Password CLI ($3/mo) — not yet set up |
| Vault | `~/Nico/CabinetAgentVault/` — canonical, PARA structure |
| Task front-end | Obsidian — sole front-end. No Apple apps. |
| Alerts/approvals | iMessage/Telegram (osascript from M1 to Vincent's phone) |
| Sync | Obsidian Sync (primary) + Git (backup) |
| SaaS stack | Next.js + Supabase |
| Git workflow | `nico/{task-name}` branch → PR → merge. Never push master. |
| Budget | $200-330/mo |
| Architecture | Build for N agents, not 2. Every decision must scale to 5+ concurrent agents. |
| Agent model | Hybrid — Letta for persistent roles, Claude Code Tasks for execution-only |

---

*End of Master Task Rollup — extracted 2026-03-08 18:26 UTC*
*Source of truth remains `00-dashboard/status.md` — update there, not here.*
