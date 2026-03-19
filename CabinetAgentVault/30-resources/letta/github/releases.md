---
title: "Letta GitHub Releases"
date: 2026-03-15
tags: [letta, github, releases]
status: active
type: research
source: "https://github.com/letta-ai/letta/releases"
---

# Letta GitHub — Latest Releases

## v0.16.6
**Tag:** 0.16.6 | **Published:** 2026-03-04

### Highlights
- Expanded Conversations API support for **default conversation / agent-direct mode**
- New conversations now initialize with a **compiled system message at creation time**
- Fixed `model_settings.max_output_tokens` default behavior so it **does not silently override** existing `max_tokens` unless explicitly set

### Conversations API updates
- Added support for `conversation_id="default"` + `agent_id` across conversation endpoints (send/list/cancel/compact/stream retrieve)
- Kept backwards compatibility for `conversation_id=agent-*` (deprecated path)
- Added lock-key handling in agent-direct flows to avoid concurrent execution conflicts

### Conversation/system-message behavior
- Conversation creation now compiles and persists a system message immediately
- This captures current memory state at conversation start and removes first-message timing edge cases

### Model/config updates
- Added model support for: `gpt-5.3-codex`, `gpt-5.3-chat-latest`
- Updated defaults: context window default **32k → 128k**, `CORE_MEMORY_BLOCK_CHAR_LIMIT` **20k → 100k**
- Anthropic model settings now allow `effort="max"` where supported
- Gemini request timeout default increased to **600s**

### Memory / memfs updates
- Git-backed memory frontmatter no longer emits `limit` (legacy `limit` keys are removed on merge)
- Skills sync now maps only `skills/{name}/SKILL.md` to `skills/{name}` block labels

---

## v0.16.5
**Tag:** 0.16.5 | **Published:** 2026-02-24

Maintenance release — version bump only.

---

## v0.16.4
**Tag:** 0.16.4 | **Published:** 2026-01-29

- Updated GitHub templates
- Version bump

---

## v0.16.2
**Tag:** 0.16.2 | **Published:** 2026-01-12

- Updated README documentation
- Corrected local setup steps in contributing.md

---

## v0.16.1
**Tag:** 0.16.1 | **Published:** 2025-12-18

- Corrected provider name for openai-proxy in LLMConfig
- Version bump
