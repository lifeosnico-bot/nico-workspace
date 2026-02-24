---
title: "Obsidian CLI Capability Audit"
type: reference
status: active
created: 2026-02-15
modified: 2026-02-23
source: chat
tags: [obsidian, cli, reference]
---

# Obsidian CLI + Claude Code: Complete Capability Audit
### Your M1 "Claude Machine" — Second Brain Setup Guide
**Date:** February 15, 2026 | **Obsidian Version:** 1.12.x (Early Access)

---

## EXECUTIVE SUMMARY

Obsidian released its **official CLI on February 10, 2026** as part of v1.12 (Early Access). Their tagline: *"Anything you can do in Obsidian, you can do from the command line."* This is a game-changer for your M1 Claude Code YOLO setup — it means Claude Code can now interact with Obsidian's internal features (templates, tasks, plugins, JavaScript execution) that were previously GUI-only.

Combined with MCP integrations and Claude Code's filesystem access, you can build a fully AI-operated second brain for research, content, tasks, projects, and calendars.

**What you need to get started:**
- Obsidian v1.12+ (requires **Catalyst License — $25 one-time**, currently Early Access)
- Claude Code running in YOLO mode on the M1
- MCP plugin(s) for real-time Claude ↔ Obsidian communication
- Key community plugins for task/calendar/project management

---

## PART 1: OFFICIAL OBSIDIAN CLI (v1.12) — WHAT IT CAN DO

The official CLI ships with **100+ commands** across 15 command categories. Here's the full breakdown:

### 1.1 All CLI Command Categories

| Command Group | Description |
|---|---|
| `obsidian bookmarks` | Manage bookmarks |
| `obsidian daily` | Create/open daily notes |
| `obsidian dev` | Developer tools including **JavaScript execution** (`dev:eval`) |
| `obsidian files` | List, read, write, create, delete files in the vault |
| `obsidian links` | Manage internal/external links |
| `obsidian plugins` | List, enable, disable, install plugins |
| `obsidian properties` | Read/set YAML frontmatter metadata |
| `obsidian search` | Full-text search and path search |
| `obsidian sync` | Obsidian Sync operations |
| `obsidian tags` | List, count, and manage tags |
| `obsidian tasks` | Query and manage checkbox tasks vault-wide |
| `obsidian templates` | List and apply templates |
| `obsidian themes` | Manage themes |
| `obsidian vault` | Display vault info (name, path, file/folder counts) |
| `obsidian version` | Display version info |

### 1.2 What Claude Code CAN Do via the CLI

**File Operations (Full CRUD)**
- ✅ List all files in the vault (`files list`)
- ✅ Get total file count (`files total`)
- ✅ Read any note's content (`files read`)
- ✅ Write/create new notes with content (`files write`)
- ✅ Delete files
- ✅ Create notes silently (without opening the Obsidian GUI) — **requires `silent` flag**

**Search**
- ✅ Full-text content search (`search content`)
- ✅ Path-based search (`search path`)
- ✅ JSON-formatted search results for programmatic parsing — **requires `format=json matches`**

**Daily Notes**
- ✅ Create/open daily notes (`daily`)
- ✅ Use with templates for consistent daily note structure

**Task Management**
- ✅ Query all tasks across the entire vault (`tasks all todo`)
- ✅ Find pending/completed tasks (`tasks all pending`, `tasks all done`)
- ✅ Batch operations on checkboxes

**Tags**
- ✅ List all tags vault-wide (`tags all`)
- ✅ Count tag usage (`tags all counts`)
- ✅ Useful for content categorization and organization

**Properties / Frontmatter**
- ✅ Read YAML frontmatter from any note (`properties read`)
- ✅ Set/update frontmatter properties (`properties set`)
- ✅ TSV format for reliable structured output — **use `format=tsv`, NOT `format=json`**

**Templates**
- ✅ List available templates (`templates list`)
- ✅ Apply templates to notes (`templates apply`)
- ✅ This was previously GUI-only — huge unlock for automation

**Plugin Management**
- ✅ List installed plugins (`plugins list`)
- ✅ Get plugin versions (`plugins versions`)
- ✅ Enable/disable plugins programmatically

