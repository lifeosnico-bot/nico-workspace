---
title: "Letta Office Hours: Letta Chat, GitHub Action, Letta Code, and more!"
date: 2026-03-01
tags: [letta, office-hours, letta-chat, github-action, conversations, sub-agents, skills, note-tool, obsidian, nico-agent]
status: active
type: research
project: nico-agent
video_id: fr61XHf6Zzw
video_url: https://youtu.be/fr61XHf6Zzw
relevance: high
presenter: Cameron (Letta team)
processed: 2026-03-01
raw_transcript: "30-resources/letta/transcripts/Letta_Office_Hours_Letta_Chat_GitHub_Action_Letta_Code_and_more.md"
---

# Letta Office Hours: Letta Chat, GitHub Action, Letta Code, and more!

> **Why this note exists:** Office hours covering multiple Letta product updates: Letta Chat frontend, GitHub Action install, Conversations system, sub-agent self-forking, skills ecosystem, Note tool + Obsidian sync, and Claude Subconscious. Several items directly relevant to Nico's architecture.

---

## 💬 Section 1 — Letta Chat

Letta Chat is a simple web frontend for personal agents — intended to replace Telegram/Discord as the primary interface for non-developer users who just want to talk to their agent.

> "There's a lot of people who use Letta for personal agents or they have like one agent that they want to talk to. These are people who just like want to use Letta as like a ChatGPT or Claude replacement."

**Key features:**
- Favorites list of agents
- Default agent "Loop" provided to all new users
- No memory block management UI exposed (intentional — keep it simple)
- Available at `chat.letta.com`
- Still in progress — onboarding flow being refined
- MCP and full agent config available via ADE (Letta Chat is just a frontend over the same agent)

**Loop Master pattern** — Cameron built a scaffolding agent that iterates on Loop's persona:
> "Loop Master is in charge of the system prompts and the memory blocks of every new loop iteration. It builds and tests Loop, currently on Loop 18."

This is an early example of the Ezra Super / monitor-agent pattern: one agent responsible for another agent's design.

🎯 **Verdict for Nico:** Letta Chat is not the right primary interface for Nico — LettaBot + Telegram is the locked decision. But Letta Chat is useful as a secondary browser-based access point. No action needed.

---

## 🐙 Section 2 — GitHub Action

GitHub Action allows Letta Code agents to run inside GitHub Actions runners, triggered by `@letta-code` mentions in issues and PRs.

**Setup:**
1. `letta code install-github-app` — interactive install OR copy YAML manually to `.github/workflows/letta.yaml`
2. Add `LETTA_API_KEY` as a repository secret
3. Tag `@letta-code` in any issue or PR comment to trigger a run

**Specialist agent pattern (Keeper):**
> "I have a version of this in the skills repository. The keeper agent is one that's specialized for understanding this communal skills repository that Letta agents maintain."

You can set a default agent for a repository by specifying the agent ID in the workflow YAML:
```yaml
letta-args: --agent <agent-id>
```

This lets one agent specialize in a repo over time, building up persistent memory about the codebase.

🎯 **Verdict for Nico:** GitHub Action is not relevant to Nico's initial build. Filed as Phase 2+ capability.

---

## 🔀 Section 3 — Conversations System

Conversations allow agents to run massively parallel sessions that share memory but have independent context windows.

> "Conversations basically allows your agents to be massively parallel. You can fork an agent and create a brand new conversation with no history. Those two conversations share memory and either conversation can update the memory that is shared between them."

**Key behaviors:**
- Default: single persistent conversation (reverted from "new conversation by default" based on user feedback)
- `/new` — creates new conversation inside Letta Code
- `letta -a --new` — CLI flag for new conversation
- `/resume` — resume a previous conversation (UI improvements coming)
- Conversation search is cross-all-conversations: agent has "perfect recall of everything"

⚠️ **Important for Nico:** LettaBot messages arrive via separate conversations (not the main thread) — this is the established pattern as of this video. This explains the architecture seen in BroTeuvX0es.

---

## 🪞 Section 4 — Sub-Agent Self-Forking (Task Tool)

Agents that know their own ID can now fork themselves to run parallel tasks using the Task tool.

> "If your agent knows its own ID, it can actually fork itself to go do something else in a conversation — your agent can basically just massively parallelize itself to accomplish many different tasks all at once."

**How it works:**
- Primary agent knows its own agent ID
- Calls Task tool with its own ID → spawns a fork in a new conversation
- Fork shares memory with primary, but has clean context

> "This is basically like Replicate — from Invincible — who can just spin herself off to go do a bunch of stuff."

🎯 **Verdict for Nico:** This is a Phase 2 capability. The foundation for Nico eventually parallelizing research, drafting, and cabinet work simultaneously.

---

## 📡 Section 5 — Messaging Agents Skill (Built-in)

New built-in skill allowing agents to message other agents without giving them access to the local machine.

> "The messaging agent skills allow you to send messages to other agents without giving them access to your local environment."

Enables inter-agent networking. Agent needs the target's agent ID. Combined with the self-fork pattern, this is the foundation for multi-agent coordination.

---

## 🛠️ Section 6 — Skills Ecosystem Updates

**Vercel skills repo** — `npx skills @letta-ai/skills` installs Letta-compatible skills. Community contributed. Letta working to get listed so skills clone directly to the Letta skills folder.

**Community skills repo** — `letta-ai/skills` on GitHub. Agents that maintain the repo agreed on a culture document with quality standards. Cameron recommends this as a curated source.

**Working in Parallel skill** — uses git worktrees so multiple agents can work on the same project without git conflicts.

