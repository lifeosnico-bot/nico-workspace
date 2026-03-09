A lot of us start with AI in a pretty
A lot of us start with AI in a pretty
A lot of us start with AI in a pretty
simple way. Either using it day-to-day
simple way. Either using it day-to-day
simple way. Either using it day-to-day
or wiring it into an app. You send a
or wiring it into an app. You send a
or wiring it into an app. You send a
prompt, you get something back, maybe
prompt, you get something back, maybe
prompt, you get something back, maybe
through chatbt or through an API in your
through chatbt or through an API in your
through chatbt or through an API in your
product. And if you've been doing that
product. And if you've been doing that
product. And if you've been doing that
for a bit, then you know the limits. It
for a bit, then you know the limits. It
for a bit, then you know the limits. It
holds up until you need the system to do
holds up until you need the system to do
holds up until you need the system to do
more than generate text. You need it to
more than generate text. You need it to
more than generate text. You need it to
use tools to call APIs or update records
use tools to call APIs or update records
use tools to call APIs or update records
and sometimes run a multi-step workflow
and sometimes run a multi-step workflow
and sometimes run a multi-step workflow
that coordinates several steps. Well,
that coordinates several steps. Well,
that coordinates several steps. Well,
that's where agents enter the picture.
that's where agents enter the picture.
that's where agents enter the picture.
Hey, I'm Gil with Mastra and I spent
Hey, I'm Gil with Mastra and I spent
Hey, I'm Gil with Mastra and I spent
over a decade building and teaching
over a decade building and teaching
over a decade building and teaching
software and I was early to working with
software and I was early to working with
software and I was early to working with
and teaching things like Rag and MCP
and teaching things like Rag and MCP
and teaching things like Rag and MCP
style systems when people first started
style systems when people first started
style systems when people first started
asking how this stuff actually works.
asking how this stuff actually works.
asking how this stuff actually works.
And as more people try to build and use
And as more people try to build and use
And as more people try to build and use
agents, I kept getting the same
agents, I kept getting the same
agents, I kept getting the same
questions about fundamentals. And as I
questions about fundamentals. And as I
questions about fundamentals. And as I
was learning it, I realized there's no
was learning it, I realized there's no
was learning it, I realized there's no
single course or even a complete book
single course or even a complete book
single course or even a complete book
that pulls it all together. I had to
that pulls it all together. I had to
that pulls it all together. I had to
piece it together the hard way. So, I'm
piece it together the hard way. So, I'm
piece it together the hard way. So, I'm
going to make it easier for you. In this
going to make it easier for you. In this
going to make it easier for you. In this
course, we're going to build an AI agent
course, we're going to build an AI agent
course, we're going to build an AI agent
with MRA, an open- source framework for
with MRA, an open- source framework for
with MRA, an open- source framework for
building agents in Typescript. We'll
building agents in Typescript. We'll
building agents in Typescript. We'll
give it tools to call code and workflows
give it tools to call code and workflows
give it tools to call code and workflows
for multi-step tasks and add memory and
for multi-step tasks and add memory and
for multi-step tasks and add memory and
storage so it can carry context and tool
storage so it can carry context and tool
storage so it can carry context and tool
results across interactions. Now, before
results across interactions. Now, before
results across interactions. Now, before
we dive in, the quickest way to see what
we dive in, the quickest way to see what
we dive in, the quickest way to see what
you'll learn is to watch an agent run.
you'll learn is to watch an agent run.
you'll learn is to watch an agent run.
Then, you can decide if this course is
Then, you can decide if this course is
Then, you can decide if this course is
for you. This is an AI agent built with
for you. This is an AI agent built with
for you. This is an AI agent built with
MRA. It's designed around the patterns
MRA. It's designed around the patterns
MRA. It's designed around the patterns
people are using today to build AI
people are using today to build AI
people are using today to build AI
powered apps, from agents and tools to
powered apps, from agents and tools to
powered apps, from agents and tools to
workflows, memory, and observability all
workflows, memory, and observability all
workflows, memory, and observability all
in one place. It's built to take you
in one place. It's built to take you
in one place. It's built to take you
from early prototypes to production
from early prototypes to production
from early prototypes to production
ready apps. And it can run alongside the
ready apps. And it can run alongside the
ready apps. And it can run alongside the
TypeScript stack you already use or as a
TypeScript stack you already use or as a
TypeScript stack you already use or as a
standalone server. When you create a
standalone server. When you create a
standalone server. When you create a
master project and run it locally, you
master project and run it locally, you
master project and run it locally, you
get a development studio out of the box.
get a development studio out of the box.
get a development studio out of the box.
This is where you can run and test
This is where you can run and test
This is where you can run and test
everything as you build. Here's the
everything as you build. Here's the
everything as you build. Here's the
default weather agent. I'll ask it about
default weather agent. I'll ask it about
default weather agent. I'll ask it about
the weather in Miami. Here you can see
the weather in Miami. Here you can see
the weather in Miami. Here you can see
the tool call kickoff. The tool returns
the tool call kickoff. The tool returns
the tool call kickoff. The tool returns
data and the agent responds. And that's
data and the agent responds. And that's
data and the agent responds. And that's
right, this week it's a little bit
right, this week it's a little bit
right, this week it's a little bit
colder than usual down here. And if you
colder than usual down here. And if you
colder than usual down here. And if you
open the trace from this run, you can
open the trace from this run, you can
open the trace from this run, you can
follow it step by step. The tool call,
follow it step by step. The tool call,
follow it step by step. The tool call,
the arguments is sent, and the result
the arguments is sent, and the result
the arguments is sent, and the result
that came back. Okay, I'll ask a
that came back. Okay, I'll ask a
that came back. Okay, I'll ask a
follow-up question. What should I do
follow-up question. What should I do
follow-up question. What should I do
today based on the weather here? And
today based on the weather here? And
today based on the weather here? And
this time, the agent uses the earlier
this time, the agent uses the earlier
this time, the agent uses the earlier
context from the run I just did. And
context from the run I just did. And
context from the run I just did. And
these suggestions look pretty great to
these suggestions look pretty great to
these suggestions look pretty great to
me. From here, you can switch models,
me. From here, you can switch models,
me. From here, you can switch models,
tweak the system prompt, adjust model
tweak the system prompt, adjust model
tweak the system prompt, adjust model
settings, and see how the agents
settings, and see how the agents
settings, and see how the agents
behavior changes.
behavior changes.
behavior changes.
Now, in code, it's pretty
Now, in code, it's pretty
Now, in code, it's pretty
straightforward. You create an agent,
straightforward. You create an agent,
straightforward. You create an agent,
give it instructions, and register the
give it instructions, and register the
give it instructions, and register the
tools it's allowed to call. And those
tools it's allowed to call. And those
tools it's allowed to call. And those
tools, well, they're just TypeScript
tools, well, they're just TypeScript
tools, well, they're just TypeScript
functions. Now, some tasks are clearly
functions. Now, some tasks are clearly
functions. Now, some tasks are clearly
defined up front and need to run in a
defined up front and need to run in a
defined up front and need to run in a
specific order. That's what workflows
specific order. That's what workflows
specific order. That's what workflows
are for. Workflows break work into
are for. Workflows break work into
are for. Workflows break work into
explicit steps. You can run them
explicit steps. You can run them
explicit steps. You can run them
directly in Monster Studio or have an
directly in Monster Studio or have an
directly in Monster Studio or have an
agent trigger them. And you can even
agent trigger them. And you can even
agent trigger them. And you can even
pause the workflow at a step for human
pause the workflow at a step for human
pause the workflow at a step for human
approval as you build. Monster Studio's
approval as you build. Monster Studio's
approval as you build. Monster Studio's
observability view is where you verify
observability view is where you verify
observability view is where you verify
what actually happened. You can see what
what actually happened. You can see what
what actually happened. You can see what
ran, what got called, what the model
ran, what got called, what the model
ran, what got called, what the model
saw, and where things might have gone
saw, and where things might have gone
saw, and where things might have gone
wrong. You can also add scoring to see
wrong. You can also add scoring to see
wrong. You can also add scoring to see
whether the agent's doing what you
whether the agent's doing what you
whether the agent's doing what you
expect, and improve its behavior. And
expect, and improve its behavior. And
expect, and improve its behavior. And
the best part is that when you're ready
the best part is that when you're ready
the best part is that when you're ready
to ship, the same Monster app you run
to ship, the same Monster app you run
to ship, the same Monster app you run
locally can quickly be deployed as is.
locally can quickly be deployed as is.
locally can quickly be deployed as is.
If you use Monstercloud, you get a
If you use Monstercloud, you get a
If you use Monstercloud, you get a
hosted studio where your team can test
hosted studio where your team can test
hosted studio where your team can test
agents, inspect runs, and iterate
agents, inspect runs, and iterate
agents, inspect runs, and iterate
together. Agents are showing up
together. Agents are showing up
together. Agents are showing up
everywhere in modern apps, from cursor
everywhere in modern apps, from cursor
everywhere in modern apps, from cursor
and the editor to deep research and
and the editor to deep research and
and the editor to deep research and
perplexity for digging into a topic and
perplexity for digging into a topic and
perplexity for digging into a topic and
even support agents like Finn. So, if
even support agents like Finn. So, if
even support agents like Finn. So, if
you've been looking for a practical way
you've been looking for a practical way
you've been looking for a practical way
to get hands-on, this is a solid jumping
to get hands-on, this is a solid jumping
to get hands-on, this is a solid jumping
off point to get you feeling caught up
off point to get you feeling caught up
off point to get you feeling caught up
and start building agents you can ship.
and start building agents you can ship.
and start building agents you can ship.
In practice, an agent is a system where
In practice, an agent is a system where
In practice, an agent is a system where
a language model reasons about a goal.
a language model reasons about a goal.
a language model reasons about a goal.
It decides which tools or workflows to
It decides which tools or workflows to
It decides which tools or workflows to
use. It can pull in conversation memory
use. It can pull in conversation memory
use. It can pull in conversation memory
and keeps iterating until it can return
and keeps iterating until it can return
and keeps iterating until it can return
a final answer and the task is complete.
a final answer and the task is complete.
a final answer and the task is complete.
Mostra is how you build that in
Mostra is how you build that in
Mostra is how you build that in
Typescript. So, in this course, you,
Typescript. So, in this course, you,
Typescript. So, in this course, you,
yes, you will build a theme park
yes, you will build a theme park
yes, you will build a theme park
companion agent. It's the kind of
companion agent. It's the kind of
companion agent. It's the kind of
assistant you can imagine an official
assistant you can imagine an official
assistant you can imagine an official
park app shipping. It can confirm the
park app shipping. It can confirm the
park app shipping. It can confirm the
park you're talking about, pull live
park you're talking about, pull live
park you're talking about, pull live
weight times from the Q Times API,
weight times from the Q Times API,
weight times from the Q Times API,
factor in weather, recommend what to do
factor in weather, recommend what to do
factor in weather, recommend what to do
next, and even walk through a ticket
next, and even walk through a ticket
next, and even walk through a ticket
purchase workflow. As we build, we'll
purchase workflow. As we build, we'll
purchase workflow. As we build, we'll
work through the core building blocks.
work through the core building blocks.
work through the core building blocks.
We'll define an agent and its tools in
We'll define an agent and its tools in
We'll define an agent and its tools in
TypeScript. We'll use Monster Studio to
TypeScript. We'll use Monster Studio to
TypeScript. We'll use Monster Studio to
run everything locally and inspect
run everything locally and inspect
run everything locally and inspect
traces. We'll chain multi-step logic
traces. We'll chain multi-step logic
traces. We'll chain multi-step logic
with workflows and add memory and
with workflows and add memory and
with workflows and add memory and
storage so follow-ups behave
storage so follow-ups behave
storage so follow-ups behave
consistently. And by the end, you'll
consistently. And by the end, you'll
consistently. And by the end, you'll
have a monster agent you can deploy and
have a monster agent you can deploy and
have a monster agent you can deploy and
run inside any app. Look, 2026 kicks off
run inside any app. Look, 2026 kicks off
run inside any app. Look, 2026 kicks off
the decade of agents. So, if you ship
the decade of agents. So, if you ship
the decade of agents. So, if you ship
TypeScript apps, this is the course to
TypeScript apps, this is the course to
TypeScript apps, this is the course to
get ahead and even be the person your
get ahead and even be the person your
get ahead and even be the person your
team counts on to get agents into a
team counts on to get agents into a
team counts on to get agents into a
product. So, if you're ready to go,
product. So, if you're ready to go,
product. So, if you're ready to go,
let's start by getting MRA running
let's start by getting MRA running
let's start by getting MRA running
locally and looking at what it gives us
locally and looking at what it gives us
locally and looking at what it gives us
out of the box.