**Developer Tools**
- ✅ Execute arbitrary JavaScript inside Obsidian (`dev:eval`)
- ✅ Access the full Obsidian API programmatically
- ✅ Run Dataview queries, manipulate the app object, trigger commands

**Bookmarks & Links**
- ✅ Manage bookmarked items
- ✅ Inspect and manage internal links between notes

**Sync**
- ✅ Trigger and manage Obsidian Sync operations

**TUI Mode (Interactive Terminal UI)**
- ✅ Launch with just `obsidian` (no arguments)
- ✅ Browse vault, search, create/delete/rename files with keyboard shortcuts
- ✅ Useful for SSH access to the M1 remotely

### 1.3 What Claude Code CANNOT Do via the CLI (Limitations)

**No Direct GUI Rendering**
- ❌ Cannot render the graph view in the terminal
- ❌ Cannot display Bases/database views visually
- ❌ Cannot preview rendered Markdown (only raw content)
- ❌ Cannot interact with Canvas files visually

**No Native Calendar UI**
- ❌ No built-in calendar command — calendar views require plugins + GUI
- ❌ Cannot display calendar events in the terminal

**No Image/Attachment Handling**
- ❌ Cannot embed or preview images from the CLI
- ❌ Cannot manage attachments (copy, move, resize) natively
- ❌ Can reference them in Markdown but can't process them

**No Real-Time Collaboration**
- ❌ CLI is single-user, no collaborative editing
- ❌ No live cursors or presence awareness

**No Plugin UI Interaction**
- ❌ Cannot interact with plugin-specific GUIs (e.g., Kanban drag-and-drop)
- ❌ Cannot trigger plugin-specific modal dialogs
- ❌ Can work around this with `dev:eval` for some plugin APIs

**Mobile/Cross-Device Limitations**
- ❌ CLI is desktop-only (macOS/Windows/Linux)
- ❌ No iOS CLI access — mobile notes require Sync + GUI app

**Search Limitations**
- ❌ No regex search natively (community tools can supplement)
- ❌ No semantic/AI-powered search built in

---

## PART 2: CRITICAL GOTCHAS (Things That Silently Fail)

Based on community testing of 57 scenarios against Obsidian CLI 1.12, **22.8% of commands silently fail** — they return exit code 0 but give wrong or empty data. Here are the traps to avoid:

| Trap | ❌ Naive Command | ✅ Correct Command | What Goes Wrong |
|---|---|---|---|
| Task scope | `tasks todo` | `tasks all todo` | Returns 0 results (scoped to "active file" which is nothing in CLI) |
| Tag scope | `tags counts` | `tags all counts` | Returns empty output |
| Property format | `properties format=json` | `properties format=tsv` | Returns YAML instead of JSON |
| Search format | `search query="x"` | `search query="x" format=json matches` | Returns plain text, no structure |
| Create opens GUI | `create name="x" content="y"` | Add `silent` flag | Opens Obsidian UI instead of running silently |
| Exit codes lie | Check `$?` | Parse output for `Error:` | Commands return 0 even on failure |

**Bottom line:** Always use `all` scope for vault-wide operations, always add `silent` for headless automation, always parse stdout for errors instead of trusting exit codes.

---

## PART 3: MCP INTEGRATIONS — CONNECTING CLAUDE CODE TO OBSIDIAN

The CLI alone gives Claude Code powerful batch operations, but for **real-time, structured AI interaction**, you'll want MCP (Model Context Protocol) connectors. Here are your best options:

### 3.1 Option A: obsidian-claude-code-mcp (Recommended for Claude Code)

**What it is:** An Obsidian plugin that runs an MCP server inside Obsidian, and Claude Code auto-discovers it via WebSocket.

**Key features:**
- Auto-discovery — Claude Code finds the vault automatically
- WebSocket + HTTP/SSE transports
- Default port: 22360
- Shared + IDE-specific tool sets
- No external dependencies

**Setup:**
1. Install plugin in Obsidian
2. Claude Code discovers it automatically — no config needed
3. For Claude Desktop: use `mcp-remote` bridge

**What it enables:**
- ✅ Read/write notes through structured MCP tools
- ✅ Search vault contents
- ✅ Create/update notes with metadata
- ✅ Multi-vault support (unique ports per vault)

