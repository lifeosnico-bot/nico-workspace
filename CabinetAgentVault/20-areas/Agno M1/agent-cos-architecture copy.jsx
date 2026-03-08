import { useState } from "react";

const colors = {
  bg: "#0f172a",
  card: "#1e293b",
  cardHover: "#334155",
  accent: "#3b82f6",
  accentLight: "#60a5fa",
  green: "#22c55e",
  greenDark: "#15803d",
  orange: "#f59e0b",
  orangeDark: "#b45309",
  purple: "#a855f7",
  purpleDark: "#7e22ce",
  pink: "#ec4899",
  pinkDark: "#be185d",
  cyan: "#06b6d4",
  cyanDark: "#0e7490",
  text: "#f1f5f9",
  textMuted: "#94a3b8",
  border: "#334155",
  line: "#475569",
};

const views = ["hierarchy", "dataflow", "infrastructure", "dayinlife"];

function Badge({ color, children }) {
  return (
    <span
      style={{
        display: "inline-block",
        padding: "2px 10px",
        borderRadius: 9999,
        fontSize: 11,
        fontWeight: 600,
        background: color + "22",
        color: color,
        border: `1px solid ${color}44`,
      }}
    >
      {children}
    </span>
  );
}

function AgentCard({ name, role, color, tools, description, badge }) {
  const [hover, setHover] = useState(false);
  return (
    <div
      onMouseEnter={() => setHover(true)}
      onMouseLeave={() => setHover(false)}
      style={{
        background: hover ? colors.cardHover : colors.card,
        border: `2px solid ${color}`,
        borderRadius: 12,
        padding: 16,
        minWidth: 200,
        maxWidth: 260,
        transition: "all 0.2s",
        transform: hover ? "translateY(-2px)" : "none",
        boxShadow: hover ? `0 8px 24px ${color}33` : "none",
        cursor: "default",
      }}
    >
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 6 }}>
        <span style={{ fontWeight: 700, fontSize: 15, color: colors.text }}>{name}</span>
        {badge && <Badge color={color}>{badge}</Badge>}
      </div>
      <div style={{ fontSize: 12, color: color, fontWeight: 600, marginBottom: 8 }}>{role}</div>
      <div style={{ fontSize: 12, color: colors.textMuted, lineHeight: 1.5, marginBottom: 10 }}>{description}</div>
      {tools && (
        <div style={{ display: "flex", flexWrap: "wrap", gap: 4 }}>
          {tools.map((t, i) => (
            <span
              key={i}
              style={{
                fontSize: 10,
                padding: "2px 8px",
                borderRadius: 6,
                background: colors.bg,
                color: colors.textMuted,
                border: `1px solid ${colors.border}`,
              }}
            >
              {t}
            </span>
          ))}
        </div>
      )}
    </div>
  );
}

function ConnectorLine({ label, direction = "down", color = colors.line }) {
  if (direction === "down") {
    return (
      <div style={{ display: "flex", flexDirection: "column", alignItems: "center", margin: "4px 0" }}>
        <div style={{ width: 2, height: 24, background: color }} />
        {label && (
          <span style={{ fontSize: 10, color: colors.textMuted, margin: "2px 0", fontStyle: "italic" }}>{label}</span>
        )}
        <div style={{ width: 0, height: 0, borderLeft: "6px solid transparent", borderRight: "6px solid transparent", borderTop: `8px solid ${color}` }} />
      </div>
    );
  }
  return null;
}

function SectionTitle({ children, subtitle }) {
  return (
    <div style={{ textAlign: "center", marginBottom: 24 }}>
      <h2 style={{ fontSize: 22, fontWeight: 700, color: colors.text, margin: 0 }}>{children}</h2>
      {subtitle && <p style={{ fontSize: 13, color: colors.textMuted, margin: "4px 0 0" }}>{subtitle}</p>}
    </div>
  );
}