**Skills from skills.sh / cloudub** — both available for bulk skill installation.

---

## 📝 Section 7 — Note Tool + Obsidian Sync (CRITICAL)

Cameron built a "note tool" that treats memory blocks as a filesystem. This is directly relevant to the Nico vault-as-bridge pattern.

> "The note tool basically allows your agent to use memory blocks as if they were a file system — view, append, edit, rename, delete, search. All of this stuff is just on the server."

**Obsidian sync demo:**
> "I said, okay, well, all you need to do is sync the memory blocks to your device and then be able to push them back up to the server. You can actually use Obsidian to work with notes that are native to your agent."

- Cameron built a `/bin pull` and `/bin push` CLI tool to sync memory blocks to/from a local Obsidian vault
- Obsidian opens the synced folder and shows the agent's memory notes as markdown files
- Editing in Obsidian → push back to server → agent sees the updates

**Vault successor coming:**
> "There's going to be a successor to this called Vault and Vault is going to use memory block tags which means that you can have view permissions across many different agents."

⚠️ **Architecture note:** This pattern (note tool + Obsidian sync) is a different approach from the context repositories pattern in `R_4r_NNjg1M`. Context repositories are git-backed local memory files. Note tool is memory blocks synced via REST/SDK. They may coexist or one may be preferred for specific use cases.

🎯 **Verdict for Nico:** The sync pattern confirms that Obsidian ↔ Letta agent memory integration is achievable and is already being done by the Letta team internally. The vault-as-bridge locked decision is reinforced.

---

## 🧠 Section 8 — Claude Subconscious

Experimental plugin for Claude Code that injects a Letta agent's memory into `.claude.md`, passes Claude Code transcripts to the subconscious agent, and allows the subconscious agent to whisper back.

> "Claude subconscious takes the memory of a subconscious agent and injects all of the agent's memories into the bottom of claude.md. It sends all of the user prompts and transcript to that agent. That agent can do memory updates and we show the diffs prepended at the beginning of the next user prompt."

**Implication:** Every Claude Code session would be observed by a persistent Letta agent that accumulates memory across sessions.

⚠️ **Status as of this video:** Experimental, broken in live demo due to batching bug. Cameron planned to fix and write a blog post.

🎯 **Verdict for Nico:** Defer to Phase 2+. Do not include in initial build. Interesting capability once stable.

---

## 💡 Section 9 — Cameron's Personal Agent Architecture

Direct insight into how Cameron organizes his own agents — useful as a reference for Nico's design:

> "I organize them by domain. I have one that's for Leta development — that's Ezra. I have a personal agent that is like my knowledge manager and knows everything about my life that I use for Obsidian notes and talking to in general — that's my Claude replacement. And then for specialized projects I typically have one agent that handles that project."

This is exactly the Nico model: one general CoS agent for personal knowledge + task management, with specialized agents added as needed.

---

## 💰 Section 10 — Model & Cost Tips

- **Reduce context window to under 100K tokens** to stay in lower cost tier on Letta Cloud (click LLM config → set max context)
- **GLM 4.7** — free/very cheap on Letta Cloud, competitive with Sonnet for regular tasks (not Opus-level)
- **Letta Cloud billing** = per-step, not per-token. Benefits from KV caching at scale
- **Bring your own key** = often more expensive for large agents due to large fixed context. Use Letta credits instead

---

## 🏗️ Extracted Architecture Decisions for Nico

1. **LettaBot messages = separate conversations** — not the main thread. This is the architecture, not a quirk.
2. **Note tool + Obsidian sync** = viable pattern for vault integration. Cameron uses it personally.
3. **Context window**: keep under 100K tokens for cost efficiency.
4. **Claude Subconscious**: defer to Phase 2+.
5. **Conversations system**: `/new` and `letta -a --new` for parallel session management — useful for Nico running parallel work streams.
6. **Self-forking via Task tool**: Phase 2 capability. Nico can eventually parallelize cabinet and SaaS tasks.
7. **Agent domain organization**: personal CoS = one agent. Don't over-fragment into too many agents on day one.
8. **Letta Chat**: available as a secondary access surface alongside Telegram. No setup required beyond existing agent.
9. **GitHub Action**: not relevant to Nico Phase 1.
10. **Skills**: use community repos for bulk installs, Vercel skills for curated installs.

---

## 💡 What This Means for Nico

- The note tool / Obsidian sync pattern is a practical implementation of the vault-as-bridge — Cameron is already doing this personally with his own knowledge-manager agent. This validates the entire Nico architecture.
- The Conversations system means Nico's LettaBot Telegram messages and direct ADE sessions are separate conversation branches — both valid, both update the same shared memory.
- Claude Subconscious would let future versions of Nico observe every Claude Code session and accumulate memory across sessions without Vincent doing anything. But it's not ready yet.
- Cameron's own setup (one big personal agent for life/Obsidian/knowledge + specialized agents by domain) is the exact template for Nico at launch.

---

## 🔗 Related Notes

- [[BroTeuvX0es-lettabot-tutorial|LettaBot Tutorial]]
- [[LKRnP-ptC4c-lettabot-updates|Opus 4.6, LettaBot Updates]]
- [[j1agWxBx54E-github-actions|GitHub Actions — Stateful Background Agents]]
- [[p7So3IM75WY-memfs-letta-chat|MemFS, Letta Chat]]
- [[YtZgsw9x8l8-letta-code-obsidian|Letta Code + Obsidian Integration]]
- [[R_4r_NNjg1M-context-repositories|Context Repositories — git-backed memory]]
