import { useState } from "react";

const c = {
  bg: "#0f172a",
  card: "#1e293b",
  cardHover: "#334155",
  text: "#f1f5f9",
  muted: "#94a3b8",
  border: "#334155",
  agno: "#3b82f6",
  agnoGlow: "#3b82f633",
  letta: "#a855f7",
  lettaGlow: "#a855f733",
  both: "#22c55e",
  bothGlow: "#22c55e33",
  warn: "#f59e0b",
  red: "#ef4444",
  cyan: "#06b6d4",
};

function Badge({ color, children }) {
  return (
    <span style={{
      display: "inline-block", padding: "2px 10px", borderRadius: 9999,
      fontSize: 11, fontWeight: 600, background: color + "22",
      color, border: `1px solid ${color}44`,
    }}>{children}</span>
  );
}

function ScoreBar({ label, agnoScore, lettaScore, agnoNote, lettaNote }) {
  const maxWidth = 140;
  return (
    <div style={{ marginBottom: 16 }}>
      <div style={{ fontSize: 13, fontWeight: 700, color: c.text, marginBottom: 6 }}>{label}</div>
      <div style={{ display: "flex", gap: 20, flexWrap: "wrap" }}>
        <div style={{ flex: 1, minWidth: 180 }}>
          <div style={{ display: "flex", alignItems: "center", gap: 8, marginBottom: 4 }}>
            <span style={{ fontSize: 11, color: c.agno, fontWeight: 600, width: 50 }}>Agno</span>
            <div style={{ background: c.bg, borderRadius: 6, height: 14, width: maxWidth, overflow: "hidden" }}>
              <div style={{ background: c.agno, height: "100%", width: (agnoScore / 10) * maxWidth, borderRadius: 6, transition: "width 0.5s" }} />
            </div>
            <span style={{ fontSize: 11, color: c.muted }}>{agnoScore}/10</span>
          </div>
          <div style={{ fontSize: 10, color: c.muted, marginLeft: 58 }}>{agnoNote}</div>
        </div>
        <div style={{ flex: 1, minWidth: 180 }}>
          <div style={{ display: "flex", alignItems: "center", gap: 8, marginBottom: 4 }}>
            <span style={{ fontSize: 11, color: c.letta, fontWeight: 600, width: 50 }}>Letta</span>
            <div style={{ background: c.bg, borderRadius: 6, height: 14, width: maxWidth, overflow: "hidden" }}>
              <div style={{ background: c.letta, height: "100%", width: (lettaScore / 10) * maxWidth, borderRadius: 6, transition: "width 0.5s" }} />
            </div>
            <span style={{ fontSize: 11, color: c.muted }}>{lettaScore}/10</span>
          </div>
          <div style={{ fontSize: 10, color: c.muted, marginLeft: 58 }}>{lettaNote}</div>
        </div>
      </div>
    </div>
  );
}

function SectionTitle({ children, sub }) {
  return (
    <div style={{ textAlign: "center", marginBottom: 20 }}>
      <h2 style={{ fontSize: 22, fontWeight: 700, color: c.text, margin: 0 }}>{children}</h2>
      {sub && <p style={{ fontSize: 13, color: c.muted, margin: "4px 0 0" }}>{sub}</p>}
    </div>
  );
}