function HierarchyView() {
  return (
    <div style={{ display: "flex", flexDirection: "column", alignItems: "center" }}>
      <SectionTitle subtitle="Who reports to whom — just like a real company org chart">
        Agent Org Chart
      </SectionTitle>

      {/* Vincent */}
      <div
        style={{
          background: `linear-gradient(135deg, ${colors.accent}, ${colors.purple})`,
          borderRadius: 16,
          padding: "16px 32px",
          textAlign: "center",
          boxShadow: `0 4px 20px ${colors.accent}44`,
        }}
      >
        <div style={{ fontSize: 20, fontWeight: 800, color: "white" }}>Vincent</div>
        <div style={{ fontSize: 12, color: "rgba(255,255,255,0.8)" }}>CEO / Founder</div>
        <div style={{ fontSize: 11, color: "rgba(255,255,255,0.6)", marginTop: 4 }}>
          Makes final decisions. Approves big moves.
        </div>
      </div>

      <ConnectorLine label="talks to ONE agent" color={colors.accent} />

      {/* CoS */}
      <AgentCard
        name="Jarvis"
        role="Chief of Staff Agent"
        color={colors.accent}
        badge="TEAM LEAD"
        description="Your right hand. Holds all context, manages priorities, delegates to specialists. You only talk to Jarvis — Jarvis talks to everyone else."
        tools={["Obsidian", "Letta Memory", "Email", "Calendar", "Agent Dispatch"]}
      />

      <ConnectorLine label="delegates tasks to specialists" color={colors.accent} />

      {/* Specialist Agents */}
      <div style={{ display: "flex", gap: 16, flexWrap: "wrap", justifyContent: "center", maxWidth: 800 }}>
        <AgentCard
          name="Ops Agent"
          role="Lucavo Operations"
          color={colors.green}
          badge="SPECIALIST"
          description="Handles the cabinet business — client projects, drawings, site schedules, material orders. Knows your 35 years of ops."
          tools={["Obsidian", "PDF Reader", "File System", "Client DB"]}
        />
        <AgentCard
          name="Dev Agent"
          role="SaaS Development"
          color={colors.purple}
          badge="SPECIALIST"
          description="Manages the software side — Client Portal, Cabinet SaaS, code tasks. Tracks bugs, features, and sprint progress."
          tools={["GitHub", "Supabase", "Code Tools", "Vercel"]}
        />
        <AgentCard
          name="Comms Agent"
          role="Communications"
          color={colors.orange}
          badge="SPECIALIST"
          description="Drafts emails, schedules meetings, manages your inbox. Never sends without your approval."
          tools={["Gmail", "Calendar", "Slack", "Contacts"]}
        />
      </div>

      <div style={{ marginTop: 16, display: "flex", gap: 16, flexWrap: "wrap", justifyContent: "center" }}>
        <AgentCard
          name="Research Agent"
          role="Research & Analysis"
          color={colors.cyan}
          badge="SPECIALIST"
          description="Looks things up — vendors, pricing, competitors, technical docs. Summarizes findings for you."
          tools={["Web Search", "Doc Analysis", "Summarizer"]}
        />
        <AgentCard
          name="Future Agents..."
          role="As You Need Them"
          color={colors.textMuted}
          description="The system grows with you. Need a bookkeeping agent? A marketing agent? The CoS can onboard new specialists as your business scales."
          tools={["Defined by need"]}
        />
      </div>

      {/* Trust explanation */}
      <div
        style={{
          marginTop: 24,
          padding: 16,
          background: colors.card,
          borderRadius: 12,
          border: `1px solid ${colors.border}`,
          maxWidth: 600,
          textAlign: "center",
        }}
      >
        <div style={{ fontSize: 14, fontWeight: 700, color: colors.accent, marginBottom: 6 }}>
          The Trust Rule
        </div>
        <div style={{ fontSize: 13, color: colors.textMuted, lineHeight: 1.6 }}>
          Specialists can <strong style={{ color: colors.green }}>read anything</strong> they need.
          But they can only <strong style={{ color: colors.orange }}>write/send/change</strong> things
          after <strong style={{ color: colors.text }}>Jarvis reviews it</strong> and
          <strong style={{ color: colors.accent }}> you approve it</strong>.
          Think of it like a real company — employees draft, managers review, the CEO signs off.
        </div>
      </div>
    </div>
  );
}

