# NICO AGENT OS — FINAL SETUP PLAN
## The Definitive Document — February 15, 2026

**How to use this document:** Phases marked 🤖 are fully autonomous — paste into Claude Code. Phases marked 👤 require Vincent at the keyboard. Phases marked 🤝 are mixed.

---

## CURRENT STATE

### ✅ Already Done
- M1 factory reset + fresh macOS (Feb 14)
- Apple ID: lifeos.nico@gmail.com (on M1, iCloud Keychain OFF)
- macOS hardened: Location OFF, Siri OFF, Analytics OFF, FileVault ON, Apple Intelligence ON
- Homebrew, Git, GitHub CLI installed
- GitHub account: lifeos.nico@gmail.com + `gh auth login` completed
- Tailscale: M1 (100.87.182.78 "nico-agent") ↔ M3 (100.72.130.40 "macbook-pro")
- SSH: M3 → M1 confirmed working
- Claude Code installed on M1
- Letta headless installed (agent ID: agent-5a9b0e69-1f30-476d-a89a-30c8e21c9668)
- Workspace: ~/Nico/ with Projects, Logs, Memory subdirectories
- Obsidian Catalyst License purchased ($25)
- Obsidian Sync upgraded (multi-vault plan)

### ❌ Not Yet Done
- 1Password account + CLI (no account exists yet)
- iMessage on M1 (not signed in)
- Tailscale on iPhone (never installed)
- Obsidian install + vault + Sync + CLI
- Community plugins
- MCP server configuration
- CLAUDE.md persona file on M1
- Mobile communication workflow

---

## PHASE 0 — 1PASSWORD SETUP
**👤 Vincent — ~8 min | Dependency: everything that touches secrets**

