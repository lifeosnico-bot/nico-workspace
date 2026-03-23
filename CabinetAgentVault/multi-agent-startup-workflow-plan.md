# Multi-Agent Startup Operating System — Master Plan

**Date:** 2026-03-18
**Author:** Nico (Chief of Staff Agent) + Vincent Imbriani (CEO)
**Status:** PLAN — Awaiting CEO Review
**Version:** 1.0

---

## The Core Problem

You're running a startup where **multiple AI coding agents and humans** are simultaneously building the business AND running the business. The bottleneck you've identified is real and it's the #1 killer of multi-agent workflows: **coordination chaos when N agents + humans all touch the same repos, files, and task lists.**

Right now your stack includes Claude Code, Letta Bot, Codex, Antigravity, Gemini Chat, and ChatGPT — each with different interfaces, different context windows, different persistence models. The only common ground is **GitHub** (every coding agent can push/pull) and potentially **Linear** (structured task management with GitHub sync).

This plan treats your entire startup as a software system. Every business function — ops, engineering, product, marketing, finance, client success — becomes a module with defined interfaces, owners, and CI/CD.

---

## Part 1: The Architecture

### 1.1 — The Single Source of Truth Problem

Your current vault-based system works for 1-2 agents. It breaks at 5+. Here's why:

- **Obsidian vault** is a flat file system. Two agents editing the same `.md` file = merge conflict.
- **status.md as single task list** becomes a bottleneck when 4 agents need to update it simultaneously.
- **Branch-per-agent** works for code but not for operational docs that need real-time visibility.

**The fix:** Split coordination into two layers:

| Layer                 | Tool                        | What Lives Here                            | Who Writes                    |
| --------------------- | --------------------------- | ------------------------------------------ | ----------------------------- |
| **Task Coordination** | GitHub Issues + Linear      | All tasks, assignments, status, priorities | Any agent, any human          |
| **Knowledge / Docs**  | Obsidian Vault (git-backed) | Decisions, SOPs, research, meeting notes   | Designated writer per file    |
| **Code**              | GitHub Repos (worktrees)    | All application code, infrastructure       | Any agent via isolated branch |
| **Communication**     | Slack + Telegram            | Real-time alerts, approvals, handoffs      | Any agent, any human          |
| **Memory**            | Letta (persistent agents)   | Long-term context, identity, behavior      | Letta agents only             |

**Key principle:** Tasks go in a database (Linear/GitHub Issues), not a file. Files are for knowledge. Code is in repos. Never mix these.

### 1.2 — The Agent Roster

Every agent gets a defined role, a GitHub identity, and clear boundaries:

| Agent | Platform | Role | GitHub Identity | Strength |
|-------|----------|------|-----------------|----------|
| **Nico** | Claude Code (M1/Mac Studio) | Chief of Staff — delegates, coordinates, reviews | `nico-agent` | Strategic planning, task decomposition, vault writing |
| **Letta Bot** | Letta (always-on) | Executive Assistant — Vincent's 24/7 interface | reads via API | Persistent memory, Telegram, heartbeats |
| **Claude Code** | Claude Code (Cowork/CLI) | Senior Engineer — complex builds, architecture | `nico-agent` or session worktree | Deep reasoning, multi-file refactors, planning |
| **Codex** | OpenAI Codex CLI / GitHub Action | Mid Engineer — focused implementation tasks | `codex-bot` (GitHub App) | Fast execution, boilerplate, tests |
| **Antigravity** | Antigravity IDE | Specialist — skill-based task execution | `antigravity-bot` | 1200+ pre-built skills, parallel execution |
| **Copilot** | GitHub Copilot Coding Agent | Junior Engineer — PR-scoped tasks | `copilot` (built-in) | GitHub-native, auto-PR, CI integration |
| **Gemini/ChatGPT** | Chat interfaces | Research Analysts — research, brainstorming | N/A (no direct repo access) | Broad knowledge, alternative perspectives |