function IdentityView() {
  return (
    <div>
      <SectionTitle sub="What each tool actually IS at its core — they solve different problems">
        What They Are
      </SectionTitle>
      <div style={{ display: "flex", gap: 20, flexWrap: "wrap", justifyContent: "center", marginBottom: 24 }}>
        {/* Agno */}
        <div style={{ background: c.card, borderRadius: 16, padding: 20, border: `2px solid ${c.agno}`, width: 320, flexShrink: 0 }}>
          <div style={{ textAlign: "center", marginBottom: 12 }}>
            <div style={{ fontSize: 28, fontWeight: 900, color: c.agno }}>Agno</div>
            <div style={{ fontSize: 12, color: c.muted }}>formerly Phidata</div>
            <Badge color={c.agno}>FULL-STACK FRAMEWORK</Badge>
          </div>
          <div style={{ fontSize: 13, color: c.text, lineHeight: 1.7, marginBottom: 12 }}>
            <strong>Think of it as:</strong> The complete operating system for running an AI company. It gives you the framework to build agents, a production server to run them, and a dashboard to monitor them.
          </div>
          <div style={{ fontSize: 13, color: c.muted, lineHeight: 1.7, marginBottom: 12 }}>
            <strong style={{ color: c.text }}>Best analogy:</strong> Agno is like <strong style={{ color: c.agno }}>hiring a general contractor</strong> who brings the whole crew, tools, and project management. You tell them what to build, they handle everything.
          </div>
          <div style={{ fontSize: 12, color: c.muted, lineHeight: 1.6 }}>
            <strong style={{ color: c.text }}>Born from:</strong> Phidata, a developer tools company. Their DNA is production infrastructure — shipping software fast and reliably.
          </div>
        </div>

        {/* Letta */}
        <div style={{ background: c.card, borderRadius: 16, padding: 20, border: `2px solid ${c.letta}`, width: 320, flexShrink: 0 }}>
          <div style={{ textAlign: "center", marginBottom: 12 }}>
            <div style={{ fontSize: 28, fontWeight: 900, color: c.letta }}>Letta</div>
            <div style={{ fontSize: 12, color: c.muted }}>formerly MemGPT</div>
            <Badge color={c.letta}>MEMORY-FIRST PLATFORM</Badge>
          </div>
          <div style={{ fontSize: 13, color: c.text, lineHeight: 1.7, marginBottom: 12 }}>
            <strong>Think of it as:</strong> The world's best memory system for AI agents. It makes agents that remember everything — across conversations, days, months. Agents that actually learn and get better.
          </div>
          <div style={{ fontSize: 13, color: c.muted, lineHeight: 1.7, marginBottom: 12 }}>
            <strong style={{ color: c.text }}>Best analogy:</strong> Letta is like <strong style={{ color: c.letta }}>hiring a brilliant executive assistant</strong> with a photographic memory. They never forget a detail, but you still need to give them an office to work in.
          </div>
          <div style={{ fontSize: 12, color: c.muted, lineHeight: 1.6 }}>
            <strong style={{ color: c.text }}>Born from:</strong> UC Berkeley research (MemGPT paper). Their DNA is memory science — making AI agents that truly remember and learn.
          </div>
        </div>
      </div>

      {/* The key insight */}
      <div style={{ background: c.both + "11", border: `2px solid ${c.both}44`, borderRadius: 14, padding: 20, maxWidth: 680, margin: "0 auto", textAlign: "center" }}>
        <div style={{ fontSize: 16, fontWeight: 800, color: c.both, marginBottom: 8 }}>The Key Insight</div>
        <div style={{ fontSize: 14, color: c.text, lineHeight: 1.7 }}>
          They're not really competitors — they solve different problems. <strong style={{ color: c.agno }}>Agno</strong> is about <em>orchestrating agents at scale</em>. <strong style={{ color: c.letta }}>Letta</strong> is about <em>making agents that truly remember</em>. The best architecture might use <strong style={{ color: c.both }}>both</strong>.
        </div>
      </div>
    </div>
  );
}