### 3.2 Option B: Claudesidian MCP (Most Feature-Rich)

**What it is:** A full MCP integration with embedded vector search, memory system, and agent mode.

**Key features:**
- Semantic search with embeddings (local via Ollama or API-based)
- Structured memory system for AI context
- Multiple embedding strategies (live, idle, startup, manual)
- Atomic operations for safe vault manipulation

**Best for:** Heavy AI-first workflows where you want Claude to semantically understand and navigate your entire vault.

### 3.3 Option C: Claudian Plugin (Claude Code Embedded in Obsidian)

**What it is:** Embeds Claude Code directly as an Obsidian sidebar panel using the Claude Agent SDK.

**Key features:**
- Full Claude Code tools: Read, Write, Edit, Bash, Grep, Glob, WebFetch, WebSearch
- Context-aware — auto-attaches focused note, @mention files
- Inline edit with word-level diff preview
- Slash commands and custom instructions
- YOLO mode (bypass approval prompts) or Safe mode
- MCP server support for connecting external tools
- Vision support (drag-drop images for analysis)

**Best for:** Working inside Obsidian's GUI with Claude as a persistent sidebar agent.

### 3.4 Option D: Direct Filesystem Access (Simplest)

Since Obsidian vaults are just folders of Markdown files, Claude Code in YOLO mode can:
- ✅ Read/write `.md` files directly
- ✅ Modify YAML frontmatter with sed/awk or Python
- ✅ Create folder structures
- ✅ Run find/grep across the vault
- ✅ Use git for version control

**Limitation:** No access to Obsidian's internal APIs (plugin state, resolved links, Bases calculations, etc.)

### 3.5 Recommended Stack for Your M1

**Use ALL of these together:**
1. **Official CLI** — for template application, task queries, plugin management, JavaScript execution
2. **obsidian-claude-code-mcp** — for real-time structured MCP communication
3. **Direct filesystem** — for bulk operations, git versioning, and scripting
4. **Claudian** (optional) — when you want to work in Obsidian's GUI with Claude as a sidebar

---

## PART 4: SECOND BRAIN ARCHITECTURE — VAULT STRUCTURE

Here's a recommended vault structure optimized for AI-assisted management across your use cases:

```
📁 SecondBrain/
├── 📁 00-Inbox/                  # Quick capture, unsorted notes
├── 📁 01-Projects/               # Active projects (PARA method)
│   ├── 📁 Lucavo-CEP/
│   ├── 📁 Cabinet-Company/
│   ├── 📁 Client-App-SaaS/
│   └── 📁 Marketing-2026/
├── 📁 02-Areas/                  # Ongoing areas of responsibility
│   ├── 📁 Business-Operations/
│   ├── 📁 DevOps/
│   ├── 📁 Finance/
│   ├── 📁 Health/
│   └── 📁 Learning/
├── 📁 03-Resources/              # Reference material, research
│   ├── 📁 AI-Research/
│   ├── 📁 Marketing-Playbooks/
│   ├── 📁 Tech-Docs/
│   └── 📁 Templates/
├── 📁 04-Archive/                # Completed/inactive items
├── 📁 05-Daily-Notes/            # Journal, daily logs
│   └── 📁 2026/
│       ├── 📁 01-January/
│       └── 📁 02-February/
├── 📁 06-Tasks/                  # Task notes (if using TaskNotes plugin)
├── 📁 07-Content/                # Content creation pipeline
│   ├── 📁 Blog-Posts/
│   ├── 📁 Social-Media/
│   ├── 📁 Email-Campaigns/
│   └── 📁 Video-Scripts/
├── 📁 08-Clients/                # Client-specific notes and docs
├── 📁 09-Meetings/               # Meeting notes
├── 📁 _Bases/                    # Obsidian Bases database views
├── 📁 _Templates/                # Note templates
└── 📁 _Attachments/              # Images, PDFs, files
```

### Frontmatter Schema (Standardized Across All Notes)

```yaml
---
title: "Note Title"
type: project | task | note | meeting | content | client | resource
status: draft | active | review | complete | archived
priority: high | medium | low
tags: []
project: "[[Project Name]]"
area: "Business-Operations"
created: 2026-02-15
modified: 2026-02-15
due: 2026-03-01          # for tasks
scheduled: 2026-02-20    # for calendar
assignee: "Vincent"
---
```