### 1.3 — The Coordination Stack

```
┌─────────────────────────────────────────────────┐
│                    VINCENT (CEO)                 │
│         Telegram / Slack / Linear UI             │
└──────────────────────┬──────────────────────────┘
                       │
              ┌────────▼────────┐
              │      NICO       │
              │  Chief of Staff │
              │  (Coordinator)  │
              └────────┬────────┘
                       │
         ┌─────────────┼─────────────┐
         │             │             │
    ┌────▼────┐  ┌─────▼─────┐  ┌───▼────┐
    │ LINEAR  │  │  GITHUB   │  │ SLACK  │
    │ (Tasks) │  │ (Code+CI) │  │ (Comms)│
    └────┬────┘  └─────┬─────┘  └───┬────┘
         │             │             │
    ┌────▼─────────────▼─────────────▼────┐
    │         AGENT EXECUTION LAYER        │
    │                                      │
    │  Claude Code  │  Codex  │  Copilot  │
    │  Antigravity  │  Letta  │  Gemini   │
    └──────────────────────────────────────┘
         │             │             │
    ┌────▼─────────────▼─────────────▼────┐
    │            GIT WORKTREES             │
    │    (Isolated branches per agent)     │
    └──────────────────────────────────────┘
         │
    ┌────▼────┐
    │  GITHUB │
    │  (PRs)  │
    └─────────┘
```

---

## Part 2: Daily Operations — How This Actually Works

### 2.1 — The Daily Cycle

**Morning (8:00 AM — Automated)**

1. Letta Bot sends Vincent a Telegram briefing: today's priorities from Linear, any overnight PRs to review, blockers.
2. Nico (scheduled task) scans Linear for new issues, updates priorities, assigns agents.
3. GitHub Actions run overnight CI results — any failures get auto-assigned back.

**Working Hours (Vincent + Agents)**

4. Vincent reviews briefing, adds/reprioritizes in Linear (or via Telegram quick commands).
5. Nico decomposes high-level tasks into agent-sized issues (5-15 min scope each).
6. Each agent picks up assigned Linear issues → creates branch → does work → opens PR.
7. GitHub Actions run tests on every PR. Copilot Code Review runs automatically.
8. Nico reviews PRs for architectural coherence. Vincent reviews business-critical ones.
9. Merged PRs auto-update Linear issue status (In Progress → Done).

**Evening (Vincent winds down)**

10. Vincent drops any new ideas into Linear inbox or Telegram.
11. Nico triages, creates issues, queues overnight work.

**Overnight (Autonomous)**

12. Overnight runner picks up queued tasks (research, doc generation, test writing).
13. Agents work in isolated worktrees. PRs created but NOT merged (await morning review).
14. Letta Bot consolidates the day's decisions into persistent memory.

### 2.2 — Task Lifecycle (The Pipeline)

Every piece of work follows this pipeline, whether it's writing code, creating a marketing page, updating financials, or onboarding a client:

```
INTAKE → TRIAGE → DECOMPOSE → ASSIGN → EXECUTE → REVIEW → MERGE → VERIFY → CLOSE
```

| Stage | Who | Where | What Happens |
|-------|-----|-------|--------------|
| **Intake** | Vincent, Letta Bot, any agent | Linear Inbox / Telegram / Slack | Raw idea captured as Linear issue |
| **Triage** | Nico | Linear | Priority set (P1-P4), labels added, project assigned |
| **Decompose** | Nico | Linear | Break into sub-issues sized for one agent (5-15 min) |
| **Assign** | Nico | Linear | Route to best agent based on task type (see routing table) |
| **Execute** | Assigned agent | Git worktree + their platform | Agent works in isolation, commits to branch |
| **Review** | Nico + CI + Copilot Review | GitHub PR | Automated tests + code review + architecture check |
| **Merge** | Nico or Vincent | GitHub | PR merged to main after passing all checks |
| **Verify** | CI/CD + Nico | GitHub Actions + Linear | Deployment succeeds, acceptance criteria met |
| **Close** | Automated | Linear (via GitHub sync) | Issue moves to Done, metrics captured |