function HeadToHeadView() {
  const categories = [
    { label: "Memory Depth", agnoScore: 7, lettaScore: 10, agnoNote: "3-tier memory: session, user, learned. Solid but newer.", lettaNote: "Gold standard. Core/recall/archival from MemGPT research. Agents edit own memory." },
    { label: "Multi-Agent Teams", agnoScore: 9, lettaScore: 5, agnoNote: "Built-in Team class. Leader/member pattern. First-class feature.", lettaNote: "Agent-to-agent calls exist, but no formal team orchestration layer." },
    { label: "Production Runtime", agnoScore: 9, lettaScore: 7, agnoNote: "FastAPI, horizontal scaling, 50+ APIs out of the box.", lettaNote: "REST API per agent. Solid, but less infrastructure tooling." },
    { label: "Monitoring / Dashboard", agnoScore: 9, lettaScore: 8, agnoNote: "AgentOS control plane. Full traces, logs, management UI.", lettaNote: "ADE (Agent Dev Environment). Real-time memory inspection. Great for debugging." },
    { label: "Tool Integrations", agnoScore: 9, lettaScore: 6, agnoNote: "100+ toolkits. MCP support. Slack, email, DBs, everything.", lettaNote: "MCP support. Growing ecosystem, but fewer out-of-box integrations." },
    { label: "Learning Over Time", agnoScore: 7, lettaScore: 10, agnoNote: "Agentic Memory feature is promising but newer.", lettaNote: "Core to its identity. Sleep-time compute. Agents refine knowledge when idle." },
    { label: "Ease of Setup", agnoScore: 8, lettaScore: 6, agnoNote: "Clean docs, pip install, straightforward Python API.", lettaNote: "Docker-based server. More moving parts to get running." },
    { label: "Human-in-the-Loop", agnoScore: 9, lettaScore: 6, agnoNote: "Built-in approval workflows, confirmation, external tool execution.", lettaNote: "Possible but not a first-class feature. You'd build it yourself." },
    { label: "Model Flexibility", agnoScore: 9, lettaScore: 8, agnoNote: "Any model. OpenAI, Claude, Gemini, Ollama, etc.", lettaNote: "Model-agnostic. Even supports models without tool-calling." },
    { label: "Community & Momentum", agnoScore: 9, lettaScore: 7, agnoNote: "18k+ GitHub stars. Very active. Strong docs.", lettaNote: "13k+ stars. Research-driven community. Growing fast." },
  ];

  return (
    <div>
      <SectionTitle sub="Scored 1-10 by a senior architect evaluating for your specific use case">
        Head-to-Head Comparison
      </SectionTitle>
      <div style={{ background: c.card, borderRadius: 14, padding: 20, maxWidth: 700, margin: "0 auto" }}>
        {categories.map((cat, i) => (
          <div key={i}>
            <ScoreBar {...cat} />
            {i < categories.length - 1 && <div style={{ borderBottom: `1px solid ${c.border}`, marginBottom: 16 }} />}
          </div>
        ))}
      </div>

      <div style={{ display: "flex", gap: 16, justifyContent: "center", marginTop: 20, flexWrap: "wrap" }}>
        <div style={{ background: c.card, borderRadius: 12, padding: 14, border: `1px solid ${c.agno}44`, textAlign: "center", width: 200 }}>
          <div style={{ fontSize: 28, fontWeight: 900, color: c.agno }}>85</div>
          <div style={{ fontSize: 12, color: c.muted }}>Agno Total Score</div>
          <div style={{ fontSize: 11, color: c.agno, marginTop: 4 }}>Wins: Teams, Runtime, Tools, HITL</div>
        </div>
        <div style={{ background: c.card, borderRadius: 12, padding: 14, border: `1px solid ${c.letta}44`, textAlign: "center", width: 200 }}>
          <div style={{ fontSize: 28, fontWeight: 900, color: c.letta }}>73</div>
          <div style={{ fontSize: 12, color: c.muted }}>Letta Total Score</div>
          <div style={{ fontSize: 11, color: c.letta, marginTop: 4 }}>Wins: Memory, Learning</div>
        </div>
      </div>
    </div>
  );
}

