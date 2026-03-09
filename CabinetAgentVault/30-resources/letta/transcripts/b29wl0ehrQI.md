[music]
[music]
In this video, I want to tell you about
In this video, I want to tell you about
In this video, I want to tell you about
two things I built and then abandoned.
two things I built and then abandoned.
two things I built and then abandoned.
The first was a Laravel package, a
The first was a Laravel package, a
The first was a Laravel package, a
knowledge graph memory system for AI
knowledge graph memory system for AI
knowledge graph memory system for AI
tools backed by Neo4j with MCP
tools backed by Neo4j with MCP
tools backed by Neo4j with MCP
integration. I called it Momento. I
integration. I called it Momento. I
integration. I called it Momento. I
shipped it and some people used it. The
shipped it and some people used it. The
shipped it and some people used it. The
second was a full rewrite written in Go,
second was a full rewrite written in Go,
second was a full rewrite written in Go,
framework agnostic, cleaner
framework agnostic, cleaner
framework agnostic, cleaner
architecture, and a little more
architecture, and a little more
architecture, and a little more
ambitious. I finished that one, too, and
ambitious. I finished that one, too, and
ambitious. I finished that one, too, and
released it. Then I stopped working on
released it. Then I stopped working on
released it. Then I stopped working on
it. Not because it didn't work. It
it. Not because it didn't work. It
it. Not because it didn't work. It
worked fine. I stopped because I
worked fine. I stopped because I
worked fine. I stopped because I
finished it, looked at what I built, and
finished it, looked at what I built, and
finished it, looked at what I built, and
realized this is still the same thing
realized this is still the same thing
realized this is still the same thing
everyone else is doing. I just
everyone else is doing. I just
everyone else is doing. I just
repackaged it a little different. That
repackaged it a little different. That
repackaged it a little different. That
realization is what this video is all
realization is what this video is all
realization is what this video is all
about. because what I built next is
about. because what I built next is
about. because what I built next is
completely different and I want to show
completely different and I want to show
completely different and I want to show
you why I think it's different and the
you why I think it's different and the
you why I think it's different and the
difference matters. Here's how almost
difference matters. Here's how almost
difference matters. Here's how almost
every AI memory solution works under the
every AI memory solution works under the
every AI memory solution works under the
hood, including both things I built.
hood, including both things I built.
hood, including both things I built.
Your agent has a conversation. The
Your agent has a conversation. The
Your agent has a conversation. The
system extracts some key facts or
system extracts some key facts or
system extracts some key facts or
points. Those get embedded and stored,
points. Those get embedded and stored,
points. Those get embedded and stored,
usually in a vector database, sometimes
usually in a vector database, sometimes
usually in a vector database, sometimes
knowledge graph, sometimes both. Next
knowledge graph, sometimes both. Next
knowledge graph, sometimes both. Next
session, when the agent needs context,
session, when the agent needs context,
session, when the agent needs context,
it queries that store and retrieves the
it queries that store and retrieves the
it queries that store and retrieves the
most relevant things, injects them into
most relevant things, injects them into
most relevant things, injects them into
the prompt. Agent responds with the
the prompt. Agent responds with the
the prompt. Agent responds with the
context it otherwise wouldn't have had.
context it otherwise wouldn't have had.
context it otherwise wouldn't have had.
That's the pattern. My Momento packages
That's the pattern. My Momento packages
That's the pattern. My Momento packages
did this. Mem does this. Zep does this.
did this. Mem does this. Zep does this.
did this. Mem does this. Zep does this.
Langme does this. The implementations
Langme does this. The implementations
Langme does this. The implementations
vary. Some have graph layers, entity
vary. Some have graph layers, entity
vary. Some have graph layers, entity
extraction, temporal summarization. Real
extraction, temporal summarization. Real
extraction, temporal summarization. Real
engineering went into all of them, mine
engineering went into all of them, mine
engineering went into all of them, mine
included. But here's the thing I kept
included. But here's the thing I kept
included. But here's the thing I kept
coming back to, even when I looked at my
coming back to, even when I looked at my
coming back to, even when I looked at my
own work. The database is passive. It
own work. The database is passive. It
own work. The database is passive. It
holds what you put in it, and it gives
holds what you put in it, and it gives
holds what you put in it, and it gives
it back when you ask for it. Here's the
it back when you ask for it. Here's the
it back when you ask for it. Here's the
question I couldn't shake. What if the
question I couldn't shake. What if the
question I couldn't shake. What if the
problem with AI agents isn't that they
problem with AI agents isn't that they
problem with AI agents isn't that they
didn't store enough? It's the storage
didn't store enough? It's the storage
didn't store enough? It's the storage
itself didn't think. What if what we
itself didn't think. What if what we
itself didn't think. What if what we
actually need isn't a better retrieval
actually need isn't a better retrieval
actually need isn't a better retrieval
system, but something that's doing
system, but something that's doing
system, but something that's doing
cognitive work between queries. So, I
cognitive work between queries. So, I
cognitive work between queries. So, I
finished the second Momento video,
finished the second Momento video,
finished the second Momento video,
framework agnostic. go version. I was
framework agnostic. go version. I was
framework agnostic. go version. I was
pretty happy with it. And I'm looking at
pretty happy with it. And I'm looking at
pretty happy with it. And I'm looking at
it and I'm thinking this is good, but
it and I'm thinking this is good, but
it and I'm thinking this is good, but
it's still the same model. Store, fetch,
it's still the same model. Store, fetch,
it's still the same model. Store, fetch,
inject. My graph schema is a little
inject. My graph schema is a little
inject. My graph schema is a little
cleaner than most. My search is solid,
cleaner than most. My search is solid,
cleaner than most. My search is solid,
but fundamentally when the agent asks a
but fundamentally when the agent asks a
but fundamentally when the agent asks a
question, I'm doing retrieval. I'm
question, I'm doing retrieval. I'm
question, I'm doing retrieval. I'm
pulling things that are semantically
pulling things that are semantically
pulling things that are semantically
close and handing them back. The
close and handing them back. The
close and handing them back. The
database doesn't know what time is. It
database doesn't know what time is. It
database doesn't know what time is. It
doesn't know that the thing I stored
doesn't know that the thing I stored
doesn't know that the thing I stored
yesterday matters more than the thing
yesterday matters more than the thing
yesterday matters more than the thing
from 3 months ago. It doesn't know that
from 3 months ago. It doesn't know that
from 3 months ago. It doesn't know that
two concepts have been coming up
two concepts have been coming up
two concepts have been coming up
together constantly and should probably
together constantly and should probably
together constantly and should probably
be linked together by now. It's passive.
be linked together by now. It's passive.
be linked together by now. It's passive.
It waits to be asked and when asked, it
It waits to be asked and when asked, it
It waits to be asked and when asked, it
measures distance. And I thought, is
measures distance. And I thought, is
measures distance. And I thought, is
this actually how memory works? So, I
this actually how memory works? So, I
this actually how memory works? So, I
went and looked it up. I ended up in
went and looked it up. I ended up in
went and looked it up. I ended up in
cognitive psychology papers from the
cognitive psychology papers from the
cognitive psychology papers from the
1980s, which is not where I expected to
1980s, which is not where I expected to
1980s, which is not where I expected to
spend my time. There's a model called
spend my time. There's a model called
spend my time. There's a model called
ACTR, adaptive control of thought
ACTR, adaptive control of thought
ACTR, adaptive control of thought
rationale, developed to describe how
rationale, developed to describe how
rationale, developed to describe how
human memory actually activates, not
human memory actually activates, not
human memory actually activates, not
retrieval, activation. That's the word
retrieval, activation. That's the word
retrieval, activation. That's the word
they use and that's the distinction that
they use and that's the distinction that
they use and that's the distinction that
matters. In human memory, what you
matters. In human memory, what you
matters. In human memory, what you
recall isn't the thing that's most
recall isn't the thing that's most
recall isn't the thing that's most
similar to the current thought. It's the
similar to the current thought. It's the
similar to the current thought. It's the
thing your brain has activated most
thing your brain has activated most
thing your brain has activated most
recently, most frequently, and with the
recently, most frequently, and with the
recently, most frequently, and with the
right context. Things you haven't
right context. Things you haven't
right context. Things you haven't
engaged with in months fade naturally.
engaged with in months fade naturally.
engaged with in months fade naturally.
Things you think about together
Things you think about together
Things you think about together
repeatedly become linked automatically.
repeatedly become linked automatically.
repeatedly become linked automatically.
When you encounter contradictory
When you encounter contradictory
When you encounter contradictory
information, your confidence in both
information, your confidence in both
information, your confidence in both
things shift. None of this is retrieval.
things shift. None of this is retrieval.
things shift. None of this is retrieval.
It's a living process. The storage
It's a living process. The storage
It's a living process. The storage
itself is active. And I realized nobody
itself is active. And I realized nobody
itself is active. And I realized nobody
had built a database that actually works
had built a database that actually works
had built a database that actually works
this way, including me. So I started
this way, including me. So I started
this way, including me. So I started
over. So I want to be upfront. I built
over. So I want to be upfront. I built
over. So I want to be upfront. I built
Moon and DB. This isn't a review of
Moon and DB. This isn't a review of
Moon and DB. This isn't a review of
something I stumbled across. I built it
something I stumbled across. I built it
something I stumbled across. I built it
because I kept hitting the same wall and
because I kept hitting the same wall and
because I kept hitting the same wall and
nothing else addressed it properly.
nothing else addressed it properly.
nothing else addressed it properly.
Named it after Moon, one of Odin's
Named it after Moon, one of Odin's
Named it after Moon, one of Odin's
ravens in Norse mythology. Hugan was
ravens in Norse mythology. Hugan was
ravens in Norse mythology. Hugan was
thought Moonin is memory. The raven who
thought Moonin is memory. The raven who
thought Moonin is memory. The raven who
flies out and brings back what matters.
flies out and brings back what matters.
flies out and brings back what matters.
That felt right. One thing I want to say
That felt right. One thing I want to say
That felt right. One thing I want to say
before I walk through how it works. Moon
before I walk through how it works. Moon
before I walk through how it works. Moon
and DB has no LLM requirement, no API
and DB has no LLM requirement, no API
and DB has no LLM requirement, no API
key, no external model. It ships with
key, no external model. It ships with
key, no external model. It ships with
the bundled embedding model that runs
the bundled embedding model that runs
the bundled embedding model that runs
entirely locally. The cognitive layer,
entirely locally. The cognitive layer,
entirely locally. The cognitive layer,
everything I'm about to show you is
everything I'm about to show you is
everything I'm about to show you is
mathematical. It's built into the
mathematical. It's built into the
mathematical. It's built into the
storage engine itself. Most of the tools
storage engine itself. Most of the tools
storage engine itself. Most of the tools
I looked at, including my own, Momento,
I looked at, including my own, Momento,
I looked at, including my own, Momento,
reach out to an LLM to do their
reach out to an LLM to do their
reach out to an LLM to do their
thinking. The database is passive. The
thinking. The database is passive. The
thinking. The database is passive. The
LLM is where the intelligence lives.
LLM is where the intelligence lives.
LLM is where the intelligence lives.
Moon flips that. The intelligence is
Moon flips that. The intelligence is
Moon flips that. The intelligence is
inside of the database. No model
inside of the database. No model
inside of the database. No model
required to activate it. Here's what
required to activate it. Here's what
required to activate it. Here's what
that actually means. And I want to use
that actually means. And I want to use
that actually means. And I want to use
real examples because the technical
real examples because the technical
real examples because the technical
names for these things make them sound
names for these things make them sound
names for these things make them sound
more complicated than they really are.
more complicated than they really are.
more complicated than they really are.
Temporal decay. Think about a colleague
Temporal decay. Think about a colleague
Temporal decay. Think about a colleague
you worked with closely last month. You
you worked with closely last month. You
you worked with closely last month. You
can recall their preferences, their
can recall their preferences, their
can recall their preferences, their
working style, what they were good at
working style, what they were good at
working style, what they were good at
easily. Now think about a colleague who
easily. Now think about a colleague who
easily. Now think about a colleague who
left the company 2 years ago. You
left the company 2 years ago. You
left the company 2 years ago. You
remember them but you have to reach for
remember them but you have to reach for
remember them but you have to reach for
it. It takes a moment. Same type of
it. It takes a moment. Same type of
it. It takes a moment. Same type of
information but time has changed how
information but time has changed how
information but time has changed how
readily it surfaces. Moon and DB works
readily it surfaces. Moon and DB works
readily it surfaces. Moon and DB works
like this. Every Ingram, every piece of
like this. Every Ingram, every piece of
like this. Every Ingram, every piece of
stored knowledge has an activation
stored knowledge has an activation
stored knowledge has an activation
strength that decays mathematically when
strength that decays mathematically when
strength that decays mathematically when
it isn't accessed. Things you engaged
it isn't accessed. Things you engaged
it isn't accessed. Things you engaged
with recently are right there. Things
with recently are right there. Things
with recently are right there. Things
you haven't touched in months fade in
you haven't touched in months fade in
you haven't touched in months fade in
rank. Not deleted, just a little
rank. Not deleted, just a little
rank. Not deleted, just a little
quieter. The database is doing this on
quieter. The database is doing this on
quieter. The database is doing this on
its own between queries without any code
its own between queries without any code
its own between queries without any code
from you heavy in association. You walk
from you heavy in association. You walk
from you heavy in association. You walk
into a store and catch a scent of
into a store and catch a scent of
into a store and catch a scent of
perfume and instantly without choosing
perfume and instantly without choosing
perfume and instantly without choosing
to you think of your mother. Perfume and
to you think of your mother. Perfume and
to you think of your mother. Perfume and
your mother are not semantically
your mother are not semantically
your mother are not semantically
related. There's no logical category
related. There's no logical category
related. There's no logical category
that connects them. The association
that connects them. The association
that connects them. The association
formed because these two things were
formed because these two things were
formed because these two things were
activated together in your mind
activated together in your mind
activated together in your mind
repeatedly for years. The connection
repeatedly for years. The connection
repeatedly for years. The connection
isn't about similarity. It's about
isn't about similarity. It's about
isn't about similarity. It's about
co-occurrence. Moon and DB works the
co-occurrence. Moon and DB works the
co-occurrence. Moon and DB works the
same way. When two Ingrams keep
same way. When two Ingrams keep
same way. When two Ingrams keep
surfacing together in activation
surfacing together in activation
surfacing together in activation
results, their connection automatically
results, their connection automatically
results, their connection automatically
strengthens over time. Activating one
strengthens over time. Activating one
strengthens over time. Activating one
pulls up the other. Not because they're
pulls up the other. Not because they're
pulls up the other. Not because they're
similar, but because they've been
similar, but because they've been
similar, but because they've been
relevant in the same context. You don't
relevant in the same context. You don't
relevant in the same context. You don't
write any code for this. The
write any code for this. The
write any code for this. The
associations emerge from how you use the
associations emerge from how you use the
associations emerge from how you use the
system. Basian confidence. You hear a
system. Basian confidence. You hear a
system. Basian confidence. You hear a
rumor about something at work. You're
rumor about something at work. You're
rumor about something at work. You're
about 30% sure it's true. Low
about 30% sure it's true. Low
about 30% sure it's true. Low
confidence, single source. Then three
confidence, single source. Then three
confidence, single source. Then three
separate people mention the same thing.
separate people mention the same thing.
separate people mention the same thing.
Your confidence goes up, maybe to 80%.
Your confidence goes up, maybe to 80%.
Your confidence goes up, maybe to 80%.
Then one of them wants it back.
Then one of them wants it back.
Then one of them wants it back.
Actually, I might have been wrong. Your
Actually, I might have been wrong. Your
Actually, I might have been wrong. Your
confidence doesn't snap back to zero. It
confidence doesn't snap back to zero. It
confidence doesn't snap back to zero. It
adjusts. Maybe it drops to 65%. You're
adjusts. Maybe it drops to 65%. You're
adjusts. Maybe it drops to 65%. You're
calibrating continuously based on
calibrating continuously based on
calibrating continuously based on
evidence. Every Ingram and Moon and DB
evidence. Every Ingram and Moon and DB
evidence. Every Ingram and Moon and DB
has a confidence score that works
has a confidence score that works
has a confidence score that works
exactly like this. When new information
exactly like this. When new information
exactly like this. When new information
reinforces something you've already
reinforces something you've already
reinforces something you've already
stored, confidence rises. When something
stored, confidence rises. When something
stored, confidence rises. When something
contradictory comes in, confidence on
contradictory comes in, confidence on
contradictory comes in, confidence on
both pieces updates. The database knows
both pieces updates. The database knows
both pieces updates. The database knows
what it's uncertain about. Push
what it's uncertain about. Push
what it's uncertain about. Push
triggers. You meet someone new, you're
triggers. You meet someone new, you're
triggers. You meet someone new, you're
having a conversation, maybe a first
having a conversation, maybe a first
having a conversation, maybe a first
date, maybe someone at a party, and
date, maybe someone at a party, and
date, maybe someone at a party, and
within a few minutes, before you've
within a few minutes, before you've
within a few minutes, before you've
consciously decided anything, you think,
consciously decided anything, you think,
consciously decided anything, you think,
"This person reminds me of somebody."
"This person reminds me of somebody."
"This person reminds me of somebody."
You don't go looking for it. You weren't
You don't go looking for it. You weren't
You don't go looking for it. You weren't
running a comparison in your head.
running a comparison in your head.
running a comparison in your head.
Something about them, the way they tell
Something about them, the way they tell
Something about them, the way they tell
a story, a specific laugh, the way they
a story, a specific laugh, the way they
a story, a specific laugh, the way they
get genuinely excited about something
get genuinely excited about something
get genuinely excited about something
crossed the threshold and your brain
crossed the threshold and your brain
crossed the threshold and your brain
surfaced a connection from somewhere in
surfaced a connection from somewhere in
surfaced a connection from somewhere in
your past automatically. That's a push
your past automatically. That's a push
your past automatically. That's a push
trigger. The context became relevant
trigger. The context became relevant
trigger. The context became relevant
enough that your memory initiated the
enough that your memory initiated the
enough that your memory initiated the
connection. You didn't retrieve it. It
connection. You didn't retrieve it. It
connection. You didn't retrieve it. It
arrived. Moon and DB has semantic
arrived. Moon and DB has semantic
arrived. Moon and DB has semantic
triggers. You set a relevance threshold
triggers. You set a relevance threshold
triggers. You set a relevance threshold
on a topic and when activation context
on a topic and when activation context
on a topic and when activation context
crosses it, the database notifies your
crosses it, the database notifies your
crosses it, the database notifies your
agent before it asks, before you ask.
agent before it asks, before you ask.
agent before it asks, before you ask.
The database surfaces what's relevant
The database surfaces what's relevant
The database surfaces what's relevant
because the moment is right. That's not
because the moment is right. That's not
because the moment is right. That's not
retrieval. That's something closer to
retrieval. That's something closer to
retrieval. That's something closer to
intuition. And I'll be honest, this is
intuition. And I'll be honest, this is
intuition. And I'll be honest, this is
the behavior that surprised me the most
the behavior that surprised me the most
the behavior that surprised me the most
even after I designed it. When I first
even after I designed it. When I first
even after I designed it. When I first
saw a trigger fire in a context I hadn't
saw a trigger fire in a context I hadn't
saw a trigger fire in a context I hadn't
anticipated, it felt less like a
anticipated, it felt less like a
anticipated, it felt less like a
database and more like something was
database and more like something was
database and more like something was
paying attention.
All right, I'm going to paste the
All right, I'm going to paste the
All right, I'm going to paste the
installer here. Press enter.
installer here. Press enter.
installer here. Press enter.
Now I should be able to run moon and
Now I should be able to run moon and
Now I should be able to run moon and
init.
init.
init.
And notice this is the first time we ran
And notice this is the first time we ran
And notice this is the first time we ran
it. So it's going to walk us through the
it. So it's going to walk us through the
it. So it's going to walk us through the
wizard. And just so you know, this is an
wizard. And just so you know, this is an
wizard. And just so you know, this is an
alpha release. We're at version 0.2.4
alpha release. We're at version 0.2.4
alpha release. We're at version 0.2.4
right now. It auto detected that I have
right now. It auto detected that I have
right now. It auto detected that I have
clawed desktop, clawed code, and cursor
clawed desktop, clawed code, and cursor
clawed desktop, clawed code, and cursor
installed. And it's asking me if I want
installed. And it's asking me if I want
installed. And it's asking me if I want
to choose or auto install anything else.
to choose or auto install anything else.
to choose or auto install anything else.
I'm just going to press enter.
I'm just going to press enter.
I'm just going to press enter.
Which embed should Moon use for memory
Which embed should Moon use for memory
Which embed should Moon use for memory
search? I'm going to use the local. How
search? I'm going to use the local. How
search? I'm going to use the local. How
should your AI use memory? I'm going to
should your AI use memory? I'm going to
should your AI use memory? I'm going to
set it to autonomous, but if you want to
set it to autonomous, but if you want to
set it to autonomous, but if you want to
set up something else, you can. You have
set up something else, you can. You have
set up something else, you can. You have
a few options.
a few options.
a few options.
Now, it's asking me if I want to
Now, it's asking me if I want to
Now, it's asking me if I want to
autoconfigure Claude MD to prefer Moonin
autoconfigure Claude MD to prefer Moonin
autoconfigure Claude MD to prefer Moonin
for memory. I'm going to say yes.
for memory. I'm going to say yes.
for memory. I'm going to say yes.
As you can see here, our Moonend DB is
As you can see here, our Moonend DB is
As you can see here, our Moonend DB is
running. We see the green dot. It's
running. We see the green dot. It's
running. We see the green dot. It's
available at 8475.
available at 8475.
available at 8475.
The MCP is running at 8750
The MCP is running at 8750
The MCP is running at 8750
and the web UI is running at 8476.
and the web UI is running at 8476.
and the web UI is running at 8476.
I'm going to copy this and show you the
I'm going to copy this and show you the
I'm going to copy this and show you the
web UI. Here we are in the web UI. The
web UI. Here we are in the web UI. The
web UI. Here we are in the web UI. The
default login is root and password.
default login is root and password.
default login is root and password.
And here we are. We have the full web
And here we are. We have the full web
And here we are. We have the full web
UI. We can click through. By default,
UI. We can click through. By default,
UI. We can click through. By default,
you're going to get one vault. It is
you're going to get one vault. It is
you're going to get one vault. It is
called default. You can see it here and
called default. You can see it here and
called default. You can see it here and
here. You can click through and view
here. You can click through and view
here. You can click through and view
your memories. We do have a graph once
your memories. We do have a graph once
your memories. We do have a graph once
memories are loaded.
memories are loaded.
memories are loaded.
Session information.
Session information.
Session information.
How to connect other tools if you didn't
How to connect other tools if you didn't
How to connect other tools if you didn't
do it by default is going to be here in
do it by default is going to be here in
do it by default is going to be here in
your settings. You can actually adjust
your settings. You can actually adjust
your settings. You can actually adjust
your vault for certain things here if
your vault for certain things here if
your vault for certain things here if
you want to adjust the way memories are
you want to adjust the way memories are
you want to adjust the way memories are
working. We have a few presets here, but
working. We have a few presets here, but
working. We have a few presets here, but
you can also override them by coming
you can also override them by coming
you can also override them by coming
down here and picking something else.
down here and picking something else.
down here and picking something else.
We have the idea of plugins right now.
We have the idea of plugins right now.
We have the idea of plugins right now.
I'm still kind of messing around with
I'm still kind of messing around with
I'm still kind of messing around with
that to see API keys. So, this is how
that to see API keys. So, this is how
that to see API keys. So, this is how
you would access Moonin through
you would access Moonin through
you would access Moonin through
something other than MCP.
something other than MCP.
something other than MCP.
By default, your default vault is not
By default, your default vault is not
By default, your default vault is not
going to have any authentication on it.
going to have any authentication on it.
going to have any authentication on it.
Just so you can fire it up, get it
Just so you can fire it up, get it
Just so you can fire it up, get it
connected via MCP and you're off to the
connected via MCP and you're off to the
connected via MCP and you're off to the
races. You can always come back and add
races. You can always come back and add
races. You can always come back and add
authentication later if you want. Every
authentication later if you want. Every
authentication later if you want. Every
vault after this, as of right now, will
vault after this, as of right now, will
vault after this, as of right now, will
have authentication required. And then
have authentication required. And then
have authentication required. And then
of course if you needed to change which
of course if you needed to change which
of course if you needed to change which
I would recommend your local
I would recommend your local
I would recommend your local
installation pick something more secure
installation pick something more secure
installation pick something more secure
than password.
than password.
than password.
We have the idea of clustering. I've
We have the idea of clustering. I've
We have the idea of clustering. I've
been messing with this a little bit.
been messing with this a little bit.
been messing with this a little bit.
It's not fully tested yet but it is
It's not fully tested yet but it is
It's not fully tested yet but it is
coming. And then you can of course view
coming. And then you can of course view
coming. And then you can of course view
the logs of what's happening within Moon
the logs of what's happening within Moon
the logs of what's happening within Moon
and DB. A fresh Moon and DB database is
and DB. A fresh Moon and DB database is
and DB. A fresh Moon and DB database is
like a newborn. It just heard its first
like a newborn. It just heard its first
like a newborn. It just heard its first
word. It has all the cognitive
word. It has all the cognitive
word. It has all the cognitive
machinery, the temporal scoring, the
machinery, the temporal scoring, the
machinery, the temporal scoring, the
heavy and learning, the confidence
heavy and learning, the confidence
heavy and learning, the confidence
tracking. Everything is there and
tracking. Everything is there and
tracking. Everything is there and
working, but it hasn't experienced
working, but it hasn't experienced
working, but it hasn't experienced
anything yet. There's no associations to
anything yet. There's no associations to
anything yet. There's no associations to
strengthen, no patterns to learn from,
strengthen, no patterns to learn from,
strengthen, no patterns to learn from,
no access history to score against. The
no access history to score against. The
no access history to score against. The
magic of the system isn't in the
magic of the system isn't in the
magic of the system isn't in the
install. It's what it becomes after
install. It's what it becomes after
install. It's what it becomes after
you've been feeding it context.
you've been feeding it context.
you've been feeding it context.
Decisions, conversations, observations
Decisions, conversations, observations
Decisions, conversations, observations
for days, weeks, months. That's when the
for days, weeks, months. That's when the
for days, weeks, months. That's when the
associations it's quietly been building
associations it's quietly been building
associations it's quietly been building
start surfacing things you didn't ask
start surfacing things you didn't ask
start surfacing things you didn't ask
for. That's when the temporal scoring
for. That's when the temporal scoring
for. That's when the temporal scoring
starts separating what still matters
starts separating what still matters
starts separating what still matters
from what you've moved on from. That's
from what you've moved on from. That's
from what you've moved on from. That's
when it stops feeling like a database
when it stops feeling like a database
when it stops feeling like a database
and starts feeling like something that
and starts feeling like something that
and starts feeling like something that
actually knows your work. I want to be
actually knows your work. I want to be
actually knows your work. I want to be
clear about what I'm saying and what I'm
clear about what I'm saying and what I'm
clear about what I'm saying and what I'm
not saying. I'm aware that as the person
not saying. I'm aware that as the person
not saying. I'm aware that as the person
who built this, I have an obvious bias.
who built this, I have an obvious bias.
who built this, I have an obvious bias.
So, I'm going to try and be precise
So, I'm going to try and be precise
So, I'm going to try and be precise
rather than enthusiastic.
rather than enthusiastic.
rather than enthusiastic.
Mem zero, Zep, the lang chain memory
Mem zero, Zep, the lang chain memory
Mem zero, Zep, the lang chain memory
modules. These are real tools solving
modules. These are real tools solving
modules. These are real tools solving
real problems. Real engineering went
real problems. Real engineering went
real problems. Real engineering went
into them. I'm not trying to diminish
into them. I'm not trying to diminish
into them. I'm not trying to diminish
that. What I'm saying is that
that. What I'm saying is that
that. What I'm saying is that
architecturally they're all retrieval
architecturally they're all retrieval
architecturally they're all retrieval
systems. You ask, they fetch. The
systems. You ask, they fetch. The
systems. You ask, they fetch. The
database is passive between queries.
database is passive between queries.
database is passive between queries.
Moon and DB is a database where state
Moon and DB is a database where state
Moon and DB is a database where state
evolves between queries, where
evolves between queries, where
evolves between queries, where
activation patterns automatically build
activation patterns automatically build
activation patterns automatically build
associations, where temporal scoring
associations, where temporal scoring
associations, where temporal scoring
changes rankings without any code from
changes rankings without any code from
changes rankings without any code from
you, where the system develops an
you, where the system develops an
you, where the system develops an
understanding of what tends to matter
understanding of what tends to matter
understanding of what tends to matter
based on how you actually use it.
based on how you actually use it.
based on how you actually use it.
Whether that distinction matters for
Whether that distinction matters for
Whether that distinction matters for
your use case, I genuinely can't tell
your use case, I genuinely can't tell
your use case, I genuinely can't tell
you. It depends on what you're building.
you. It depends on what you're building.
you. It depends on what you're building.
What I can say is that once I understood
What I can say is that once I understood
What I can say is that once I understood
the difference, I couldn't see the
the difference, I couldn't see the
the difference, I couldn't see the
retrieval model the same way again. Go
retrieval model the same way again. Go
retrieval model the same way again. Go
to moon andondb.com. There's a quick
to moon andondb.com. There's a quick
to moon andondb.com. There's a quick
start, single binary bundled in better
start, single binary bundled in better
start, single binary bundled in better
under a minute to your first query. See
under a minute to your first query. See
under a minute to your first query. See
what you think.