### 2.3 — Agent Routing Table

When Nico decomposes a task, it routes to the right agent:

| Task Type | Primary Agent | Backup | Why |
|-----------|--------------|--------|-----|
| Complex architecture / multi-file refactor | Claude Code | — | Deep reasoning, 200k context |
| New feature implementation (well-defined) | Codex | Copilot | Fast execution, follows specs |
| Bug fix with failing test | Copilot | Codex | PR-scoped, CI-integrated |
| Test writing / coverage improvement | Codex | Copilot | Repetitive, pattern-based |
| Documentation / vault updates | Claude Code (Nico) | — | Vault conventions, wikilinks |
| Research / competitive analysis | Gemini or ChatGPT | Claude (Cowork) | Broad knowledge, web access |
| UI/UX component building | Antigravity | Claude Code | Pre-built skills library |
| DevOps / CI/CD pipeline | Claude Code | Codex | Infrastructure complexity |
| Client communication drafts | Letta Bot | Claude Code | Persistent context about clients |
| Financial modeling / spreadsheets | Claude (Cowork) | — | Analytical depth |
| Overnight batch work | Codex + Copilot | — | Parallel, autonomous, low-risk |

---

## Part 3: The GitHub-Centric Implementation

### 3.1 — Repository Structure

```
lifeosnico-bot/
├── cabinet-portal/          # SaaS product (Next.js + Supabase)
├── nico-workspace/          # Agent infrastructure, scripts, ops
├── nico-vault/              # Obsidian vault backup
├── .github/                 # Org-level workflows, issue templates
└── agent-configs/           # AGENTS.md files, agent-specific configs
```

Each repo gets an `AGENTS.md` file (the standard that Codex, Copilot, and Claude Code all read):

```markdown
# AGENTS.md
## Project Context
[What this repo does, architecture overview]

## Development Commands
- `npm run dev` — start dev server
- `npm test` — run tests
- `npm run lint` — check code quality

## Branch Convention
- `nico/` — Nico Chief of Staff tasks
- `codex/` — Codex agent tasks
- `copilot/` — Copilot agent tasks
- `antigravity/` — Antigravity agent tasks
- `human/` — Vincent direct changes

## Code Style
[Linting rules, formatting, conventions]

## Architecture Rules
[What agents should and shouldn't touch]
```

### 3.2 — Branch Strategy (The Isolation Layer)

This is the #1 solution to your multi-agent conflict problem:

**Rule: Every agent works in a git worktree. No exceptions.**

```bash
# Each agent session creates an isolated worktree
git worktree add ../worktree-codex-issue-42 -b codex/issue-42
git worktree add ../worktree-copilot-issue-43 -b copilot/issue-43
git worktree add ../worktree-nico-issue-44 -b nico/issue-44

# Agents work completely independently
# No file conflicts possible — each has their own copy

# When done, PR back to main
# Worktree cleaned up after merge
```

**Branch naming convention:**
```
{agent-name}/{issue-number}-{short-description}
```

Examples:
- `nico/42-refactor-auth-module`
- `codex/43-add-unit-tests-api`
- `copilot/44-fix-login-redirect`
- `antigravity/45-build-dashboard-component`
- `human/46-update-business-logic`

**Branch protection rules (GitHub):**
- `main` — Protected. Requires PR + 1 approval + CI passing.
- No direct pushes. Ever. Not even Vincent.
- Copilot Code Review runs on every PR automatically.
- CODEOWNERS file routes reviews to Nico for architecture, Vincent for business logic.

### 3.3 — GitHub Actions (The Automation Layer)