function ArchitectureView() {
  return (
    <div>
      <SectionTitle sub="Three possible ways to build your system — and which one a senior architect would pick">
        Architecture Options
      </SectionTitle>

      <div style={{ display: "flex", flexDirection: "column", gap: 20, maxWidth: 700, margin: "0 auto" }}>
        {/* Option A */}
        <div style={{ background: c.card, borderRadius: 14, padding: 20, border: `1px solid ${c.border}` }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 12 }}>
            <div>
              <div style={{ fontSize: 16, fontWeight: 800, color: c.agno }}>Option A: Agno Only</div>
              <div style={{ fontSize: 12, color: c.muted }}>Use Agno for everything — agents, memory, runtime, tools</div>
            </div>
            <Badge color={c.warn}>SIMPLER</Badge>
          </div>
          <div style={{ fontSize: 13, color: c.muted, lineHeight: 1.7, marginBottom: 12 }}>
            You build Jarvis and all specialist agents in Agno. Use Agno's built-in memory (session + user + learned). Run the whole thing on FastAPI on your M1. One framework, one codebase, one system to learn.
          </div>
          <div style={{ display: "flex", gap: 8, flexWrap: "wrap", marginBottom: 12 }}>
            {["Faster to build", "One thing to learn", "Great team orchestration", "100+ tool integrations", "Production-ready day 1"].map((p, i) => (
              <span key={i} style={{ fontSize: 10, padding: "3px 10px", borderRadius: 6, background: c.both + "22", color: c.both, border: `1px solid ${c.both}44` }}>✓ {p}</span>
            ))}
          </div>
          <div style={{ display: "flex", gap: 8, flexWrap: "wrap" }}>
            {["Memory not as deep as Letta", "Learning features are newer/less proven", "No sleep-time compute"].map((p, i) => (
              <span key={i} style={{ fontSize: 10, padding: "3px 10px", borderRadius: 6, background: c.red + "22", color: c.red, border: `1px solid ${c.red}44` }}>✗ {p}</span>
            ))}
          </div>
        </div>

        {/* Option B */}
        <div style={{ background: c.card, borderRadius: 14, padding: 20, border: `1px solid ${c.border}` }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 12 }}>
            <div>
              <div style={{ fontSize: 16, fontWeight: 800, color: c.letta }}>Option B: Letta Only</div>
              <div style={{ fontSize: 12, color: c.muted }}>Use Letta for everything — agents with world-class memory</div>
            </div>
            <Badge color={c.warn}>MEMORY-FIRST</Badge>
          </div>
          <div style={{ fontSize: 13, color: c.muted, lineHeight: 1.7, marginBottom: 12 }}>
            You build every agent in Letta. Each one gets the full MemGPT memory stack. They remember everything forever. Agent-to-agent communication for coordination.
          </div>
          <div style={{ display: "flex", gap: 8, flexWrap: "wrap", marginBottom: 12 }}>
            {["Best-in-class memory", "Agents learn over time", "Sleep-time compute", "Research-backed architecture", "Agent Dev Environment for debugging"].map((p, i) => (
              <span key={i} style={{ fontSize: 10, padding: "3px 10px", borderRadius: 6, background: c.both + "22", color: c.both, border: `1px solid ${c.both}44` }}>✓ {p}</span>
            ))}
          </div>
          <div style={{ display: "flex", gap: 8, flexWrap: "wrap" }}>
            {["Weaker team orchestration", "Fewer tool integrations", "More complex to set up", "No built-in approval workflows", "You'd build the CoS pattern yourself"].map((p, i) => (
              <span key={i} style={{ fontSize: 10, padding: "3px 10px", borderRadius: 6, background: c.red + "22", color: c.red, border: `1px solid ${c.red}44` }}>✗ {p}</span>
            ))}
          </div>
        </div>

        {/* Option C - Recommended */}
        <div style={{ background: c.card, borderRadius: 14, padding: 20, border: `2px solid ${c.both}`, boxShadow: `0 4px 20px ${c.bothGlow}` }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 12 }}>
            <div>
              <div style={{ fontSize: 16, fontWeight: 800, color: c.both }}>Option C: Agno + Letta Together</div>
              <div style={{ fontSize: 12, color: c.muted }}>Agno runs the show. Letta provides the memory.</div>
            </div>
            <Badge color={c.both}>RECOMMENDED</Badge>
          </div>
          <div style={{ fontSize: 13, color: c.muted, lineHeight: 1.7, marginBottom: 12 }}>
            Use <strong style={{ color: c.agno }}>Agno</strong> for what it's best at: agent orchestration, team coordination, tool integrations, production runtime, human-in-the-loop approvals. Use <strong style={{ color: c.letta }}>Letta</strong> for what it's best at: deep persistent memory that learns and improves. Letta becomes a <strong style={{ color: c.text }}>memory service</strong> that Agno agents call via API — like a shared brain.
          </div>
          <div style={{ display: "flex", gap: 8, flexWrap: "wrap", marginBottom: 12 }}>
            {["Best of both worlds", "Agno handles orchestration", "Letta handles memory", "Agents learn AND coordinate", "Production-ready", "Approval workflows built-in", "100+ tools available"].map((p, i) => (
              <span key={i} style={{ fontSize: 10, padding: "3px 10px", borderRadius: 6, background: c.both + "22", color: c.both, border: `1px solid ${c.both}44` }}>✓ {p}</span>
            ))}
          </div>
          <div style={{ display: "flex", gap: 8, flexWrap: "wrap", marginBottom: 16 }}>
            {["Two systems to maintain", "More initial setup", "Slightly more complexity"].map((p, i) => (
              <span key={i} style={{ fontSize: 10, padding: "3px 10px", borderRadius: 6, background: c.warn + "22", color: c.warn, border: `1px solid ${c.warn}44` }}>~ {p}</span>
            ))}
          </div>

          {/* Architecture diagram */}
          <div style={{ background: c.bg, borderRadius: 12, padding: 16, border: `1px solid ${c.border}` }}>
            <div style={{ textAlign: "center", fontSize: 12, fontWeight: 700, color: c.text, marginBottom: 12 }}>How They Fit Together on Your M1</div>
            <div style={{ display: "flex", flexDirection: "column", alignItems: "center", gap: 8 }}>
              <div style={{ padding: "8px 20px", background: c.agno + "22", borderRadius: 8, border: `1px solid ${c.agno}`, fontSize: 12, color: c.agno, fontWeight: 600, textAlign: "center" }}>
                Agno Runtime (FastAPI) — The front door. All requests come here.
              </div>
              <div style={{ fontSize: 18, color: c.muted }}>↓</div>
              <div style={{ display: "flex", gap: 12, flexWrap: "wrap", justifyContent: "center" }}>
                <div style={{ padding: "8px 14px", background: c.agno + "11", borderRadius: 8, border: `1px solid ${c.agno}44`, fontSize: 11, color: c.muted, textAlign: "center", width: 130 }}>
                  <div style={{ color: c.agno, fontWeight: 600 }}>Jarvis (Team)</div>
                  Agent orchestration
                </div>
                <div style={{ padding: "8px 14px", background: c.agno + "11", borderRadius: 8, border: `1px solid ${c.agno}44`, fontSize: 11, color: c.muted, textAlign: "center", width: 130 }}>
                  <div style={{ color: c.agno, fontWeight: 600 }}>Specialists</div>
                  Ops, Dev, Comms
                </div>
                <div style={{ padding: "8px 14px", background: c.agno + "11", borderRadius: 8, border: `1px solid ${c.agno}44`, fontSize: 11, color: c.muted, textAlign: "center", width: 130 }}>
                  <div style={{ color: c.agno, fontWeight: 600 }}>MCP Tools</div>
                  Obsidian, Gmail, etc.
                </div>
              </div>
              <div style={{ fontSize: 18, color: c.muted }}>↕</div>
              <div style={{ padding: "8px 20px", background: c.letta + "22", borderRadius: 8, border: `1px solid ${c.letta}`, fontSize: 12, color: c.letta, fontWeight: 600, textAlign: "center" }}>
                Letta Memory Service (Docker) — The shared brain. All agents read/write memory here.
              </div>
              <div style={{ display: "flex", gap: 12, flexWrap: "wrap", justifyContent: "center" }}>
                <div style={{ padding: "6px 12px", background: c.letta + "11", borderRadius: 8, border: `1px solid ${c.letta}44`, fontSize: 10, color: c.muted, textAlign: "center" }}>
                  Core Memory (always loaded)
                </div>
                <div style={{ padding: "6px 12px", background: c.letta + "11", borderRadius: 8, border: `1px solid ${c.letta}44`, fontSize: 10, color: c.muted, textAlign: "center" }}>
                  Recall Memory (searchable history)
                </div>
                <div style={{ padding: "6px 12px", background: c.letta + "11", borderRadius: 8, border: `1px solid ${c.letta}44`, fontSize: 10, color: c.muted, textAlign: "center" }}>
                  Archival Memory (long-term knowledge)
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

