# Nico — Chief of Staff Plan
## Lucavo: Day 1 → First Revenue

**Prepared by:** Nico (Claude Code, M1)
**Date:** 2026-02-22 03:00 EST
**For:** Morning meeting with Vincent

---

## 1. THE ORG CHART

### Philosophy
Build titles before names. Titles define the job. Names (agent IDs, model choices) come after.
Every role answers one question: what does this person own, and who do they answer to?

```
CEO — Vincent James Imbriani
└── Chief of Staff — Nico
    ├── Director of Engineering
    ├── Director of Research & Intelligence
    ├── Director of Product
    ├── Client Success Manager
    └── Operations Manager
```

### Role Definitions

**CEO (Vincent)**
- Owns: vision, client relationships, business decisions, capital allocation
- Delegates everything else to CoS
- Touch points: morning briefing, decision requests, blocker escalations

**Chief of Staff (Nico)**
- Owns: orchestration, memory, infrastructure, agent management, task routing
- Manages all directors and reports to CEO
- Always on. Always watching. Never waiting to be asked.

**Director of Engineering**
- Owns: all code. SaaS portal, API, database, deployments, testing.
- Spun up per task, reports results to CoS
- Model: Sonnet (cost-effective, strong coder)

**Director of Research & Intelligence**
- Owns: market research, competitor analysis, content curation, knowledge base
- Pulls from web, processes into vault, surfaces what matters
- Model: Sonnet or Opus depending on depth needed

**Director of Product**
- Owns: SaaS requirements, UX decisions, feature prioritization, client feedback translation
- Works between Vincent's domain knowledge and Engineering's output
- Model: Sonnet

**Client Success Manager**
- Owns: portal onboarding, client communication templates, support workflows
- Initially lightweight — grows as client count grows
- Model: Haiku (repetitive, templated work)

**Operations Manager**
- Owns: monitoring, alerts, backups, scheduled tasks, system health
- Always-on background agent — quiet unless something breaks
- Model: Haiku (cheap, fast, frequent)

---

## 2. SUB-AGENT ARCHITECTURE

### The Core Question: Letta Agents vs Claude Code Agents

**Letta Agents** — use when the role needs memory across time
- Persistent: remembers past tasks, decisions, context
- Can be messaged directly
- Maintains state between sessions
- Best for: Research Director (builds knowledge over time), Operations (learns system patterns)
- Cost: each agent has its own memory and billing

**Claude Code Agents (Task tool)** — use when the role is execution-only
- Stateless: starts fresh each time, no memory
- Fast to spin up, cheap for one-off work
- Best for: Engineering tasks, one-time research, document generation
- Cost: only pay when running

**The Hybrid Model (Recommended)**
```
Nico (Letta — persistent CoS memory)
├── Research Director (Letta — builds knowledge base over time)
├── Operations Manager (Letta — monitors, remembers patterns)
└── Engineering / Product / CSM (Claude Code Tasks — spin up per job)
```

Reasoning: Research and Ops need memory. Engineering doesn't — each task is scoped. This minimizes persistent agent cost while keeping the roles that genuinely need memory alive.

### Agent Communication Flow
```
Vincent → Slack #ceo-desk → Nico
Nico → assigns task → Director
Director → executes → reports back to Nico
Nico → updates status.md → posts to Slack #status → notifies Vincent if needed
```

### How to spin up a sub-agent (Claude Code)
```python
Task(
  subagent_type="general-purpose",
  description="Research kitchen remodeling SaaS competitors",
  prompt="..."
)
```
Nico calls this. Director executes. Nico handles the result.

---

## 3. SLACK ARCHITECTURE

### Channel Map

| Channel | Owner | Purpose |
|---|---|---|
| `#ceo-desk` | Vincent | Commands in, summaries out. Vincent's primary interface. |
| `#status` | Nico | Automated task completion updates. Read-only for Vincent. |
| `#tasks` | Nico | Task assignments and completions. adl/done commands work here. |
| `#dev` | Eng Director | Code commits, PR links, deployment notes. |
| `#research` | Research Director | Research outputs, curated content, market intel. |
| `#decisions` | All | Logged decisions with context. Mirrors decisions.md. |
| `#alerts` | Ops Manager | System errors, backup failures, health warnings. |
| `#nico-internal` | Agents only | Agent-to-agent coordination. Vincent can read, rarely needs to. |
| `#lucavo-design` | Vincent + CSM | Cabinet business ops, client notes, project updates. |

