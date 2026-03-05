---
title: "Combine Letta Code with Obsidian"
date: 2026-03-01
tags: [letta, obsidian, letta-code, vault, memory, integration, nico-agent]
status: active
type: research
project: nico-agent
video_id: YtZgsw9x8l8
video_url: https://youtu.be/YtZgsw9x8l8
relevance: critical
presenter: Cameron (Letta developer relations)
processed: 2026-03-01
raw_transcript: "30-resources/letta/transcripts/Combine_Letta_Code_with_Obsidian.md"
---

# Combine Letta Code with Obsidian

> [!important] Why This Note Matters for Nico
> Obsidian IS Nico's vault — the persistent knowledge layer for both Lucavo Design and the SaaS startup. This video is the canonical demo of exactly the architecture we are building: a stateful Letta agent (LettaBot) whose external memory lives in Obsidian markdown files. Cameron demos Letta Code reading and writing vault files directly from the terminal, which is the same access pattern Claude Code uses. This is the closest thing to a reference implementation for Nico's vault-as-bridge design. Every decision in this note must be evaluated against that locked architecture.

---

## 1. Core Premise — Why Obsidian + Letta Code Work Together

Cameron opens with the fundamental insight that makes this integration natural:

> "The nice part about working with Obsidian is that it just has a bunch of markdown files on a folder in your computer. And what does Letta Code do really well? It modifies a bunch of text files in a folder on your computer."

No API, no plugin required at the baseline level. Letta Code (and by extension Claude Code) operates on the vault by treating it as a plain filesystem of markdown files. The agent's statefulness is the multiplying factor:

> "Because Letta agents are stateful, meaning that they learn and improve over time, they are persistently long-lived like you and I, they can learn a lot about your notes as you go on. They'll become kind of a thinking partner or a companion for working on your specific Obsidian vault."

🎯 **Verdict:** The integration requires zero Obsidian plugins for basic read/write. The vault is just a folder. Letta Code (or Claude Code) accesses it via standard filesystem tools. The agent's persistent memory is what makes it context-aware over time.

---

## 2. Setup Process Shown in Demo

Cameron's setup sequence:

1. Download Obsidian, create a new vault, note the folder path on disk
2. `cd` into the vault folder in terminal
3. Install Letta Code globally: `npm install -g @letta-ai/letta-code`
4. Run `letta` from within the vault directory
5. Authenticate via OAuth
6. Create a new agent (no existing agent required)
7. Agent defaults to model `claude-sonnet-4-5` — Cameron switches to GPT during demo due to cloud instability at recording time

> "To get into Letta Code, just type letta like that... it asks which agent I want to use, but because this is a new account, I don't have any agents. So I'm just going to create a new one."

The agent is created in the context of the vault directory. Cameron's initial prompt explicitly orients the agent to its environment:

> "I'm introducing myself. I'm saying you're an agent designed to help us build a good Obsidian vault... I've helped it understand its environment, which you don't strictly need to do, but I think of it as like kind of good practice to help your agent understand as much as it possibly can about its operating environment."

🎯 **Verdict:** No complex setup. The vault directory is the working context. Orienting the agent with a system prompt or first message about the vault is recommended practice, not required.

---

## 3. Memory Architecture — How the Agent Learns the Vault

The agent automatically maintains memory blocks. Cameron observes after first interaction:

> "It's stored a bunch of information. Cameron likes collaborative work with short, personalized questions, values careful, thoughtful work, and creating content for YouTube. It's tracking information in its persona block, which is information about itself, like a personality... And then by default we include a project block which is... basically information about the vault."

Two key memory blocks in use:
- **Persona block** — agent identity, communication style
- **Human block** — information learned about the user (preferences, context, role)
- **Project block** — vault structure, location, operational context

Cameron notes a cross-agent memory sharing behavior:

> "By default in Letta Code, all of your new agents share the same block of information about you. So anytime you work with any agent anywhere on your computer, typically they will share memory, but you can disable this if you would like."

⚠️ **Gotcha — Shared Human Block:** By default, a new Letta Code agent will inherit the human memory block from other agents on the same machine. If LettaBot is running on the same machine as other Letta agents, it may pick up memory from unrelated contexts. This is configurable but must be explicitly managed.

---

## 4. File Access Pattern — How the Agent Reads and Writes Files

Cameron demonstrates the agent performing direct file edits throughout the demo. Key observations:

- The agent uses standard file read/write tool calls — no special Obsidian plugin or Local REST API is used at any point in this demo
- The agent creates new folders and files: `inbox/`, `concepts/`, `skills/`, reference notes, personal notes
- The agent runs Python scripts inline when it wants to batch-process files (Cameron disapproves of this pattern):

> "It's like trying to go download the page and then parse it separately to make it like easier to read. Yeah, I created this like weird script to like cause links. Like that's so lazy. I don't like that at all."

Cameron explicitly prefers direct tool edits over inline scripts:

> "I want the agent to actually do tool edits."

- The agent reads external URLs (web search, blog posts, documentation) and writes the results into vault notes
- The agent uses `find` and `grep`-style operations to locate files matching patterns before linking

🎯 **Verdict:** No Local REST API or Obsidian plugin is used or recommended in this demo. Pure filesystem access is the pattern. The agent reads and writes `.md` files directly. This is identical to how Claude Code operates in Nico's vault.

---

## 5. Vault Structure Conventions Demonstrated

Cameron does not import a pre-built structure. He asks the agent to build it from scratch based on his preferences (Zettelkasten, YouTube content focus, work/career domain). The agent generates:

- `inbox/` — low-friction capture layer, dump links and raw content here
- `concepts/` — stable, reusable concept notes (wiki-style, one idea per note)
- `skills/` — procedural memory documents for the agent
- `reference/` — external docs, product pages, distilled research
- Personal notes (e.g., `cameron.md`) — built by reading the user's public web presence

The agent also introduces **Maps of Content (MOC)** — essentially tables of contents / index notes that link related notes together. Cameron was not previously familiar with MOCs, suggesting this was agent-generated structure, not user-specified.

Cameron's explicit preference stated during setup:

> "Keep it minimal until structure emerges... don't overbuild."

⚠️ **Gotcha — Overbuild Risk:** The agent will proactively generate extensive folder structures and concept notes if given latitude. Cameron repeatedly steers it back toward minimalism. For Nico, this is relevant: LettaBot should not be given free rein to restructure the vault. Write permissions should be scoped.

---

## 6. Vault-as-Bridge: Does This Video Support or Contradict the Locked Decision?

Locked decision: **"Vault-as-bridge: Claude Code writes, LettaBot reads — never reverse on same file."**

The video shows Letta Code (which is functionally equivalent to having LettaBot with filesystem access) doing **both reads and writes** to the vault. Cameron's Letta Code agent writes files freely throughout the demo.

⚠️ **Architecture Conflict — Important:** This video depicts a single-agent model where one Letta Code agent both reads and writes the vault. Nico's architecture is a two-agent model (Claude Code writes, LettaBot reads). The video does NOT demonstrate the vault-as-bridge pattern and does NOT validate it — but it also does not contradict it. The video simply doesn't address multi-agent file access coordination.

The risk this video highlights: if LettaBot is also given write access (as Letta Code agents have by default), simultaneous writes from Claude Code and LettaBot to the same files will cause conflicts. The locked decision exists precisely to prevent this. The video is neutral on this point — it shows what's possible, not what's safe in a multi-agent setup.

🎯 **Verdict:** Vault-as-bridge decision remains sound and is not contradicted. The video confirms the technical capability (Letta agent can write vault files) but the locked decision correctly restricts LettaBot to read-only to prevent write conflicts with Claude Code.

---

## 7. Skills — Procedural Memory for the Agent

Cameron dedicates significant time to the `/skill` command:

> "A skill is just, you know, a document that says how to do a thing... These are things that are stored elsewhere, but your agent needs to be able to go look at to learn how to do on demand."

> "Skills are a huge part of continual learning because they store procedural knowledge. Memory, self-editing memory of the type that Letta agents are known for, is one part of the puzzle. Skills give you access to this infinite repository of things that your agent can do that it doesn't need to know all the time."

How skills work in practice:
- Triggered via `/skill [prompt]` in Letta Code
- The agent enters "skill creation mode" by loading a meta-skill that explains how to make skills
- The created skill document is stored in `/skills/` folder inside the vault
- Skills are loaded into core memory when needed — the agent "always knows" what skills are available

The demo skill created: "creating concepts" — a structured workflow for how to mine a source document into concept notes, link them, and densify the vault graph.