```yaml
# .github/workflows/agent-ci.yml
name: Agent CI Pipeline
on:
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm ci
      - run: npm test
      - run: npm run lint

  copilot-review:
    runs-on: ubuntu-latest
    steps:
      - uses: github/copilot-code-review@v1

  label-agent:
    runs-on: ubuntu-latest
    steps:
      - name: Auto-label by agent
        run: |
          BRANCH=${{ github.head_ref }}
          AGENT=$(echo $BRANCH | cut -d'/' -f1)
          gh pr edit ${{ github.event.pull_request.number }} --add-label "agent:$AGENT"

  notify-linear:
    runs-on: ubuntu-latest
    if: github.event.action == 'closed' && github.event.pull_request.merged
    steps:
      - name: Update Linear issue
        run: |
          # Extract issue number from branch name
          # Update Linear status to Done via API
```

### 3.4 — Linear Integration (The Task Brain)

**Why Linear over GitHub Issues alone:**
- Linear has cycles (sprints) — perfect for weekly agent work planning
- Linear has projects — maps to your business modules
- Linear has bi-directional GitHub sync — PRs auto-update issue status
- Linear has an API that agents can call programmatically
- Linear supports automation rules — issues move through pipeline automatically

**Linear Project Structure:**

```
Workspace: Lucavo / LifeOS
├── Team: Engineering
│   ├── Project: Cabinet Portal (SaaS)
│   ├── Project: Agent Infrastructure
│   └── Project: DevOps & CI/CD
├── Team: Operations
│   ├── Project: Business Ops
│   ├── Project: Client Management
│   └── Project: Finance
├── Team: Product
│   ├── Project: Product Roadmap
│   └── Project: UX Research
└── Team: Growth
    ├── Project: Marketing
    └── Project: Sales
```

**Linear Workflow States:**
```
Backlog → Triage → Todo → In Progress → In Review → Done → Archived
```

**Automation Rules:**
- PR opened → Issue moves to "In Review"
- PR merged → Issue moves to "Done"
- Issue assigned to agent label → Auto-set priority based on agent capacity
- Issue in "Todo" for >48h → Alert Nico to reassign

### 3.5 — VS Code Workspaces (The IDE Layer)

VS Code becomes the multi-agent command center:

**Workspace Configuration (`.code-workspace`):**
```json
{
  "folders": [
    { "path": "cabinet-portal", "name": "SaaS Portal" },
    { "path": "nico-workspace", "name": "Agent Ops" },
    { "path": "CabinetAgentVault", "name": "Vault" }
  ],
  "settings": {
    "github.copilot.enable": true,
    "copilot.agent.enable": true
  }
}
```

**How agents use VS Code:**
- **Copilot Coding Agent:** Runs directly in VS Code, creates worktrees automatically
- **Claude Code:** CLI mode from terminal panel, `--worktree` flag for isolation
- **Codex:** CLI from terminal, or via GitHub Action (headless)
- **Antigravity:** IDE integration, skill-based execution

**VS Code as Mission Control:**
- Source Control panel shows all active agent branches
- Terminal panels: one per active agent session
- GitHub Copilot Chat: quick questions, code explanations
- Linear extension: view/update issues without leaving IDE

---

## Part 4: Business-as-Software Modules

Every business function is a "module" with defined inputs, outputs, owners, and tests.

### Module 1: Engineering

**Owner:** Nico (delegation) + Claude Code (execution)
**Repo:** `cabinet-portal`
**Linear Project:** Cabinet Portal

| Process | Input | Output | Agent | Cadence |
|---------|-------|--------|-------|---------|
| Feature development | Linear issue with spec | Merged PR + tests | Codex / Claude Code | Continuous |
| Bug fixes | Bug report / failing test | Fix PR + regression test | Copilot / Codex | As needed |
| Code review | Open PR | Review comments + approval | Copilot Review + Nico | Per PR |
| Architecture decisions | RFC issue | Decision doc in vault | Claude Code (Nico) | As needed |
| Dependency updates | Dependabot PR | Merged update | Copilot | Weekly |
| Test coverage | Coverage report | New tests PR | Codex | Weekly |

### Module 2: Operations