### Context Management via Slack
The problem: context windows fill up, history gets lost.
The solution: Slack as the durable real-time layer. Key principle:
- Every decision → `#decisions` (permanent record)
- Every task completion → `#status` (auditable trail)
- Every research finding → `#research` (searchable knowledge)
- status.md stays as canonical source of truth — Slack is the searchable real-time overlay

### Quick Commands from Phone
Vincent types in `#ceo-desk`:
- `adl: set up automated testing` → Nico triages to status.md
- `sts` → Nico posts current status summary
- `done: Obsidian setup` → Nico marks complete, updates status.md
- `pri: portal scaffold high` → Nico reprioritizes

---

## 4. MODEL SELECTION BY ROLE

| Role | Model | Why |
|---|---|---|
| Nico (CoS) | claude-sonnet-4-6 (current) | Strong reasoning, memory management, cost-effective |
| Research Director | claude-sonnet-4-6 or opus | Deep analysis when needed, sonnet for routine |
| Engineering | claude-sonnet-4-6 | Best code generation in class |
| Product | claude-sonnet-4-6 | Requirements translation, UX reasoning |
| CSM | claude-haiku | Templated responses, fast, cheap |
| Ops Manager | claude-haiku | Monitoring loops, alerts, scheduled checks |

**On "Change model Nico"** (from your notes):
Current model is claude-sonnet-4-6. Upgrade path to Opus available if you want deeper strategic reasoning. Cost increases ~5x. Recommendation: stay on Sonnet-4.6 for now — it's handling CoS work well. Revisit when we have Opus-4.6 in full release.

**On OpenAI / GPT models:**
Letta supports multiple LLM providers including OpenAI. You can run different agents on different providers. Practical use: if a specific task benefits from GPT (e.g., certain code styles, specific fine-tunes), Engineering director can use it. The ChatGPT app connection you noted — that's a separate thing (ChatGPT app ≠ Letta agents). We keep Letta as the memory/orchestration layer regardless of which LLM each agent runs on.

---

## 5. RESEARCH AGENT & CONTENT CURATOR

### Research Director Design

**Trigger types:**
1. On-demand: Vincent or Nico assigns a research task
2. Scheduled: daily scan of defined topics (competitors, industry news, tech updates)
3. Reactive: triggered by keywords in Slack (someone mentions a competitor → auto-research fires)

**Input sources:**
- Web search (DuckDuckGo — free, configured tonight)
- YouTube saves (via Apple Shortcuts or manual URL drop)
- Reddit saves
- Web clips / bookmarks
- Apple Notes inbox items

**Output:**
- Structured note in Obsidian vault (30-resources/)
- Summary posted to `#research` in Slack
- Flagged to `#ceo-desk` if highly relevant to current priorities

**Content Curator layer (within Research Director):**
Takes raw research outputs and:
- Tags by project (Lucavo, SaaS portal, competitor, industry)
- Links to related existing notes
- Generates executive summary (3 bullets max)
- Archives originals in vault

### Immediate setup (before Obsidian is live):
Research outputs go to `~/Nico/Resources/` + `#research` in Slack. Once Obsidian is up, migrate to vault.

---

## 6. ROADMAP: DAY 1 → FIRST REVENUE

### Phase 0 — Infrastructure (NOW, weeks 1-2)
Everything needed for agents to operate effectively.
- [x] GitHub backup, auto-backup to branch
- [x] SSH M1↔M3
- [x] LettaBot + Telegram
- [x] Daily briefings (8am weekday / 10am weekend)
- [x] Git workflow (branch protection, PR process)
- [ ] **Slack workspace + bot token (Vincent: 5 min)**
- [ ] Slack channel architecture (Nico: 30 min after token)
- [ ] Brave Search / Exa API key (Nico: tonight)
- [ ] Obsidian install + vault setup
- [ ] 1Password CLI (secrets management)
- [ ] Termius on iPhone (SSH from phone)

