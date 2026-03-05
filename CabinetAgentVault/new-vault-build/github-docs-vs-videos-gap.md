---
title: "GitHub Docs vs. Video Transcripts — Gap Analysis"
date: 2026-03-01
tags: [verification, github-docs, lettabot, letta-code, gap-analysis, nico-agent]
status: active
type: note
project: nico-agent
---

# GitHub Docs vs. Video Transcripts — Gap Analysis

Created Session 6. Cross-reference of all 14 processed video research notes against current GitHub docs for LettaBot and Letta Code. Sources checked:
- `github.com/letta-ai/lettabot` — README, SKILL.md, getting-started.md, configuration.md
- `docs.letta.com/letta-code` — overview, models, memory

---

## 🔴 CRITICAL — Install Plan Must Reflect These

### 1. Heartbeat Silent Mode

**What videos said:** Heartbeats fire on a timer, agent responds. Demo showed messages arriving in Telegram automatically.

**What docs say:** Heartbeats run in Silent Mode. Agent text responses do NOT auto-deliver. To send a message during a heartbeat, the agent must explicitly call:
```bash
lettabot-message send --text "Your message here"
```

**Two prerequisites:**
- Bash tool must be enabled (in `features.allowedTools`)
- User must have messaged the bot at least once

**Impact on Nico:** Without this, Nico's morning reports and heartbeat check-ins silently execute but never arrive in Telegram. The bootstrap prompt and heartbeat prompt must explicitly instruct Nico to call `lettabot-message send`.

---

### 2. `LETTA_MODEL` Environment Variable is REMOVED

**What videos said:** LKRnP-ptC4c noted the model field in lettabot.yaml is "misleading/legacy" and Cameron opened an issue to remove it.

**What docs say:** `LETTA_MODEL` env var is confirmed removed. Model is set server-side:
```bash
lettabot model set <model-handle>
```
Or via `/model` command inside Letta Code.

**Impact on Nico:** Do not configure model in lettabot.yaml or via env var. Set it in the Letta ADE or via `lettabot model set` after setup.

---

### 3. Install Command

**What videos said:** `npm ci` (BroTeuvX0es tutorial).

**What docs say (SKILL.md — authoritative):**
```bash
npm install && npm run build && npm link
```
`npm link` creates the global `lettabot` command. Without it, `lettabot onboard` and `lettabot server` won't work as bare commands.

`getting-started.md` also uses `npm ci` but separately notes `npm run build && npm link` for the interactive path.

**Reconciliation:** Use SKILL.md as authoritative. Full path:
```bash
git clone https://github.com/letta-ai/lettabot.git
cd lettabot
npm install && npm run build && npm link
```

---

### 4. Config File Location

**What videos said:** Not explicitly addressed.

**What docs say:** Config saves to `~/.lettabot/config.yaml` by default (global, not project-local). Priority order:
1. `LETTABOT_CONFIG_YAML` env var
2. `LETTABOT_CONFIG` env var (file path)
3. `./lettabot.yaml` (project-local)
4. `~/.lettabot/config.yaml` (global default)

**Impact on Nico:** The config lives at `~/.lettabot/config.yaml` after onboarding. Edit it directly or via `lettabot configure`.

---

### 5. `LETTA_AGENT_ID` — How to Point LettaBot at an Existing Agent

**What videos said (LKRnP-ptC4c):** "Set the agent ID inside of your configuration file when you start up LettaBot."

**What docs say:** Set via environment variable:
```bash
export LETTA_AGENT_ID="agent-..."
```
Or in `lettabot.yaml`:
```yaml
agent:
  id: agent-...
```

**Impact on Nico:** The fresh Letta agent must be created first (via Letta Code or ADE), ID captured, then used here. Install plan must include this step.

---

### 6. DM Policy Defaults to `pairing`

**What videos said:** Not explicitly discussed. BroTeuvX0es demo showed agent responding immediately.

**What docs say:** Default `dmPolicy: pairing` — users must be approved before bot responds. New users receive an approval code; must run:
```bash
lettabot pairing approve telegram <code>
```
Or approve via `POST /api/v1/pairing/telegram/approve`.

**Impact on Nico:** Vincent must pair his own Telegram account after starting the server. This is a step the install plan must include.

---

## 🟡 IMPORTANT — Install Plan Should Include These

### 7. Heartbeat Prompt is Configurable in YAML

Not in videos. Docs show:
```yaml
features:
  heartbeat:
    enabled: true
    intervalMin: 60
    skipRecentUserMin: 5
    prompt: "Check your task list and send Vincent a morning briefing."
    promptFile: ~/.lettabot/heartbeat-prompt.md
```
`skipRecentUserMin: 5` means heartbeat is skipped if Vincent messaged in last 5 min (prevents interrupting active conversations).

---

### 8. GPT Uses a Different Toolset (Codex / ApplyPatch)

