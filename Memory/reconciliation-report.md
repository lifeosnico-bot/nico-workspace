# Reconciliation Report — Founding Documents vs. status.md
**Date:** 2026-02-23
**Source:** Claude Code
**Purpose:** Audit all founding planning documents against current status.md to ensure no tasks, decisions, or context are lost.

---

## Documents Reviewed

1. `NICO-FINAL-SETUP-PLAN.md` — Master 5-phase execution plan (Feb 15)
2. `nico-setup-plan-v4-2026-02-15.md` — Identical to #1 (duplicate)
3. `obsidian-setup-plan.md` — Earlier Obsidian planning doc (autonomous + manual actions)
4. `obsidian-final-setup-plan.md` — Final Obsidian plan with full context + Claude Code prompt
5. `obsidian-final-setup-plans.md` — Identical to #4 (duplicate)
6. `nico-task-dashboard.html` — HTML visualization of task list, last updated Feb 16, 2026
7. `status.md` — Current single source of truth (updated 2026-02-23 02:10 EST)

---

## Section A: Tasks in the Old Docs That ARE Already in status.md

These items from the founding documents are confirmed present and tracked in status.md:

**Phase 0 / Completed:**
- GitHub backup (nico-workspace repo, auto-backup every 6 hrs) — marked complete in status.md
- Git credential helper fix (gh auth setup-git) — marked complete
- Cloud MCP connector sync disabled (Craft tools, 17.8k tokens) — marked complete in Phase 0C

**Phase 0B (Secrets):**
- 1Password account creation — present in status.md Phase 0B, all 3 steps with subtasks

**Phase 1 (Obsidian Pre-Install):**
- Install Obsidian via brew — present with full subtask decomposition
- Vault directory structure (00–07 folders + subfolders) — present with subtask detail
- CLAUDE.md at vault root — present
- 6 templates (daily, project, meeting, research, decision, client) — present with all 6 listed
- Seed notes (00-Home, 3 project indexes, 3 area indexes) — present with subtasks
- .gitignore + sync-ignore — present
- .obsidian settings files (app.json, community-plugins.json, core-plugins.json, appearance.json) — present
- Community plugins via filesystem (templater, dataview, obsidian-git, periodic-notes, calendar, obsidian-claude-code-mcp) — present
- kepano/obsidian-skills installation + known bug workaround — present
- Git repo initialization in Vault — present

**Phase 2 (Obsidian Manual Setup):**
- Open Obsidian + select vault — present
- Sign in + enable Insider Builds (v1.12+) — present
- Enable CLI — present
- Enable community plugins — present
- Enable Obsidian Sync (name vault "Nico") — present

**Phase 3 (Post-Launch Verification):**
- CLI verification (version, vault, files total) — present
- Test CLI operations (list, read, search, tasks) — present
- Configure Obsidian Git plugin (data.json: 10 min auto-commit, pull on boot) — present
- Push vault to GitHub (nico-vault private repo) — present
- Push ~/Nico/ workspace to GitHub (nico-workspace) — present with subtasks
- Full smoke test — present with 8 subtask checks
- Update ~/Nico/CLAUDE.md with Obsidian section — present

**Phase 4 (Communication):**
- Absorbed into Phase 0F — confirmed in status.md ("Phase 4: Absorbed into Phase 0F")

**Phase 5 (SaaS Portal):**
- Next.js + Supabase scaffold — present with full subtask decomposition (project setup, auth, dashboard, PDF handling, ship it)

**Phase 0F (Agent Access & Communication):**
- All 7 tasks present with full subtask detail (remote sessions, Slack, agent-Slack integration, SSH from phone, iMessage escalation, advanced options, documentation)

**Phase 0E (Git Workflow):**
- All tasks present; most marked complete (branch protection, auto-backup to `backup` branch, agent workflow, PR cycle, tests)
- Task 6 (metadata standards enforcement) still open — present

**Phase 0D:**
- Marked complete in status.md (SSH fixed 2026-02-21)

**Phase 0C (MCP Audit):**
- Present with tasks 1-2 complete, tasks 3-5 open

**Phases 6-9:**
- All present in status.md (Backup & Redundancy, LifeOS Agent Evolution, External App Integrations, Research Agent)

---

## Section B: Tasks in the Old Docs That Are NOT in status.md

These items appear in the founding documents but are absent from status.md:

**1. MCP Configuration (Phase 3 / Phase 7 overlap)**
The obsidian-final-setup-plan.md specifically calls out `obsidian-claude-code-mcp` as a plugin with its own MCP server configuration (port 22360). Status.md mentions MCP in Phase 7 (2b: configure obsidian-claude-code-mcp), but there is no task to:
- Verify obsidian-claude-code-mcp is running post-install
- Test MCP communication between Claude Code and Obsidian
- Document the port (22360) and connection method
**Suggested placement:** Phase 3, after CLI verification.