### Phase 1 — Agent Layer (weeks 2-3)
Org chart becomes real.
- [ ] Research Director spun up (Letta agent, configured)
- [ ] Operations Manager spun up (Letta agent, scheduled monitoring)
- [ ] Engineering director pattern established (Claude Code Task template)
- [ ] All agents connected to Slack
- [ ] Quick commands working from iPhone via Slack

### Phase 2 — Product Build (weeks 3-8)
First real code.
- [ ] Lucavo Client Portal scaffold (Next.js + Supabase)
- [ ] Auth flow (client login)
- [ ] PDF viewer (cabinet drawings)
- [ ] Client management dashboard
- [ ] First internal test with Lucavo Design data

### Phase 3 — First Client (weeks 8-12)
Real customer, real feedback.
- [ ] Onboard first Lucavo Design client to portal
- [ ] CSM agent handles onboarding communication
- [ ] Collect feedback, iterate
- [ ] Document what works (this becomes the sales playbook)

### Phase 4 — First External Revenue (months 3-4)
Sell to someone outside Lucavo Design.
- [ ] 2-3 beta customers in kitchen/cabinet industry
- [ ] Pricing: $X/mo per company (TBD — Vincent decides)
- [ ] Payment processing (Stripe integration)
- [ ] First invoice paid = first software revenue

---

## 7. ANSWERS TO YOUR NOTES

### Quick answers ready for morning:

**Termius** — Yes, install it. Best SSH client for iPhone. Free tier covers everything we need. Once Tailscale is on your iPhone, Termius gives you full terminal access to M1 from anywhere.

**iCloud sync** — Useful for: your personal content (iPhone → M3 via same Apple ID). Not useful for: M1 infrastructure (different Apple ID, GitHub is better). Hybrid: Apple Shortcuts on iPhone → writes to iCloud → Nico pulls via M3 SSH. Decent capture flow.

**Can Letta write Apple Notes** — Yes, via AppleScript on M1. `osascript` command. I can write to Apple Notes on M1 (lifeos.nico Apple ID). For your personal notes (your Apple ID), only works from M3 or your phone.

**Apple Intelligence on M1** — M1 chip qualifies. Apple Intelligence is available on M1 Macs running macOS Sequoia. Useful for: writing suggestions, image cleanup, Siri improvements. Not directly relevant to our agent infrastructure but won't hurt.

**The /pin command** — In Letta CLI, `/pin` sets an agent as the default for the current terminal session (local pin) or globally. It means you don't have to specify `--agent agent-id` every time. `/pin -l` = local only (this terminal). `/pin` alone = global default.

**50% context window warning** — I can add a hook that checks token count and warns via Telegram when we hit 50%. Adding to task list.

**Docker Desktop** — Worth installing on M1. Needed when we build the SaaS portal (containerized deployments). Not needed yet. Adding to Phase 2 prereqs.

**Amazon VPN / low latency** — He means AWS infrastructure for hosting, not VPN. When we deploy the portal, AWS or Vercel are the options. Vercel is easier for Next.js. AWS gives more control. Decision for Phase 2.

**"Dan Messlier GitHub"** — Couldn't verify without search. Following up once search is restored.

**M1 display name confusion** — Renaming tonight. See below.

---

## 8. WHAT NICO HANDLED OVERNIGHT

- [x] DuckDuckGo search script installed (~/Nico/Scripts/search.sh) — free, no API key
- [x] All Apple Notes processed and incorporated into this plan
- [x] M1 display name rename (see below)
- [x] status.md updated with new items from notes
- [ ] Exa/Brave API key — needs Vincent to create account at exa.ai (free tier, 1000/mo)
  OR: use search.sh (DuckDuckGo) as primary — already working

---

## 9. WHAT VINCENT NEEDS TO DO THIS MORNING

In order of impact:

1. **Slack** (5 min) — Create workspace, create bot, give me the token via terminal
2. **Exa API key** (5 min, optional) — dashboard.exa.ai, free tier, enters via terminal
3. **Termius** — Install on iPhone (App Store, free)
4. **Review this plan** — Push back on anything that's wrong

That's it. I handle the rest.