---

## PART 5: USE CASE BREAKDOWN — WHAT CLAUDE CODE CAN AUTOMATE

### 5.1 Research & Content Management

| Capability | Method | Works? |
|---|---|---|
| Create research notes from web searches | CLI `files write` or filesystem | ✅ |
| Auto-tag and categorize notes | CLI `properties set` + `tags` | ✅ |
| Apply templates to new research notes | CLI `templates apply` | ✅ |
| Build content outlines from research | CLI `files write` or filesystem | ✅ |
| Search across all research notes | CLI `search content format=json matches` | ✅ |
| Generate summaries of research folders | Read files → LLM processing → write summary | ✅ |
| Link related notes automatically | `dev:eval` with link-suggestion logic | ✅ |
| Track content pipeline status | Frontmatter `status` + Bases views | ✅ |
| Semantic search across vault | Claudesidian MCP with embeddings | ✅ |

### 5.2 Task Management

| Capability | Method | Works? |
|---|---|---|
| Query all open tasks vault-wide | CLI `tasks all todo` | ✅ |
| Find overdue tasks | CLI `tasks` + date comparison in `dev:eval` | ✅ |
| Create tasks with metadata | CLI `files write` with frontmatter | ✅ |
| Mark tasks complete | CLI property updates or `dev:eval` | ✅ |
| Priority-based task views | Bases with frontmatter filters | ✅ (GUI) |
| Kanban board management | TaskNotes or Kanban plugin | ✅ (GUI) |
| Recurring task automation | TaskNotes plugin with repeat config | ✅ |
| Task assignment tracking | Frontmatter `assignee` field | ✅ |
| Daily task rollup in daily notes | Template + `dev:eval` script | ✅ |

### 5.3 Notes & Projects

| Capability | Method | Works? |
|---|---|---|
| Create project folders and starter notes | CLI `files write` + filesystem mkdir | ✅ |
| Apply project templates | CLI `templates apply` | ✅ |
| Track project status across all projects | CLI `properties` + search | ✅ |
| Generate project status reports | Read all project notes → summarize | ✅ |
| Link project deliverables to tasks | Obsidian wiki-links in frontmatter | ✅ |
| Archive completed projects | Filesystem move + property update | ✅ |
| Daily notes with auto-populated agenda | CLI `daily` + template + `dev:eval` | ✅ |
| Meeting notes with action items extraction | Create note → LLM processing → task creation | ✅ |

### 5.4 Calendar & Scheduling

| Capability | Method | Works? |
|---|---|---|
| Create calendar events as notes | CLI `files write` with date frontmatter | ✅ |
| View calendar in Obsidian GUI | Calendar Bases plugin or Full Calendar | ✅ (GUI only) |
| Query upcoming events | CLI search by date properties | ✅ |
| ICS feed subscription (Google Calendar sync) | TaskNotes plugin | ✅ |
| Time-blocking with daily notes | Daily note template with time slots | ✅ |
| Deadline tracking across projects | Frontmatter `due` field + CLI `tasks` | ✅ |
| Generate weekly/monthly agenda summaries | Claude reads date-based notes → generates summary | ✅ |
| Calendar view in terminal | ❌ Not available — GUI only | ❌ |

---

## PART 6: SETUP CHECKLIST FOR YOUR M1

### Prerequisites

- [ ] **Obsidian installed** (download from obsidian.md)
- [ ] **Catalyst License purchased** ($25 one-time at obsidian.md/pricing → Insider tier)
- [ ] **Obsidian v1.12+** (Settings → General → Enable Insider Builds → Check for Updates)
- [ ] **CLI enabled** (Settings → Command line interface → toggle ON)
- [ ] **Verify CLI works:** open Terminal, run `obsidian help` — should show command list
- [ ] **Claude Code installed** and running in YOLO mode on the M1
- [ ] **Node.js installed** (needed for MCP bridges)

### Plugin Installation Order

1. **Core plugins to enable:**
   - Daily Notes
   - Templates
   - Properties
   - Bookmarks
   - Bases (for database views)
   - Tags