**2. Daily Notes Core Plugin Config (Phase 3)**
The obsidian-final-setup-plan.md explicitly calls for configuring the daily notes core plugin to use `06-Daily/2026/{{date}}` format with the daily-note template. Status.md Phase 3 has no subtask for configuring the daily notes plugin settings (the plugin config file). The smoke test checks CLI creates a note, but the automatic daily note path and template linkage is not tracked as a setup task.
**Suggested placement:** Phase 3, task 3 (configure Obsidian Git plugin) could absorb a parallel task for daily-notes plugin config.

**3. kepano/obsidian-skills Known Bug (SKILL.md `!` character)**
The obsidian-final-setup-plan.md documents a specific known bug: after installing kepano/obsidian-skills, check `.claude/skills/obsidian-bases/SKILL.md` for backticked `!` characters that cause Claude Code permission check failures, and replace them with `<code>!</code>`. Status.md Phase 1 task 10c mentions "Check for known bug: backticked `!` in obsidian-bases/SKILL.md" — but does not specify the fix. This is present in status.md but the remediation step is incomplete. The fix instruction (replace with `<code>!</code>`) should be in the subtask.

**4. Sync-ignore file for Obsidian Sync**
The obsidian-final-setup-plan.md specifies creating `.obsidian/sync-ignore` to exclude `.git/` and `node_modules/` so Obsidian Sync doesn't try to sync the git repo itself. Status.md Phase 1 task 7 says "Create .obsidian/sync-ignore (exclude .git/ and node_modules/)" — this IS present. Covered.

**5. Home Note at vault root (00-Home.md)**
The founding docs call for a `00-Home.md` at the vault root level (not inside a folder) as a navigation hub. Status.md Phase 1 task 5a says "00-Home.md (vault root — navigation hub)" — this IS present. Covered.

**6. Disaster Recovery Documentation**
Phase 6 in status.md includes "Disaster recovery plan" (task 4) but the founding docs specify the recovery docs should be saved to `03-Resources/Reference/` inside the Obsidian vault. Status.md task 4a says "Document how to restore from GitHub if M1 dies" and 4b says restore from Obsidian Sync — but does not specify where to save them. The vault location (`03-Resources/Reference/`) is not captured.
**Suggested placement:** Phase 6, task 4 — add subtask 4d: "Save recovery docs to vault at 03-Resources/Reference/".

**7. Research Note Template**
The obsidian-setup-plan.md and obsidian-final-setup-plan.md both specify a 6th template: `research-note.md` (distinct from the 5 in NICO-FINAL-SETUP-PLAN.md). Status.md Phase 1 task 4 says "Create 6 templates" and lists 4d as `research-note.md`. This IS present. Covered.

**8. "00-Home.md" as vault-level file (vs. folder)**
Status.md confirms the vault structure uses `~/Nico/Vault/` — this is consistent across all docs.

**Summary of genuinely missing tasks:**
- Phase 3: Add subtask — verify obsidian-claude-code-mcp MCP server is running on port 22360
- Phase 3: Add subtask — configure daily notes core plugin (path: 06-Daily/2026/, template: daily-note.md)
- Phase 1 task 10c: Expand subtask to include the actual fix (replace backticked `!` with `<code>!</code>`)
- Phase 6 task 4: Add subtask — save recovery docs to `03-Resources/Reference/` in vault

---

## Section C: Decisions in the Old Docs That Differ from status.md

**1. Vault Location: Changed**
- Old docs (NICO-FINAL-SETUP-PLAN, obsidian-setup-plan, obsidian-final-setup-plan): vault at `~/Nico/Vault/`
- status.md (Key Decisions): vault at `~/Nico/Vault/` — **consistent, no conflict**
- Note: The system-reminder context for this session references `~/Nico/CabinetAgentVault/` but status.md and all founding docs use `~/Nico/Vault/`. If the vault was moved or renamed to `CabinetAgentVault/`, this is NOT captured in status.md and represents a significant discrepancy. Requires clarification.

**2. Primary Communication Channel: Changed**
- Old docs (NICO-FINAL-SETUP-PLAN): "Communication: iMessage first, then Telegram/Slack"
- status.md (Key Decisions): "Communication: Slack (primary — agent comms backbone), iMessage (escalation/urgent only)"
- This is correctly updated in status.md. The old priority order (iMessage first) is superseded.

