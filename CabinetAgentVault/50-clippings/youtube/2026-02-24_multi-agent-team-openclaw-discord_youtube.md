---
title: "Video Research: Set up a multi-agent team using OpenClaw in Discord"
date: 2026-02-24
tags: [research, video, youtube, agentic, discord]
type: research
status: processed
source: https://www.youtube.com/watch?v=vxpuLIA17q4
platform: youtube
---

# Set up a multi-agent team using OpenClaw in Discord

## Summary
- Discord is being used as the “UI layer” for a multi-agent workflow: channels per project + scheduled reports + handoffs between agents.
- The core value is separation-by-channel: project context stays isolated and searchable vs one long Telegram thread.
- The system relies on (1) a private Discord server, (2) a Discord bot, (3) the agent/orchestrator that can read/write in channels, and (4) optional scheduled jobs that post into channels.
- Key security principle: keep the server private; if someone gets access to the server, they effectively get a control surface to your agent workflows.

## Key Steps / Key Points
1. Create a private Discord server (solo).
2. Create a Discord “application” (the bot) in the Discord Developer Portal.
3. Configure bot permissions (only what’s needed).
4. Generate bot token (treat like a password).
5. Invite bot to the private server.
6. Create channels per project and per automation feed.
7. Set up scheduled automations (daily digest, research, etc.) that post into specific channels.
8. (Optional) Set up a dashboard (“mission control”) to monitor agents and activity.

## Tools Mentioned
- Discord
- Discord Developer Portal (bot/app creation)
- Scheduled tasks / cron jobs (concept)
- API keys for data sources (example: YouTube API, X API)

## Security / Risks
- Keep the Discord server private; do not invite others.
- Discord bot token must never be shared in chat or committed to git.
- Prefer least-privilege permissions for the bot.
- Be cautious about automations that send outbound messages (email/SMS) without human approval.

## Lucavo Mapping
### Copy
- Channels-per-project structure.
- Orchestrator + worker-agent pattern.
- Daily digest + scheduled research as the first automations.

### Modify
- Instead of OpenClaw-specific features, we implement our own “Discord bridge” on the always-on M1 that routes Discord messages to Nico/agents.
- We start with *one* bot and *one* automation, then expand.

### Skip
- Content-creator specific pipelines (X trending -> script writing -> thumbnails).
- Multi-bot sprawl on day 1 (start with one bot).

### Risks
- Token leakage.
- Over-permissioned bot.
- Too many channels/automations before we have stable ops.

## Execution Checklist
### Prereqs
- [ ] Vincent creates a private Discord server.
- [ ] Decide whether the bot can create channels or we create channels manually.
- [ ] Access to the always-on M1 runtime where the bridge will run.

### Steps
- [ ] Create Discord application + bot in Developer Portal.
- [ ] Configure minimal permissions + intents.
- [ ] Add bot to server.
- [ ] Store token locally on M1 (env var / secret file) (DO NOT paste in chat).
- [ ] Implement Discord bridge service (listen -> route -> respond).
- [ ] Create initial channel set (5–8 channels max).
- [ ] Add daily digest scheduled post.
- [ ] Validate: message routing, channel isolation, rate limits, restart behavior.

## Next Actions (Do Now)
1. Vincent: confirm bot can create channels automatically (yes/no).
2. Vincent: provide Discord server name + initial channel list.
3. Nico: draft click-by-click instructions for Discord bot creation + minimal permissions, then begin wiring the bridge on M1.

## References
- https://www.youtube.com/watch?v=vxpuLIA17q4