**Owner:** Nico + Letta Bot
**Repo:** `nico-workspace`
**Linear Project:** Business Ops

| Process | Input | Output | Agent | Cadence |
|---------|-------|--------|-------|---------|
| Morning briefing | Linear state + overnight PRs | Telegram message | Letta Bot | Daily 8am |
| Task triage | Inbox issues | Prioritized + assigned issues | Nico | Daily |
| Sprint planning | Backlog review | Cycle issues assigned | Nico + Vincent | Weekly |
| Retrospective | Completed cycle | Retro doc in vault | Nico | Weekly |
| Infrastructure health | Healthcheck scripts | Alert on failure | LaunchAgent | Every 60m |
| Backup verification | Auto-backup logs | Confirmation or alert | LaunchAgent | Every 6h |

### Module 3: Client Management (Lucavo)

**Owner:** Nico + Letta Bot
**Linear Project:** Client Management

| Process | Input | Output | Agent | Cadence |
|---------|-------|--------|-------|---------|
| New client intake | Client info | Vault client note + Linear project | Nico | As needed |
| Quote generation | Cabinet specs | Quote document | Claude Code | As needed |
| Project timeline | Scope + constraints | Timeline in Linear | Nico | Per project |
| Status updates | Project progress | Client email draft | Letta Bot | Weekly |
| Invoice tracking | Completed milestones | Finance update | Nico | Per milestone |

### Module 4: Product Development

**Owner:** Vincent + Nico
**Linear Project:** Product Roadmap

| Process | Input | Output | Agent | Cadence |
|---------|-------|--------|-------|---------|
| Feature ideation | User feedback + market research | RFC issues | Vincent + Gemini | Ongoing |
| Spec writing | RFC approved | Technical spec in vault | Claude Code | Per feature |
| User research | Competitor analysis | Research doc | Gemini / ChatGPT | Monthly |
| Dogfooding review | Internal usage notes | Improvement issues | Nico | Weekly |

### Module 5: Finance

**Owner:** Vincent (approval) + Nico (tracking)
**Linear Project:** Finance

| Process | Input | Output | Agent | Cadence |
|---------|-------|--------|-------|---------|
| Expense tracking | Receipts + subscriptions | Spreadsheet update | Nico | Weekly |
| Revenue tracking | Client payments | Finance dashboard | Nico | Monthly |
| Budget review | Spending vs budget | Variance report | Claude (Cowork) | Monthly |
| Subscription audit | Tool list + costs | Optimization recommendations | Nico | Quarterly |

### Module 6: Marketing & Growth

**Owner:** Vincent + Nico
**Linear Project:** Marketing

| Process | Input | Output | Agent | Cadence |
|---------|-------|--------|-------|---------|
| Content creation | Topic + audience | Blog post / social draft | Claude Code + Gemini | Weekly |
| SEO research | Target keywords | Research doc | Gemini / ChatGPT | Monthly |
| Landing page updates | New copy / features | PR to portal repo | Antigravity / Codex | As needed |
| Analytics review | Usage data | Insights report | Claude (Cowork) | Weekly |

---

## Part 5: The Delegation Engine

This is the most critical piece — how Nico (or any coordinator agent) takes a high-level goal and turns it into agent-executable work.

### 5.1 — Decomposition Protocol

When Vincent says "Build the client onboarding flow," Nico does this:

```
1. UNDERSTAND: What is the business outcome? (Clients can self-serve onboarding)
2. SCOPE: What modules are affected? (Engineering + Client Mgmt + Product)
3. DECOMPOSE: Break into issues sized for one agent session (5-15 min each)
4. SEQUENCE: Which issues depend on which? (DB schema → API → UI → Tests)
5. ASSIGN: Route each issue to the best agent
6. TRACK: Create Linear issues with dependencies marked
7. MONITOR: Watch for blockers, reassign if needed
```

**Example Decomposition:**

