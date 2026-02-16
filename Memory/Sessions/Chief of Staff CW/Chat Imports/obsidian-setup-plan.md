# Obsidian Autonomous Setup Plan for Claude Code (M1)
### Nico Agent — Second Brain for AI-Native Business Startup
**Date:** February 15, 2026 | **Target Machine:** M1 MacBook Air (nico-agent)

---

## OVERVIEW

This plan enables Claude Code on the M1 to set up Obsidian as Nico's second brain with minimal human involvement. The setup covers installation, vault creation, plugin configuration, CLI integration, and the kepano/obsidian-skills integration for native Claude Code ↔ Obsidian interop.

**Vincent's involvement: 3 actions, ~5 minutes total.**
**Claude Code handles everything else autonomously.**

---

## PREREQUISITES (Current M1 State)

Already completed (from Feb 14 setup session):
- ✅ Factory reset + clean macOS install
- ✅ Homebrew installed
- ✅ Git + GitHub CLI installed
- ✅ Tailscale connected (IP: 100.87.182.78)
- ✅ SSH enabled between M1 and M3
- ✅ Claude Code installed + authenticated
- ✅ Letta headless installed
- ✅ Workspace at ~/Nico/ with Projects, Logs, Memory subdirectories

Still needed before this plan executes:
- ⬜ GitHub account created (lifeos.nico@gmail.com) + `gh auth login`
- ⬜ Obsidian installed on M1

---

## WHAT VINCENT MUST DO (Human-Required Actions)

These are the ONLY things that require Vincent's physical presence or manual action. Everything else is autonomous.

### Action 1: Purchase Catalyst License ($25 one-time)
- Go to https://obsidian.md/pricing
- Purchase the Catalyst License ($25)
- This unlocks Obsidian v1.12 Early Access with the official CLI
- Note: The CLI will eventually be free for everyone, but Early Access requires Catalyst

### Action 2: Install Obsidian + Enable CLI
- Install Obsidian: `brew install --cask obsidian` (Claude Code can run this)
- OR download from obsidian.md/download
- Open Obsidian once (first-run vault picker dialog)
- Point it at the vault directory Claude Code will have already created: `~/Nico/Vault/`
- Go to Settings → About → Log in with Obsidian account (Catalyst)
- Go to Settings → About → Switch to Early Access (v1.12+)
- Go to Settings → Command Line Interface → Toggle ON "Register CLI"
- Close and reopen Terminal so the CLI is on PATH

### Action 3: Verify CLI Works
- Open Terminal and run: `obsidian version`
- Should return: `Obsidian v1.12.x`
- Run: `obsidian vault` to confirm the vault is registered
- Tell Claude Code: "Obsidian CLI is ready"

**That's it. Total time: ~5 minutes.**

---

## WHAT CLAUDE CODE DOES AUTONOMOUSLY

Everything below can be executed by Claude Code on the M1 without human involvement. This is the script/plan Claude Code follows.

### Phase 1: Pre-Installation (Before Vincent opens Obsidian)

#### 1.1 Install Obsidian via Homebrew
```bash
brew install --cask obsidian
```

#### 1.2 Create Vault Directory Structure
```bash
mkdir -p ~/Nico/Vault
```

#### 1.3 Build the Vault Folder Architecture
```bash
# Core structure - flat, one level deep, following best practices
# from kepano's community research (347 replies, 4.1K likes)

mkdir -p ~/Nico/Vault/{00-Inbox,01-Projects,02-Areas,03-Resources,04-Archive,05-Templates,06-Daily,07-Canvas}

# Business-specific directories
mkdir -p ~/Nico/Vault/01-Projects/{Lucavo-Design,SaaS-Portal,Nico-Agent}
mkdir -p ~/Nico/Vault/02-Areas/{Business-Ops,Clients,Finance,Marketing,Development}
mkdir -p ~/Nico/Vault/03-Resources/{Research,Tutorials,Reference,Vendors,Standards}
mkdir -p ~/Nico/Vault/04-Archive
mkdir -p ~/Nico/Vault/05-Templates
mkdir -p ~/Nico/Vault/06-Daily/{2026}
mkdir -p ~/Nico/Vault/07-Canvas
```

#### 1.4 Create CLAUDE.md at Vault Root (for Claude Code integration)
This is the master context file Claude Code reads when working inside the vault.