2. **Community plugins (priority order):**
   - **MCP Tools** or **obsidian-claude-code-mcp** — Claude Code connection
   - **TaskNotes** — full task management with calendar/kanban/agenda views
   - **Calendar Bases** — calendar view for Bases (needs Full Calendar)
   - **Full Calendar** — required dependency for Calendar Bases
   - **Templater** — advanced templating beyond core Templates
   - **Dataview** — powerful query engine for vault data
   - **Periodic Notes** — weekly/monthly/quarterly note automation
   - **Claudian** (optional) — Claude Code embedded in sidebar

3. **CLI Agent Skill (for Claude Code):**
```bash
# Install the Obsidian CLI skill to help Claude Code avoid silent failures
mkdir -p .claude/skills/obsidian-cli
curl -o .claude/skills/obsidian-cli/SKILL.md \
  https://raw.githubusercontent.com/jackal092927/obsidian-official-cli-skills/main/plugins/obsidian-cli/skills/obsidian-cli/SKILL.md
```

### macOS-Specific Notes

- On macOS, the CLI setup is simpler than Windows — no `Obsidian.com` file needed
- The CLI binary should be added to PATH automatically when you enable it in Settings
- If `obsidian` command is not found, check: the app may need a full restart (Cmd+Q, not just close window)
- Some users report needing to open a new terminal window after enabling CLI
- The CLI communicates with the running Obsidian app via IPC — **Obsidian must be running** for CLI commands to work

---

## PART 7: WHAT OBSIDIAN STILL CAN'T DO (EVEN WITH CLI)

These are fundamental platform limitations, not CLI gaps:

1. **No native email integration** — can't send/receive emails from Obsidian
2. **No native CRM** — you'd need to build this with frontmatter + Bases
3. **No native web forms/intake** — can't capture form submissions directly
4. **No native API endpoint** — Obsidian doesn't expose a REST API by default (needs Local REST API plugin)
5. **No native automation triggers** — no "when X happens, do Y" (would need external cron/scripts)
6. **No native Google Calendar 2-way sync** — ICS subscription is read-only; writing back requires external tools
7. **No collaborative editing yet** — on the roadmap but not shipped
8. **No native mobile CLI** — iOS/Android only have the GUI app
9. **No built-in AI** — all AI capabilities come from external tools (Claude Code, MCP plugins)
10. **No native spreadsheet/calculation** — Bases has basic formulas but it's not Excel

---

## PART 8: RECOMMENDED FIRST ACTIONS

Once everything is set up, here's what I'd recommend Claude Code tackle first on the M1:

1. **Create the vault structure** (folder hierarchy from Part 4)
2. **Build template set** — daily note, project, task, meeting, content, client, research
3. **Set up Bases views** — all tasks, all projects by status, content pipeline, upcoming deadlines
4. **Configure Claude Code CLI skill** so future sessions avoid silent failure traps
5. **Test the full loop:** create a task via CLI → verify in Obsidian GUI → complete via CLI → verify
6. **Set up daily note automation** — template with auto-populated tasks, calendar items, and review sections
7. **Import existing content** — migrate relevant notes from Notion/other systems into the vault
8. **Configure iCloud sync** — so your vault syncs to iPhone/iPad for on-the-go access

---

## SUMMARY: THE FULL PICTURE

| Layer | Tool | What It Does |
|---|---|---|
| **Storage** | Obsidian Vault (local Markdown) | All data stored as portable .md files |
| **CLI Automation** | Obsidian CLI 1.12 | 100+ commands for headless vault management |
| **AI Bridge** | MCP Plugin(s) | Real-time structured communication with Claude |
| **AI Agent** | Claude Code (YOLO) | Reads, writes, reasons, automates |
| **Filesystem** | Direct file access | Bulk operations, git versioning, scripting |
| **GUI** | Obsidian App | Visual views (calendar, kanban, graph, bases) |
| **Sync** | iCloud / Obsidian Sync | Cross-device access (iPhone, iPad, other Macs) |
| **Plugins** | TaskNotes, Bases, Calendar, etc. | Specialized views and workflows |

This gives you a **fully AI-operated second brain** where Claude Code can manage the entire lifecycle — from capturing research to organizing projects to tracking tasks to publishing content — with you reviewing and steering from the Obsidian GUI or your iPhone.