Not in any video. Docs say:
- Claude → string-replace `Edit` tool
- GPT → patch-based `ApplyPatch` tool (Codex toolset)
- Gemini → string-replace `Replace` tool

**Impact on Nico:** Vincent's locked model is OpenAI GPT via Pro subscription. The agent will use ApplyPatch for file edits, not string-replace. This may affect how Nico edits vault files and should be tested.

---

### 9. MemFS / Context Repositories — How to Enable

Not fully covered in videos. Docs say:
- Memory stored at `~/.letta/agents/<agent-id>/memory`
- Enable on existing agents: `/memfs enable`
- New agents: may have MemFS on by default (version dependent)
- `/sleeptime` command to configure reflection subagent

Sleeptime config (confirm in Letta ADE):
- Trigger: compaction events (recommended by Charles in R_4r_NNjg1M)
- Launch mode: auto-launch (mandatory, not reminder-based)

---

### 10. Cron Jobs Use Standard Crontab Syntax

Videos showed natural language scheduling ("remind me at 11pm"). Docs show the CLI uses standard crontab:
```bash
lettabot cron add "Daily standup at 9am" "0 9 * * *"
lettabot cron list
```
The agent can also self-schedule via the cron skill. Both methods work.

---

### 11. `/connectcodex` Not in Public Docs

LKRnP-ptC4c video showed Cameron using `/connectcodex` to OAuth into OpenAI Pro. This command is not documented publicly in `docs.letta.com`. It may be:
- A Letta Code CLI command (only works when running Letta Code interactively)
- Still being rolled out / not fully documented yet

The docs confirm GPT is supported and the `chatgpt-plus-...` model prefix is valid. The OAuth path likely works but must be done interactively in Letta Code, not scripted.

---

### 12. Skills Install via `npx molthub@latest install`

SKILL.md shows:
```bash
npx molthub@latest install sonoscli
lettabot skills  # spacebar to toggle, enter to confirm
```
Skills load from Clawdhub, skills.sh, or local `.skills/` directory. The `lettabot skills` command is an interactive skill toggle.

---

### 13. Non-Interactive Setup Path Available

Not in videos. SKILL.md documents a fully non-interactive path for scripted/agent-assisted setup:
```bash
export LETTA_API_KEY="letta_..."
export TELEGRAM_BOT_TOKEN="123456:ABC-DEF..."
lettabot onboard --non-interactive
```
Uses safe defaults. Useful if an AI assistant (Claude Code) is helping set up LettaBot.

---

## 🟢 USEFUL — Good to Know

| Item | From Docs | Not in Videos |
|------|-----------|--------------|
| `lettabot model set <handle>` | Change model post-setup | ✓ |
| `lettabot pairing list` | See pending pairing requests | ✓ |
| `lettabot pairing approve <channel> <code>` | Approve a user | ✓ |
| `lettabot cron list` | List scheduled tasks | ✓ |
| `lettabot configure` | Edit config interactively | ✓ |
| `npm run update` | Pull latest changes, rebuild | ✓ |
| `lettabot destroy` | Delete local data / reset | ✓ |
| `features.showToolCalls: true` | Show tool invocations in chat | ✓ |
| `features.showReasoning: true` | Show model reasoning in chat | ✓ |
| `features.workingDir` | Set per-agent working directory | ✓ |
| Voice transcription (`transcription.provider`) | OpenAI Whisper or Mistral Voxtral | ✓ |
| TTS (`tts.provider`) | ElevenLabs or OpenAI voices | ✓ |
| OpenAI-compatible API at `localhost:8080` | Now live (was "coming soon") | ✓ |
| Gmail polling YAML structure | `polling.gmail.account: user@gmail.com` | ✓ |

---

## Summary: What the Install Plan Must Incorporate

1. Full install: `npm install && npm run build && npm link`
2. Create Letta agent first → capture agent ID → set `LETTA_AGENT_ID`
3. `lettabot onboard` (interactive or non-interactive)
4. Self-pairing step: `lettabot pairing approve telegram <code>`
5. Set model via `lettabot model set` (NOT via env var or yaml)
6. Heartbeat prompt must instruct agent to call `lettabot-message send`
7. MemFS enable: `/memfs enable` + `/sleeptime` config if not default
8. Sleeptime: compaction trigger, auto-launch mode
9. `/connectcodex` for OpenAI Pro — do interactively in Letta Code
10. Test heartbeat via `/heartbeat` command in Telegram

---

## Sources

- `github.com/letta-ai/lettabot` SKILL.md (authoritative setup guide)
- `github.com/letta-ai/lettabot` README
- `github.com/letta-ai/lettabot` docs/getting-started.md
- `github.com/letta-ai/lettabot` docs/configuration.md
- `docs.letta.com/letta-code` — overview, models, memory
- Video transcripts: BroTeuvX0es, LKRnP-ptC4c, M8LNa3FKE4k, YtZgsw9x8l8, fr61XHf6Zzw