```markdown
# Nico — Obsidian Vault CLAUDE.md

## Identity
You are Nico, the AI Chief of Staff for Vincent Imbriani's AI-native business.
This vault is your second brain — the persistent knowledge layer for both
Lucavo Design (cabinet business) and the SaaS startup.

## Vault Structure
- 00-Inbox/: Unsorted captures, quick notes, web clippings
- 01-Projects/: Active projects with status tracking
- 02-Areas/: Ongoing areas of responsibility
- 03-Resources/: Reference material, research, standards
- 04-Archive/: Completed or inactive items
- 05-Templates/: Note templates for consistent formatting
- 06-Daily/: Daily notes organized by year
- 07-Canvas/: Visual maps and relationship diagrams

## Conventions
- Use Obsidian-flavored Markdown (wikilinks, callouts, embeds)
- Frontmatter required on all notes: title, date, tags, status
- Link liberally between notes using [[wikilinks]]
- Tags use kebab-case: #project-status, #cabinet-specs
- Status values: draft, active, review, complete, archived
- File names use kebab-case: my-note-title.md

## Frontmatter Schema
---
title: "Note Title"
date: YYYY-MM-DD
tags: [tag1, tag2]
status: draft | active | review | complete | archived
project: project-name (optional)
type: note | meeting | research | decision | task | daily
---

## Git Workflow
- Vault is a git repo synced to GitHub
- Branch as nico/{task-name}, never push to main
- Commit frequently with clear messages
- Pull latest before starting new work

## Key Principles
- Capture first, organize later (Inbox → proper location)
- One idea per note (atomic notes)
- Link > folder hierarchy (discovery through connections)
- Templates ensure consistency
- Daily notes are the entry point for each day
```

#### 1.5 Create Core Templates

**Daily Note Template** (`05-Templates/daily-note.md`):
```markdown
---
title: "Daily Note - {{date}}"
date: {{date}}
tags: [daily]
type: daily
status: active
---

# {{date}} — Daily Note

## Morning Check-in
- [ ] Review yesterday's notes
- [ ] Check project statuses
- [ ] Priority tasks for today

## Tasks
- [ ] 

## Notes


## Decisions Made


## End of Day
- [ ] Update project statuses
- [ ] Move captures from Inbox
- [ ] Commit vault changes
```

**Project Note Template** (`05-Templates/project-note.md`):
```markdown
---
title: "Project: {{title}}"
date: {{date}}
tags: [project]
type: project
status: draft
project: {{project-slug}}
---

# {{title}}

## Objective


## Key Decisions


## Tasks
- [ ] 

## Resources
- 

## Notes


## Status Updates

### {{date}}
- 
```

**Meeting Note Template** (`05-Templates/meeting-note.md`):
```markdown
---
title: "Meeting: {{title}}"
date: {{date}}
tags: [meeting]
type: meeting
status: complete
project: 
attendees: []
---

# Meeting: {{title}}

## Agenda


## Discussion


## Decisions


## Action Items
- [ ] 
```

**Research Note Template** (`05-Templates/research-note.md`):
```markdown
---
title: "Research: {{title}}"
date: {{date}}
tags: [research]
type: research
status: draft
source: 
---

# {{title}}

## Summary


## Key Findings


## Implications for Lucavo / SaaS


## References

```

**Decision Log Template** (`05-Templates/decision-note.md`):
```markdown
---
title: "Decision: {{title}}"
date: {{date}}
tags: [decision]
type: decision
status: complete
project: 
---

# Decision: {{title}}

## Context
Why was this decision needed?

## Options Considered
1. 
2. 
3. 

## Decision
What was decided and why.

## Consequences
What follows from this decision.
```

#### 1.6 Create Seed Notes

**Home Note** (`00-Home.md`):
```markdown
---
title: Home
date: 2026-02-15
tags: [nav]
type: note
status: active
---

# Nico's Second Brain

Welcome to the knowledge base for Vincent Imbriani's AI-native business.

## Quick Navigation
- [[01-Projects/Lucavo-Design/index|Lucavo Design]]
- [[01-Projects/SaaS-Portal/index|SaaS Client Portal]]
- [[01-Projects/Nico-Agent/index|Nico Agent System]]

## Areas
- [[02-Areas/Business-Ops/index|Business Operations]]
- [[02-Areas/Development/index|Development]]
- [[02-Areas/Clients/index|Clients]]

## Recent Daily Notes
Check [[06-Daily/2026/|2026 Daily Notes]]
```

**Project Index Notes** (one per project directory):
Create `index.md` files in each project folder with project-specific context.

#### 1.7 Initialize Git Repository
```bash
cd ~/Nico/Vault
git init
git add .
git commit -m "Initial vault structure — Nico second brain"
# Once GitHub account is set up:
# gh repo create nico-vault --private --source=. --push
```

