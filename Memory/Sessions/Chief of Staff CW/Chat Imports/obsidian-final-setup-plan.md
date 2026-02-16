# FINAL PLAN: Obsidian Autonomous Setup for Claude Code on M1
### Nico Agent — Second Brain for Vincent Imbriani's AI-Native Business
**Date:** February 15, 2026 | **Version:** FINAL | **Target:** M1 MacBook Air (nico-agent)

---

## WHAT THIS DOCUMENT IS

This is the complete, context-aware plan for Claude Code on the M1 to autonomously set up Obsidian as Nico's second brain. It incorporates every decision, research finding, and contextual detail from the entire Chief of Staff project — including the original architecture session (Feb 2), the M1 factory reset (Feb 14), the Nico setup session (Feb 14), the Obsidian CLI capability audit (Feb 15), and the planning session (Feb 15).

**Two deliverables in this document:**
1. **Reference Plan** — Full context, rationale, and architecture (Sections 1-8)
2. **Claude Code Prompt** — The actual prompt Vincent pastes into Claude Code to execute (Section 9)

---

## 1. CURRENT M1 STATE (As of Feb 15, 2026)

### Completed
- ✅ Factory reset + clean macOS (Feb 14)
- ✅ New Apple ID: lifeos.nico@gmail.com
- ✅ Hostname: nico-agent
- ✅ Sleep prevention: `sudo pmset -c sleep 0 disksleep 0 displaysleep 0`
- ✅ Homebrew installed
- ✅ Git + GitHub CLI (`gh`) installed
- ✅ Git identity: "Nico (LifeOS Agent)" <lifeos.nico@gmail.com>
- ✅ Tailscale connected (M1 IP: 100.87.182.78, M3 IP: 100.72.130.40)
- ✅ SSH enabled M1↔M3
- ✅ Claude Code installed + authenticated
- ✅ Letta/Memo connected (agent-5a9b0e69-1f30-476d-a89a-30c8e21c9668)
- ✅ Workspace: ~/Nico/ with Projects/, Logs/, Memory/ subdirectories
- ✅ CLAUDE.md at ~/Nico/CLAUDE.md with Nico persona
- ✅ Catalyst License purchased ($25 one-time)
- ✅ Obsidian Sync upgraded (supports multiple vaults)
- ✅ GitHub account created (lifeos.nico@gmail.com) + `gh auth login` — DONE

### Not Yet Completed
- ⬜ iMessage NOT set up on M1
- ⬜ Obsidian NOT installed on M1

### Machine Access
- M1 username: lifeos.nico
- M1 hostname: nico-agent
- M3→M1 SSH: `ssh lifeos.nico@100.87.182.78`
- M1 Tailscale IP: 100.87.182.78
- M3 Tailscale IP: 100.72.130.40

---

## 2. DECISIONS ALREADY MADE

These were finalized across multiple sessions and are NOT up for discussion:

| Decision | Value | Session |
|----------|-------|---------|
| Vault name | **Nico** | Feb 15 planning |
| Vault location | **~/Nico/Vault/** | Feb 15 planning |
| Starting content | **Empty** (no migration) | Feb 15 planning |
| Existing personal vault (M3) | "Obsidian vault" (no conflict) | Feb 15 planning |
| Claude Code access level | **Full unrestricted** | Feb 15 planning |
| Management scope | Business ops, SaaS dev, research, daily notes/tasks | Feb 15 planning |
| Users | Vincent + Claude Code now; future agents later | Feb 15 planning |
| Primary sync | **Obsidian Sync** (already paid) + **Git backup** | Feb 15 planning |
| Agent name | Nico (renamed from Jarvis, Feb 14) | Feb 14 setup |
| Primary framework | Claude Code (not OpenClaw, not Letta-only) | Feb 2 architecture |
| SaaS tech stack | Next.js + Supabase | Feb 2 architecture |
| Git workflow | Branch as nico/{task-name}, never push to main | Feb 2 architecture |
| Memory approach | Letta for cross-session + CLAUDE.md for per-session + Obsidian for deep knowledge | Feb 14 setup |

---

## 3. BUSINESS CONTEXT (What Nico Needs to Know)

### Vincent Imbriani
- Runs **Lucavo Design**, a kitchen cabinet business
- Transitioning to AI-native SaaS company
- Building a **client portal** for cabinet companies: PDF drawing search, client management
- Strategy: build for Lucavo first, then sell as SaaS to other cabinet companies
- First-year CS student experience level
- Budget: $200-330/month for AI services
- Prefers rapid iteration over evaluation — "crash and break things" in the sandbox
- Wants genuine pushback, not sycophancy

### The Business Nico Manages
1. **Lucavo Design (Physical Cabinet Business)**: Drawings, installs, client management, vendor relationships, financials
2. **SaaS Client Portal (Startup)**: Next.js + Supabase, PDF upload/search, client authentication, project status
3. **Nico Agent System (Infrastructure)**: M1 setup, automation, memory, knowledge base, future sub-agents

### Key Cabinet Business Terms
- Toe-kick, reveal dimensions, cabinet specs
- Client drawings (PDF), install schedules
- Vendor/supplier relationships
- Project bidding and estimation

---

## 4. VAULT ARCHITECTURE

### Folder Structure
Flat, one level deep. PARA-inspired (Projects, Areas, Resources, Archive) with business-specific additions. Based on kepano's community research (347 replies, 4.1K likes recommending flat hierarchy + liberal wikilinks).

```
~/Nico/Vault/
├── .obsidian/              # Obsidian config (auto-generated + configured)
├── .claude/                # kepano/obsidian-skills (Claude Code integration)
├── .git/                   # Git repo for backup sync
├── CLAUDE.md               # Vault-specific Claude Code context
├── 00-Inbox/               # Quick captures, unsorted notes
├── 01-Projects/            # Active projects
│   ├── Lucavo-Design/      # Cabinet business project notes
│   ├── SaaS-Portal/        # Client portal development
│   └── Nico-Agent/         # Agent system setup and architecture
├── 02-Areas/               # Ongoing areas of responsibility
│   ├── Business-Ops/       # Day-to-day operations
│   ├── Clients/            # Client-specific notes
│   ├── Finance/            # Budget, invoicing, projections
│   ├── Marketing/          # Marketing plans, content
│   └── Development/        # Tech stack, architecture, DevOps
├── 03-Resources/           # Reference material
│   ├── Research/           # AI tools, industry research
│   ├── Tutorials/          # How-tos, learned skills
│   ├── Reference/          # Standards docs, specs
│   ├── Vendors/            # Supplier info, contacts
│   └── Attachments/        # Images, PDFs, files
├── 04-Archive/             # Completed or inactive items
├── 05-Templates/           # Note templates
├── 06-Daily/               # Daily notes
│   └── 2026/               # Year subfolder
└── 07-Canvas/              # Visual maps, relationship diagrams
```

### Frontmatter Schema (All Notes)
```yaml
---
title: "Note Title"
date: YYYY-MM-DD
tags: [tag1, tag2]
status: draft | active | review | complete | archived
project: project-name        # optional
type: note | meeting | research | decision | task | daily | project | client
priority: high | medium | low # optional, for tasks
due: YYYY-MM-DD              # optional, for tasks
assignee: "Vincent"           # optional
---
```

### Naming Conventions
- File names: kebab-case (`my-note-title.md`)
- Tags: kebab-case (`#project-status`, `#cabinet-specs`)
- Wikilinks for internal connections: `[[note-name]]`
- Status values: draft → active → review → complete → archived

---

## 5. TEMPLATES

### Daily Note (`05-Templates/daily-note.md`)
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
- [ ] Set priority tasks for today

## Tasks
- [ ] 

## Notes


## Decisions Made


## End of Day
- [ ] Update project statuses
- [ ] Move captures from Inbox
- [ ] Commit vault changes
```

### Project Note (`05-Templates/project-note.md`)
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


## Status Updates

### {{date}}
- 
```

### Meeting Note (`05-Templates/meeting-note.md`)
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

### Research Note (`05-Templates/research-note.md`)
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

### Decision Log (`05-Templates/decision-note.md`)
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

### Client Note (`05-Templates/client-note.md`)
```markdown
---
title: "Client: {{name}}"
date: {{date}}
tags: [client]
type: client
status: active
project: Lucavo-Design
---

# {{name}}

## Contact Info
- Phone: 
- Email: 
- Address: 

## Projects
- 

## Notes


## History

### {{date}}
- Initial contact
```

---

## 6. PLUGIN STRATEGY

### Core Obsidian Plugins to Enable (Built-in)
These are toggled on in Settings → Core Plugins:
- Daily Notes
- Templates
- Properties View
- Bookmarks
- Tags View
- Bases (database views)

### Community Plugins to Install
Priority order. These need community plugins enabled first (Settings → Community Plugins → Turn on).

| Plugin | Why | Install Method |
|--------|-----|----------------|
| **Obsidian Git** | Auto-sync vault to GitHub as backup | Marketplace |
| **Tasks** | Vault-wide task queries, due dates, recurring tasks | Marketplace |
| **Templater** | Advanced templating with dates, variables, scripts | Marketplace |
| **Calendar** | Calendar view for daily notes | Marketplace |
| **Dataview** | Query notes as a database using code blocks | Marketplace |
| **obsidian-claude-code-mcp** | MCP bridge for real-time Claude Code ↔ Obsidian | Marketplace |

### Claude Code Integration: kepano/obsidian-skills
Install via Claude Code's plugin system (NOT manual git clone):
```
/plugin marketplace add kepano/obsidian-skills
/plugin install obsidian@obsidian-skills
```

**Known issue (#10):** The `!` character in `obsidian-bases/SKILL.md` can cause Claude Code permission check failures. Workaround: after installation, edit the SKILL.md to replace backticked `!` with `<code>!</code>` or remove the backticks.

This gives Claude Code native understanding of:
- Obsidian Markdown (.md) — wikilinks, callouts, embeds, properties
- Obsidian Bases (.base) — database views with filters, formulas
- JSON Canvas (.canvas) — visual mapping

---

## 7. SYNC STRATEGY

### Primary: Obsidian Sync (already paid)
- Vincent already upgraded Sync to support multiple vaults
- Vault "Nico" syncs to M3 and mobile automatically
- No conflict with personal vault "Obsidian vault" (different vault name)
- Near-instant sync, handles conflicts automatically

### Backup: Git via obsidian-git plugin
- Vault is also a git repo pushed to GitHub (private)
- Auto-commit every 10 minutes
- Auto-pull on boot
- Provides version history and rollback capability
- Claude Code can interact with it natively via git commands

### How Both Work Together
- Obsidian Sync handles real-time cross-device sync (M1 → M3 → iPhone)
- Git handles versioning, backup, and programmatic access
- They don't conflict — Obsidian Sync ignores `.git/` and `.obsidian/` is configurable
- Add `.git/` and `node_modules/` to `.obsidian/sync-ignore` file

---

## 8. OBSIDIAN CLI REFERENCE (v1.12)

### Critical Gotchas (22.8% of commands silently fail)
These are the documented traps from community testing of 57 scenarios:

| Trap | Wrong Command | Correct Command | What Goes Wrong |
|------|--------------|-----------------|-----------------|
| Task scope | `tasks todo` | `tasks all todo` | Returns 0 results (scoped to "active file") |
| Tag scope | `tags counts` | `tags all counts` | Returns empty output |
| Property format | `properties format=json` | `properties format=tsv` | Returns YAML instead of JSON |
| Search format | `search query="x"` | `search query="x" format=json matches` | Returns plain text |
| Create opens GUI | `create name="x"` | Add `silent` flag | Opens Obsidian UI |
| Exit codes lie | Check `$?` | Parse stdout for `Error:` | Commands return 0 on failure |

### Key Requirements
- CLI requires Obsidian app to be running (communicates via IPC)
- Obsidian must be v1.12+ (Early Access, requires Catalyst License)
- CLI must be enabled in Settings → Command Line Interface → toggle ON
- New terminal window needed after enabling CLI (PATH update)

### Most Useful Commands for Nico
```bash
obsidian version                                    # Verify CLI works
obsidian vault                                      # Vault info
obsidian files list                                 # List all files
obsidian files total                                # File count
obsidian files read "path/to/note.md"               # Read note
obsidian files write "path/to/note.md" --content    # Write note
obsidian search content "keyword" format=json matches  # Search
obsidian tasks all todo                             # All open tasks
obsidian tasks all done                             # All completed tasks
obsidian daily                                      # Create/open daily note
obsidian templates list                             # List templates
obsidian templates apply "template-name"            # Apply template
obsidian properties read "path/to/note.md" format=tsv  # Read frontmatter
obsidian plugins list                               # List plugins
obsidian dev:eval "js code"                         # Execute JS in Obsidian
```

---

## 9. CLAUDE CODE PROMPT — THE AUTONOMOUS SETUP

Everything below this line is the prompt Vincent pastes into Claude Code on the M1. Claude Code executes it autonomously. Vincent performs 3 manual actions when prompted.

---

### ═══════════════════════════════════════════
### COPY EVERYTHING BELOW THIS LINE INTO CLAUDE CODE
### ═══════════════════════════════════════════

```
Set up Obsidian as Nico's second brain on this M1 MacBook. Execute all phases below autonomously. When you hit a step that requires my physical action, stop and tell me exactly what to do, then wait for me to confirm before continuing.

CONTEXT:
- I'm Vincent Imbriani, I run Lucavo Design (kitchen cabinets) and am starting an AI-native SaaS startup
- You are Nico, my AI Chief of Staff, running on this dedicated M1 MacBook Air
- The vault will be called "Nico" and located at ~/Nico/Vault/
- I already purchased a Catalyst License ($25) and upgraded Obsidian Sync for multiple vaults
- My personal vault on my M3 is called "Obsidian vault" — no conflicts
- Starting empty, no content to migrate
- This vault manages: business ops, SaaS development, research, daily notes/tasks

PHASE 1 — PRE-INSTALLATION (You do this, no human needed):

1. Install Obsidian:
   brew install --cask obsidian

2. Create the vault directory structure:
   mkdir -p ~/Nico/Vault/{00-Inbox,01-Projects,02-Areas,03-Resources,04-Archive,05-Templates,06-Daily,07-Canvas}
   mkdir -p ~/Nico/Vault/01-Projects/{Lucavo-Design,SaaS-Portal,Nico-Agent}
   mkdir -p ~/Nico/Vault/02-Areas/{Business-Ops,Clients,Finance,Marketing,Development}
   mkdir -p ~/Nico/Vault/03-Resources/{Research,Tutorials,Reference,Vendors,Attachments}
   mkdir -p ~/Nico/Vault/06-Daily/2026

3. Create CLAUDE.md at ~/Nico/Vault/CLAUDE.md with this content:

---START CLAUDE.MD---
# Nico — Obsidian Vault Context

## Identity
You are Nico, the AI Chief of Staff for Vincent Imbriani's AI-native business.
This vault is your second brain — the persistent knowledge layer for both
Lucavo Design (cabinet business) and the SaaS startup.

## Vault Structure
- 00-Inbox/: Unsorted captures, quick notes, web clippings
- 01-Projects/: Active projects with status tracking
  - Lucavo-Design/: Cabinet business operations
  - SaaS-Portal/: Next.js + Supabase client portal
  - Nico-Agent/: Agent system infrastructure
- 02-Areas/: Ongoing areas of responsibility
  - Business-Ops, Clients, Finance, Marketing, Development
- 03-Resources/: Reference material, research, vendor info
- 04-Archive/: Completed or inactive items
- 05-Templates/: Note templates for consistent formatting
- 06-Daily/: Daily notes organized by year
- 07-Canvas/: Visual maps and relationship diagrams

## Conventions
- Frontmatter required on all notes: title, date, tags, status, type
- Wikilinks for internal connections: [[note-name]]
- Tags use kebab-case: #project-status, #cabinet-specs
- File names use kebab-case: my-note-title.md
- Status values: draft, active, review, complete, archived
- Type values: note, meeting, research, decision, task, daily, project, client

## Frontmatter Schema
title: "Note Title"
date: YYYY-MM-DD
tags: [tag1, tag2]
status: draft | active | review | complete | archived
type: note | meeting | research | decision | task | daily | project | client
project: project-name (optional)
priority: high | medium | low (optional)
due: YYYY-MM-DD (optional)
assignee: "Vincent" (optional)

## Git Workflow
- This vault is a git repo synced to GitHub as backup
- Branch as nico/{task-name}, never push to main
- Commit frequently with clear messages
- Also synced via Obsidian Sync for mobile access

## CLI Gotchas (v1.12)
- Always use "tasks all todo" not "tasks todo" (scope issue)
- Always use "format=tsv" for properties, not "format=json"
- Always add "silent" flag when creating notes headlessly
- Always use "format=json matches" for search results
- Parse stdout for "Error:" — exit codes lie (return 0 on failure)
- CLI requires Obsidian app to be running

## Key Principles
- Capture first, organize later (Inbox → proper location)
- One idea per note (atomic notes)
- Link over folder hierarchy (discovery through connections)
- Templates ensure consistency
- Daily notes are the entry point for each day
---END CLAUDE.MD---

4. Create these 6 template files in 05-Templates/:

   daily-note.md:
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
   - [ ] Set priority tasks for today
   ## Tasks
   - [ ] 
   ## Notes
   ## Decisions Made
   ## End of Day
   - [ ] Update project statuses
   - [ ] Move captures from Inbox
   - [ ] Commit vault changes

   project-note.md:
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
   ## Status Updates
   ### {{date}}

   meeting-note.md:
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

   research-note.md:
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

   decision-note.md:
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
   ## Options Considered
   1. 
   2. 
   3. 
   ## Decision
   ## Consequences

   client-note.md:
   ---
   title: "Client: {{name}}"
   date: {{date}}
   tags: [client]
   type: client
   status: active
   project: Lucavo-Design
   ---
   # {{name}}
   ## Contact Info
   - Phone: 
   - Email: 
   - Address: 
   ## Projects
   ## Notes
   ## History
   ### {{date}}
   - Initial contact

5. Create seed notes:

   00-Home.md (at vault root):
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
   ## Recent
   Check [[06-Daily/2026/|2026 Daily Notes]]

   01-Projects/Lucavo-Design/index.md:
   ---
   title: "Project: Lucavo Design"
   date: 2026-02-15
   tags: [project, lucavo, cabinets]
   type: project
   status: active
   project: Lucavo-Design
   ---
   # Lucavo Design — Cabinet Business
   ## Overview
   Kitchen cabinet design, fabrication, and installation business owned by Vincent Imbriani. Currently serves as the test environment for the SaaS client portal.
   ## Key Areas
   - Client project management
   - PDF drawing storage and search
   - Installation scheduling
   - Vendor/supplier relationships
   - Quoting and estimation
   ## Related
   - [[01-Projects/SaaS-Portal/index|SaaS Portal]] — The software being built for this business
   - [[02-Areas/Clients/index|Client Notes]]

   01-Projects/SaaS-Portal/index.md:
   ---
   title: "Project: SaaS Client Portal"
   date: 2026-02-15
   tags: [project, saas, development]
   type: project
   status: active
   project: SaaS-Portal
   ---
   # SaaS Client Portal
   ## Overview
   AI-native client portal for kitchen cabinet companies. Built with Next.js + Supabase. Strategy: build for Lucavo Design first, then sell as SaaS.
   ## Tech Stack
   - Frontend: Next.js
   - Backend: Supabase (auth, database, storage)
   - Hosting: TBD
   - AI: Claude API for document search/analysis
   ## Key Features (Planned)
   - [ ] PDF drawing upload and storage
   - [ ] AI-powered PDF search across drawings
   - [ ] Client authentication and portal access
   - [ ] Project status tracking
   - [ ] Client communication tools
   ## Related
   - [[01-Projects/Lucavo-Design/index|Lucavo Design]] — First customer / test environment
   - [[02-Areas/Development/index|Development Area]]

   01-Projects/Nico-Agent/index.md:
   ---
   title: "Project: Nico Agent System"
   date: 2026-02-15
   tags: [project, nico, agent, infrastructure]
   type: project
   status: active
   project: Nico-Agent
   ---
   # Nico Agent System
   ## Overview
   AI Chief of Staff running on a dedicated M1 MacBook Air. Manages both Lucavo Design operations and SaaS development. Goal: autonomous operation with mobile communication.
   ## Infrastructure
   - Hardware: M1 MacBook Air (nico-agent)
   - Primary tool: Claude Code
   - Memory: Letta/Memo (agent-5a9b0e69-1f30-476d-a89a-30c8e21c9668)
   - Knowledge: This Obsidian vault
   - Networking: Tailscale (IP: 100.87.182.78)
   - Sync: Obsidian Sync + Git backup
   ## Setup Log
   - 2026-02-14: Factory reset, Homebrew, Git, Tailscale, Claude Code, Letta installed
   - 2026-02-15: Obsidian vault setup (this vault)
   ## Remaining Setup
   - [x] GitHub account (lifeos.nico@gmail.com) — completed
   - [ ] iMessage on M1
   - [ ] Mobile communication workflow (Telegram/Slack/iMessage bot)
   - [ ] MCP server configuration
   ## Related
   - [[01-Projects/SaaS-Portal/index|SaaS Portal]] — Primary development project
   - [[02-Areas/Development/index|Development Area]]

   02-Areas/Business-Ops/index.md:
   ---
   title: "Area: Business Operations"
   date: 2026-02-15
   tags: [area, operations]
   type: note
   status: active
   ---
   # Business Operations
   Day-to-day operational notes for Lucavo Design.
   ## Sub-areas
   - Scheduling and installs
   - Vendor management
   - Inventory and materials
   - Standard operating procedures

   02-Areas/Development/index.md:
   ---
   title: "Area: Development"
   date: 2026-02-15
   tags: [area, development, tech]
   type: note
   status: active
   ---
   # Development
   Technical development area for both SaaS portal and Nico agent system.
   ## Tech Stack
   - Next.js + Supabase (SaaS Portal)
   - Claude Code (agent development)
   - Obsidian CLI v1.12 (knowledge management)
   - Letta (persistent memory)
   - Tailscale (networking)
   ## Standards
   - Git: branch as nico/{task-name}, never push to main
   - Code: commit frequently with clear messages

   02-Areas/Clients/index.md:
   ---
   title: "Area: Clients"
   date: 2026-02-15
   tags: [area, clients]
   type: note
   status: active
   ---
   # Clients
   Client management for Lucavo Design. Each client gets their own note using the client-note template.

6. Create .gitignore at vault root:
   .obsidian/workspace.json
   .obsidian/workspace-mobile.json
   .obsidian/core-plugins-migration.json
   .trash/
   .DS_Store

7. Create sync-ignore file for Obsidian Sync at .obsidian/sync-ignore (Claude Code: create the .obsidian directory first since Obsidian hasn't run yet):
   .git
   .git/
   node_modules

8. Initialize git repo:
   cd ~/Nico/Vault
   git init
   git add .
   git commit -m "Initial vault structure — Nico second brain"

STOP HERE. Tell me: "Phase 1 complete. I need you to do 3 things now." Then list:
1. Open Obsidian (it was just installed via Homebrew)
2. When the vault picker appears, click "Open folder as vault" and select ~/Nico/Vault/
3. Sign into your Obsidian account (Settings → About), enable Insider Builds to get v1.12+, then go to Settings → Command Line Interface → toggle ON "Register CLI"
4. Close and reopen Terminal, then run: obsidian version
5. Tell me when CLI is working

PHASE 2 — POST-CLI (After I confirm CLI works):

1. Verify CLI access:
   obsidian version
   obsidian vault
   obsidian files total

2. Install kepano/obsidian-skills for Claude Code integration:
   Run: /plugin marketplace add kepano/obsidian-skills
   Run: /plugin install obsidian@obsidian-skills
   If that fails, fall back to manual install:
   git clone https://github.com/kepano/obsidian-skills.git /tmp/obsidian-skills
   mkdir -p ~/Nico/Vault/.claude/skills
   cp -r /tmp/obsidian-skills/skills/* ~/Nico/Vault/.claude/skills/
   rm -rf /tmp/obsidian-skills
   
   KNOWN BUG: Check .claude/skills/obsidian-bases/SKILL.md for backticked ! characters that cause permission failures. Replace `!` with <code>!</code> if found.

3. Enable community plugins. Tell me: "I need you to enable community plugins in Obsidian. Go to Settings → Community Plugins → Turn on community plugins. Then search and install these 6 plugins from the marketplace: Obsidian Git, Tasks, Templater, Calendar, Dataview, obsidian-claude-code-mcp. Enable all of them after installing."

   Wait for my confirmation.

4. After plugins are installed, configure Obsidian Git plugin:
   mkdir -p ~/Nico/Vault/.obsidian/plugins/obsidian-git
   Write data.json with:
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

5. Configure core Obsidian settings:
   Write ~/Nico/Vault/.obsidian/app.json:
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

6. Configure daily notes (core plugin config):
   Write daily-notes config to use 06-Daily/2026/{{date}} format with the daily-note template.

7. Set up Obsidian Sync. Tell me: "Enable Obsidian Sync for this vault. Go to Settings → Sync → Log in to your Obsidian account → Turn on sync for the Nico vault. Your personal vault 'Obsidian vault' won't be affected."

PHASE 3 — VERIFICATION:

1. Run smoke tests:
   - ls ~/Nico/Vault/0* (vault structure exists)
   - cd ~/Nico/Vault && git status (git initialized)
   - cat ~/Nico/Vault/CLAUDE.md | head -5 (CLAUDE.md exists)
   - ls ~/Nico/Vault/05-Templates/ (templates exist)
   - obsidian version (CLI works)
   - obsidian files total (reports correct file count)
   - obsidian tasks all todo (returns task list from seed notes)
   - obsidian search content "Lucavo" format=json matches (search works)

2. Create today's daily note:
   obsidian daily (or create via filesystem if CLI daily note isn't configured yet)
   Add content: "Vault setup complete. First day of Nico's second brain."

3. Git commit everything:
   cd ~/Nico/Vault
   git add .
   git commit -m "Complete vault setup — plugins, templates, seed notes, CLI verified"

4. Update the main ~/Nico/CLAUDE.md to add:
   ## Obsidian Vault
   - Location: ~/Nico/Vault/
   - Vault name: Nico
   - Sync: Obsidian Sync (mobile) + Git (backup)
   - CLI: Obsidian v1.12+ with official CLI
   - Skills: kepano/obsidian-skills installed
   - Access: Direct filesystem + CLI + MCP (obsidian-claude-code-mcp)

5. Report results: Tell me what succeeded, what failed, and what needs manual attention.
```

### ═══════════════════════════════════════════
### END OF CLAUDE CODE PROMPT
### ═══════════════════════════════════════════

---

## 10. VINCENT'S MANUAL ACTIONS SUMMARY

You will be prompted exactly 3 times during the autonomous setup:

| # | When | What You Do | Time |
|---|------|-------------|------|
| 1 | After Phase 1 | Open Obsidian → select vault folder → sign in → enable Insider Builds → enable CLI | 3 min |
| 2 | During Phase 2 | Enable community plugins → install 6 plugins from marketplace | 2 min |
| 3 | During Phase 2 | Enable Obsidian Sync for the Nico vault | 1 min |

**Total Vincent time: ~6 minutes across 3 interactions.**

---

## 11. WHAT HAPPENS AFTER SETUP

Once the vault is operational, Nico (Claude Code) can immediately:
- Create and manage daily notes
- Track tasks across all projects with `obsidian tasks all todo`
- Search the entire vault: `obsidian search content "keyword" format=json matches`
- Create meeting notes, research notes, decision logs using templates
- Manage project status via frontmatter updates
- Auto-commit vault changes every 10 minutes via obsidian-git
- Access vault through MCP for real-time structured operations

**Next priorities after vault setup:**
1. Push vault to GitHub as private repo: `gh repo create nico-vault --private --source=. --push`
2. Set up iMessage on M1 for mobile communication
3. Configure MCP servers for enhanced tool access
4. Begin actual SaaS development work in the vault