```
Goal: "Build client onboarding flow"

Issues Created:
1. [ENG] Design onboarding DB schema (Supabase)     → Claude Code  [P1]
2. [ENG] Create onboarding API endpoints             → Codex        [P1, blocked by #1]
3. [ENG] Build onboarding UI components              → Antigravity  [P2, blocked by #1]
4. [ENG] Wire UI to API endpoints                    → Codex        [P2, blocked by #2, #3]
5. [ENG] Write integration tests for onboarding      → Codex        [P2, blocked by #4]
6. [ENG] Add onboarding to navigation/routing        → Copilot      [P3, blocked by #3]
7. [OPS] Create client onboarding checklist template  → Nico         [P2]
8. [OPS] Update client intake process docs            → Nico         [P3, blocked by #7]
9. [PRODUCT] Write onboarding UX copy                 → Claude Code  [P2]
10. [QA] End-to-end onboarding test                   → Claude Code  [P3, blocked by #5]
```

### 5.2 — The Nico Delegation Loop (Scheduled)

This runs on a schedule (or can be triggered manually):

```
Every 30 minutes during working hours:
  1. Check Linear for unassigned issues in "Todo" state
  2. Check agent availability (are worktrees active? PRs pending?)
  3. Match issue to best available agent (routing table)
  4. Assign issue in Linear
  5. If agent is Claude Code / Codex: trigger via CLI or GitHub Action
  6. If agent is Copilot: assign in GitHub, it auto-picks up
  7. Post status update to Slack #status
```

### 5.3 — Inter-Agent Communication

Agents don't talk to each other directly. They communicate through artifacts:

| Communication | Channel | Example |
|--------------|---------|---------|
| Task handoff | Linear issue comment | "Schema is merged. API endpoints can now proceed." |
| Blocker escalation | Linear issue label `blocked` + Slack alert | "Need Vincent approval on pricing model" |
| Architecture question | GitHub PR comment | "Should this use server components or client?" |
| Knowledge sharing | Vault doc (wikilinked) | Research findings linked from issue |
| Status update | Linear issue state change | In Progress → In Review |
| Conflict resolution | GitHub PR review | "This conflicts with PR #47, needs rebase" |

---

## Part 6: What GitHub + Tooling Can Handle Today

### Already Available (Implement Now)

| Capability | Tool | Status |
|-----------|------|--------|
| Branch isolation per agent | Git worktrees | Ready — all agents support this |
| Automated CI/CD | GitHub Actions | Ready — set up workflows |
| Code review | Copilot Code Review (agentic) | GA — enable on repos |
| Task management with GitHub sync | Linear | Ready — set up workspace |
| Agent-to-GitHub integration | Codex Action, Copilot Agent | Ready — configure |
| PR-based merge workflow | GitHub branch protection | Ready — configure rules |
| Agent identification | Branch naming + PR labels | Ready — convention-based |
| AGENTS.md for agent context | Convention file | Ready — write per repo |
| VS Code multi-agent workspace | VS Code 1.109+ | Ready — create .code-workspace |
| Slack notifications | GitHub + Linear integrations | Ready — connect apps |

### Needs Setup (1-2 Days Work)

| Capability | What's Needed |
|-----------|---------------|
| Linear workspace structure | Create teams, projects, workflow states |
| GitHub Actions workflows | Write CI, labeling, Linear sync workflows |
| CODEOWNERS file | Define review routing |
| Agent GitHub accounts | Create bot accounts for Codex, Antigravity |
| VS Code workspace file | Create multi-folder workspace config |
| Nico scheduled delegation | Build the delegation loop as scheduled task |

### Needs Building (1-2 Weeks)

| Capability | What's Needed |
|-----------|---------------|
| Nico → Linear API integration | Script/MCP for Nico to create/assign/update issues |
| Agent dispatch system | Trigger agents from Linear issue assignment |
| Overnight work queue | Linear label + scheduled runner picks up labeled issues |
| Cross-agent conflict detection | GitHub Action that checks for overlapping file changes |
| Metrics dashboard | Track agent throughput, PR merge rate, cycle time |