### Phase 2: Post-Installation (After Vincent enables CLI)

#### 2.1 Verify CLI Access
```bash
obsidian version
obsidian vault
obsidian files total
```

#### 2.2 Install kepano/obsidian-skills for Claude Code
```bash
cd ~/Nico/Vault
mkdir -p .claude
git clone https://github.com/kepano/obsidian-skills.git /tmp/obsidian-skills
cp -r /tmp/obsidian-skills/* ~/Nico/Vault/.claude/
rm -rf /tmp/obsidian-skills
```

This gives Claude Code native understanding of:
- Obsidian Markdown (.md) with wikilinks, callouts, embeds, properties
- Obsidian Bases (.base) for database views
- JSON Canvas (.canvas) for visual mapping

#### 2.3 Configure Community Plugins (via filesystem)
Claude Code writes directly to `.obsidian/` config files. Obsidian must have been opened at least once for this directory to exist.

```bash
# Enable community plugins
cat > ~/Nico/Vault/.obsidian/community-plugins.json << 'EOF'
[
  "obsidian-tasks-plugin",
  "obsidian-git",
  "calendar",
  "dataview",
  "templater-obsidian"
]
EOF
```

Then install each plugin by cloning from GitHub into `.obsidian/plugins/`:

```bash
PLUGINS_DIR=~/Nico/Vault/.obsidian/plugins
mkdir -p "$PLUGINS_DIR"

# Tasks plugin — task management with queries
git clone https://github.com/obsidian-tasks-group/obsidian-tasks.git /tmp/tasks-plugin
mkdir -p "$PLUGINS_DIR/obsidian-tasks-plugin"
cp /tmp/tasks-plugin/dist/* "$PLUGINS_DIR/obsidian-tasks-plugin/" 2>/dev/null || true
# Alternative: download latest release assets directly

# Obsidian Git — vault sync via git
# Download latest release from GitHub releases page
# Place main.js, manifest.json, styles.css in $PLUGINS_DIR/obsidian-git/

# Calendar — daily note calendar view
# Dataview — query notes as a database
# Templater — advanced template engine
```

**Note:** Plugin installation via filesystem can be fragile. The more reliable approach is to use the Obsidian GUI to enable community plugins and install them from the marketplace. This takes Vincent ~2 minutes clicking through 5 plugin installs. If we want to avoid that, Claude Code can download release assets directly from GitHub and place them in the correct directories.

#### 2.4 Configure Obsidian Settings (via filesystem)
```bash
# Core Obsidian settings
cat > ~/Nico/Vault/.obsidian/app.json << 'EOF'
{
  "defaultViewMode": "source",
  "showLineNumber": true,
  "spellcheck": true,
  "promptDelete": false,
  "alwaysUpdateLinks": true,
  "newFileLocation": "folder",
  "newFileFolderPath": "00-Inbox",
  "attachmentFolderPath": "03-Resources/Attachments",
  "useMarkdownLinks": false
}
EOF
```

#### 2.5 Set Up Obsidian Git Plugin Config
```bash
mkdir -p ~/Nico/Vault/.obsidian/plugins/obsidian-git
cat > ~/Nico/Vault/.obsidian/plugins/obsidian-git/data.json << 'EOF'
{
  "commitMessage": "vault sync: {{date}}",
  "autoSaveInterval": 10,
  "autoPullInterval": 10,
  "autoPullOnBoot": true,
  "disablePush": false,
  "pullBeforePush": true,
  "disablePopups": false,
  "listChangedFilesInMessageBody": true
}
EOF
```

#### 2.6 Test CLI Operations
```bash
# Create a test note via CLI
obsidian create "00-Inbox/test-cli-note.md" --silent

# List files
obsidian files total

# Search
obsidian search "Lucavo"

# Open a note
obsidian open "00-Home.md"
```

#### 2.7 Create MCP Integration (Optional, for enhanced Claude Code access)
If using an MCP server for Obsidian, configure it in Claude Code's MCP settings:

```bash
# obsidian-claude-code-mcp plugin approach
# This allows Claude Code to interact with Obsidian through MCP protocol
# in addition to direct filesystem + CLI access

# Three access methods available:
# 1. Direct filesystem (always works, no dependencies)
# 2. Obsidian CLI (requires v1.12+, provides 100+ commands)
# 3. MCP server (optional, provides structured API)
```

### Phase 3: Operational Verification

#### 3.1 Smoke Test Checklist
Claude Code runs these to verify everything works:

