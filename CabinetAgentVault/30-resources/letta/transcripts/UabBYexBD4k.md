There's a fundamental truth about LLMs,
There's a fundamental truth about LLMs,
There's a fundamental truth about LLMs,
large language models. They are frozen
large language models. They are frozen
large language models. They are frozen
in time. They know everything about our
in time. They know everything about our
in time. They know everything about our
world up until their training cutoff
world up until their training cutoff
world up until their training cutoff
date and absolutely nothing about what
date and absolutely nothing about what
date and absolutely nothing about what
happened 5 minutes ago. Nor do they know
happened 5 minutes ago. Nor do they know
happened 5 minutes ago. Nor do they know
anything about your private data, your
anything about your private data, your
anything about your private data, your
internal wiks, your proprietary
internal wiks, your proprietary
internal wiks, your proprietary
codebase. And if we do want an LLM to
codebase. And if we do want an LLM to
codebase. And if we do want an LLM to
know any of that stuff, well, we have to
know any of that stuff, well, we have to
know any of that stuff, well, we have to
solve the problem of context injection.
solve the problem of context injection.
solve the problem of context injection.
How do we get the right data into the
How do we get the right data into the
How do we get the right data into the
model at the right time? And there have
model at the right time? And there have
model at the right time? And there have
been two very different ways to handle
been two very different ways to handle
been two very different ways to handle
this. Now, the first is really what we
this. Now, the first is really what we
this. Now, the first is really what we
can think of as the engineering
can think of as the engineering
can think of as the engineering
approach. It's rag retrieval augmented
approach. It's rag retrieval augmented
approach. It's rag retrieval augmented
generation. So here we've got an LLM and
generation. So here we've got an LLM and
generation. So here we've got an LLM and
we've also got an input prompt from the
we've also got an input prompt from the
we've also got an input prompt from the
user. Now ahead of time we take some of
user. Now ahead of time we take some of
user. Now ahead of time we take some of
the documents that we want to give to
the documents that we want to give to
the documents that we want to give to
this LLM. So these are documents that
this LLM. So these are documents that
this LLM. So these are documents that
could be PDFs or code files or entire
could be PDFs or code files or entire
could be PDFs or code files or entire
books and we chunk them. We break them
books and we chunk them. We break them
books and we chunk them. We break them
up into smaller chunks and we pass them
up into smaller chunks and we pass them
up into smaller chunks and we pass them
through to an embedding model and the
through to an embedding model and the
through to an embedding model and the
embedding model takes those chunks and
embedding model takes those chunks and
embedding model takes those chunks and
it turns them into vectors and those
it turns them into vectors and those
it turns them into vectors and those
vectors are then stored in a dedicated
vectors are then stored in a dedicated
vectors are then stored in a dedicated
vector database. Now when a user asks a
vector database. Now when a user asks a
vector database. Now when a user asks a
question, it performs
question, it performs
question, it performs
a semantic search to retrieve the most
a semantic search to retrieve the most
a semantic search to retrieve the most
relevant chunks and then inject them
relevant chunks and then inject them
relevant chunks and then inject them
into the context window. So now the
into the context window. So now the
into the context window. So now the
context window has the user prompt, but
context window has the user prompt, but
context window has the user prompt, but
it also has all of these chunks that we
it also has all of these chunks that we
it also has all of these chunks that we
have taken from the vector database and
have taken from the vector database and
have taken from the vector database and
together
together
together
this forms the context window. Now this
this forms the context window. Now this
this forms the context window. Now this
works but it does rely on something. It
works but it does rely on something. It
works but it does rely on something. It
relies on the hope that your retrieval
relies on the hope that your retrieval
relies on the hope that your retrieval
logic actually found the right
logic actually found the right
logic actually found the right
information in the vector database. Now
information in the vector database. Now
information in the vector database. Now
the the second approach is really a bit
the the second approach is really a bit
the the second approach is really a bit
more of a brute force approach and that
more of a brute force approach and that
more of a brute force approach and that
one is called long
one is called long
one is called long
context. Now this is really the model
context. Now this is really the model
context. Now this is really the model
native solution because you skip the
native solution because you skip the
native solution because you skip the
database here and you skip the embedding
database here and you skip the embedding
database here and you skip the embedding
model. All you do is you take your
model. All you do is you take your
model. All you do is you take your
documents and you just well you put them
documents and you just well you put them
documents and you just well you put them
straight into the context window and
straight into the context window and
straight into the context window and
then you let the model's attention
then you let the model's attention
then you let the model's attention
mechanism actually do the heavy lifting
mechanism actually do the heavy lifting
mechanism actually do the heavy lifting
of finding the answer. Now for a long
of finding the answer. Now for a long
of finding the answer. Now for a long
time this kind of brute force method
time this kind of brute force method
time this kind of brute force method
wasn't really much of an option because
wasn't really much of an option because
wasn't really much of an option because
initially context windows were tiny.
initially context windows were tiny.
initially context windows were tiny.
Early LLMs had context windows that
Early LLMs had context windows that
Early LLMs had context windows that
could maybe store what like 4K of
could maybe store what like 4K of
could maybe store what like 4K of
tokens. You couldn't fit a novel in
tokens. You couldn't fit a novel in
tokens. You couldn't fit a novel in
there, let alone a corporate knowledge
there, let alone a corporate knowledge
there, let alone a corporate knowledge
base. You basically had to use rag. But
base. You basically had to use rag. But
base. You basically had to use rag. But
today's models have much larger context
today's models have much larger context
today's models have much larger context
windows. Some of them have, you know, a
windows. Some of them have, you know, a
windows. Some of them have, you know, a
million tokens plus. And to put that
million tokens plus. And to put that
million tokens plus. And to put that
into perspective, a million tokens is
into perspective, a million tokens is
into perspective, a million tokens is
roughly 700,000 words. and you could fit
roughly 700,000 words. and you could fit
roughly 700,000 words. and you could fit
the entire Lord of the Rings series into
the entire Lord of the Rings series into
the entire Lord of the Rings series into
the prompt and still have room for The
the prompt and still have room for The
the prompt and still have room for The
Hobbit. So, this massive jump in
Hobbit. So, this massive jump in
Hobbit. So, this massive jump in
capacity forces us to ask a difficult
capacity forces us to ask a difficult
capacity forces us to ask a difficult
question about our architecture. Because
question about our architecture. Because
question about our architecture. Because
if we can simply command A, command C,
if we can simply command A, command C,
if we can simply command A, command C,
command V, all of our documentation into
command V, all of our documentation into
command V, all of our documentation into
the models context window, do we really
the models context window, do we really
the models context window, do we really
need the overhead of embedding models
need the overhead of embedding models
need the overhead of embedding models
and vector data stores? Is rag becoming
and vector data stores? Is rag becoming
and vector data stores? Is rag becoming
an unnecessary complexity layer? Well,
an unnecessary complexity layer? Well,
an unnecessary complexity layer? Well,
if we accept that we can fit whatever
if we accept that we can fit whatever
if we accept that we can fit whatever
data we need into the context window,
data we need into the context window,
data we need into the context window,
then the argument for doing so basically
then the argument for doing so basically
then the argument for doing so basically
boils down to one word,
boils down to one word,
boils down to one word,
simplicity. And let me give you three
simplicity. And let me give you three
simplicity. And let me give you three
reasons why stuffing the context window
reasons why stuffing the context window
reasons why stuffing the context window
directly may indeed be the way to go.
directly may indeed be the way to go.
directly may indeed be the way to go.
And reason number one is collapsing the
And reason number one is collapsing the
And reason number one is collapsing the
infrastructure. A production rag system.
infrastructure. A production rag system.
infrastructure. A production rag system.
Well, it is quite heavy. You need a a
Well, it is quite heavy. You need a a
Well, it is quite heavy. You need a a
chunking strategy which is like fixed
chunking strategy which is like fixed
chunking strategy which is like fixed
size maybe or sliding window or
size maybe or sliding window or
size maybe or sliding window or
recursive. You decide. You're going to
recursive. You decide. You're going to
recursive. You decide. You're going to
need a embedding model to encode the
need a embedding model to encode the
need a embedding model to encode the
data. You need a a vector database to
data. You need a a vector database to
data. You need a a vector database to
store it. You're going to need a
store it. You're going to need a
store it. You're going to need a
reranker to sort the results. you need
reranker to sort the results. you need
reranker to sort the results. you need
to keep all the vectors in sync with
to keep all the vectors in sync with
to keep all the vectors in sync with
your source data. It's basically a lot
your source data. It's basically a lot
your source data. It's basically a lot
of moving parts, a lot of places for
of moving parts, a lot of places for
of moving parts, a lot of places for
things to break. And long context offers
things to break. And long context offers
things to break. And long context offers
what we might call well just simply the
what we might call well just simply the
what we might call well just simply the
uh the no stack stack. You remove the
uh the no stack stack. You remove the
uh the no stack stack. You remove the
database, you remove the embeddings, you
database, you remove the embeddings, you
database, you remove the embeddings, you
remove the retrieval logic. The
remove the retrieval logic. The
remove the retrieval logic. The
architecture simplifies down to getting
architecture simplifies down to getting
architecture simplifies down to getting
the data and just well sending it to the
the data and just well sending it to the
the data and just well sending it to the
model. So that's reason number one.
model. So that's reason number one.
model. So that's reason number one.
Reason number two is the retrieval
Reason number two is the retrieval
Reason number two is the retrieval
lottery. Now, rag introduces a critical
lottery. Now, rag introduces a critical
lottery. Now, rag introduces a critical
point of failure here, the retrieval
point of failure here, the retrieval
point of failure here, the retrieval
step itself, because when a user asks a
step itself, because when a user asks a
step itself, because when a user asks a
question, rag looks at mathematical
question, rag looks at mathematical
question, rag looks at mathematical
representations of the data which are
representations of the data which are
representations of the data which are
stored in vectors. And vectors are
stored in vectors. And vectors are
stored in vectors. And vectors are
basically just like a really long series
basically just like a really long series
basically just like a really long series
of numbers in an array. And it tries to
of numbers in an array. And it tries to
of numbers in an array. And it tries to
find the closest match. That's semantic
find the closest match. That's semantic
find the closest match. That's semantic
search. But semantic search is
search. But semantic search is
search. But semantic search is
probabilistic and for all manner of
probabilistic and for all manner of
probabilistic and for all manner of
reasons, the retrieval might fail to
reasons, the retrieval might fail to
reasons, the retrieval might fail to
find the relevant document. And we
find the relevant document. And we
find the relevant document. And we
actually have a name for this. It's
actually have a name for this. It's
actually have a name for this. It's
called silent failure. The answer, well,
called silent failure. The answer, well,
called silent failure. The answer, well,
it existed in the data, but the LLM
it existed in the data, but the LLM
it existed in the data, but the LLM
never saw it because the retrieval step
never saw it because the retrieval step
never saw it because the retrieval step
didn't return the right results. With
didn't return the right results. With
didn't return the right results. With
long context, there is no retrieval
long context, there is no retrieval
long context, there is no retrieval
step. The model gets to see everything.
step. The model gets to see everything.
step. The model gets to see everything.
Now, reason number three
Now, reason number three
Now, reason number three
that is well, I think we're going to
that is well, I think we're going to
that is well, I think we're going to
call this the whole book problem. A rag
call this the whole book problem. A rag
call this the whole book problem. A rag
is fundamentally designed to retrieve
is fundamentally designed to retrieve
is fundamentally designed to retrieve
what exists. It relies on finding a
what exists. It relies on finding a
what exists. It relies on finding a
semantic match between your query and a
semantic match between your query and a
semantic match between your query and a
specific snippet of text in your
specific snippet of text in your
specific snippet of text in your
database. But what if the answer lies in
database. But what if the answer lies in
database. But what if the answer lies in
what's not in the database? So, so let's
what's not in the database? So, so let's
what's not in the database? So, so let's
say you have a set of product
say you have a set of product
say you have a set of product
requirements stored as a document and
requirements stored as a document and
requirements stored as a document and
you've also got a set of release notes
you've also got a set of release notes
you've also got a set of release notes
stored as a document and then we ask
stored as a document and then we ask
stored as a document and then we ask
which security requirements were omitted
which security requirements were omitted
which security requirements were omitted
from the final release. Now using rag
from the final release. Now using rag
from the final release. Now using rag
when you query for omitted security
when you query for omitted security
when you query for omitted security
requirements the vector search looks for
requirements the vector search looks for
requirements the vector search looks for
chunks discussing well security and
chunks discussing well security and
chunks discussing well security and
requirements. It retrieves snippets from
requirements. It retrieves snippets from
requirements. It retrieves snippets from
the requirements doc. It retrieves
the requirements doc. It retrieves
the requirements doc. It retrieves
snippets from the release notes, but it
snippets from the release notes, but it
snippets from the release notes, but it
cannot retrieve the gap between them.
cannot retrieve the gap between them.
cannot retrieve the gap between them.
And because rag only shows the model a
And because rag only shows the model a
And because rag only shows the model a
few isolated snapshots, the model never
few isolated snapshots, the model never
few isolated snapshots, the model never
sees the full picture required to spot
sees the full picture required to spot
sees the full picture required to spot
the missing pieces. The model really
the missing pieces. The model really
the missing pieces. The model really
needs both of these documents in full to
needs both of these documents in full to
needs both of these documents in full to
perform the comparison, which is exactly
perform the comparison, which is exactly
perform the comparison, which is exactly
what long context does by dumping the
what long context does by dumping the
what long context does by dumping the
whole book. the full requirements dock
whole book. the full requirements dock
whole book. the full requirements dock
and the full release notes into the
and the full release notes into the
and the full release notes into the
context window. So, is rag dead? Is the
context window. So, is rag dead? Is the
context window. So, is rag dead? Is the
vector database destined for the museum
vector database destined for the museum
vector database destined for the museum
of things we needed in 2024?
of things we needed in 2024?
of things we needed in 2024?
Well, not quite because while long
Well, not quite because while long
Well, not quite because while long
context wins on simplicity, rag still
context wins on simplicity, rag still
context wins on simplicity, rag still
has a place. And I got another three
has a place. And I got another three
has a place. And I got another three
reasons to support that. So, reason
reasons to support that. So, reason
reasons to support that. So, reason
number one is the rereading text. Now,
number one is the rereading text. Now,
number one is the rereading text. Now,
long context creates a massive compute
long context creates a massive compute
long context creates a massive compute
inefficiency. So, if we take a manual,
inefficiency. So, if we take a manual,
inefficiency. So, if we take a manual,
let's say this is like a a 500 page
let's say this is like a a 500 page
let's say this is like a a 500 page
manual, and we've got to turn this into
manual, and we've got to turn this into
manual, and we've got to turn this into
tokens. Well, that's something like 250k
tokens. Well, that's something like 250k
tokens. Well, that's something like 250k
of tokens. And we need to do that every
of tokens. And we need to do that every
of tokens. And we need to do that every
time we make a user query and we put
time we make a user query and we put
time we make a user query and we put
this document in the prompt. You're
this document in the prompt. You're
this document in the prompt. You're
basically requiring the model to process
basically requiring the model to process
basically requiring the model to process
that manual every time. Now, rag also
that manual every time. Now, rag also
that manual every time. Now, rag also
has to process that manual, but it only
has to process that manual, but it only
has to process that manual, but it only
pays that processing cost once at
pays that processing cost once at
pays that processing cost once at
indexing time. Now, prompt caching that
indexing time. Now, prompt caching that
indexing time. Now, prompt caching that
can partially offset some of this for
can partially offset some of this for
can partially offset some of this for
static data, but for dynamic data
static data, but for dynamic data
static data, but for dynamic data
streams where content changes
streams where content changes
streams where content changes
frequently, you are stuck paying the
frequently, you are stuck paying the
frequently, you are stuck paying the
full tax on every request.
full tax on every request.
full tax on every request.
Reason number two is the needle in the
Reason number two is the needle in the
Reason number two is the needle in the
haystack problem. Now, there's a an
haystack problem. Now, there's a an
haystack problem. Now, there's a an
intuitive assumption that if data is in
intuitive assumption that if data is in
intuitive assumption that if data is in
the context window, the model's probably
the context window, the model's probably
the context window, the model's probably
going to use it, but research suggests
going to use it, but research suggests
going to use it, but research suggests
otherwise. Because as we start with a
otherwise. Because as we start with a
otherwise. Because as we start with a
context window and then it grows and it
context window and then it grows and it
context window and then it grows and it
continues to grow and now we're at like
continues to grow and now we're at like
continues to grow and now we're at like
500,000 tokens, well, the model's
500,000 tokens, well, the model's
500,000 tokens, well, the model's
attention mechanism can get a bit
attention mechanism can get a bit
attention mechanism can get a bit
diluted. If you ask a specific question
diluted. If you ask a specific question
diluted. If you ask a specific question
about a single paragraph that's buried
about a single paragraph that's buried
about a single paragraph that's buried
in, let's say, the middle of a 2,000page
in, let's say, the middle of a 2,000page
in, let's say, the middle of a 2,000page
document, well, the model often fails to
document, well, the model often fails to
document, well, the model often fails to
retrieve it or it hallucinates details
retrieve it or it hallucinates details
retrieve it or it hallucinates details
from the surrounding text. But with rag,
from the surrounding text. But with rag,
from the surrounding text. But with rag,
we're giving the model less noise. So by
we're giving the model less noise. So by
we're giving the model less noise. So by
retrieving, say only the top five
retrieving, say only the top five
retrieving, say only the top five
relevant chunks, rag has removed the
relevant chunks, rag has removed the
relevant chunks, rag has removed the
haystack and presents the model with
haystack and presents the model with
haystack and presents the model with
just the needles. It forces the model to
just the needles. It forces the model to
just the needles. It forces the model to
focus on the signal and not the noise.
focus on the signal and not the noise.
focus on the signal and not the noise.
And then reason number three, well that
And then reason number three, well that
And then reason number three, well that
is the infinite data set. Now a context
is the infinite data set. Now a context
is the infinite data set. Now a context
window of millions of tokens sounds
window of millions of tokens sounds
window of millions of tokens sounds
great but in the scheme of enterprise
great but in the scheme of enterprise
great but in the scheme of enterprise
data that's really just a drop in the
data that's really just a drop in the
data that's really just a drop in the
bucket. I mean an enterprise data lake
bucket. I mean an enterprise data lake
bucket. I mean an enterprise data lake
that's probably measured in terabytes or
that's probably measured in terabytes or
that's probably measured in terabytes or
or maybe even pabytes. So if you want an
or maybe even pabytes. So if you want an
or maybe even pabytes. So if you want an
infinite data set that stores
infinite data set that stores
infinite data set that stores
everything, you really do need to have a
everything, you really do need to have a
everything, you really do need to have a
retrieval layer to filter information
retrieval layer to filter information
retrieval layer to filter information
down to something that fits into the LLM
down to something that fits into the LLM
down to something that fits into the LLM
context window. So where does this leave
context window. So where does this leave
context window. So where does this leave
us? Well, if your problem involves a
us? Well, if your problem involves a
us? Well, if your problem involves a
bounded data set and requires complex
bounded data set and requires complex
bounded data set and requires complex
global reasoning like analyzing a
global reasoning like analyzing a
global reasoning like analyzing a
specific legal contract or summarizing a
specific legal contract or summarizing a
specific legal contract or summarizing a
book, I think long context is the way to
book, I think long context is the way to
book, I think long context is the way to
go. It simplifies the stack and it
go. It simplifies the stack and it
go. It simplifies the stack and it
improves the reasoning. But if you're
improves the reasoning. But if you're
improves the reasoning. But if you're
navigating the infinite data set of
navigating the infinite data set of
navigating the infinite data set of
enterprise knowledge, the vector
enterprise knowledge, the vector
enterprise knowledge, the vector
database remains the only viable
database remains the only viable
database remains the only viable
warehouse for your data. But how about
warehouse for your data. But how about
warehouse for your data. But how about
you? Are you team long context, team
you? Are you team long context, team
you? Are you team long context, team
rag, maybe a bit of both? Let me know in
rag, maybe a bit of both? Let me know in
rag, maybe a bit of both? Let me know in
the comments.