---

## Part 7: Implementation Prompts

These are the sequential prompts to execute this plan. Each is a standalone work session.

### Prompt 1: Linear Workspace Setup
```
Set up the Linear workspace for Lucavo/LifeOS with the following structure:

Teams: Engineering, Operations, Product, Growth
Projects: Cabinet Portal, Agent Infrastructure, DevOps, Business Ops,
          Client Management, Finance, Product Roadmap, Marketing

Workflow states: Backlog → Triage → Todo → In Progress → In Review → Done

Labels: agent:nico, agent:codex, agent:copilot, agent:antigravity,
        agent:claude, agent:human, type:feature, type:bug, type:ops,
        type:research, type:docs, priority:p1, priority:p2, priority:p3

Enable GitHub integration with bi-directional sync.
Set up automation: PR opened → In Review, PR merged → Done.
```

### Prompt 2: GitHub Repository Configuration
```
Configure all GitHub repos (cabinet-portal, nico-workspace, nico-vault) with:

1. Branch protection on main: require PR, require CI pass, require 1 review
2. CODEOWNERS file routing architecture to nico-agent, business to Vincent
3. GitHub Actions CI workflow (test, lint, label-by-agent, Linear sync)
4. AGENTS.md file per repo with project context, commands, conventions
5. Issue templates for: feature, bug, ops-task, research
6. PR template with: summary, Linear issue link, test plan, agent identifier
```

### Prompt 3: Git Worktree Automation
```
Create a shell script (agent-worktree.sh) that:

1. Takes: agent-name, issue-number, short-description
2. Creates a git worktree at ../worktree-{agent}-{issue}
3. Creates branch {agent}/{issue}-{description}
4. Sets up the worktree (npm install, etc.)
5. Outputs the worktree path for the agent to use

Create a cleanup script that removes merged worktrees.
Add both to nico-workspace/Scripts/.
```

### Prompt 4: Nico Delegation Engine
```
Build Nico's delegation engine as a scheduled task that:

1. Reads unassigned Linear issues in "Todo" state via Linear API
2. Matches each issue to the best agent using the routing table
3. Assigns the issue in Linear
4. For code tasks: creates the git worktree and branch
5. Posts assignment notification to Slack #tasks
6. Runs every 30 minutes during working hours (8am-10pm)

Use Linear's GraphQL API. Store the API key in env vars (1Password later).
```

### Prompt 5: Overnight Work Queue
```
Upgrade the overnight runner to:

1. Read Linear issues labeled "overnight-ok" in "Todo" state
2. For each issue:
   a. Create git worktree
   b. Dispatch to appropriate agent (Codex via GitHub Action, or Claude Code CLI)
   c. Agent works in worktree, commits, opens draft PR
   d. Mark issue as "In Review" in Linear
3. Generate overnight summary for morning briefing
4. Never merge — all overnight PRs await morning review

Add safety rails:
- Max 5 issues per night
- Only issues labeled "overnight-ok" by Nico or Vincent
- No destructive operations (no deletes, no schema migrations)
- Alert on any failure
```

### Prompt 6: VS Code Workspace + Agent Configuration
```
Create the multi-agent VS Code workspace:

1. .code-workspace file with all repos
2. Recommended extensions: GitHub Copilot, Linear, GitLens,
   GitHub Actions, GitHub PR
3. Terminal profiles for each agent (Claude Code, Codex CLI)
4. Task definitions for common operations (create worktree,
   run tests, deploy preview)
5. Keybindings for quick agent dispatch
```

### Prompt 7: Metrics and Observability
```
Build a metrics tracking system that captures:

1. Per-agent: issues completed, PRs merged, avg cycle time,
   failure rate
2. Per-project: velocity, burndown, blocker count
3. System-wide: total throughput, human intervention rate,
   overnight success rate
4. Store in a tracking spreadsheet or Supabase table
5. Generate weekly report for vault
6. Alert on anomalies (agent stuck, throughput drop, CI failure spike)
```