function DataFlowView() {
  const steps = [
    { icon: "🗣️", label: 'You say:', example: '"Jarvis, what\'s my status today?"', color: colors.accent },
    { icon: "🧠", label: "Jarvis checks memory", example: "Reads Letta memory blocks for current state — projects, deadlines, recent activity", color: colors.purple },
    { icon: "📂", label: "Jarvis checks Obsidian", example: "Scans your vault — open tasks, project notes, daily note, inbox items", color: colors.green },
    { icon: "📡", label: "Jarvis dispatches specialists", example: "Asks Ops Agent for cabinet deadlines, Dev Agent for code status, Comms Agent for unread emails", color: colors.orange },
    { icon: "🔄", label: "Specialists report back", example: "Each agent returns a summary of their domain to Jarvis", color: colors.cyan },
    { icon: "📋", label: "Jarvis synthesizes", example: "Combines everything into one clear briefing, prioritized by urgency", color: colors.pink },
    { icon: "✅", label: "You get ONE answer", example: '"You have 3 priorities today: Miller install at 2pm, portal bug fix, and a vendor email to approve."', color: colors.accent },
  ];

  return (
    <div>
      <SectionTitle subtitle="What happens when you ask Jarvis a question — step by step">
        How a Request Flows Through the System
      </SectionTitle>
      <div style={{ display: "flex", flexDirection: "column", alignItems: "center", gap: 4 }}>
        {steps.map((step, i) => (
          <div key={i}>
            <div
              style={{
                display: "flex",
                alignItems: "center",
                gap: 16,
                background: colors.card,
                borderRadius: 12,
                padding: "14px 20px",
                border: `1px solid ${step.color}44`,
                maxWidth: 560,
                width: "100%",
              }}
            >
              <div
                style={{
                  width: 40,
                  height: 40,
                  borderRadius: "50%",
                  background: step.color + "22",
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                  fontSize: 20,
                  flexShrink: 0,
                }}
              >
                {step.icon}
              </div>
              <div style={{ flex: 1 }}>
                <div style={{ fontSize: 13, fontWeight: 700, color: step.color }}>{`Step ${i + 1}: ${step.label}`}</div>
                <div style={{ fontSize: 12, color: colors.textMuted, lineHeight: 1.4, marginTop: 2 }}>{step.example}</div>
              </div>
            </div>
            {i < steps.length - 1 && (
              <div style={{ display: "flex", justifyContent: "center" }}>
                <div style={{ width: 2, height: 12, background: colors.line }} />
              </div>
            )}
          </div>
        ))}
      </div>
    </div>
  );
}

