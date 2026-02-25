---
title: "Glue — Agent Swarm Architecture Session Report"
type: research
status: draft
created: 2026-02-25
modified: 2026-02-25
source: chat
tags: [glue, agent-swarm, architecture, comms]
---

# Glue — Agent Swarm Architecture Session Report

## Executive Summary
Planning session to architect a multi-agent system ("agent swarm") for running a startup. Centered on a Chief of Staff agent that delegates to sub-agents. Glue selected as a candidate communication platform.

## Key Decisions (captured)
- Communication Platform: Glue (pilot)
- Chief of Staff Agent: Letta (primary) with Claude Code as coding sub-agent
- Current Agent Comms: Telegram → candidate migration to Glue
- System of record: Obsidian + GitHub
- Orchestration framework: start simple (no heavy framework until needed)
- Initial sub-agent count: 3–5

## Architecture Overview

### Roles
- Chief of Staff Agent (Letta)
- Research Agent
- Assistant Agent
- Task Manager Agent

### Communication Flow (as proposed)
Glue Thread/Group UI ↔ Bridge service ↔ Letta agent

## Glue Thread/Group Structure (proposed)
- Chief of Staff
- Business Plans
- Research Tasks
- Task Board
- Notes & Docs

## Obsidian/GitHub → Glue Sync (ideas)
- Obsidian → GitHub push → GitHub Action/Webhook → Glue API post into a thread
- Alternative: CoS reads GitHub directly and posts relevant docs into Glue threads

## Letta vs Claude Code (for CoS)
- Letta: persistent memory + stateful conversations (best fit for CoS)
- Claude Code: strongest for coding tasks (best fit as sub-agent)

## Glue Capabilities Mentioned
### What we have
- Markdown support in messages
- File upload via GraphQL API
- Public GraphQL API (beta)
- MCP Servers support
- OAuth2 authentication

### What we do not have (yet)
- Built-in wiki/doc editor
- Native task management (use MCP → Linear/Asana)

## Setup Steps (captured from session)
- Create OAuth app in Glue
- Obtain access token via client credentials
- Scopes: workspaces:read, threads:read, groups:read, threads.messages:write
- Create a Chief of Staff group, add bot, test sendMessage

## Links
- https://glue.ai/
- https://docs.glue.ai/