### Prompt 8: Migration from Vault-Only to Hybrid System
```
Migrate current vault-based task management to Linear + Vault hybrid:

1. Export all tasks from status.md into Linear issues
2. Keep status.md as a DERIVED VIEW (auto-generated from Linear)
3. Update CLAUDE.md to reference Linear as task source of truth
4. Update all agent instructions to use Linear for tasks
5. Keep vault for: decisions, SOPs, research, session notes, client docs
6. Vault task-board.md becomes a read-only view synced from Linear
7. Test the full pipeline: Vincent → Telegram → Nico → Linear →
   Agent → PR → Merge → Linear Done
```

---

## Part 8: Open Questions for Vincent

Before executing, these need your input:

1. **Linear vs GitHub Projects:** Linear is more powerful but adds another tool + cost ($8/user/mo for Standard). GitHub Projects v2 is free and native but less sophisticated. Which do you prefer? (I recommend Linear for the automation rules and cycle planning.)

2. **Agent GitHub accounts:** Do you want separate GitHub bot accounts for each agent type (codex-bot, antigravity-bot), or funnel everything through the existing lifeosnico-bot org? Separate accounts give clearer audit trails.

3. **Overnight autonomy scope:** How aggressive should overnight work be? Options:
   - Conservative: Research and docs only (current)
   - Moderate: Research, docs, tests, and small features (draft PRs)
   - Aggressive: Full feature work with draft PRs (recommended)

4. **Mac Studio timeline:** When will the Mac Studio be set up? The delegation engine needs an always-on machine. M1 works for now but Mac Studio is the target.

5. **Budget for tooling:** Linear Standard is $8/user/mo. With agent "users" this could add up. Are we using it for just Vincent + Nico, or creating seats per agent?

6. **Antigravity access:** Do you currently have Antigravity set up? What's your access level? This determines whether we include it in the initial rollout or add it later.

7. **Codex access:** Do you have OpenAI Codex CLI access (requires Copilot Pro+ or Enterprise)? This determines the dispatch mechanism.

8. **Current GitHub org structure:** Is `lifeosnico-bot` the org you want to use for everything, or should we create a separate org for the business?

---

## Part 9: Priority Order

**Week 1 — Foundation:**
- [ ] Answer open questions (Vincent)
- [ ] Set up Linear workspace (Prompt 1)
- [ ] Configure GitHub repos (Prompt 2)
- [ ] Create AGENTS.md files
- [ ] Set up VS Code workspace (Prompt 6)

**Week 2 — Automation:**
- [ ] Build worktree automation scripts (Prompt 3)
- [ ] Build Nico delegation engine (Prompt 4)
- [ ] Set up GitHub Actions CI pipeline
- [ ] Migrate tasks from status.md to Linear (Prompt 8)

**Week 3 — Overnight + Metrics:**
- [ ] Upgrade overnight runner (Prompt 5)
- [ ] Build metrics tracking (Prompt 7)
- [ ] Test full pipeline end-to-end
- [ ] First full autonomous work cycle

**Week 4 — Optimize:**
- [ ] Review metrics from Week 3
- [ ] Tune agent routing based on performance
- [ ] Add any missing automation rules
- [ ] Document SOPs for the whole system

---

## Summary

The system works because of three principles:

1. **Git worktrees solve the conflict problem.** Every agent gets an isolated copy of the repo. No merge conflicts during work. Conflicts only happen at PR merge time, which is controlled.

2. **Linear (or GitHub Issues) replaces flat files for task coordination.** A database beats a markdown file when N agents need concurrent read/write access.

3. **Nico is the coordinator, not a worker.** Nico decomposes, assigns, reviews, and merges. The coding agents do the coding. The research agents do the research. Separation of concerns at the agent level mirrors separation of concerns in code.

You're not building a company that uses AI. You're building an AI-native company where the operating system IS the product. Every workflow you perfect internally becomes a feature you can sell externally.

Let's build it.
