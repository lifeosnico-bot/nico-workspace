# Mac Studio Migration — Context Handoff
## Created: 2026-03-14 | Source: Opus chat session (Chief of Staff project)

---

## PURPOSE
This document captures everything verified from a deep vault audit so the next session can produce a complete Mac Studio migration guide without re-reading the vault.

---

## MACHINE BEING REPLACED
- **M1 MacBook Air** — hostname: `nico-agent`, Tailscale IP: `100.87.182.78`, macOS user: `lifeos.nico`
- **Apple ID on machine**: `lifeos.nico@gmail.com`

## NEW MACHINE
- **Mac Studio** — not yet set up

## OTHER MACHINES IN THE NETWORK
- **M3 MacBook Pro** (Vincent's daily driver) — hostname: `macbook-pro`, Tailscale IP: `100.72.130.40`
- **iPhone** — Tailscale installed, Termius installed, Slack installed

---

## VERIFIED COMPLETED INFRASTRUCTURE ON M1 (as of 2026-03-09)

### Core System
- [x] M1 factory reset + fresh macOS (2026-02-14)
- [x] Apple ID: lifeos.nico@gmail.com (iCloud Keychain OFF)
- [x] macOS hardened: FileVault ON, Location OFF, Siri OFF, Analytics OFF, Apple Intelligence ON
- [x] Hostname: nico-agent
- [x] Caffeinate / sleep prevention configured
- [x] Passwordless sudo enabled (NOPASSWD: ALL)

### Developer Tools
- [x] Homebrew, Git, GitHub CLI installed
- [x] Git identity: "Nico (LifeOS Agent)" / lifeos.nico@gmail.com
- [x] GitHub account: lifeos.nico@gmail.com, authenticated via `gh auth login`
- [x] Claude Code installed + authenticated (YOLO mode / --dangerously-skip-permissions)
- [x] DuckDuckGo search script (`~/Nico/Scripts/search.sh`)
- [x] Exa API key obtained (free tier)

### Networking
- [x] Tailscale: M1 (100.87.182.78) ↔ M3 (100.72.130.40) ↔ iPhone
- [x] SSH: M3 → M1 working (passwordless)
- [x] SSH: iPhone → M1 via Termius + Tailscale

### Letta / LettaBot
- [x] LettaBot installed locally (NOT Docker) at `~/Nico/lettabot/`
- [x] Config: `~/Nico/lettabot/lettabot/lettabot.yaml`
- [x] Architecture: LettaBot → Letta Cloud API (`api.letta.com`), NOT local server
- [x] Config key: `server.mode: api`
- [x] Agent: `agent-5a9b0e69-1f30-476d-a89a-30c8e21c9668` (Nico)
- [x] Model: `gpt-5.3-codex` via `chatgpt_oauth`, temp 1.0, 128k context
- [x] Telegram DM channel active (Chat ID: 8385420240, user: Vincent James Imbriani)
- [x] Single bot token, single poller
- [x] Heartbeats: 60 min intervals
- [x] Daily briefings: 8am weekday / 10am weekend
- [x] Auto-start on M1 boot via launchd
- [x] Conversation isolation fix applied (2026-03-09): `conversations.mode: per-channel` + `heartbeat: dedicated`
- [x] Letta memory blocks (human, persona, project, task) — ALL CLOUD-SIDE on api.letta.com
- [x] Letta block IDs: m1-setup `block-9172b79a`, project-overview `block-241149bc`, human-profile `block-be2c64c6`, claude-code-notes `block-a4b588f9`

### Letta MemFS (Git-Backed Memory)
- [x] MemFS path: `/Users/lifeos.nico/.letta/agents/agent-5a9b0e69-1f30-476d-a89a-30c8e21c9668/memory/`
- [x] Contains: `system/human.md`, `system/persona.md`, `system/operations.md`, `system/ai-assistant/`, `system/project/`
- [x] MemFS autosync installed: `~/Nico/Scripts/memfs-autosync.sh` + LaunchAgent `com.nico.memfs-autosync.plist`
- [x] Multiple other local agent folders exist under `~/.letta/agents/` (routing issue documented — some writes hit wrong agent IDs)

### Slack
- [x] Slack workspace created ("Cabinet Agent")
- [x] Two-way bot: Socket Mode, claude-code-slack-bot
- [x] Channels: #ceo-desk, #status, #tasks, #dev, #decisions, #alerts, #nico-internal, #vincent-to-nico
- [x] Slack posting script: `slack-post.sh` + alert hooks
- [x] Background Slack polling: `slack-poll.sh` + `slack-poll-check.py` + LaunchAgent `com.nico.slack-poller`
- [x] Bot responds to DMs, posts to channels

### Obsidian
- [x] Obsidian installed on M1
- [x] CabinetAgentVault at `~/Nico/CabinetAgentVault/` — PARA structure (00-dashboard, 01-inbox, 05-reviews, 05-templates, 10-projects, 20-areas, 30-resources, 40-archive, 50-clippings)
- [x] CLAUDE.md at vault root with full conventions, frontmatter schema, CLI gotchas, linking standards
- [x] Phase 1 COMPLETE: app.json, community-plugins.json, core-plugins.json, appearance.json, 5 community plugins installed, all data.json configs, daily note config
- [x] Community plugins enabled by Vincent
- [x] Git repo: `nico-vault` on GitHub (lifeosnico-bot)
- [x] Templates in 05-templates/
- [x] iMessage infrastructure active (alerts route via Telegram using imessage-alert.sh)

### LaunchAgents (all tracked as code in `~/Nico/ops/launchd/`)
- [x] `com.nico.overnight-runner.plist` — runs `~/Nico/Scripts/overnight-runner.py` at 2am
- [x] `com.nico.heartbeat-healthcheck.plist` — silent health check
- [x] `com.nico.slack-poller` — background Slack polling
- [x] `com.nico.phase0g-status-ping.plist` — 15-min status pings
- [x] `com.nico.memfs-autosync.plist` — MemFS git commit/push
- [x] `com.nico.workspace-backup` — auto-backup every 6hrs

### Claude Code Skills
- [x] `/handoff` skill: `~/.claude/skills/handoff/SKILL.md`
- [x] `/mem` skill: `~/.claude/skills/mem/SKILL.md` (Letta sync)

### Workspace Structure
```
~/Nico/
├── CLAUDE.md (master agent instruction file)
├── CabinetAgentVault/ (Obsidian vault — git-backed)
├── Scripts/ (imessage-alert.sh, context-monitor.sh, permission-alert.sh, auto-backup.sh, slack-poll.sh, slack-poll-check.py, search.sh, overnight-runner.py, memfs-autosync.sh)
├── Logs/
├── Memory/ (status.md symlinked into vault)
├── Projects/
├── ops/launchd/ (tracked plist files + install/uninstall scripts)
├── lettabot/ (LettaBot connector code + config)
├── 911.md (emergency checklist)
├── .trash/{CW,CC,Chat}/ (soft-delete holding area)
```

### GitHub Repos
- `lifeosnico-bot/nico-workspace` (private) — ~/Nico/ backup
- `lifeosnico-bot/nico-vault` (private) — vault backup

---

## NOT COMPLETED (verified still open)

- [ ] **1Password** — no account exists anywhere. Blocks secrets management.
- [ ] **Obsidian Phase 2 manual steps** — Vincent never signed into Obsidian Sync in the app, never created remote vault "CabinetAgent", never installed Obsidian on iPhone for sync, never registered CLI (Settings → CLI → toggle ON)
- [ ] **Telegram bot token rotation** — P1 security item, token was exposed in session compaction summaries. BotFather `/revoke` never done.
- [ ] **Letta API key rotation** — exposed in session, needs rotation at api.letta.com
- [ ] **Docker Desktop** — never installed on M1
- [ ] **Phase 0E metadata standards enforcement**
- [ ] **Overnight runner** — report-only (no PR capability)
- [ ] **Nighttime report job** — missing script (`Scripts/nighttime-report.py`)
- [ ] **new-vault-build Steps 4-5** — master install plan + bootstrap files awaiting Vincent approval

---

## WHAT DOES NOT NEED MIGRATION (cloud-side)
- Letta agent memory blocks — all on api.letta.com
- LLM model routing — managed by Letta cloud
- GitHub repos — remote
- Obsidian Sync remote vault — once properly set up

## WHAT NEEDS TO MOVE
1. **LettaBot connector code** — `~/Nico/lettabot/` (or re-clone from source)
2. **lettabot.yaml** — with ROTATED credentials (API key + bot token)
3. **~/Nico/ workspace** — clone from GitHub (`nico-workspace`)
4. **CabinetAgentVault** — clone from GitHub (`nico-vault`)
5. **MemFS memory** — clone from git (it's git-backed)
6. **LaunchAgent plists** — copy from `~/Nico/ops/launchd/` (tracked in git)
7. **Claude Code skills** — `~/.claude/skills/handoff/` and `~/.claude/skills/mem/`
8. **Dotfiles** — `.zshrc` (contains Letta auth env var), `.gitconfig`
9. **Any files NOT yet committed to git** — rsync sweep before decommission

## SECURITY STEPS (do BEFORE migration)
1. Rotate Telegram bot token (BotFather `/revoke`)
2. Rotate Letta API key (api.letta.com dashboard)
3. Create 1Password account (lifeos.nico@gmail.com, $2.99/mo)
4. Vault ALL credentials in 1Password before writing them on new machine
5. Scan M1 for hardcoded secrets in dotfiles/scripts
6. Generate fresh SSH keys on Mac Studio (don't copy from M1)
7. FileVault ON, Firewall ON on Mac Studio

## KEY DECISIONS (from decisions.md — do not re-ask)
- Agent name: Nico
- Framework: Claude Code (YOLO mode)
- Memory: Letta + CLAUDE.md + Obsidian vault
- Secrets: 1Password CLI ($3/mo)
- Vault: ~/Nico/CabinetAgentVault/, PARA structure
- Task front-end: Obsidian only. No Apple apps.
- Sync: Obsidian Sync (primary) + Git (backup)
- SaaS stack: Next.js + Supabase
- Git workflow: nico/{task-name} → PR → merge. Never push master.
- Communication: Slack (backbone), Telegram (CEO desk), iMessage (escalation only)
- Budget: $200-330/mo
- Trash policy: never delete, move to ~/Nico/.trash/{CW,CC,Chat}/
- Architecture: build for N agents, not 2

## TAILSCALE IP UPDATE REQUIRED
Mac Studio will get a NEW Tailscale IP (not 100.87.182.78). Update:
- Termius config on iPhone
- Any hardcoded IP references in scripts on M3
- Operator's manual (`30-resources/reference/nico-operators-manual.md`)
- status.md Remote Access section
- CLAUDE.md on the new machine

## LETTABOT DIAGNOSTIC CHECKLIST (from CC-13, 2026-03-09)
47-item optimization checklist exists at: `CabinetAgentVault/01-inbox/2026-03-09_lettabot-diagnostic-fixes.md`
Critical items: lower temp 1.0→0.4, attach memory/archival tools, enable sleeptime agent, seed memory blocks, consider model switch from gpt-5.3-codex

## VAULT FILE LOCATIONS FOR REFERENCE
- Status (master task list): `CabinetAgentVault/00-dashboard/status.md`
- Task board: `CabinetAgentVault/00-dashboard/task-board.md`
- Decisions: `CabinetAgentVault/00-dashboard/decisions.md`
- Ops index: `CabinetAgentVault/00-dashboard/ops-index.md`
- Session index: `CabinetAgentVault/00-dashboard/llm-sessions/session-index.md`
- Operator's manual: `CabinetAgentVault/30-resources/reference/nico-operators-manual.md`
- Memory layers explainer: `CabinetAgentVault/00-dashboard/memory-layers-explainer.md`
- LettaBot diagnostic: `CabinetAgentVault/01-inbox/2026-03-09_lettabot-diagnostic-fixes.md`
- Research verification: `CabinetAgentVault/new-vault-build/research-verification.md`