🎯 **Verdict:** Skills stored in the vault as markdown files are directly relevant to Nico. Nico's protocols (morning report, session handoff, cabinet spec processing) are candidates for skill documents. Claude Code can write them; LettaBot can load them.

---

## 8. Agent Naming and Pinning

Cameron names his agent "Archavist" after about an hour of working together:

> "I usually ask my agents what name they would like to give themselves."

Pinning: `/pin` opens a dialogue to name and pin an agent, making it accessible from any directory on the machine:

> "Pinning an agent allows you to access that agent anywhere on your computer. It's kind of a shortcut way for talking to different agents in case you want to work with it in other circumstances."

Cameron's personal pattern:

> "I personally like to have about one agent per project plus a personal agent that operates in a lot of different places."

🎯 **Verdict:** Pin LettaBot (Nico) after initial setup so it can be invoked from any directory, not just the vault folder. This is how a personal CoS should operate.

---

## 9. YOLO Mode — Auto-Approve Caution

Cameron enables YOLO mode (auto-approve all file edits) via Shift+Tab three times:

> "You should be very careful about using yolo mode, especially in like sensitive code situations. People have like accidentally destroyed their computers... you need to pay attention to your agents."

⚠️ **Warning:** Do not enable YOLO mode for LettaBot in Nico's vault unless all file writes are strictly scoped. The vault contains operational state that, if corrupted, would break Nico's entire knowledge layer.

---

## 10. Graph View and Backlinks

Cameron demonstrates Obsidian's graph view showing the agent-generated concept network. The agent adds inline backlinks via Obsidian query blocks. As the vault grows, the graph becomes a visual map of the agent's concept mining work. This is a feature of Obsidian itself, not Letta — but the agent actively constructs the link structure to make it useful.

---

## Extracted Architecture Decisions for Nico

1. **No plugin required for basic integration.** Letta Code and Claude Code both access the vault as a plain markdown filesystem. Local REST API is not needed for this use case.
2. **Orient LettaBot to the vault explicitly on first session.** Provide a system prompt or first-message context that describes the vault structure, its purpose, and LettaBot's role (read-only, CoS function).
3. **Shared human memory block is on by default.** If other Letta agents exist on the same machine, LettaBot will inherit their human block. Disable or isolate this to keep Nico's memory clean.
4. **Skills folder belongs in the vault.** Store Nico's procedural protocols as skill documents in `/skills/` or equivalent. Claude Code writes them; LettaBot loads them.
5. **Direct tool edits preferred over inline scripts.** When the agent writes vault files, it should use file edit tool calls, not generate and execute Python/shell scripts to batch-modify files.
6. **Pin LettaBot after setup** so it can be invoked from any working directory on the machine, not just the vault root.
7. **Write permissions must be scoped.** LettaBot should not have free-rein write access to the vault. The vault-as-bridge locked decision must be enforced at the operational level, not just assumed.
8. **Minimal structure, let it emerge.** Do not pre-scaffold every folder. Build what is needed, add structure as actual content demands it.

---

## What This Means for Nico

This video is the closest reference implementation available for Nico's architecture. The core loop Cameron demonstrates — drop content into inbox, agent mines it into concept notes, agent densifies links — is directly applicable to how Nico should process cabinet specs, client notes, and SaaS research.

The critical gap between the demo and Nico's architecture is the multi-agent coordination layer. Cameron runs a single Letta Code agent that does everything. Nico splits the work: Claude Code handles file writes (vault structure, session notes, deliverables), LettaBot handles reasoning and synthesis (reading vault state, running Telegram, memory). The vault-as-bridge pattern is the coordination mechanism, and this video confirms the technical plausibility of both sides of it.

The skills system is directly usable for Nico's morning protocol, session handoff, and cabinet workflows. Skills stored as markdown in the vault are first-class artifacts that both agents can reference.

One practical confirmation from this video: the agent's ability to read external URLs and write summaries into the vault is a key capability for Nico's research ingestion pipeline. LettaBot can be tasked with reading vendor pages, YouTube transcripts, or documentation and writing structured notes directly into the vault — as long as write access is managed.

---

## Related Notes

- [[BroTeuvX0es-lettabot-tutorial|LettaBot Tutorial]]
- [[p7So3IM75WY-memfs-letta-chat|MemFS, Letta Chat]]
- [[R_4r_NNjg1M-context-repositories|Context Repositories]]
- [[hFNWhrXukc0-archival-memory|Archival Memory]]