```bash
# 1. Vault exists and has structure
ls ~/Nico/Vault/0*

# 2. Git is initialized
cd ~/Nico/Vault && git status

# 3. CLAUDE.md exists at vault root
cat ~/Nico/Vault/CLAUDE.md | head -5

# 4. Templates exist
ls ~/Nico/Vault/05-Templates/

# 5. obsidian-skills installed
ls ~/Nico/Vault/.claude/skills/

# 6. CLI responds (after Vincent enables it)
obsidian version

# 7. Can create notes
obsidian create "00-Inbox/smoke-test.md" --silent
obsidian files total
```

#### 3.2 Create First Real Notes
Once verified, Claude Code creates the initial business context:

- `01-Projects/Lucavo-Design/index.md` — Cabinet business overview, standards, workflows
- `01-Projects/SaaS-Portal/index.md` — SaaS project status, tech stack, roadmap
- `01-Projects/Nico-Agent/index.md` — Agent system architecture, setup log, decisions
- `02-Areas/Development/tech-stack.md` — Next.js, Supabase, current tooling
- `03-Resources/Standards/cabinet-standards.md` — Lucavo Design business standards

---

## EXECUTION ORDER

| Step | Who | What | Time |
|------|-----|------|------|
| 1 | Claude Code | `brew install --cask obsidian` | 2 min |
| 2 | Claude Code | Create vault directory + folder structure | 1 min |
| 3 | Claude Code | Create CLAUDE.md, templates, seed notes | 2 min |
| 4 | Claude Code | Initialize git repo | 1 min |
| 5 | **Vincent** | Purchase Catalyst License ($25) | 2 min |
| 6 | **Vincent** | Open Obsidian → point at vault → enable CLI | 3 min |
| 7 | **Vincent** | Verify `obsidian version` works | 30 sec |
| 8 | Claude Code | Install kepano/obsidian-skills | 1 min |
| 9 | Claude Code | Configure plugins via filesystem | 2 min |
| 10 | Claude Code | Configure settings | 1 min |
| 11 | Claude Code | Run smoke tests | 1 min |
| 12 | Claude Code | Create initial business context notes | 5 min |
| 13 | Claude Code | Git commit + push | 1 min |

**Total Claude Code time:** ~14 minutes autonomous
**Total Vincent time:** ~5 minutes, 3 discrete actions

---

## DECISION: OBSIDIAN SYNC vs GIT SYNC

Two sync options for the vault across M1 and M3:

| Factor | Obsidian Sync ($10/mo) | Git Sync (free) |
|--------|----------------------|-----------------|
| Cost | $10/month | Free |
| Mobile access | ✅ iOS/Android app | ❌ No mobile |
| Conflict resolution | Automatic, merge-friendly | Manual git merges |
| Setup complexity | Login + toggle | obsidian-git plugin + GitHub |
| Claude Code friendly | Transparent (just files) | Native (git commands) |
| Real-time | Near-instant | Every 10 min (configurable) |

**Recommendation:** Use Git sync via obsidian-git plugin. You already have GitHub infrastructure, it's free, and Claude Code speaks git natively. If you want mobile access to notes later, add Obsidian Sync alongside git — they don't conflict.

---

## KNOWN GOTCHAS (from capability audit)

1. **22.8% of CLI commands silently fail** — Always use `tasks all todo` not `tasks todo`, use `format=tsv` for properties, add `silent` flag for headless creation
2. **First-run dialog requires GUI click** — Can't be automated, but it's a one-time 10-second task
3. **Plugin installation via filesystem is fragile** — Release asset formats change between plugin versions. GUI marketplace install is more reliable but requires Vincent
4. **CLI requires Obsidian to be running** — The official CLI communicates with the running Obsidian app. For pure headless operation without the GUI, use direct filesystem access instead
5. **Catalyst License is required today** — The CLI is in Early Access. Will be free eventually, but $25 is required now

---

## FALLBACK: No Catalyst License

If Vincent doesn't want to spend $25 right now, Claude Code can still set up everything except the official CLI commands. The fallback stack:

1. **Direct filesystem access** — Claude Code reads/writes .md files directly (always works)
2. **NotesMD CLI** (community, free) — `brew install yakitrak/yakitrak/notesmd-cli` — provides open, search, create, list without needing Obsidian running
3. **kepano/obsidian-skills** — Still works, as it operates on files, not the CLI
4. **obsidian-git plugin** — Still works for sync

The official CLI adds convenience (100+ commands, TUI mode, plugin management) but is not strictly required for core functionality. Claude Code's primary interaction with the vault will be through direct file manipulation regardless.