function VerdictView() {
  return (
    <div>
      <SectionTitle sub="The 25-year architect's honest recommendation for your specific situation">
        The Verdict
      </SectionTitle>
      <div style={{ maxWidth: 660, margin: "0 auto" }}>
        {/* Context */}
        <div style={{ background: c.card, borderRadius: 14, padding: 20, border: `1px solid ${c.border}`, marginBottom: 20 }}>
          <div style={{ fontSize: 14, fontWeight: 700, color: c.text, marginBottom: 8 }}>Your Situation</div>
          <div style={{ fontSize: 13, color: c.muted, lineHeight: 1.8 }}>
            You're a first-year CS student building an AI-native business. You need a system that's powerful enough to grow into, simple enough to learn, and reliable enough to trust with real business operations. You already have a Letta agent (Memo) running. You're building on an M1 + M3 + iPhone setup.
          </div>
        </div>

        {/* Recommendation */}
        <div style={{ background: c.card, borderRadius: 14, padding: 20, border: `2px solid ${c.both}`, marginBottom: 20 }}>
          <div style={{ fontSize: 16, fontWeight: 800, color: c.both, marginBottom: 10 }}>Recommendation: Start with Agno. Keep Letta for Memory.</div>
          <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
            <div style={{ padding: 14, background: c.bg, borderRadius: 10, border: `1px solid ${c.border}` }}>
              <div style={{ fontSize: 13, fontWeight: 700, color: c.agno, marginBottom: 4 }}>Phase 1: Learn Agno (Weeks 1-4)</div>
              <div style={{ fontSize: 12, color: c.muted, lineHeight: 1.6 }}>
                Build Jarvis as a single agent in Agno. Connect it to your Obsidian vault via MCP. Get comfortable with the framework. This gives you the orchestration layer, production server, and tool integrations — the stuff that's hardest to build yourself.
              </div>
            </div>
            <div style={{ padding: 14, background: c.bg, borderRadius: 10, border: `1px solid ${c.border}` }}>
              <div style={{ fontSize: 13, fontWeight: 700, color: c.letta, marginBottom: 4 }}>Phase 2: Plug In Letta (Weeks 5-8)</div>
              <div style={{ fontSize: 12, color: c.muted, lineHeight: 1.6 }}>
                Your Memo agent already runs on Letta. Instead of replacing it, connect it to Jarvis as a memory service. Agno agents call Letta's API to read/write persistent memory. This gives you the best memory system in the industry without rebuilding anything.
              </div>
            </div>
            <div style={{ padding: 14, background: c.bg, borderRadius: 10, border: `1px solid ${c.border}` }}>
              <div style={{ fontSize: 13, fontWeight: 700, color: c.both, marginBottom: 4 }}>Phase 3: Scale the Team (Month 3+)</div>
              <div style={{ fontSize: 12, color: c.muted, lineHeight: 1.6 }}>
                Add specialist agents in Agno, each with access to Letta memory. The CoS pattern kicks in — Jarvis orchestrates, specialists execute, Letta remembers. You're running an AI-native operation.
              </div>
            </div>
          </div>
        </div>

        {/* Why not just one */}
        <div style={{ background: c.card, borderRadius: 14, padding: 20, border: `1px solid ${c.border}`, marginBottom: 20 }}>
          <div style={{ fontSize: 14, fontWeight: 700, color: c.text, marginBottom: 10 }}>Why Not Just Pick One?</div>
          <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>
            <div style={{ fontSize: 13, color: c.muted, lineHeight: 1.6 }}>
              <strong style={{ color: c.agno }}>Agno only?</strong> You'd get great orchestration but weaker memory. For a CoS agent that needs to remember 35 years of cabinet business knowledge, client preferences, and ongoing project state — that's a real gap.
            </div>
            <div style={{ fontSize: 13, color: c.muted, lineHeight: 1.6 }}>
              <strong style={{ color: c.letta }}>Letta only?</strong> You'd get incredible memory but have to build the team orchestration, approval workflows, and production infrastructure yourself. That's months of work for a first-year CS student.
            </div>
            <div style={{ fontSize: 13, color: c.muted, lineHeight: 1.6 }}>
              <strong style={{ color: c.both }}>Together?</strong> Each does what it's best at. Agno is the body (action, coordination, tools). Letta is the brain (memory, learning, context). You wouldn't hire someone with a great memory but no arms, or a great worker with amnesia. You want both.
            </div>
          </div>
        </div>

        {/* Reality check */}
        <div style={{ background: c.warn + "11", border: `1px solid ${c.warn}44`, borderRadius: 14, padding: 20 }}>
          <div style={{ fontSize: 14, fontWeight: 700, color: c.warn, marginBottom: 8 }}>Reality Check from the Architect</div>
          <div style={{ fontSize: 13, color: c.muted, lineHeight: 1.8 }}>
            Both Agno and Letta are evolving fast. Agno's memory could get as good as Letta's in 6 months. Letta could add better team orchestration. The AI framework landscape in Feb 2026 will look different by August 2026. The recommendation above is based on where things stand <em>today</em>. The good news: because both are open source and self-hosted, you're never locked in. If Agno's memory gets great, you can drop Letta. If Letta adds teams, you could consolidate there. You own the data either way.
          </div>
        </div>
      </div>
    </div>
  );
}