**3. Sync Primary/Backup Order: Consistent**
- Old docs: Obsidian Sync (primary) + Git (backup)
- status.md: Obsidian Sync (primary) + Git (backup) — consistent.

**4. Plugin List: Expanded**
- NICO-FINAL-SETUP-PLAN: 5 plugins (templater, dataview, obsidian-git, periodic-notes, calendar)
- obsidian-final-setup-plan: 6 plugins — added `obsidian-claude-code-mcp`
- status.md Phase 1 task 9f: lists `obsidian-claude-code-mcp` — the newer list is correctly captured.

**5. Vault Structure: Minor Numbering Difference**
- All docs use `00–07` folder numbering. No conflict.
- obsidian-setup-plan.md used `03-Resources/Standards/` as a subfolder; the final plan and status.md use `03-Resources/Reference/` instead. Status.md is consistent with the final plan.

**6. Budget: Consistent**
- All docs: $200–330/month. status.md Key Decisions: $200–330/mo. Consistent.

**7. Agent Name History: Not Captured in status.md**
- obsidian-final-setup-plan.md notes "Agent name: Nico (renamed from Jarvis, Feb 14)" — this historical context (originally named Jarvis) is in the founding docs but not in status.md Key Decisions. Low importance but worth preserving.

**8. "Phase 4: Communication" Disposition**
- Old docs: Phase 4 was a standalone communication setup phase
- status.md: "Phase 4: Absorbed into Phase 0F" — correctly documented.

---

## Section D: Items in the Old Docs That Are Completely Superseded/Irrelevant

**1. NICO-FINAL-SETUP-PLAN.md and nico-setup-plan-v4 are exact duplicates.** They are identical files. One can be discarded. Both are already in `.trash/CC/` — no action needed.

**2. obsidian-final-setup-plan.md and obsidian-final-setup-plans.md are exact duplicates.** Same content. Both in `.trash/CC/` — no action needed.

**3. obsidian-setup-plan.md** is an earlier draft superseded by obsidian-final-setup-plan.md. Key differences: recommended Git sync over Obsidian Sync (the final decision reversed this), did not include MCP plugin or research-note template. The final plan's decisions are what matter.

**4. The nico-task-dashboard.html** (last updated Feb 16) is a static snapshot of the task list as it existed Feb 16. It is now outdated — Phase 0D, 0E, LettaBot, and others have been updated in status.md since then. The HTML serves no ongoing function. The current status.md is the live source of truth.

**5. "No Catalyst License" fallback section** in obsidian-setup-plan.md: This fallback (NotesMD CLI, no official CLI) is irrelevant — Catalyst was purchased Feb 15. Discard.

**6. "COPY EVERYTHING BELOW THIS LINE INTO CLAUDE CODE" prompt** in obsidian-final-setup-plan.md: This was the execution prompt for a session that is now in the past. The prompt itself is superseded by the current task list in status.md. Discard.

**7. Phase 0 "Option B — Do it manually"** in status.md: Phase 0 is complete. The manual option instructions are historical. No action needed.

---

## Section E: Items in the Old Docs NOT Captured Anywhere

The following context, background, or operational knowledge exists only in the founding documents and is not preserved in status.md or CLAUDE.md:

**1. Obsidian CLI Gotchas Table (22.8% silent failure rate)**
The obsidian-final-setup-plan.md contains a detailed table from community testing of 57 scenarios documenting the exact CLI failure modes:

| Trap | Wrong | Correct | What Goes Wrong |
|------|-------|---------|-----------------|
| Task scope | `tasks todo` | `tasks all todo` | Returns 0 results |
| Tag scope | `tags counts` | `tags all counts` | Returns empty output |
| Property format | `properties format=json` | `properties format=tsv` | Returns YAML |
| Search format | `search query="x"` | `search query="x" format=json matches` | Plain text |
| Create opens GUI | `create name="x"` | Add `silent` flag | Opens Obsidian UI |
| Exit codes lie | Check `$?` | Parse stdout for `Error:` | Returns 0 on failure |

This table is referenced in CLAUDE.md (`~/Nico/Nico/CLAUDE.md`) and the vault CLAUDE.md plan, but the full table is only in the founding docs. It should be written to the vault's CLAUDE.md when Phase 1 runs. Status.md task 3b notes the CLAUDE.md should include "CLI gotchas section (22.8% silent failure traps)" but the actual content is only in the founding docs.

**2. Full Obsidian CLI Command Reference**
The obsidian-final-setup-plan.md contains a reference table of ~15 most-useful CLI commands for Nico:
- `obsidian files read`, `obsidian files write`, `obsidian search content`, `obsidian tasks all todo/done`, `obsidian daily`, `obsidian templates apply`, `obsidian properties read format=tsv`, `obsidian plugins list`, `obsidian dev:eval`
This is not in status.md or CLAUDE.md. It belongs in the vault CLAUDE.md (created in Phase 1) or in a reference note at `03-Resources/Reference/obsidian-cli-reference.md`.

