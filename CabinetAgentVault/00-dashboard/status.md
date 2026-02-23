# Status

**Last Updated**: 2026-02-23 13:55 EST | **Updated by**: Claude Code | **Session**: CC-7

---

## Current State

Phase 0D ✅, LettaBot ✅, Phase 0E ✅ (mostly), Daily briefing ✅, Termius+Tailscale ✅, Passwordless sudo ✅, Obsidian installed ✅, Obsidian Phase 1 ✅ (mostly). Master list consolidation ✅. Vault housekeeping ✅. Task-board ✅. iMessage alert script ✅ (working via Telegram). /handoff skill ✅. Task architecture plan approved ✅. 50% context alert ✅ (statusline + Telegram). Permission prompt alert ✅ (Notification hook + Telegram).

**#1 PRIORITY (Nico):** Phase 0E metadata enforcement.
**#1 PRIORITY (Vincent):** Telegram bot token rotation (BotFather /revoke) → Slack workspace + bot token.

---

## Quick Commands
_Use these shorthand commands from any surface (text, voice, Cowork, Claude Code):_

- **atl [P#] [description]** — Add to list. Defaults to P3/unassigned if no priority given.
- **sts** — Show current status. What's in progress, what's next.
- **done [task]** — Mark a task complete.
- **blocker [description]** — Flag something as blocked with reason.
- **pri [task] [1-5]** — Change priority of a task.
- **note [phase] [text]** — Add a note to a phase without creating a task.

_Priority scale: P1 = critical/blocking → P2 = this week → P3 = normal → P4 = low → P5 = someday_
_Owner tags: [V] = Vincent must do · [N] = Nico handles · [A] = delegatable to sub-agent_

---

## 🔴 Active This Week

| Priority | Owner | Task |
|---|---|---|
| ~~P1~~ | ~~[N]~~ | ~~50% context window alert hook~~ ✅ |
| P1 | [V] | Telegram bot token rotation (BotFather → /revoke → new token to Nico) |
| P1 | [V] | Create Slack workspace + bot token |
| P2 | [N] | Phase 0E — metadata standards enforcement |
| P2 | [V] | Obsidian Phase 2 manual setup |
| P2 | [V] | 1Password setup (secrets management) |

---

## 👤 Vincent's Actions (Blocking Nico)

_These require Vincent. Nothing else can proceed until done._

- [ ] **P1** Telegram bot token rotation: open @BotFather → `/revoke` → get new token → paste to Nico (security — old token exposed in compaction summaries)
- [ ] **P1** Create Slack workspace → copy bot token → paste in terminal to Nico
- [ ] **P2** 1Password: create account at 1password.com, install desktop app
- [ ] **P2** Obsidian Phase 2: manual setup (sign in, enable Sync, register CLI, enable plugins) — Nico will prep everything, Vincent flips the switches
- [ ] **P3** Exa API key: free tier at dashboard.exa.ai (1000/mo) — optional, DuckDuckGo works now
- [ ] **P4** Review `05-reviews/housekeeping/vault-consolidation-review.md` in Obsidian — one decision needed
- [ ] **P5** "Watch vid of pa guy in hall in Philly" — personal reminder

---

## 🤖 Nico's Queue (Autonomous Work)

_Nico executes without Vincent. Ordered by priority._

1. ~~iMessage alert script~~ ✅ Built (working via Telegram, 2026-02-23)
2. ~~Vault housekeeping~~ ✅ Done (2026-02-23)
3. ~~task-board.md~~ ✅ Built (2026-02-23)
4. ~~Master list consolidation~~ ✅ Done (2026-02-23)
5. ~~Obsidian Phase 1~~ ✅ Mostly done (app.json, plugins, git repo — 2026-02-23)
6. ~~50% context window alert hook~~ ✅ Done (statusline + Telegram alert, 2026-02-23)
7. ~~Telegram bot token rotation~~ → moved to Vincent's Actions (needs BotFather)
8. **[P2]** Phase 0E remaining — metadata standards enforcement
9. **[P2]** LettaBot Telegram poller conflict — investigate and fix
10. **[P3]** Obsidian Phase 1 remaining — core-plugins.json, appearance.json (minor)
11. **[P3]** Phase 0A — consolidate Chat Imports, deduplicate docs
12. **[P3]** Phase 0C — verify MCP context fix is holding

---

## 📥 Inbox — Unprocessed Captures (Triaged 2026-02-23 CC-5)

_Land here first, get triaged into phases by Nico. Items below have been assigned P/owner but not yet moved to phases._

### Closed (duplicate or done)
- [x] 50% context window hook → already Phase 0-Alerts task 2
- [x] lucavolifeos Google account → already Phase 8 task 4
- [x] YouTube saves → Obsidian skills → already Phase 9 scope
- [x] Telegram guard rails → already in LettaBot section
- [x] LettaBot poller conflict → already in Nico's Queue
- [x] Telegram bot token rotation → moved to Nico Queue P1
- [x] Evaluate /todos /plan → adopted plan mode + todos this session (CC-5)
- [x] Obsidian file open rule → already added to CLAUDE.md

### Remaining (25 items, triaged)
- [ ] **[P1][V]** Final comms decision: pick canonical channel (Telegram vs iMessage vs other) — partially done, needs final pick
- [ ] **[P4][N]** `/peekaboo` skill: create enable/disable toggle for Peekaboo MCP ✅ DONE (built 2026-02-23)
- [ ] **[P4][N]** Peekaboo disabled by default — saves ~9.8k tokens/session. Re-enable via `/peekaboo on` + restart when GUI automation needed
- [ ] **[P3][N]** Session log gap: Feb 21 CC session not logged — add entry
- [ ] **[P3][N]** "Why so many Nico bots" — document all bots/agents and their roles
- [ ] **[P3][N]** Claude Code hooks discipline — verify SessionStart/Stop scripts still working
- [ ] **[P3][N]** Search token cost audit — how much is search costing per session?
- [ ] **[P3][N]** Bookmarked/pinned task-board in Obsidian — Vincent opens instantly on any device _(Phase 2 area)_
- [ ] **[P3][N]** Emergency standard setup list — define "emergency reset" for the whole system _(Phase 6 area)_
- [ ] **[P4][N]** GitHub file structure mirroring Obsidian structure _(Phase 6 area)_
- [ ] **[P4][N]** Daily note file structure in GitHub before Obsidian CLI is live _(Phase 6 area)_
- [ ] **[P4][N]** Token command to stop massive text output mid-session _(research)_
- [ ] **[P4][N]** `/remote-env` slash command — research and evaluate _(research)_
- [ ] **[P4][N]** Discord audit — community sentiment, hacks _(research)_
- [ ] **[P4][N]** Update Screenshots folder — organize Logs/Screenshots/ _(cleanup)_
- [ ] **[P4][N]** Docker Desktop: install on M1 _(Phase 5 prereq)_
- [ ] **[P4][V+N]** M1 display name → "Nico Agent" in System Settings _(requires Vincent)_
- [ ] **[P4][V]** Caffeinate dims on M3 — investigate _(M3 issue, Vincent's machine)_
- [ ] **[P4][N]** Google Workspace evaluation for lifeos.nico@gmail.com _(Phase 8 area)_
- [ ] **[P4][N]** Where does live chat go if Claude Code disconnects? _(research)_
- [ ] **[P5][N]** Widget boxes on M1/M3 screen for quick status _(someday)_
- [ ] **[P5][N]** Dan Messlier GitHub — research _(someday)_
- [ ] **[P5][N]** Session logs: research how software cos structure engineering logs _(someday)_
- [x] **[P5][N]** Trash sub-folder review ✅ Vault `.trash/` configured via `trashOption: local` (done 2026-02-23)
- [ ] **[P5][N]** Cursor Mac-to-Mac issue — investigate _(someday)_
- [ ] **[P5][N]** Heartbeat + cron: "OpenClaw"-style agent loop _(Phase 7 scope)_
- [ ] **[P3][N]** Revisit Obsidian Sync setup (excluded from current Obsidian setup)
- [ ] **[P3][N]** Research how to trigger Peekaboo MCP on-demand from Claude Code — enable GUI automation without keeping it always-on (saves ~9.8k tokens). Goal: Claude Code can self-enable Peekaboo when UI interaction is needed, then disable after.

---

## Tasks

### In Progress
_(None — queue items above are next)_

---

### Phase 0-Alerts: iMessage + Context Alerts [N] P1
_Dependency: None. Build tonight. Vincent needs to be reachable when Nico is blocked._

- [x] 1. **[P1][N]** Build alert script ✅ (done 2026-02-23 — working via Telegram, imessage-alert.sh exists)
  - [x] 1a. Create `~/Nico/Scripts/imessage-alert.sh` ✅
  - [x] 1b. Test: alerts working via Telegram ✅
  - [x] 1c. Add usage to CLAUDE.md session protocol ✅
  - [x] 1d. Add call to `/handoff` skill ✅
- [x] 2. **[P1][N]** 50% context window alert ✅ (done 2026-02-23)
  - [x] 2a. Research: hooks can't inspect token count — StatusLine is the only mechanism ✅
  - [x] 2b. Built statusline script (context-monitor.sh) — fires Telegram alert at 50% ✅
  - [x] 2c. Alert via Telegram (uses imessage-alert.sh) ✅
  - [x] 2d. Message: "Context window at X% — consider /compact or starting new session" ✅
- [x] 3. **[P1][N]** Permission prompt alert ✅ (done 2026-02-23)
  - [x] 3a. Built Notification hook (permission_prompt matcher) → Telegram alert ✅
  - [x] 3b. 2-minute cooldown prevents spam ✅

---

### ~~Phase 0-Housekeeping: Vault + Workspace Cleanup~~ ✅ COMPLETE (2026-02-23)
_Done in CC-4. Vault A archived, home dir cleaned, Memory/ loose files moved, cos-plan archived._

---

### Phase 0F: Agent Access & Communication [V+N] P1
_Dependency: None. #1 PRIORITY after Nico's overnight tasks. CEO must be able to reach agents from anywhere._

**The three problems:**
1. How does Vincent reach agents from iPhone?
2. How do two Claude Code installs on different machines coexist?
3. What's the always-on communication channel?

**How two Claude Code Desktops work:**
- M3 sees M3 files ONLY · M1 sees M1 files ONLY
- Same Anthropic account (billing) but completely independent sessions
- Cross-machine coordination = Git (push/pull via GitHub)

- [ ] 1. **[P1][V]** QUICK WIN: Claude Code remote sessions from phone (~5 min)
  - [ ] 1a. Open claude.ai/code in Safari on iPhone — can you launch remote sessions?
  - [ ] 1b. Open Claude iOS app — check for session monitoring
  - [ ] 1c. Test: start remote session from phone, give it a task, confirm it runs
- [ ] 2. **[P1][V]** QUICK WIN: Slack workspace + iPhone app (~10 min)
  - [ ] 2a. Create Slack workspace (name: your call — "lucavo-lifeos", "nico-hq", or other)
  - [ ] 2b. Install Slack on iPhone
  - [ ] 2c. Create bot + copy token → paste to Nico via terminal
- [ ] 3. **[P1][N]** Connect agents to Slack (~20 min, after token received)
  - [ ] 3a. Connect Cowork to Slack (MCP connector)
  - [ ] 3b. Research Claude Code ↔ Slack integration (bot token vs. Slack App vs. API)
  - [ ] 3c. Implement Claude Code → Slack posting (status updates, task completions)
  - [ ] 3d. Create channels: #ceo-desk, #status, #tasks, #dev, #decisions, #alerts, #nico-internal, #lucavo-design
  - [ ] 3e. Test: Vincent posts `atl: something` in #tasks from phone → Nico picks it up
  - [ ] 3f. Test: agent completes task → posts to #status automatically
- [ ] 4. **[P2][V]** SSH from phone (fallback — Phase 0D done, just needs iPhone setup)
  - [ ] 4a. Tailscale already on iPhone ✅
  - [ ] 4b. Termius already on iPhone ✅
  - [ ] 4c. Test: SSH from phone → M1 → run `claude` in terminal
- [ ] 5. **[P1][N]** iMessage escalation channel (see Phase 0-Alerts — building tonight)
- [ ] 6. **[P4][N]** Advanced multi-device options (research after basics work)
  - [ ] 6a. Can Claude Code Desktop on M3 SSH remote into M1 workspace?
  - [ ] 6b. Can Cowork on M3 mount ~/Nico/ via Tailscale/SSHFS?
  - [ ] 6c. Evaluate Happy Coder and other mobile Claude Code apps
- [ ] 7. **[P2][N]** Document access architecture
  - [ ] 7a. iPhone: Slack + claude.ai/code + SSH/Termius · M3: Cowork + Claude Code + Slack · M1: Claude Code CLI + Slack
  - [ ] 7b. Update CLAUDE.md under "Remote Access"

---

### Phase 0E: Fix Git Workflow [N] P2 (Mostly Done)
_Dependency: Phase 0 complete ✅_

- [x] 1. Protect master branch (done 2026-02-22)
- [x] 2. Update auto-backup script to backup branch only (done 2026-02-22)
- [x] 3. Update agent workflow + CLAUDE.md (done 2026-02-22)
- [x] 4. Migrate + first proper PR cycle (done 2026-02-22)
- [x] 5a. Direct push blocked ✅ · 5b. Branch→PR→merge works ✅
- [ ] 5c. **[P3][N]** Verify auto-backup runs on next cycle correctly
- [ ] 6. **[P2][N]** Enforce metadata standards
  - [ ] 6a. Audit existing files: status.md, decisions.md, session-log.md — add missing timestamps
  - [ ] 6b. Define exact format per document type (timezone, source label)
  - [ ] 6c. Add metadata checklist to CLAUDE.md Session Protocol
  - [ ] 6d. Future: Slack bot validates metadata before accepting #status posts

---

### Phase 0C: Audit Claude Code Context Loading [N] P3 (Mostly Done)
_Dependency: None._

- [x] 1. Identified problem: Craft MCP loading 17.8k tokens/session (done 2026-02-16)
- [x] 2. Disabled cloud MCP sync (done 2026-02-16)
- [ ] 3. **[P3][N]** Verify fix
  - [ ] 3a. Run `/context` — confirm Craft tools gone
  - [ ] 3b. Confirm no other unexpected MCP servers loading
- [ ] 4. **[P3][N]** Permanent fix documentation
  - [ ] 4a. Document in CLAUDE.md: "Cloud MCP sync disabled — do not re-enable without token audit"
- [ ] 5. **[P3][N]** Audit remaining context usage
  - [ ] 5a. Review 13 .mcp.json plugin files — are any loading unexpectedly?
  - [ ] 5b. Document baseline context usage in CLAUDE.md

---

### Phase 0A: Consolidate Chat Data [N+V] P3
_Dependency: None. Clean up lingering duplicate docs from Chat sessions._

- [ ] 1. **[P3][V]** Confirm: is anything still in Chat that hasn't been exported?
- [ ] 2. **[P3][N]** Deduplicate Chat Imports
  - [ ] 2a. NICO-FINAL-SETUP-PLAN.md vs nico-setup-plan-v4 — keep best, trash duplicate
  - [ ] 2b. obsidian-final-setup-plan.md vs obsidian-final-setup-plans.md — keep newest, trash other
  - [ ] 2c. Move surviving files to vault (30-resources/reference/) with proper naming
  - [ ] 2d. Add README.md to Chat Imports/ explaining what each file is/was
- [ ] 3. **[P3][N]** Extract any decisions not yet in Key Decisions section

---

### Phase 0B: Secrets & Security — 1Password [V] P2
_Dependency: Blocks any task requiring stored API keys._

- [ ] 1. **[P2][V]** Create 1Password account
  - [ ] 1a. Go to 1password.com → sign up with lifeos.nico@gmail.com (Individual, $2.99/mo)
  - [ ] 1b. Save Secret Key safely
  - [ ] 1c. Download + install desktop app on M1
- [ ] 2. **[P2][N]** Install 1Password CLI (after Vincent creates account)
  - [ ] 2a. `brew install 1password-cli`
  - [ ] 2b. `op signin`
  - [ ] 2c. Verify: `op vault list`
- [ ] 3. **[P2][N]** Store secrets
  - [ ] 3a. Anthropic API key
  - [ ] 3b. GitHub token (if needed beyond SSH)
  - [ ] 3c. Test retrieval

---

### ~~LettaBot: Install + Configure on M1~~ ✅ COMPLETE (2026-02-22)
- [x] Cloned + configured on M1
- [x] Telegram bot set up and working
- [x] Heartbeats enabled (60 min intervals)
- [x] Daily briefings: 8am weekday / 10am weekend
- [x] Auto-start on M1 boot via launchd
- [x] Vincent can message from iPhone via Telegram
- [ ] **[P2][N]** Guard rails for Telegram crashes / multiple instance prevention (see Inbox)
- [ ] **[P2][N]** Reduce Telegram chatter — filter what gets posted, clean up noise

---

### Phase 1: Obsidian Vault Setup [N] P2 ✅ COMPLETE
_Dependency: Obsidian installed ✅. CabinetAgentVault exists ✅. Needs completion._

**Vault path**: `~/Nico/CabinetAgentVault/` (canonical — confirmed 2026-02-23)

**What exists already:**
- Vault structure: 00-dashboard/, 01-inbox/, 05-reviews/, 05-templates/, 10-projects/, 20-areas/, 30-resources/, 40-archive/, 50-clippings/ ✅
- CLAUDE.md at vault root ✅
- home.md in 00-dashboard/ ✅
- Project index files ✅

**What's done:**
- [x] 1. Templates ✅ Already exist in 05-templates/ (done 2026-02-23)
- [x] 2a. app.json ✅ (done 2026-02-23)
- [x] 2b. community-plugins.json ✅ (done 2026-02-23)
- [x] 3. Community plugins installed ✅ (5 plugins on disk, done 2026-02-23)
- [x] 4. Git repo initialized + pushed to GitHub (nico-vault) ✅ (done 2026-02-23)
- [x] 5. task-board.md ✅ Built (done 2026-02-23)

**What still needs to be done:**
- [x] 2c. **[P3][N]** core-plugins.json ✅ (exists, done 2026-02-23)
- [x] 2d. **[P3][N]** appearance.json ✅ (done 2026-02-23)
- [x] 2e. **[N]** Plugin data.json configs (Templater, Dataview, Obsidian Git, Tasks, Calendar) ✅ (done 2026-02-23)
- [x] 2f. **[N]** daily-notes.json (00-dashboard/daily/, template, YYYY-MM-DD format) ✅ (done 2026-02-23)

---

### Phase 2: Obsidian Manual Setup [V] P2
_Dependency: Phase 1 complete. Claude Code preps everything, Vincent flips switches (~10 min)._

- [ ] 1. **[V]** Open Obsidian → "Open folder as vault" → select `~/Nico/CabinetAgentVault/`
- [ ] 2. **[V]** Sign in to Obsidian account (Catalyst license — lifeos.nico account)
- [ ] 3. **[V]** Enable Obsidian Sync
  - [ ] 3a. Settings → Sync → Log in
  - [ ] 3b. Create new remote vault → name it "CabinetAgent"
  - [ ] 3c. Wait for initial sync
  - [ ] 3d. Install Obsidian on iPhone → log into same account → vault appears
- [x] 4. **[V]** Enable community plugins ✅ (done 2026-02-23)
  - [x] 4a. Settings → Community Plugins → Turn off Restricted Mode ✅
  - [x] 4b. Enable all pre-installed plugins ✅
- [ ] 5. **[N]** Register CLI (after Vincent enables it)
  - [ ] 5a. Settings → Command Line Interface → toggle ON
  - [ ] 5b. Verify: `obsidian version`

---

### Phase 3: Post-Launch Verification [N] P2
_Dependency: Phase 2 complete (Vincent has done manual setup)._

- [ ] 1. **[N]** Verify CLI working
  - [ ] 1a. `obsidian version` · `obsidian vault` · `obsidian files total`
- [ ] 2. **[N]** Test CLI operations
  - [ ] 2a. Files list, read, search, tasks
  - [ ] 2b. Create today's daily note via CLI
  - [ ] 2c. Verify obsidian-claude-code-mcp running on port 22360
- [ ] 3. **[N]** Configure Obsidian Git plugin
  - [ ] 3a. Auto-commit every 10 min, auto-pull every 10 min, pull on boot
- [ ] 4. **[N]** Run smoke test
  - [ ] 4a. Vault structure ✓ · Git initialized ✓ · CLI responds ✓ · Search works ✓ · Tasks work ✓
- [ ] 5. **[N]** Update CLAUDE.md with Obsidian section
  - [ ] 5a. Vault location, sync info, CLI version

---

### Phase 4: Communication & Access
_Absorbed into Phase 0F. See Phase 0F._

---

### Phase 5: SaaS Client Portal — Scaffold [N] P3
_Dependency: Phase 0B (1Password for credentials). The actual product build._

- [ ] 1. **[N]** Project setup
  - [ ] 1a. Create `~/Nico/Projects/cabinet-portal/`
  - [ ] 1b. Branch: `nico/scaffold-portal`
  - [ ] 1c. Initialize Next.js with App Router
  - [ ] 1d. Install dependencies (Supabase client)
- [ ] 2. **[N]** Supabase configuration
  - [ ] 2a. Create Supabase project (store in 1Password)
  - [ ] 2b. Configure client
  - [ ] 2c. Design schema: users, projects, documents
  - [ ] 2d. Run initial migrations
- [ ] 3. **[N]** Auth flow
  - [ ] 3a. Login + Signup pages
  - [ ] 3b. Supabase Auth integration
  - [ ] 3c. Protected routes / middleware
- [ ] 4. **[N]** Dashboard
  - [ ] 4a. Layout + sidebar
  - [ ] 4b. Project listing view
- [ ] 5. **[N]** PDF handling (placeholder)
  - [ ] 5a. PDF upload component
  - [ ] 5b. Storage bucket in Supabase
  - [ ] 5c. Document listing view
- [ ] 6. **[N]** Ship it
  - [ ] 6a. Push branch → open PR
  - [ ] 6b. Create session note in vault summarizing what was built

---

### Phase 6: Backup & Redundancy [N+V] P3
_Dependency: Phase 3 complete._

- [ ] 1. **[N]** GitHub repos
  - [ ] 1a. nico-vault (private) — vault backup ✅ (in progress)
  - [ ] 1b. nico-workspace (private) — ~/Nico/ backup ✅ (exists)
  - [ ] 1c. cabinet-portal (private) — SaaS code (Phase 5)
- [ ] 2. **[N]** Automated backup schedule
  - [ ] 2a. Obsidian Git plugin: auto-commit vault every 10 min
  - [ ] 2b. Verify workspace auto-backup (every 6hrs via launchd) still working
- [ ] 3. **[V]** Sync verification
  - [ ] 3a. Obsidian Sync working M1 → iPhone
  - [ ] 3b. GitHub repos accessible from M3
- [ ] 4. **[N]** Disaster recovery plan
  - [ ] 4a. Document: how to restore from GitHub if M1 dies
  - [ ] 4b. Save to vault: `30-resources/reference/disaster-recovery.md`

---

### Phase 7: LifeOS Agent Evolution [N] P4
_Dependency: Phases 0-3 complete. Future — scope after infrastructure is stable._

**Org chart (designed in cos-plan.md):**
```
CEO — Vincent James Imbriani
└── Chief of Staff — Nico (Claude Code, Sonnet-4.6)
    ├── Director of Engineering (Claude Code Task, Sonnet)
    ├── Director of Research & Intelligence (Letta, Sonnet/Opus)
    ├── Director of Product (Claude Code Task, Sonnet)
    ├── Client Success Manager (Claude Code Task, Haiku)
    └── Operations Manager (Letta, Haiku)
```

- [ ] 1. **[N]** Define full scope
  - [ ] 1a. Write "what does full LifeOS agent mean" in vault
  - [ ] 1b. Identify first automations beyond Lucavo
- [ ] 2. **[N]** MCP server configuration
  - [ ] 2a. Evaluate which MCP servers to enable
  - [ ] 2b. Configure obsidian-claude-code-mcp (port 22360)
- [ ] 3. **[N]** Multi-agent architecture
  - [ ] 3a. Research Claude Code Agent SDK
  - [ ] 3b. Define agent roles + access scope
  - [ ] 3c. Build agent registry (which agents exist, status, scope)
  - [ ] 3d. Slack #nico-internal as inter-agent channel
  - [ ] 3e. Define escalation rules: when does sub-agent escalate to Nico or Vincent?
- [ ] 4. **[N]** Spin up agent layer
  - [ ] 4a. Research Director (Letta agent — builds knowledge over time)
  - [ ] 4b. Operations Manager (Letta agent — monitoring, alerts, scheduled tasks)
  - [ ] 4c. Engineering Director pattern (Claude Code Task template — stateless per task)
- [ ] 5. **[N]** GitHub as agent management layer
  - [ ] 5a. Evaluate GitHub Actions for agent-triggered workflows
  - [ ] 5b. Evaluate GitHub Projects v2 as visual board for Nico
  - [ ] 5c. Design: agents as contributors, PRs as deliverables, Issues as assignments

---

### Phase 8: External App Integrations [N+V] P4
_Dependency: Phase 3 complete. Connect external tools → Obsidian vault._

**Note: No Apple Notes or Apple Reminders integrations — Obsidian is the sole task/notes front-end.**

- [ ] 1. **[N]** TickTick integration (if still in use)
  - [ ] 1a. Research TickTick API (REST, OAuth, webhooks?)
  - [ ] 1b. Define sync direction and what syncs
  - [ ] 1c. Build integration → TickTick tasks appear in vault inbox
- [ ] 2. **[N]** Google Calendar integration
  - [ ] 2a. Gmail API access (lifeos.nico@gmail.com)
  - [ ] 2b. Agent reads calendar before morning briefing
  - [ ] 2c. Calendar events appear in daily notes
- [ ] 3. **[N]** M3 → M1 data migration sweep
  - [ ] 3a. Audit M3 for scattered content: Stickies, Desktop files, Downloads, old Obsidian vault
  - [ ] 3b. Pull everything into CabinetAgentVault/01-inbox/ via SSH or Obsidian Sync
  - [ ] 3c. Verify: nothing important left on M3 that isn't in vault
- [ ] 4. **[V+N]** lucavolifeos Google account decision
  - [ ] 4a. Separate account for business or consolidate? Vincent decides.

---

### Phase 9: Research Agent [N] P5
_Dependency: Phase 3 + Phase 7 Task 3 + Phase 8. Autonomous content organization into vault._

- [ ] 1. **[N]** Define scope + behavior
  - [ ] 1a. Sources: YouTube saves, Reddit saves, web clips, Obsidian Inbox
  - [ ] 1b. Output: organized notes in vault with frontmatter, tags, wikilinks
- [ ] 2. **[N]** Build ingestion pipelines
  - [ ] 2a. YouTube: saved videos → research note in 30-resources/
  - [ ] 2b. Reddit: saved posts → research note
  - [ ] 2c. Web clips → clipping in 50-clippings/
  - [ ] 2d. Obsidian 01-inbox/: unsorted → auto-categorize and move
- [ ] 3. **[N]** Build organization engine
  - [ ] 3a. Auto-tag by content analysis
  - [ ] 3b. Auto-link to related notes (wikilinks)
  - [ ] 3c. Auto-assign to project (Lucavo, SaaS Portal, Nico Agent)
  - [ ] 3d. Generate executive summary (3 bullets max)
- [ ] 4. **[N]** Build review workflow
  - [ ] 4a. Organized items land in 01-inbox/ with proposed categorization
  - [ ] 4b. Vincent approves/rejects via Obsidian
  - [ ] 4c. Agent learns from corrections (via Letta memory)

---

### Completed
- [x] Original architecture session — agent concept defined (2026-02-02)
- [x] M1 factory reset + fresh macOS (2026-02-14)
- [x] Apple ID: lifeos.nico@gmail.com created (2026-02-14)
- [x] M1 hardened (FileVault, Location OFF, Siri OFF) (2026-02-14)
- [x] Hostname set: nico-agent (2026-02-14)
- [x] Sleep prevention configured / caffeinate (2026-02-14)
- [x] Homebrew, Git, gh CLI installed (2026-02-14)
- [x] Git identity: "Nico (LifeOS Agent)" configured (2026-02-14)
- [x] Tailscale connected M1↔M3 (2026-02-14)
- [x] SSH enabled M1↔M3 (2026-02-14)
- [x] Claude Code installed (v2.1.42) + authenticated (2026-02-14)
- [x] Letta/Memo connected (agent-5a9b0e69) (2026-02-14)
- [x] ~/Nico workspace structure created (2026-02-14)
- [x] CLAUDE.md written and configured (2026-02-14, updated ongoing)
- [x] Memory system initialized: status.md, decisions.md (2026-02-14)
- [x] GitHub account + gh auth login (2026-02-15)
- [x] Obsidian Catalyst License purchased ($25) (2026-02-15)
- [x] Obsidian Sync upgraded — multi-vault (2026-02-15)
- [x] Obsidian CLI capability audit completed (2026-02-15)
- [x] Vault architecture designed (PARA, frontmatter schema, templates) (2026-02-15)
- [x] Chat project files imported (6 files in Chat Imports/) (2026-02-16)
- [x] Trash policy established (~/.trash/{CW,CC,Chat}/) (2026-02-16)
- [x] Quick commands system (atl, sts, done, blocker, pri, note) (2026-02-16)
- [x] Task decomposition + dependency rules in CLAUDE.md (2026-02-16)
- [x] Metadata standards added (2026-02-16)
- [x] Phase 0-CRITICAL: GitHub backup — nico-workspace repo, auto-backup 6hrs (2026-02-16)
- [x] Git credential helper fixed (2026-02-16)
- [x] Cloud MCP connector sync disabled (17.8k tokens saved/session) (2026-02-16)
- [x] Phase 0D: SSH M3↔M1 fully working (2026-02-21)
- [x] Termius + Tailscale SSH from iPhone (2026-02-22)
- [x] Passwordless sudo enabled (NOPASSWD: ALL) (2026-02-22)
- [x] Obsidian installed (2026-02-22)
- [x] Claude Code --dangerously-skip-permissions alias (2026-02-22)
- [x] LettaBot: installed, Telegram working, heartbeats 60min, daily briefings 8am/10am (2026-02-22)
- [x] Phase 0E: Branch protection, auto-backup to backup branch, PR workflow (2026-02-22)
- [x] DuckDuckGo search script installed (~/Nico/Scripts/search.sh) (2026-02-22)
- [x] CabinetAgentVault/ created with PARA structure (2026-02-22)
- [x] 05-reviews/ folder established in vault for Obsidian-based doc review (2026-02-23)
- [x] /handoff skill built (~/.claude/skills/handoff/SKILL.md) (2026-02-23)
- [x] Task architecture plan approved (woolly-exploring-goose.md) (2026-02-23)
- [x] No-Apple-apps decision: Obsidian is sole front-end until further notice (2026-02-23)
- [x] Master list consolidation — all sources reconciled into this file (2026-02-23)
- [x] Vault housekeeping — Vault A archived, home dir cleaned, Memory/ organized (2026-02-23)
- [x] task-board.md built in 00-dashboard/ (2026-02-23)
- [x] iMessage/Telegram alert script built (imessage-alert.sh) (2026-02-23)
- [x] Obsidian Phase 1: app.json, community-plugins.json, 5 plugins installed, all data.json configs ✅ COMPLETE (2026-02-23)
- [x] Obsidian Phase 2 partial: community plugins enabled by Vincent (2026-02-23)
- [x] Vault git repo created + pushed to GitHub (nico-vault) (2026-02-23)
- [x] Templates confirmed in 05-templates/ (2026-02-23)
- [x] status.md moved into vault, symlinked from Memory/ (2026-02-23)
- [x] Wikilinks standard added to vault CLAUDE.md (2026-02-23)
- [x] Files-open-in-Obsidian rule added to CLAUDE.md (2026-02-23)
- [x] Session CC-5 audit: status.md synced with reality (2026-02-23)
- [x] 50% context window alert: statusline script + Telegram alert at 50% (2026-02-23)
- [x] Permission prompt alert: Notification hook + Telegram when approval needed (2026-02-23)

---

## Key Decisions (Final — Do Not Re-Ask)

- **Agent name**: Nico
- **Framework**: Claude Code (YOLO/dangerously-skip-permissions mode)
- **Memory**: Letta (Memo agent) + CLAUDE.md + Obsidian vault
- **Secrets**: 1Password CLI ($3/mo) — not yet set up
- **Vault**: `~/Nico/CabinetAgentVault/` — canonical, PARA structure (00/10/20/30/40/50)
- **Task front-end**: Obsidian — sole front-end until further notice. No Apple apps.
- **Quick capture**: `atl` command (terminal) · Obsidian 01-inbox/ (drop a note)
- **Alerts/approvals**: iMessage only (osascript from M1 to Vincent's phone)
- **Sync**: Obsidian Sync (primary, M1→iPhone→M3) + Git (backup)
- **SaaS stack**: Next.js + Supabase
- **Git workflow**: `nico/{task-name}` branch → PR → merge. Never push master.
- **Communication**: Slack (future backbone, set up when Vincent creates workspace), iMessage (alerts/approvals only)
- **Budget**: $200-330/mo
- **Trash policy**: Never delete. Move to `~/Nico/.trash/{CW,CC,Chat}/` with date prefix.
- **Task list**: Single source of truth = this file. No other list exists anywhere.
- **Architecture principle**: Build for N agents, not 2. Every decision must scale to 5+ concurrent agents.
- **Agent model**: Hybrid — Letta for persistent roles (Research Director, Ops Manager), Claude Code Tasks for execution-only roles
- **Billion dollar insight**: We're dogfooding the product we'll sell. Every pain point building this system is a feature request for the SaaS we'll eventually sell to other construction companies.

---

## Remote Access
- M3 → M1: `ssh lifeos.nico@100.87.182.78`
- M1 Tailscale IP: 100.87.182.78 · M3 Tailscale IP: 100.72.130.40
- M1 username: lifeos.nico · hostname: nico-agent
- iPhone → M1: Tailscale + Termius (SSH) ✅

---

## Key Files
- `~/Nico/CLAUDE.md` — master agent instruction file
- `~/Nico/Memory/status.md` — THIS FILE — single source of truth
- `~/Nico/Memory/decisions.md` — decision log
- `~/Nico/CabinetAgentVault/` — Obsidian vault (canonical)
- `~/Nico/CabinetAgentVault/00-dashboard/task-board.md` — Obsidian task snapshot (Nico writes at session start/end)
- `~/Nico/CabinetAgentVault/05-reviews/` — docs for Vincent to review in Obsidian
- `~/Nico/Scripts/imessage-alert.sh` — alert Vincent when approval needed (working via Telegram)
- `~/Nico/Scripts/context-monitor.sh` — statusline: shows ctx% + alerts at 50%
- `~/Nico/Scripts/permission-alert.sh` — Notification hook: alerts when permission prompt fires
- `~/Nico/Scripts/auto-backup.sh` — workspace backup every 6hrs
- `~/Nico/Scripts/search.sh` — DuckDuckGo search
- `~/.claude/skills/handoff/SKILL.md` — end-of-session handoff skill
- `~/.claude/skills/mem/SKILL.md` — Letta sync skill
- `~/.claude/plans/woolly-exploring-goose.md` — task architecture plan
- `~/Nico/Memory/cos-plan.md` — CoS plan (archive to vault — superseded)
- `~/Nico/911.md` — emergency checklist
- `~/Nico/Memory/nico-operators-manual.md` — operators manual

---

## Reference
- GitHub: https://github.com/lifeosnico-bot/nico-workspace
- Letta Memo agent: `agent-5a9b0e69-1f30-476d-a89a-30c8e21c9668`
- Letta block IDs: m1-setup `block-9172b79a` · project-overview `block-241149bc` · human-profile `block-be2c64c6` · claude-code-notes `block-a4b588f9`