export default function AgnoVsLetta() {
  const [view, setView] = useState("identity");

  return (
    <div style={{ background: c.bg, minHeight: "100vh", padding: "24px 20px", fontFamily: "-apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif" }}>
      <div style={{ textAlign: "center", marginBottom: 24 }}>
        <h1 style={{ fontSize: 28, fontWeight: 900, color: c.text, margin: 0 }}>
          <span style={{ color: c.agno }}>Agno</span> vs <span style={{ color: c.letta }}>Letta</span>
        </h1>
        <p style={{ fontSize: 14, color: c.muted, margin: "6px 0 0" }}>
          Deep Comparison for the Agent Chief of Staff Architecture
        </p>
      </div>

      <div style={{ display: "flex", justifyContent: "center", gap: 8, marginBottom: 28, flexWrap: "wrap" }}>
        {[
          { id: "identity", label: "What They Are" },
          { id: "headtohead", label: "Head-to-Head" },
          { id: "architecture", label: "Architecture Options" },
          { id: "verdict", label: "The Verdict" },
        ].map((tab) => (
          <button key={tab.id} onClick={() => setView(tab.id)} style={{
            padding: "8px 18px", borderRadius: 9999, border: "none", fontSize: 13, fontWeight: 600, cursor: "pointer",
            background: view === tab.id ? c.both : c.card,
            color: view === tab.id ? "white" : c.muted,
          }}>{tab.label}</button>
        ))}
      </div>

      <div style={{ maxWidth: 860, margin: "0 auto" }}>
        {view === "identity" && <IdentityView />}
        {view === "headtohead" && <HeadToHeadView />}
        {view === "architecture" && <ArchitectureView />}
        {view === "verdict" && <VerdictView />}
      </div>

      <div style={{ textAlign: "center", marginTop: 40, padding: "16px 0", borderTop: `1px solid ${c.border}` }}>
        <div style={{ fontSize: 11, color: c.muted }}>
          Agno vs Letta Deep Dive v1.0 — Built for Vincent James / Lucavo Design — Feb 28, 2026
        </div>
      </div>
    </div>
  );
}