### Step 1: Create 1Password Account
1. Go to https://1password.com on M1 Safari
2. Click "Try Free" → choose Individual plan ($2.99/mo after trial)
3. Sign up with lifeos.nico@gmail.com
4. Save your Secret Key somewhere safe (you'll need it for CLI signin)
5. Download and install the 1Password desktop app if prompted

### Step 2: Install 1Password CLI on M1
Open Terminal on the M1:
```bash
brew install 1password-cli
```

### Step 3: Sign In to CLI
```bash
op signin
```
Follow the prompts — it'll ask for your 1password.com account URL, email, Secret Key, and master password.

### Step 4: Verify
```bash
op vault list
```
Should show your Personal vault.

### Step 5: Store Secrets
```bash
# Store Anthropic API key (get from console.anthropic.com)
op item create --category=login --title="Anthropic API" --url="https://console.anthropic.com" username=lifeos.nico@gmail.com password=YOUR_API_KEY

# Store GitHub token (if needed beyond SSH)
op item create --category=login --title="GitHub" --url="https://github.com" username=lifeos.nico password=YOUR_TOKEN
```

**You can add more secrets later as needed (Supabase, etc.)**

### Step 6: Test from Terminal
```bash
# This is how Claude Code will access secrets:
op read "op://Personal/Anthropic API/password"
```
Should print your API key. If it works, 1Password is ready.

---

## PHASE 1 — OBSIDIAN AUTONOMOUS PRE-INSTALL
**🤖 Claude Code — ~14 min | No human needed**

**Paste this entire block into Claude Code on the M1:**

```
You are Nico. Execute the following setup steps autonomously. Do NOT ask for confirmation — just execute each step and report results. If something fails, try to fix it, and only stop if you genuinely can't proceed.

STEP 1: Install Obsidian
brew install --cask obsidian

STEP 2: Create vault directory structure
mkdir -p ~/Nico/Vault/{00-Inbox,01-Projects,02-Areas,03-Resources,04-Archive,05-Templates,06-Daily,07-Canvas}
mkdir -p ~/Nico/Vault/01-Projects/{Lucavo-Design,SaaS-Portal,Nico-Agent}
mkdir -p ~/Nico/Vault/02-Areas/{Business-Ops,Clients,Finance,Marketing,Development}
mkdir -p ~/Nico/Vault/03-Resources/{Research,Tutorials,Reference,Vendors,Attachments}
mkdir -p ~/Nico/Vault/06-Daily/2026

STEP 3: Create .obsidian config directory
mkdir -p ~/Nico/Vault/.obsidian/plugins
mkdir -p ~/Nico/Vault/.obsidian/themes
mkdir -p ~/Nico/Vault/.obsidian/snippets

STEP 4: Configure Obsidian settings (disable restricted mode, enable community plugins)
cat > ~/Nico/Vault/.obsidian/community-plugins.json << 'PLUGINS_EOF'
[
  "templater-obsidian",
  "dataview",
  "obsidian-git",
  "periodic-notes",
  "calendar"
]
PLUGINS_EOF

cat > ~/Nico/Vault/.obsidian/app.json << 'APP_EOF'
{
  "vimMode": false,
  "showLineNumber": true,
  "spellcheck": true,
  "strictLineBreaks": false,
  "readableLineLength": true,
  "livePreview": true,
  "defaultViewMode": "source",
  "showFrontmatter": true,
  "foldHeading": true,
  "foldIndent": true,
  "newLinkFormat": "shortest",
  "useMarkdownLinks": false,
  "promptDelete": false,
  "alwaysUpdateLinks": true,
  "newFileLocation": "folder",
  "newFileFolderPath": "00-Inbox",
  "attachmentFolderPath": "03-Resources/Attachments"
}
APP_EOF

cat > ~/Nico/Vault/.obsidian/appearance.json << 'APPEAR_EOF'
{
  "accentColor": "",
  "interfaceFontFamily": "",
  "textFontFamily": "",
  "monospaceFontFamily": "",
  "baseFontSize": 16,
  "enabledCssSnippets": []
}
APPEAR_EOF

cat > ~/Nico/Vault/.obsidian/core-plugins.json << 'CORE_EOF'
[
  "file-explorer",
  "global-search",
  "switcher",
  "graph",
  "backlink",
  "outgoing-link",
  "tag-pane",
  "properties",
  "page-preview",
  "daily-notes",
  "templates",
  "note-composer",
  "command-palette",
  "editor-status",
  "bookmarks",
  "outline",
  "word-count",
  "file-recovery"
]
CORE_EOF

STEP 5: Download and install community plugins via filesystem
For each plugin, download the latest release from GitHub and place the files in .obsidian/plugins/<plugin-id>/

Plugin list:
1. templater-obsidian — https://github.com/SilentVoid13/Templater/releases/latest
   Files needed: main.js, manifest.json, styles.css (if exists)
   Target: ~/Nico/Vault/.obsidian/plugins/templater-obsidian/

2. dataview — https://github.com/blacksmithgu/obsidian-dataview/releases/latest
   Target: ~/Nico/Vault/.obsidian/plugins/dataview/

3. obsidian-git — https://github.com/Vinzent03/obsidian-git/releases/latest
   Target: ~/Nico/Vault/.obsidian/plugins/obsidian-git/

4. periodic-notes — https://github.com/liamcain/obsidian-periodic-notes/releases/latest
   Target: ~/Nico/Vault/.obsidian/plugins/periodic-notes/

5. calendar — https://github.com/liamcain/obsidian-calendar-plugin/releases/latest
   Target: ~/Nico/Vault/.obsidian/plugins/calendar/

For each plugin:
- Use curl or wget to download main.js, manifest.json, and styles.css from the latest GitHub release
- The download URL pattern is: https://github.com/{owner}/{repo}/releases/latest/download/{filename}
- Create the plugin directory and place files there
- If a download fails, note it and continue with the others

STEP 6: Create CLAUDE.md at vault root
Create ~/Nico/Vault/CLAUDE.md with this content:

# Nico — Obsidian Vault Context

## Identity
You are Nico, the AI Chief of Staff for Vincent Imbriani's AI-native business.
This vault is your second brain — the persistent knowledge layer for both
Lucavo Design (cabinet business) and the SaaS startup.

## Vault Structure
- 00-Inbox/: Unsorted captures, quick notes
- 01-Projects/: Active projects (Lucavo-Design, SaaS-Portal, Nico-Agent)
- 02-Areas/: Ongoing responsibilities (Business-Ops, Clients, Finance, Marketing, Development)
- 03-Resources/: Reference material, research, vendors
- 04-Archive/: Completed or inactive items
- 05-Templates/: Note templates
- 06-Daily/: Daily notes by year
- 07-Canvas/: Visual maps

## Conventions
- Frontmatter required on all notes: title, date, tags, status, type
- Wikilinks for internal connections: [[note-name]]
- Tags use kebab-case: #project-status
- File names use kebab-case: my-note-title.md
- Status values: draft, active, review, complete, archived
- Type values: note, meeting, research, decision, task, daily, project, client

## Git Workflow
- Branch as nico/{task-name}, never push to main
- Commit frequently with clear messages

## CLI Gotchas (v1.12)
- Always use "tasks all todo" not "tasks todo"
- Always use "format=tsv" for properties
- Always add "silent" flag for headless note creation
- Parse stdout for "Error:" — exit codes lie
- CLI requires Obsidian app to be running

## Secrets
Access via 1Password CLI:
- op read "op://Personal/Anthropic API/password"
- NEVER write secrets to files or commit them

STEP 7: Create templates

Create ~/Nico/Vault/05-Templates/daily-note.md:
---
title: "{{date:YYYY-MM-DD}} Daily Note"
date: {{date:YYYY-MM-DD}}
tags: [daily]
type: daily
status: active
---
# {{date:dddd, MMMM D, YYYY}}

## Focus Today
- 

## Tasks
- [ ] 

## Notes


## End of Day Summary


Create ~/Nico/Vault/05-Templates/project-note.md:
---
title: ""
date: {{date:YYYY-MM-DD}}
tags: [project]
type: project
status: draft
priority: medium
---
# {{title}}

## Overview


## Objectives
- [ ] 

## Notes


## Related
- 

Create ~/Nico/Vault/05-Templates/meeting-note.md:
---
title: "Meeting: "
date: {{date:YYYY-MM-DD}}
tags: [meeting]
type: meeting
status: active
---
# Meeting: {{title}}
**Date:** {{date:YYYY-MM-DD}}
**Attendees:** 

## Agenda


## Notes


## Action Items
- [ ] 

Create ~/Nico/Vault/05-Templates/decision-note.md:
---
title: "Decision: "
date: {{date:YYYY-MM-DD}}
tags: [decision]
type: decision
status: active
---
# Decision: {{title}}

## Context


## Options Considered
1. 
2. 

## Decision


## Rationale


Create ~/Nico/Vault/05-Templates/client-note.md:
---
title: "Client: "
date: {{date:YYYY-MM-DD}}
tags: [client]
type: client
status: active
---
# Client: {{title}}

## Contact Info


## Projects


## Notes


STEP 8: Create seed notes

Create ~/Nico/Vault/01-Projects/Lucavo-Design/index.md:
---
title: "Project: Lucavo Design"
date: 2026-02-15
tags: [project, lucavo, cabinets]
type: project
status: active
---
# Lucavo Design
Kitchen cabinet business. Currently serves as the testing ground for the SaaS client portal.

## Key Areas
- Client project management
- PDF drawing storage and search
- Installation scheduling
- Vendor/supplier relationships
- Quoting and estimation

## Related
- [[SaaS-Portal/index|SaaS Portal]]

Create ~/Nico/Vault/01-Projects/SaaS-Portal/index.md:
---
title: "Project: SaaS Client Portal"
date: 2026-02-15
tags: [project, saas, development]
type: project
status: active
---
# SaaS Client Portal
AI-native client portal for kitchen cabinet companies. Built with Next.js + Supabase.
Strategy: build for Lucavo Design first, then sell as SaaS.

## Tech Stack
- Frontend: Next.js
- Backend: Supabase (auth, database, storage)
- AI: Claude API for document search/analysis

## Key Features (Planned)
- [ ] PDF drawing upload and storage
- [ ] AI-powered PDF search across drawings
- [ ] Client authentication and portal access
- [ ] Project status tracking

Create ~/Nico/Vault/01-Projects/Nico-Agent/index.md:
---
title: "Project: Nico Agent System"
date: 2026-02-15
tags: [project, nico, agent, infrastructure]
type: project
status: active
---
# Nico Agent System
AI Chief of Staff running on dedicated M1 MacBook Air.

## Infrastructure
- Hardware: M1 MacBook Air (nico-agent)
- Primary tool: Claude Code (YOLO mode)
- Memory: Letta + CLAUDE.md + Obsidian
- Knowledge: This vault
- Networking: Tailscale (100.87.182.78)
- Sync: Obsidian Sync + Git backup
- Secrets: 1Password CLI

## Setup Log
- 2026-02-14: Factory reset, core tools installed, Tailscale connected
- 2026-02-15: Obsidian vault created, plugins installed

STEP 9: Initialize git repo for vault backup
cd ~/Nico/Vault
git init
git checkout -b main

Create ~/Nico/Vault/.gitignore:
.obsidian/workspace.json
.obsidian/workspace-mobile.json
.obsidian/plugins/obsidian-git/data.json
.trash/
.DS_Store

git add -A
git commit -m "Initial vault setup: structure, templates, seed notes, plugins"

Then create a private GitHub repo and push:
gh repo create nico-vault --private --source=. --push

STEP 10: Download Obsidian CLI skill for Claude Code
mkdir -p ~/Nico/.claude/skills/obsidian-cli
curl -o ~/Nico/.claude/skills/obsidian-cli/SKILL.md \
  https://raw.githubusercontent.com/jackal092927/obsidian-official-cli-skills/main/plugins/obsidian-cli/skills/obsidian-cli/SKILL.md 2>/dev/null || echo "Skill file not found — will configure manually"

STEP 11: Report results
List what succeeded and what failed. Don't stop for failures — note them and continue.
```

---

## PHASE 2 — VINCENT'S ONE MANUAL SESSION
**👤 Vincent — ~5 min | Do this after Phase 1 completes**

### Step 1: Open Obsidian
- Launch Obsidian from Applications
- It will show a vault picker. Click "Open" (not "Create")
- Navigate to ~/Nico/Vault/ and select it

### Step 2: Sign In + Enable Early Access
- Go to Settings (gear icon bottom-left)
- Click "About" in the left sidebar
- Click "Log in" → sign in with your Obsidian account
- Toggle ON "Receive insider builds"
- Click "Check for updates" → install v1.12+
- Obsidian will restart

### Step 3: Enable CLI
- Go to Settings → "Command line interface" (in left sidebar)
- Toggle ON "Register CLI"
- Close Obsidian completely (Cmd+Q, not just close window)
- Open a new Terminal window

### Step 4: Verify CLI
```bash
obsidian version
```
Should return v1.12.x. If `obsidian: command not found`, try opening a new Terminal window.

### Step 5: Enable Obsidian Sync for Nico Vault
- Reopen Obsidian
- Go to Settings → "Sync" (in left sidebar, under Core plugins)
- Enable it if not enabled
- Click "Choose" or "Create new vault" → name it "Nico"
- Wait for initial sync to complete
- Confirm: your iPhone Obsidian app should now show the Nico vault available

### Step 6: Verify Plugins Loaded
- Go to Settings → "Community plugins"
- If Restricted Mode is ON, toggle it OFF (click "Turn on community plugins")
- You should see the pre-installed plugins in the list
- Enable any that aren't already enabled: Templater, Dataview, Obsidian Git, Periodic Notes, Calendar
- If any plugins failed to install via filesystem, search for them in "Browse" and install manually

### Step 7: Tell Claude Code
Go back to Claude Code and type:
```
Obsidian is set up. CLI works. Sync enabled. Plugins loaded. Continue with Phase 3.
```

---

## PHASE 3 — POST-LAUNCH AUTONOMOUS
**🤖 Claude Code — ~10 min | No human needed**

**Paste into Claude Code:**

```
Obsidian is running with CLI enabled. Execute these verification and configuration steps:

1. Verify CLI:
   obsidian version
   obsidian vault

2. Test file operations:
   obsidian files list | head -20
   obsidian files read "01-Projects/Nico-Agent/index.md"

3. Create today's daily note:
   Create the file ~/Nico/Vault/06-Daily/2026/2026-02-XX.md (use today's actual date) using the daily note template format. Use the CLI if working, otherwise create via filesystem.

4. Test search:
   obsidian search content query="SaaS" format=json matches

5. Test tasks:
   obsidian tasks all todo

6. Git commit the daily note:
   cd ~/Nico/Vault
   git add -A
   git commit -m "First daily note created"
   git push

7. Configure Obsidian Git plugin settings:
   Create/update ~/Nico/Vault/.obsidian/plugins/obsidian-git/data.json:
   {
     "autoSaveInterval": 10,
     "autoPullInterval": 10,
     "syncMethod": "merge",
     "commitMessage": "vault backup: {{date}}",
     "autoCommitMessage": "vault backup: {{date}}",
     "listChangedFilesInMessageBody": true
   }

8. Report what worked and what didn't.
```

---

## PHASE 4 — COMMUNICATION SETUP
**👤 Vincent — ~5 min**

### Step 1: iMessage on M1
1. Open System Settings on M1
2. Go to Messages (or search "Messages" in Settings)
3. Sign in with lifeos.nico@gmail.com Apple ID
4. Enable iMessage
5. Open the Messages app to confirm it's working

### Step 2: Tailscale on iPhone
1. Open App Store on your iPhone
2. Search "Tailscale" → install
3. Open Tailscale → sign in with the SAME account you used on M1/M3
4. Your iPhone is now on the tailnet

### Step 3: SSH App on iPhone
1. Install "Termius" from App Store (free tier works)
2. Add a new host: IP = 100.87.182.78, username = lifeos.nico, auth = password
3. Connect → you should get a shell on the M1
4. Type `claude` → you're now talking to Claude Code from your phone

### Step 4: Test iMessage from Claude Code
In Claude Code on the M1 (from phone or M3), run:
```
osascript -e 'tell application "Messages" to send "Nico is online." to buddy "YOUR_IPHONE_NUMBER_OR_APPLE_ID"'
```
If you receive the message on your iPhone, communication is working.

---

## PHASE 5 — GO BUILD
**🤖 Claude Code | The actual work begins**

With everything connected, the first real task:

```
You are Nico. Your first development task: scaffold the SaaS client portal.

Tech stack: Next.js + Supabase
Location: ~/Nico/Projects/cabinet-portal/
Git: Create branch nico/scaffold-portal

Features to scaffold:
1. Next.js app with App Router
2. Supabase client configuration
3. Basic auth pages (login/signup)
4. Dashboard layout
5. PDF upload component placeholder
6. Supabase schema: users, projects, documents tables

After completing:
1. Commit all work
2. Push branch to GitHub
3. Create a daily note in the vault summarizing what was built
4. Update ~/Nico/Vault/01-Projects/SaaS-Portal/index.md with progress
```

---

## EXECUTION ORDER SUMMARY

| Phase | Who | What | Time |
|-------|-----|------|------|
| 0 | 👤 Vincent | Create 1Password account + install CLI + store secrets | 8 min |
| 1 | 🤖 Claude Code | Install Obsidian, build vault, plugins, templates, git | 14 min |
| 2 | 👤 Vincent | Open Obsidian, sign in, enable CLI + Sync, verify plugins | 5 min |
| 3 | 🤖 Claude Code | Verify CLI, test operations, configure git plugin | 10 min |
| 4 | 👤 Vincent | iMessage signin, Tailscale on iPhone, test SSH from phone | 5 min |
| 5 | 🤖 Claude Code | Scaffold the SaaS client portal | Ongoing |
| **Total setup** | | | **~42 min** |

---

## DECISIONS REFERENCE (All Final — Do Not Re-Ask)

| Decision | Answer |
|----------|--------|
| Agent name | Nico |
| Apple ID | lifeos.nico@gmail.com |
| GitHub account | lifeos.nico@gmail.com |
| Framework | Claude Code (YOLO mode) |
| Memory | Letta + CLAUDE.md + Obsidian |
| Secrets | 1Password CLI ($3/mo, new account needed) |
| Vault name | Nico |
| Vault location | ~/Nico/Vault/ |
| Vault structure | PARA flat (00-07 folders) |
| Content | Empty, no migration |
| Primary sync | Obsidian Sync (paid, multi-vault) |
| Backup sync | Git (private GitHub repo) |
| Catalyst | Purchased |
| Sync tier | Upgraded for multi-vault |
| SaaS stack | Next.js + Supabase |
| First task | Scaffold SaaS client portal |
| Git workflow | nico/{task-name}, never push main |
| Mobile | iPhone, Tailscale + Termius for SSH |
| Communication | iMessage first, then Telegram/Slack |
| Budget | $200-330/mo |
| Pushback | Yes, genuine, always |