function InfrastructureView() {
  return (
    <div>
      <SectionTitle subtitle="Your actual hardware and what runs on each machine">
        Infrastructure Map
      </SectionTitle>

      <div style={{ display: "flex", gap: 20, flexWrap: "wrap", justifyContent: "center" }}>
        {/* M1 */}
        <div
          style={{
            background: colors.card,
            borderRadius: 16,
            padding: 20,
            border: `2px solid ${colors.green}`,
            width: 260,
            flexShrink: 0,
          }}
        >
          <div style={{ fontSize: 28, textAlign: "center", marginBottom: 8 }}>🖥️</div>
          <div style={{ textAlign: "center", fontWeight: 800, fontSize: 16, color: colors.text }}>M1 MacBook Air</div>
          <div style={{ textAlign: "center", fontSize: 12, color: colors.green, fontWeight: 600, marginBottom: 12 }}>
            "The Brain" — Always On
          </div>
          <div style={{ fontSize: 12, color: colors.textMuted, lineHeight: 1.6, marginBottom: 12 }}>
            Sits at home or office, lid closed, always running. This is your server — the thing that never sleeps.
          </div>
          <div style={{ display: "flex", flexDirection: "column", gap: 6 }}>
            {[
              { name: "Docker", desc: "Container that holds everything" },
              { name: "Agno Runtime", desc: "FastAPI server — the agent engine" },
              { name: "Letta", desc: "Persistent memory — remembers everything" },
              { name: "Obsidian Vault", desc: "Your knowledge base (synced)" },
              { name: "MCP Servers", desc: "Connectors to tools & services" },
            ].map((item, i) => (
              <div
                key={i}
                style={{
                  padding: "6px 10px",
                  background: colors.bg,
                  borderRadius: 8,
                  border: `1px solid ${colors.border}`,
                }}
              >
                <div style={{ fontSize: 11, fontWeight: 700, color: colors.green }}>{item.name}</div>
                <div style={{ fontSize: 10, color: colors.textMuted }}>{item.desc}</div>
              </div>
            ))}
          </div>
        </div>

        {/* M3 */}
        <div
          style={{
            background: colors.card,
            borderRadius: 16,
            padding: 20,
            border: `2px solid ${colors.accent}`,
            width: 260,
            flexShrink: 0,
          }}
        >
          <div style={{ fontSize: 28, textAlign: "center", marginBottom: 8 }}>💻</div>
          <div style={{ textAlign: "center", fontWeight: 800, fontSize: 16, color: colors.text }}>M3 MacBook Pro</div>
          <div style={{ textAlign: "center", fontSize: 12, color: colors.accent, fontWeight: 600, marginBottom: 12 }}>
            "The Workstation" — Where You Work
          </div>
          <div style={{ fontSize: 12, color: colors.textMuted, lineHeight: 1.6, marginBottom: 12 }}>
            Your daily driver. Code, design, manage. Talks to the M1 brain over your local network or SSH.
          </div>
          <div style={{ display: "flex", flexDirection: "column", gap: 6 }}>
            {[
              { name: "Claude Code / Cowork", desc: "Direct AI work (what you use now)" },
              { name: "VS Code", desc: "Code editor for SaaS dev" },
              { name: "Obsidian App", desc: "Visual access to your vault" },
              { name: "Terminal / SSH", desc: "Connects to M1 when needed" },
              { name: "Browser", desc: "Agno dashboard on M1" },
            ].map((item, i) => (
              <div
                key={i}
                style={{
                  padding: "6px 10px",
                  background: colors.bg,
                  borderRadius: 8,
                  border: `1px solid ${colors.border}`,
                }}
              >
                <div style={{ fontSize: 11, fontWeight: 700, color: colors.accent }}>{item.name}</div>
                <div style={{ fontSize: 10, color: colors.textMuted }}>{item.desc}</div>
              </div>
            ))}
          </div>
        </div>

        {/* iPhone */}
        <div
          style={{
            background: colors.card,
            borderRadius: 16,
            padding: 20,
            border: `2px solid ${colors.orange}`,
            width: 260,
            flexShrink: 0,
          }}
        >
          <div style={{ fontSize: 28, textAlign: "center", marginBottom: 8 }}>📱</div>
          <div style={{ textAlign: "center", fontWeight: 800, fontSize: 16, color: colors.text }}>iPhone</div>
          <div style={{ textAlign: "center", fontSize: 12, color: colors.orange, fontWeight: 600, marginBottom: 12 }}>
            "The Field Radio" — On the Go
          </div>
          <div style={{ fontSize: 12, color: colors.textMuted, lineHeight: 1.6, marginBottom: 12 }}>
            When you're at a cabinet site, in the truck, or away from your desk. Voice or text to Jarvis.
          </div>
          <div style={{ display: "flex", flexDirection: "column", gap: 6 }}>
            {[
              { name: "Happy App", desc: "Voice/chat interface to Jarvis" },
              { name: "Obsidian Mobile", desc: "View vault notes on the go" },
              { name: "iMessage / Slack", desc: "Notifications from agents" },
            ].map((item, i) => (
              <div
                key={i}
                style={{
                  padding: "6px 10px",
                  background: colors.bg,
                  borderRadius: 8,
                  border: `1px solid ${colors.border}`,
                }}
              >
                <div style={{ fontSize: 11, fontWeight: 700, color: colors.orange }}>{item.name}</div>
                <div style={{ fontSize: 10, color: colors.textMuted }}>{item.desc}</div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Connection arrows */}
      <div style={{ textAlign: "center", margin: "20px 0" }}>
        <div
          style={{
            display: "inline-flex",
            gap: 16,
            background: colors.card,
            padding: "12px 24px",
            borderRadius: 12,
            border: `1px solid ${colors.border}`,
          }}
        >
          <span style={{ fontSize: 12, color: colors.textMuted }}>
            M3 <span style={{ color: colors.accent }}>⟷</span> M1 via <strong style={{ color: colors.text }}>local network / SSH</strong>
          </span>
          <span style={{ color: colors.border }}>|</span>
          <span style={{ fontSize: 12, color: colors.textMuted }}>
            iPhone <span style={{ color: colors.orange }}>⟷</span> M1 via <strong style={{ color: colors.text }}>Happy API relay</strong>
          </span>
        </div>
      </div>

      {/* Tech stack summary */}
      <div
        style={{
          marginTop: 12,
          padding: 16,
          background: colors.card,
          borderRadius: 12,
          border: `1px solid ${colors.border}`,
          maxWidth: 600,
          margin: "12px auto 0",
        }}
      >
        <div style={{ fontSize: 14, fontWeight: 700, color: colors.text, marginBottom: 8, textAlign: "center" }}>
          Think of it like this
        </div>
        <div style={{ fontSize: 13, color: colors.textMuted, lineHeight: 1.7, textAlign: "center" }}>
          The M1 is the <strong style={{ color: colors.green }}>office that never closes</strong>.
          The M3 is <strong style={{ color: colors.accent }}>your desk inside that office</strong>.
          The iPhone is your <strong style={{ color: colors.orange }}>walkie-talkie to the office</strong> when you're out in the field.
          All three talk to the same brain, the same memory, the same knowledge base.
        </div>
      </div>
    </div>
  );
}

function DayInLifeView() {
  const scenes = [
    {
      time: "7:00 AM",
      icon: "☀️",
      title: "Morning Download",
      color: colors.orange,
      dialog: [
        { who: "You", text: '"Jarvis, what\'s my day look like?"', isUser: true },
        {
          who: "Jarvis",
          text: '"Morning, Vincent. Three things: (1) Miller kitchen install at 2pm — drawings are ready, I pulled them into your Obsidian project note. (2) You got 4 emails overnight — one from the Pollak client about a change order, I drafted a response for your review. (3) The Client Portal has a bug from yesterday — Dev Agent says it\'s a 20-minute fix."',
          isUser: false,
        },
      ],
    },
    {
      time: "9:30 AM",
      icon: "💻",
      title: "Desk Work",
      color: colors.accent,
      dialog: [
        { who: "You", text: '"Approve that Pollak email. And have Dev Agent fix that portal bug."', isUser: true },
        {
          who: "Jarvis",
          text: '"Done — email sent to Pollak. Dev Agent is on the bug fix, I\'ll notify you when it\'s deployed. Anything else before the Miller install?"',
          isUser: false,
        },
      ],
    },
    {
      time: "2:15 PM",
      icon: "🏗️",
      title: "On Site (via iPhone)",
      color: colors.green,
      dialog: [
        {
          who: "You",
          text: '"Jarvis, I\'m at the Miller site. The island ended up 52 inches, not 48. Update the project note."',
          isUser: true,
        },
        {
          who: "Jarvis",
          text: '"Updated Miller project note — island width changed from 48\" to 52\". I also flagged that the countertop order was based on 48\" — want me to have Ops Agent check if we need to reorder?"',
          isUser: false,
        },
        { who: "You", text: '"Yeah, do that."', isUser: true },
      ],
    },
    {
      time: "6:00 PM",
      icon: "🌙",
      title: "Evening Wrap-Up",
      color: colors.purple,
      dialog: [
        { who: "You", text: '"Jarvis, consolidate today."', isUser: true },
        {
          who: "Jarvis",
          text: '"Done. Summary: Pollak change order handled. Portal bug fixed and deployed. Miller install complete, countertop reorder placed (arrives Thursday). Tomorrow: you have a free morning — Dev Agent suggests tackling the user auth feature for the portal. Want me to block that time?"',
          isUser: false,
        },
      ],
    },
  ];

  return (
    <div>
      <SectionTitle subtitle="What using this system actually feels like, from morning to night">
        A Day in the Life with Agent CoS
      </SectionTitle>
      <div style={{ display: "flex", flexDirection: "column", gap: 16, maxWidth: 580, margin: "0 auto" }}>
        {scenes.map((scene, i) => (
          <div
            key={i}
            style={{
              background: colors.card,
              borderRadius: 14,
              padding: 18,
              border: `1px solid ${scene.color}33`,
            }}
          >
            <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 12 }}>
              <span style={{ fontSize: 22 }}>{scene.icon}</span>
              <div>
                <div style={{ fontSize: 11, color: scene.color, fontWeight: 700 }}>{scene.time}</div>
                <div style={{ fontSize: 15, fontWeight: 700, color: colors.text }}>{scene.title}</div>
              </div>
            </div>
            <div style={{ display: "flex", flexDirection: "column", gap: 8 }}>
              {scene.dialog.map((line, j) => (
                <div
                  key={j}
                  style={{
                    padding: "8px 12px",
                    borderRadius: 10,
                    background: line.isUser ? colors.accent + "22" : colors.bg,
                    borderLeft: `3px solid ${line.isUser ? colors.accent : scene.color}`,
                  }}
                >
                  <div style={{ fontSize: 10, fontWeight: 700, color: line.isUser ? colors.accent : scene.color, marginBottom: 2 }}>
                    {line.who}
                  </div>
                  <div style={{ fontSize: 12, color: colors.textMuted, lineHeight: 1.5 }}>{line.text}</div>
                </div>
              ))}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default function AgentCoSArchitecture() {
  const [view, setView] = useState("hierarchy");

  return (
    <div style={{ background: colors.bg, minHeight: "100vh", padding: "24px 20px", fontFamily: "-apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif" }}>
      {/* Header */}
      <div style={{ textAlign: "center", marginBottom: 24 }}>
        <h1 style={{ fontSize: 28, fontWeight: 900, color: colors.text, margin: 0, letterSpacing: -0.5 }}>
          Agent Chief of Staff
        </h1>
        <p style={{ fontSize: 14, color: colors.textMuted, margin: "6px 0 0" }}>
          Architecture for Vincent's AI-Native Business — Powered by Agno
        </p>
      </div>

      {/* Nav */}
      <div style={{ display: "flex", justifyContent: "center", gap: 8, marginBottom: 28, flexWrap: "wrap" }}>
        {[
          { id: "hierarchy", label: "Org Chart" },
          { id: "dataflow", label: "How Requests Flow" },
          { id: "infrastructure", label: "Hardware Map" },
          { id: "dayinlife", label: "Day in the Life" },
        ].map((tab) => (
          <button
            key={tab.id}
            onClick={() => setView(tab.id)}
            style={{
              padding: "8px 18px",
              borderRadius: 9999,
              border: "none",
              fontSize: 13,
              fontWeight: 600,
              cursor: "pointer",
              transition: "all 0.15s",
              background: view === tab.id ? colors.accent : colors.card,
              color: view === tab.id ? "white" : colors.textMuted,
            }}
          >
            {tab.label}
          </button>
        ))}
      </div>

      {/* Content */}
      <div style={{ maxWidth: 860, margin: "0 auto" }}>
        {view === "hierarchy" && <HierarchyView />}
        {view === "dataflow" && <DataFlowView />}
        {view === "infrastructure" && <InfrastructureView />}
        {view === "dayinlife" && <DayInLifeView />}
      </div>

      {/* Footer */}
      <div style={{ textAlign: "center", marginTop: 40, padding: "16px 0", borderTop: `1px solid ${colors.border}` }}>
        <div style={{ fontSize: 11, color: colors.textMuted }}>
          Agent CoS Architecture v1.0 — Built for Vincent James / Lucavo Design — Feb 2026
        </div>
      </div>
    </div>
  );
}