**3. "CLI requires Obsidian app to be running" — Key Operational Constraint**
The CLI communicates via IPC with the running app. This means for any headless Claude Code session on the M1, Obsidian must be open. If Obsidian is not running, all `obsidian` CLI commands fail. This operational constraint is mentioned in CLAUDE.md vault notes but is not documented in ~/Nico/CLAUDE.md or status.md as a system constraint.

**4. Obsidian Sync + Git Coexistence Rule**
The founding docs specify: add `.git/` and `node_modules/` to `.obsidian/sync-ignore` so Obsidian Sync doesn't try to sync the git repo directory. This is captured in Phase 1 task 7 of status.md, but the rationale (the two sync systems don't inherently conflict — Sync ignores `.git/` by default if configured) is not documented. If someone sets up a second vault without this knowledge, they could create sync conflicts.

**5. Vincent's Developer Profile**
The obsidian-final-setup-plan.md captures context not in status.md:
- "First-year CS student experience level" — relevant for how Nico should explain technical decisions
- "Prefers rapid iteration over evaluation — 'crash and break things' in the sandbox"
- "Wants genuine pushback, not sycophancy"
The last two points are in ~/Nico/CLAUDE.md as principles, but the experience level (first-year CS) is not documented anywhere and affects how Nico should communicate and structure explanations.

**6. M3 Personal Vault Name**
The founding docs note: Vincent has an existing personal Obsidian vault on his M3 called "Obsidian vault" (with a space). The new Nico vault is named "Nico" — no conflict. This fact is not in status.md or CLAUDE.md. If someone set up sync without knowing, they might try to sync to the wrong vault. Should be in the vault setup reference.

**7. History: Agent Was Originally Named Jarvis**
The obsidian-final-setup-plan.md notes: "Agent name: Nico (renamed from Jarvis, Feb 14)." This historical detail is not in status.md. Low importance but part of the founding context.

**8. kepano/obsidian-skills Installation Method Decision**
The obsidian-final-setup-plan.md specifies the Claude Code plugin method:
```
/plugin marketplace add kepano/obsidian-skills
/plugin install obsidian@obsidian-skills
```
With a manual fallback (git clone to /tmp, copy to .claude/skills/). The reason for the preferred method (not manual git clone) is not documented in status.md. Status.md task 10a just says "Clone repo to temp directory" suggesting the manual method — which contradicts the final plan's preferred approach.

**9. Vault Architecture Rationale**
The founding docs cite the source for the flat PARA structure: "kepano's community research (347 replies, 4.1K likes recommending flat hierarchy + liberal wikilinks)." This rationale is not captured anywhere in the current system. If someone later asks why the vault is structured this way, there's no trail.

**10. "Two Claude Code Desktops Are Independent" — Architecture Clarification**
The obsidian-final-setup-plan.md and Phase 0F in status.md both mention this, but status.md Phase 0F task 7c references it as a documentation task ("Document: 'Two Claude Code Desktops are independent. They share an account, not sessions or files. Git is the sync layer.'"). This task is still open (unchecked in status.md). The architectural clarification itself is only in the founding docs until that task runs.

---

## Summary: Actions Required

Based on this reconciliation, the following changes should be made to status.md:

1. **Phase 3** — Add task: verify obsidian-claude-code-mcp server is running on port 22360 after install
2. **Phase 3** — Add task: configure daily notes core plugin (path: 06-Daily/2026/, template: daily-note.md)
3. **Phase 1, task 10c** — Expand subtask to include the fix instruction: replace backticked `` `!` `` with `<code>!</code>` in obsidian-bases/SKILL.md
4. **Phase 6, task 4** — Add subtask 4d: save recovery docs to `03-Resources/Reference/` in vault
5. **Phase 1, task 10** — Clarify preferred installation method for kepano/obsidian-skills (Claude Code plugin method, not manual git clone)

And the following should be preserved in a reference location (vault or CLAUDE.md) when Phase 1 runs:

6. Full Obsidian CLI gotchas table (6 known failure modes)
7. Obsidian CLI command reference (~15 key commands)
8. Operational constraint: CLI requires Obsidian app to be running
9. Vincent's experience level (first-year CS) — relevant to Nico's communication style

The vault location discrepancy (`~/Nico/Vault/` vs. any possible rename to `CabinetAgentVault/`) requires clarification before Phase 1 runs.
