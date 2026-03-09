All right,
welcome to day seven of Missing Semester.
Today we're going to talk about agentic coding,
so continuing some of the topics on AI-powered development that we were covering in the Development Environment and Tools lecture last week.
So last time in that lecture we talked about some AI-assisted coding like autocomplete and inline chat.
Today we're going to be talking about something that I think is much more sophisticated and new,
a different form factor than what existed,
say,
five years ago.
which is coding agents.
And
I think right at the start of this lecture,
I'm going to show you a demo of how these things work,
and then we'll talk about how they work under the hood,
and then talk about basics,
and then more advanced topics.
So that's the plan for today.
So for the initial demo,
I'm going to actually continue with the example we were doing during the development environment and tools lecture.
So recall,
I'll actually bring up the code here on the screen.
So recall that we were working on this little script to...
Oh,
it's not what I wanted.
One second,
I need to do a little bit of setup.
Okay,
so recall that we were working on this script to download a page from the course website and extract all the links from it.
And this is where we're at.
So pretty simple little Python script.
And suppose we wanted to take this script we hacked together and turn it into a slightly nicer command line program.
Maybe we want to do things like add some argument parsing,
make this a page we want to fetch the contents from,
a command line argument,
things like that.
So we can ask a coding agent to just do this entire task for us end-to-end.
And so in today's lecture,
I'm going to use Claude Code,
which is one particular coding agent.
There are a bunch of other tools out there.
We have a recommended software section at the bottom of today's lecture notes.
And they're both command line coding agents,
which I at least personally prefer to use at this time.
There's also coding agents built into IDEs.
So if you're using something like VS Code or Cursor,
you can access roughly the same type of functionality within the IDE.
And so here I've started up Claude Code.
I just opened up a terminal in my directory where I have my code,
and I type.
Claude, and this brings up this command line interface to Claude Code.
And a coding agent is basically just a conversational AI model with access to some tools that will help it write code.
So if you've used something like ChatGPT before,
this is like roughly ChatGPT,
except the AI model can do things like read and write files and execute shell commands on your computer.
And then sometimes these models are specially tuned to be able to be particularly effective at writing software.
And so
I have this dl.py script in this directory,
and I can go ahead and just give natural language input to the coding agent and say something like,
turn the script I wrote...
here,
I typoed this on purpose,
I'll just leave it that way.
Turn the script I wrote,
dl.py,
into a proper command line program,
use argparse for argument parsing,
and maybe I wanted to make it nicer in some other ways like some things I'm missing here
Oh,
I guess I have type annotations here,
but I can say,
like,
make sure it has proper type annotations,
check that it works using mypy.
So I want to check the type annotations,
make sure it passes type checking.
So I can give it a command like this,
and then it starts thinking.
And then let me just explain its output.
So it gives some textual output,
like ChatGPT can say text back to you.
But then it can also invoke tools.
So this model decided to read the file dl.py.
That's a reasonable way to get started with this task.
And this is a pretty easy task.
So it just updates this dl.py and in one shot writes all the code.
So I can go in here and see what changes it's made.
As we can see,
it's written some more functions.
And now it has this main function that has the command line argument parsing and stuff.
So it's just done the entire task I asked it to do.
And it's continuing to follow my instructions.
So recall that I told it to make sure it has type annotations and that the type checker says that everything is good.
And so here it's trying to invoke the next command.
So it's using the shell and invoking mypy and giving it as an argument the path to the script.
And one thing we noticed here,
when it was editing files,
it didn't ask me for permissions.
It just went ahead and edited stuff.
That's because I have my coding agent configured in this way.
Because I find that if you need to,
if it's asking for permissions for every single little change it makes to files,
it's kind of annoying.
I want it to be able to operate more autonomously.
And generally,
I track everything in Git.
So I can let the coding agent make a whole bunch of changes and then review them at once later.
But for other tools that the coding agent wants to invoke,
like bash,
I want to make sure I'm actually checking every single command that it runs and making sure that it's safe.
We won't get into the details of agent security today,
but there are some security concerns if you let these things run fully autonomously.
And they might do things like invoke a command that you don't want it to invoke.
It might say delete a file that you care about or much more dangerous things than that.
At least I personally recommend that you run them in this mode where you have to approve individual tool calls that can do things like mutate your computer state.
So I've approved that tool call.
The agent harness ran the tool.
It gave the results back to the AI model.
The model said that everything looks good.
And then it's deciding to continue along and wants to run the script and make sure it seems to be working.
So it's doing some more things here.
And there we go.
It has completed the task I asked it to complete.
So that's what an AI...
Yeah,
question?
Yeah,
so the question is,
like,
this is using some hosted AI service in the background.
Can you limit how much money you're spending?
The answer is,
yeah,
yes,
you can.
It depends on the tool exactly what the configuration knobs are.
Generally,
you can select which AI model you want to use and then like higher capacity models,
which might be better at solving harder tasks,
will be more expensive.
And then smaller and faster models will be cheaper.
So that's one control you have.
And certain services actually slightly limit spend.
Like you can say,
I want to spend at most,
whatever,
$10 this month.
Yeah.
Yeah.
So the question is,
do I limit spending?
At least personally,
I don't.
I keep an eye on the usage.
So in Claude Code,
for example,
there's a slash cost command.
And this thing we've done so far has cost us about 19 cents.
So I'll keep an eye on this and make sure things are not getting too unreasonable.
I think if you're a student,
one decent way to get started might be go for one of the subscription plans that's $20 a month,
and then they have some amount of usage included with that.
And then if you're going above that amount of usage and think about how you're using AI.
I know that
In a lot of companies,
people are finding these tools are loved by engineers and increase productivity enough that compared to the cost of the engineer's time,
the tool cost is relatively low.
And so I know a lot of people who are spending a lot,
like several hundred dollars a month in AI usage,
but it's fine for their purposes.
Yeah,
question.
Yeah.
Coding agents cost money and they also require internet to first approximation,
yes.
You can also use coding agents that run locally and use models that run on your own laptop.
There are trade-offs there.
You have to use much lower capacity models unless you have...
You basically have to use much lower capacity models than the one I'm using in this demo,
for example.
And then they might work okay for simple tasks,
but for harder things,
they don't really work that well.
And
I think for practically today,
it makes sense to use one of the hosted models and pay for it.
Yeah,
the question is about subscription versus pay once.
I think they're all subscription because inference costs just depend on usage.
And then the pricing models vary and you can Google them and find it.
I think we don't want to spend too much time in this lecture talking about pricing.
We're going to talk about what are coding agents conceptually,
how to use them effectively,
and so on.
Cool.
So in this example,
I've shown you a very high level overview of it.
demonstration of using a coding agent,
show it how we can talk to the tool.
Here it did everything correctly.
So I just did this one shot thing.
I gave it an instruction.
It did a bunch of stuff,
including calling tools,
looking at the results,
calling more tools,
depending on what happened.
And eventually just coming back to me and saying,
okay,
I did the thing you asked for,
and the end.
You can also do multi-turn interactions with these things.
I can actually remove the type annotations,
and it will keep going.
It has the context from the rest of the previous conversation,
and I can send a follow-up messages like this.
And now this is a kind of silly thing.
It's kind of making our program worse.
But it did the thing.
More practically,
you would iterate on the thing you're working on.
If you were working on a feature where you didn't exactly know what the spec of the feature should be,
you might give it some rough description.
It does a thing.
Then you judge the results.
It's like,
oh,
actually,
I want you to tweak it in this way or that way.
And you can use these tools in this iterative manner.
Another thing you can do is if the coding agent goes wrong,
either if it does the wrong thing and gets confused,
or if you see it going off the rails and it's kind of thinking a lot or calling tools in a nonsensical way,
you can even interrupt it,
like with Control-C,
for example,
in this tool I'm using,
and then give it a follow-up message.
So if it was calling,
say,
the wrong tool,
like maybe I had mypy installed in some funny location and it couldn't find it,
I could just interrupt it and be like,
actually,
mypy is here.
Call it this way.
for example.
So any questions about that?
Yeah.
Yeah.
So the question is,
can you hard code things like don't touch this file or don't touch this part of the file?
In the particular tool I'm using,
I think you can't hard code not being able to touch a particular part of a file.
The way I would approach something like that practically,
I think it's just like keep track of everything in Git,
see what it changes.
like if it changes a thing you didn't want to change,
revert it.
You can also give it natural language instructions.
Like you can say,
remove all the type annotations except for in this function or like don't change this chunk of the code.
And it generally does a decent job of respecting those instructions.
Yeah.
Yeah.
So the question is,
do I have experience with test-driven development using the agent?
And the answer is yes.
I think we will get to that a little bit bit later in the lecture.
TLDR is a pretty good way to use these tools.
Either write the test yourself and then tell the agent to do the thing,
like implement the feature such that it passes the tests,
or you can even use the coding agent to help you write the test to begin with,
and then you can ask it to implement the feature that passes the tests.
These things work really well with feedback loops.
So if you can set them up so that it's like,
okay,
maybe you have some code that doesn't compile,
or some code that doesn't type check,
or something like that,
you can say,
here's the error,
here's what you can run to reproduce the error,
and keep working at it until you fix it.
And that works well with test-driven development as well.
Okay,
so we're going to talk a lot more about practically how to use these tools in different use cases and stuff.
But one topic I wanted to cover today was talking a little bit about how the underlying AI models and also how these agent harnesses work.
Now,
this is like a very deep area of research.
I'm obviously not going to cover this topic in its entirety in whatever.
the 10 minutes I'm planning on spending on it.
I could spend an entire semester going into in-depth on the topic,
but I think I'm going to try to cover it at just the right level of abstraction such that you learn the aspects of these tools you need in order to be able to use them effectively.
So I'm not going to teach you how to re-implement one of these things on your own,
but I will try to share a little bit about how they work so that you understand what they're good at and their limitations and why people have implemented certain features and agent harnesses and topics like that.
So
AI coding agents consist of roughly,
I'd break them down into two main parts.
There's an underlying language model,
and then wrapping that language model is an agent harness.
And so
I don't know how much background everybody has on language models.
Maybe raise your hand if you've used ChatGPT or any kind of AI language model before.
Okay,
great.
Okay,
so most of the hands went up.
Language models,
or sometimes called large language models,
can be thought of as modeling a probability distribution of completion strings.
Let's call those y.
Modeling completion strings as a function of prompt strings,
which we'll call x.
So completions,
completions y,
and prompts x.
So it's just this.
conditional generative model that will tell us,
given a particular input,
a sequence of strings,
what is the probability distribution over output strings that correspond to that sequence of inputs.
And then when we use these models,
and then so we can say like model this as a distribution,
I'll write it as pi theta,
this parameterized distribution of completions y given prompts x.
And then when we use these things,
we sample from this distribution,
You can sample strings y hat from this pi theta given inputs.
And that is it.
That's all an AI language model is.
And there's a lot of work that goes into finding a good probability distribution that does something useful.
But then in practice,
how you use them is you give them a bunch of text or strings or tokens as input.
And then they give you back a bunch of text as output.
And then everything else is built on top of that core primitive.
One other detail to note here is that in practice these things have a limited context window.
And basically that means that the length of this string and the length of the string have bounds.
All right,
so then building on top of this...
Like how does something like ChatGPT work?
Like how does conversational chat work?
I think you could probably imagine how you could use this for single turn chat.
Like you give it a question here and you get an answer here.
Like how would you do follow-up questions?
Any ideas?
If you wanted multi-turn chat.
So the way these things work is they use turn markers and you give your entire conversation history as the input to the model and it gives you the next thing,
the model's output.
as the output from the probability distribution.
So you might give it as an input something like the user says,
I don't know,
like can't write out long questions on the blackboard,
but like what is one plus one?
And then the assistant might say,
so in the first query,
when you sample from the probability distribution,
like this is your first X,
and then this thing is your first Y hat.
And then if you want to ask a follow-up question,
So I'm writing a dependent query here on purpose.
Like what if you replaced the ones with twos?
So this query on its own is not super meaningful.
You need the context to be able to answer this thing correctly.
And so the way a conversational chat app handles something like this is that it will sample Oh.
from the large language model again with this whole thing as being the prompt with some special encoding of these things as turn markers.
So the user said this,
the language model output was this,
now the user said this,
and that will generate the next thing.
So this will be your next output.
Okay,
so we've gone from this primitive of large language models,
which you can think of as a probability distribution to
how you use them for multi-turn chat.
And next we will talk about how you build something like an agent harness,
building on top of that idea.
So any questions about that so far?
Cool.
So one more idea you can add is,
like here we added turn markers.
Now we can add some special interpretation of the outputs from the LLM.
And we can say the model can output things like assistant and then some text.
But we can also have outputs that are like call a tool.
So we will train a language model such that it can output requests to do things on your machine.
So it might be...
So an example of this is something like the things we gave up here.
An example of a tool call might be a request to run,
I don't know,
like mypy,
dl.py.
And then we will have some code that wraps the language model,
kind of like in our conversational chat app,
we had this thing which would build our follow-up inputs by
concatenating together the entire message history,
we will have an agent harness,
also sometimes called scaffolding,
which will interpret these outputs.
So this is a y-hat from the LLM.
It'll interpret these outputs.
It will actually execute them on the machine and then feed them back into the language model as a subsequent input.
So it will do the thing.
And then maybe there's all this textual output from the mypy tool.
Like it says like checking dl.py,
blah,
blah.
Maybe it says like error line one,
expected int,
blah,
blah.
And you will take all this output and actually just stick it in as another input to the LLM.
So this forms a subsequent component of the X that you'll feed into the LLM.
Yeah,
question?
So the question is,
what exactly is the agent harness?
It does a number of things.
It will implement the aspect of the code,
which runs calls to the LLM in a loop,
takes the outputs.
If there are tool calls,
it will actually dispatch the tool call.
It will actually execute this thing on your machine.
It will get the text that this thing produces and feed it back to the language model and have it produce another output.
And so...
Yeah,
so those are the two main things it does.
So roughly,
agent harnesses will take in your user input,
then in a for loop,
call the agent.
If it requests a tool call,
it will execute the tool,
feed the input back into the language model,
have it generate another completion.
If it's another tool call,
it will execute the tool,
feed back the results to the language model and produce another completion and so on until the language model outputs textual output for the user,
at which point...
it will say like okay I'm done, control's back to the user and then you can proceed and so you'll have tool implementations like you might have in your coding agent tools like bash so you can have your agent execute
bash scripts you might have things like file edit like file read write and so on and together those combination of tools
lets the underlying AI model actually make changes to things on your machine and like develop code in some intelligent way.
Doing things like being able to run tests,
see what happens when you run the test,
and take that into account when deciding what actions to take in the future.
Oh,
is there a question in the back?
Okay.
So these are the main primitives.
Like there's a language model that's modeling a probability distribution over strings or tokens at the heart.
And then there's this.
agent harness that will call the LLM in a loop,
do repeated samplings,
and also dispatch requests to execute tools,
actually run them and feed the results back to the language model to drive things forward.
Usually when you type in a query,
it'll run a bunch of tools and kind of under the hood,
it's sampling from this language model many,
many times.
Yeah,
question?
Yeah,
so the question is,
is there a well-understood interface between the agent harness and the underlying language model so that you can have them interop?
And yes,
there are some commonly used interfaces.
It's not perfectly standardized and everybody's using the same thing,
but there's a good amount of interop these days.
So for example,
there are open source agent harnesses like OpenCode,
and then you can have them work with different underlying language models.
They can work with the Anthropic models and they can work with the OpenAI models and so on.
Yeah,
question.
Yeah,
so you're pointing out that the language model is this probabilistic thing and the agent harness is probably like the code you write in the harness itself is deterministic,
like how do these things relate?
So they relate through sampling.
When the agent harness calls to the LLM,
it's sampling an output string and then doing things based on that.
So you will call into the language model,
it'll output something like run this command,
and then you will run the command and continue.
Related to the non-determinism,
this language model is trained in a smart way,
but it's not intelligent in the same way that people are intelligent.
It will sometimes output things that are not quite right.
So it'll call commands that don't actually exist on your computer or use these file read-write tools.
to write incorrect code or things like that.
But in practice,
these things tend to work reasonably well.
And as you use them,
you'll build intuition for what they're good at and what they're not yet good enough to do.
Yeah.
Yeah.
So we already did.
Yeah.
So now that we've talked about how these things work,
We can go back and look at this example again and understand it from the lens of how things work under the hood.
So here I've booted up my agent harness.
In this particular case,
I'm using the Claude Code agent harness,
which is developed by Anthropic.
And under the hood,
it's using Anthropic's Opus 4.5 large language model.
I gave it the first query here.
So that's like the initial user query up in the top right.
The model here outputted some intermediate text.
and then decided to call a tool.
So this LLM called the read file tool with an argument dl.py.
That went to the agent harness.
It interpreted that language model output as like,
oh,
the language model is asking to call a tool.
It actually executed the file read operation on my file system,
produced that data which corresponds to the contents of the file,
and then fed that back in as additional input to the language model.
And so again,
think about the example in the top right.
This is adding more and more stuff into that X.
Like we kind of have this X that we start off with,
and we're appending more and more things to this conversation history up until the most recent message or data we're passing into the LM.
in this example.
So like the last thing sent to the LLM right here will be the contents of that file.
So then the model,
we run inference,
we sample from the model,
and now the model decides to output some more text.
It's giving me an update on what's going on.
And it also outputs a request to call another tool.
This time it's the file write tool.
And in this particular agent harness,
and I think is fairly commonly done.
the file write tool,
like there are a couple different interfaces,
and the model can actually supply a diff which is applied to the file.
So again the model emits a diff,
so it's just a chunk of text,
and then the agent harness,
in this case Claude Code,
will interpret that diff and apply it to the file on my file system.
So then it's done that,
it's outputted some more intermediate text.
Yeah there's this file update operation.
has a return value which is like it's like oh the operation was successful so that was given back to the model here we run another pass of inference the model decides to call another tool this time it's calling mypy so the type checker so then the agent harness interprets that runs the type checker produces the outputs uh from the tool so this time it's like success no issues found that gets passed back in to the model we run another pass of LLM inference and so on and there's like one more tool call here before it finally emits the like I am done with my my turn,
here's the final text output.
and control goes back to the user.
So like a whole bunch of LLM inference steps happening in here and a whole bunch of tool calls happening in here for a single user prompt,
right?
Cool,
and then just a brief note on privacy while we're talking about how these things work under the hood.
So as we talked about a little bit earlier,
these higher capacity language models,
which tend to be better at doing these complex tasks,
need pretty beefy.
hardware to run inference,
like to sample from that probability distribution.
And so these things run in the cloud for the most part.
And when you're using these things,
like unless you have some kind of special agreement with the provider,
you are sending them your data.
They may train on the data and things like that.
So if privacy is a concern,
look into the details of the terms and conditions or find some setup that works for you.
All right.
So let's spend the rest of this lecture talking a little bit about use cases.
And I think I'll try to spend...
Yeah,
question.
Yeah,
so the question is,
is Claude the LLM and the agent harness both?
The answer is there are a couple different setups.
In this case,
a component to the agent harness can be thought of as running in the Cloud along with the model,
which is definitely running in the Cloud here.
You can also find open source agent harnesses where the harness will run entirely locally,
but all the LLM inference steps will end up sending data to the Cloud for inference.
Yeah,
cool.
Okay,
so we've already given one example of how to use a coding agent.
to implement a new feature,
you can be pretty specific with how you give instructions to these things.
You can also be open-ended and iterate from there.
So for example,
I can go into the
Git repo for the class website,
the missing semester website,
and I'll boot up Claude and I can say something like,
make it look retro.
We can see what happens.
This will take a minute or two.
So we'll come back to this one.
Another great use case for coding agents is using them them to fix issues in your code.
So if you have a compiler issue,
like your code doesn't compile,
if you have a linter issue,
we'll cover linters in more detail on Friday,
but if you have a tool that checks for various types of errors in your code and it's complaining,
you can ask a coding agent to fix the issue for you.
And if you have unit tests,
or if you have a bug in your code,
one great way to at least take a first shot at solving that bug is to construct a test for the bug.
This is a great software engineering practice in general.
If there's something wrong with your code,
write a test.
So you can later use that as a regression test to make sure things don't go wrong in the future.
And then once you have a test,
you can tell the coding agent,
like,
hey,
this test is failing,
like figure out what the issue is and make the test pass.
And so as a quick demo of this,
it's a little bit hard to demo because like I want to work in a real code base and then you don't have context on the code base.
But I will,
so don't worry about all the details here,
but but we'll try to show you at a high level how things are working.
Okay.
So
I have a code base here,
don't worry about the details,
and I noticed an issue with the code.
And in this particular case,
I hand wrote a unit test for that issue.
And so if I run this test,
I'll see that the test fails.
You can also use the coding agent to try to take the initial crack at writing the test.
Like you could boot up the agent and say,
hey,
like when I use the code in this way,
like things go wrong,
can you write a test for it?
But then once you have a test that you're happy with,
you can boot up your coding agent.
and I'm going to copy paste this command.
You can boot up your coding agent and say something like,
there's a bug.
I wrote a test for it.
You can run it with this command to reproduce the issue,
fix the bug.
And then just like a human developer would do in this case,
like you'd first run the test to reproduce the bug.
And that's what the agent's doing.
So it's calling bash with this thing I gave it to run that particular test I just wrote.
And then it looks at...
the output and sees like,
yes,
this is indeed failing.
That output on its own is not super informative or it's like on its own,
not enough to fix the bug.
You need to actually read and understand the code.
So that's what the agent's doing next.
These things are actually pretty good at traversing code bases and like understanding code,
whatever understanding means for AI models.
So we can see like,
okay,
it's reading files.
It's here's another tool that it has.
It has a search tool,
which lets it search with a regex pattern for different things that match this pattern.
It's reading more files,
searching,
reading,
searching,
reading,
thinking.
And
I think in this particular case,
the bug is simple enough that it should just,
in one shot,
fix the bug.
Another thing that makes these coding agents a little bit hard to demo is that they're not the fastest things.
And this is something that a lot of people are working on.
Like,
how do you make agents that are really good and effective at what they do,
but also run faster?
Like here we're seeing,
oh,
it's been like one whole minute this thing is running.
But yeah,
it makes demos a little bit trickier.
can't fast forward this behavior because I wanted to do a live demo.
But okay,
now the model's saying,
oh,
here's what I think the bug is.
Here,
I'm going to fix it in this way.
And then it tries to,
on its own,
run the test again to see,
did I indeed fix the bug?
So we can approve that request to execute a tool.
And then we find,
oh,
the test passes now.
And then here,
the model's doing some other intelligent stuff.
Generally,
when you fix a bug in your code,
you want to make sure that the test you just wrote to catch that bug indeed passes.
But then,
you should run the rest of the test,
make sure you didn't break something else in the code base.
So then the agent's going and doing other useful things like that.
And then,
okay,
now the agent's done thinking and working,
it's made the changes to run the test,
and it's giving me a summary of what it did.
And I can even say something like commit the changes,
and it will create a git commit for me with some useful commit message and so on.
Yeah,
we can see these things are actually trained pretty well.
It's learned that it should not just make up a commit message.
You want to follow the style of the repository.
So it's actually looking at,
okay,
it's looking at git status to see what stage for commit and what's changed.
It's looking at a git diff to make sure what changes is the thing it did,
not some other changes that I'd made in the past.
And then it's looking at the git log,
like what do the recent commit messages look like,
so it can try to match the style.
And then it writes this commit message,
which actually looks pretty reasonable and says,
like,
oh,
this fixes this GitHub issue and so on.
question in the back.
Yeah,
so the question is,
does the prompt you gave the coding agent and the underlying LLM
affect the quality of the code,
how verbose the code is,
how long it takes to do the task,
and so on.
And the answer is absolutely,
yes.
It's a little bit more of an art than a science at this point to prompt LLMs well.
Also,
the underlying models are continually improving.
So it might have been the case that if you use a model from two years ago,
which nobody really uses now,
but if you use a really old model,
maybe you can still get it to complete a task like this,
but you have to be really descriptive in how to do it.
And now you can just be like,
there's a bug,
fix it,
and it'll figure things out.
But yeah,
I think there's a lot of resources.
I think we've linked some in the notes and we can link more.
A lot of resources on how to effectively prompt these tools to do various classes of tasks.
How do you get it to implement a sophisticated feature?
And there are various patterns people follow.
For silly things like this,
make my thing look retro,
all I said was make it look retro and it's going and doing the thing.
But for any of the complex,
serious feature,
you might have a really long prompt that's paragraphs and paragraphs long.
Or maybe you want to follow a software development practice closer to what people do in industry.
Maybe you want to put on your product designer hat and put on your product manager hat and write a whole PRD,
a product requirements doc,
and then you can give a huge markdown doc to a coding agent and be like,
hey,
here's a PRD.
Read it,
understand it,
make an implementation plan,
and then implement it.
So there are different advanced patterns you can follow like that to do more sophisticated things.
Yeah,
question.
[inaudible question]
Yeah,
so the question is,
if you start the coding agent in a directory,
does it see everything in that directory and subdirectories?
To first approximation,
yes.
Some of these agents also can request to see things outside of the directory.
There's a lot of,
the space is pretty new.
There are a lot of different tools out there.
And like some of these details vary between the tools.
But yeah,
basically,
yes,
you will want to operate at the level of a Git repository generally.
Cool.
So we saw this end-to-end example of...
fixing a bug given a failing test.
We can also just for fun see,
oh this is still thinking,
making our course website look retro.
All right.
Yeah,
let's not commit and push that change.
But yeah,
these things can actually be pretty useful for creative work too.
If you read the lecture notes for today,
in part just to like kind of dog food this technology,
we used Claude Code to work on a number of changes related to our course website.
We needed to do some refactoring when we pulled this lecture out from the previous development environment lecture into its own lecture.
And we just asked Claude Code to do that for us.
It did a decent job,
didn't get it perfect.
You can see the linked GitHub pull request to see what the agent did and what I had to do manually to fix things up afterwards.
It didn't carry over all the exercises and put them in quite the right place.
Some of them just disappeared and I had to restore them.
We also implemented things like...
Here,
let me get rid of these changes.
We also implemented things like our
Tufte-style sidenotes using Claude Code.
So yeah,
I think Jon didn't write a single line of that code himself.
It was all just like vibe coding with Claude Code.
And yeah,
so for this kind of creative work,
just telling the agent to do something with like some high level description and then just looking at the results and then giving it feedback to make tweaks can actually be super effective.
Like I know a lot of people who do front-end design and web design and things like that using these agents these days.
Cool.
So we're talking through use cases.
I think we have about 10 minutes left.
So I'm not going to demo every single use case that we have in our notes.
And also,
I'm sure you can come up with many more use cases beyond what we've written in our notes.
But I'll briefly talk through them.
And then I want to spend the last bit of the lecture on more advanced topics related to agents.
So some of the things that are very useful to do with coding agents include things like refactoring.
So as I mentioned,
we used Claude Code to actually refactor our lecture notes.
but you can also use these tools to refactor code.
These agents are really good at code review.
So if someone sends you a GitHub pull request,
or even if you just want to use it for yourself,
you can just ask the agent,
review this code.
Just that level of guidance is already pretty good to get useful feedback.
You can also give it more specific guidance to get a more tailored response.
So one thing I've used these tools for a lot,
and actually used them to catch some very subtle bugs,
is in situations where I've done performance optimization,
or other kind of refactoring where I wanted the code to be semantically equivalent before and after the change.
But yeah,
I was making like stylistic changes or performance improvements or things like that.
And the coding agent's actually pretty decent at reasoning about code and reasoning about deltas between code.
And it was able to point out like,
oh,
you made this change.
And like,
oh,
in this particular case,
the behavior is actually different.
And then I could go and fix that bug.
So really useful for code review.
These agents are great for codebase understanding too.
So I know like...
I know at least a decent chunk of the audience here is just getting into computer science.
You're probably working on smaller repositories right now.
But if you want to contribute to an open source project on GitHub or dive into a larger code base,
like say you're doing a UROP and you're working on your lab's code base,
these agents are really good at navigating code bases and understanding them and explaining them to you.
So you can even go into a fresh code base and just be like,
explain this code base to me.
Or if you're looking for particular things,
maybe you start a UROP and your UROP mentor says,
oh,
go work on this feature.
even to know what files to modify can take a lot of thought and understanding,
right?
But these coding agents are pretty good at helping you with that.
Another quick one I'll demo,
I'm tying this back to some of our earlier lectures.
So because these coding agents can call tools,
you can use them kind of sort of like a shell.
And so I actually use this these days because memorizing shell commands and all their flags and stuff like that can be challenging.
And instead,
you can just explain in natural language or coding agent.
how what you want it to do so like suppose I want to use a command to find all the Python files in this directory that have uh renaming imports I can say like use ag so this is a command line tool to find all Python files
that do renaming imports so this is like from something import something as something or just import something as something in Python it's just a particular pattern I'm looking for but like typing this out myself is way harder
like remembering that like ag has this --python flag or like how exactly to format regexes or things like that and so you just talk to your coding agent and have it behave like your shell.
And you can give it follow-ups like ignore the lib directory.
So this is searching for both code I wrote and code in this library directory.
So maybe I just want to search the code I wrote.
So you can give it a follow-up like that.
It'll generate the right shell command,
run it for you,
and even summarize the results for you.
So I think it's a pretty great use case.
Yeah,
question?
Yeah,
so the question is,
will you get in trouble for using these tools on school stuff?
please ask your instructor and see if it's okay to use these tools.
I think it just varies by class.
I've seen some classes that prohibit use of any AI coding tools.
So like no AI autocomplete,
no inline chat.
So not even the simpler features we talked about in that previous lecture.
And then obviously no coding agents.
And then I've seen other classes that are like,
yeah,
use whatever tools you want to use.
Yeah.
So please follow the rules.
Don't cheat on your your homework.
I also think some of these
companies,
I think like Anthropic and OpenAI and others,
have released special features or modes of their software for schoolwork.
So you can use them in a mode where they won't give you an answer,
but will act a little bit more like TAs.
Or if you just want to prioritize your own understanding,
you can ask the tool for a hint.
Even if it doesn't have a special mode for this,
you can be like,
there's a bug in the code,
don't tell me what the bug is,
but point me in the right direction.
And they kind of sort of work okay for that.
So yeah,
you can use them as a replacement TA.
Cool.
And then finally,
I think we're not going to talk about this in depth,
but you can use coding agents for what's called vibe coding.
So these things are pretty powerful tools and you can actually implement entire projects like start to finish without writing a single character of code yourself just by like chatting with your language model in English.
I think that make the site look retro is a small example of that.
Okay,
so any questions about those use cases of coding agents?
vibe coding.
Cool.
So now let's talk a little bit about more advanced functionality of these agents.
And I'm also going to tie back some of this to what we talked about earlier with how these things work under the hood.
So maybe I'll write these down on the blackboard.
A couple of features that most of these pieces of software have.
Starting from the simplest of the advanced features.
So one thing you might find yourself doing often is typing out the same command to these agents.
Like say you're working on a particular project and you have a particular way you want the agent to do code review for pull requests people send to your project.
Because like,
oh here are project guidelines and oh your review should focus on code quality and it should also focus on correctness,
but don't worry about security because security is less relevant in this project.
You might...
find yourself frequently giving this prompt as an input to your language model or to your coding agent.
And so usually these things have some functionality where you can just save a whole prompt,
just like a bunch of text,
and invoke it more easily later so you don't have to have a text file somewhere where you copy-paste from it into the coding agent.
Another feature that I think is really useful is parallel agents.
In some coding agent harnesses,
this is actually a built-in feature.
In other cases,
this is just a workflow that you can follow.
But as we've seen,
even in the examples we've gone through today,
even fairly simple things,
these models can take a couple of minutes to think and work.
If you give them much more advanced features to work on,
I've seen situations where the model goes off and works on a code base for 20 minutes,
30 minutes.
You don't want to just sit there and stare at it while it's doing that.
What you can do is actually just boot up multiple copies of agents.
Like you might have.
a bug you want to fix,
and also a feature you want to write,
and also another feature you want to write.
And you can do all of these in parallel.
So even in this lecture,
I actually had different agents running.
In this case,
it was on different repositories.
I had one Claude working on making the course website retro,
while I had another Claude working on fixing a bug in my code base.
But one particular tool that's really useful when you want to have multiple agents running on the same code base is something called git worktrees.
So if you just boot up multiple Claudes,
for example,
on the same directory,
and they're editing files,
they're going to conflict with each other,
right?
So what's really handy is you have completely isolated copies of your code base.
And if you're working in a Git repo,
Git Worktree is a really useful tool for doing that.
So
Git Worktree lets you create separate checkouts.
So I'm just gonna like
Git Worktree.
I'm not gonna explain this whole command in detail to you can do Git help Worktree to see the details.
What this command does is it creates this new directory for me and also a new branch at the same place where I currently am here.
And so now I can boot up one Claude in here and go here.
And here's an entire other copy of my repository.
And I can boot up another Claude there and I can give them different tasks to do.
I can commit these things to their separate branches and I can merge them all together later when I'm done.
So parallel agents and git worktrees go really well together.
There's this other thing I think someone earlier was asking about,
like is there standardized protocol to connect together agent harnesses and
LLMs? Kind of related to that,
there's a standardized protocol called Model Context Protocol,
which is for connecting agent harnesses with tools.
So there are various open source things and also some like hosted things,
where you can,
for example,
connect your coding agent to Notion.
So then you can just talk to Claude and be like,
oh,
here's a URL for a Notion doc.
Like,
fill it in,
like,
read the stuff in there,
like,
improve the implementation plan I've written in there,
and then,
like,
implement the feature in my code base.
So you can read and write to Notion,
for example,
with the Notion MCP connector.
So this is just a way to connect your coding agent harness to other tools.
And then there are a bunch of features.
in coding agents that are related to context management.
So recall that we mentioned that the underlying AI models have a limited context window.
Generally,
the models have some fixed window.
It might be like,
oh,
this model only supports inputs up to 100,000 tokens or something like that.
And then in practice,
if you give a ton of input to a model,
even if it's technically within the context window,
it's just a harder task for the model to deal with all of that input.
So you get these things like having a polluted or like...
a polluted context.
And so if you can effectively manage what you're giving as input to the underlying AI model,
it'll generally perform better.
And so some things that these agent harnesses support is basics like clearing the context window.
Normally when we chat,
we're just appending more and more messages to our message history.
And with coding agents,
we also have all our tool calls and the resulting outputs from those tool calls as getting appended to our message history,
or also known as context.
And so if we're working on one task in our coding agent,
and then we want to do something else that's unrelated to what we were doing before,
you can actually kill the agent and start it again.
Or they generally have a command just clear the context window.
So you're starting fresh.
Another handy thing that these things can generally do is rewind the conversation.
So say you were chatting with the agent,
and then you asked it to do something,
and you changed your mind.
One way you could handle that is by interrupting the agent and just giving it a follow-up instruction.
But then all the stuff it's done so far since your last message is in the context window now,
and it's confusing and not very useful to have it there.
And so instead,
these agent harnesses generally have a command you can use to basically pop messages off the end of the message history and just go back in time.
So it's like,
pretend the stuff never happened,
delete it from the context.
And again,
that'll help you keep a smaller context window to keep your LLM more focused.
Any questions about these?
Another feature related to context management that these things support is compaction.
So how do you do things like support unlimited length conversations if your underlying AI model has a fixed context window?
Generally,
the way that works both in conversational chat tools like ChatGPT and in coding agent harnesses like Claude Code is that once your conversation history grows really long,
the agent will either automatically or on demand
compress the stuff in the prefix of the history,
and that'll shrink the context window.
And so I could even,
if some of these sessions open,
in Claude Code,
for example,
I can call the slash compact command.
And that actually just uses an LLM to take my message history and summarize it into a smaller message history.
And that replaces the prefix of my context with the summary.
And that lets me keep conversing with my agent.
Generally,
these tools will do this automatically,
but if you found that you've been talking with the agent for a while and the context is getting too long for it to perform effectively,
you can call this manually.
And so we can see here,
for example,
this will actually show us what this compacted context is.
And we're not going to look at this in detail right now,
but I recommend you try running a coding agent,
have a little bit of back and forth,
have it call some tools,
and then compact the history and just look at what the LLM summary looks like.
The next thing kind of related to context management is something called LLMs.txt.
So the underlying AI models used in coding agents are fixed or frozen in time,
and they get updated from time to time.
But at any given moment,
the model is frozen and it's trained on some data that existed at the time the model was trained,
but it's not necessarily up to date on everything that's happened since.
So generally,
language models have something called a knowledge cutoff.
And then if you ask your coding agent,
for example,
to implement a feature using a library that came out yesterday,
the model will know nothing about that library.
And so how do you handle that?
And so the way you handle that is that at inference time,
you give to the model in the model context information about the library.
And so there's a...
These language models can generally fetch code from the internet.
And so
I don't have a library in mind at the moment,
but I can be like,
fetch missing.csail.mit.edu and give me a summary of the class schedule.
So you could be like,
here's a URL for a library I want to use,
read the library documentation,
and then write some code that does xyz.
And it'll fetch the website.
among the set of tools that this coding agent has as a web fetch tool,
and it will get that into its context window,
and now it can do things based on that information.
And so where llms.txt comes in is that llms.txt is a proposed standard for formatting information for LLMs.
Normally when these coding agents fetch things from a website,
and this can be set up in a number of ways,
but if you were to say fetch the raw HTML and give all that to the agent and to the underlying LLM,
HTML is pretty verbose and there's a bunch of information there that's not that useful to the model.
In this case,
all the styling information or our analytics or things like that are not things that are relevant to what this model is trying to do.
And so LLMs.txt is a standard to have plain text files that are meant to be consumed by LLMs at inference time.
And a lot of libraries,
especially the more AI-related ones or the more forward-thinking ones,
will publish an LLMs.txt.
And so we can look at an example here.
Like here's the pydantic ai llms.txt,
and we see that this is way more usable than if the model were to fetch the contents of this page in HTML.
And in particular,
it's way more compact,
so you're using less of your context,
and the model's able to perform better.
There's another kind of standard-ish thing called agents.md.
And this is a file that you put in your Git repository or in your project where the setup is that whenever you boot up the coding agent,
it will read the entire contents of this file.
For Claude,
this is a claude.md file.
If you want to see an example,
we actually have one in the lecture notes or in the repository for this class.
Here's our agent.md file.
And so if you find yourself needing to give your coding agent instructions on how to do basic things in your repository,
like when you boot these things up without anything else in their context,
if the context starts out entirely empty,
it knows nothing about your repository,
right?
So if you have certain practices you follow,
or it's like,
oh,
run this command to run the type checker,
run this command to run the unit test,
and so on.
Instead of having to supply that information to the coding agent every time you boot it up,
This is,
you can.
This is kind of related to reusable prompts too,
but this is like every time you boot up your coding agent,
just dump this into the prefix of the context.
So these things are really useful for repositories you're working on for a long time with coding agents.
Another concept that these agent harnesses support related to context management is something called skills.
So things like agent.md came first and skills was almost a follow up to this.
So one thing people found was this really helpful to dump a whole bunch of information in here so that whenever you boot up your coding agent,
it knows everything it needs to about your project.
But there's also a downside here.
If you have a really big Agents.md,
you're filling up a large chunk of your context window for your underlying LLM before you're even getting started talking to it.
And so people found that in these Agent.md files,
there was information about a whole bunch of different topics,
but at any given time,
a coding agent might not need all that information in its context.
And so there's this neat trick to add one level of indirection.
So instead of supplying all the information upfront in Agents.md,
you can say like,
Here's an overview of the different things you can look at.
Like see this document for our development practices and like code quality standards.
See this document for like how to run the tests.
See this document for how you should write documentation and so on.
So you have that small amount of information supplied to the agent up front.
And then in basically a separate file that the agent can open up and look at and load into its context window on demand,
roughly as a tool call,
you have all the follow-up information on each of the topics.
And I think the final topic I want to talk about in terms of context management in coding agents is the concept of sub-agents.
And so it's like,
if you have one agent,
why don't you have more than one agent?
And why might you want something like that?
Well,
it's in part related to context management.
If you have a coding agent that's trying to do some task and it can identify a sub-task to do,
instead of doing that all kind of in line in the same coding agent,
if it can spawn up a different agent.
and give it as a prompt just like the subtask you want it to do,
then it can go do its thing,
finish,
and then return control back to the parent agent.
And then the parent agent's context is not polluted with all the details of what the subagent did.
That might sound a little bit abstract,
but these things are...
You can write your own subagents for these coding agents,
and they're also used in implementing components of these agents sometimes.
So,
for example,
some coding agents implement the WebFetch tool.
actually as a sub-agent.
So when the parent agent wants to fetch contents of a web page,
and as we mentioned earlier,
loading the entire HTML contents of a web page into the context window of a language model might not be the best idea because there's a lot of stuff there.
But instead,
if you can spin up another agent,
tell it,
fetch this website,
and summarize this aspect of it for me,
then it'll filter out just the relevant information.
And then that relevant information will be put into the context of the parent agent.
And that way you keep your context window smaller.
This also enables some nice things like these agents generally have support for parallel tool calls and parallel subagents.
So maybe there's several things you want to do in parallel.
Like maybe you've written a subagent that has a really great prompt for doing code review.
And maybe you've written another subagent that has a really great prompt for fixing issues related to type checking.
And maybe you work on a feature and then you spin off both of these subagents in parallel.
This is something that Claude Code,
for example,
can do.
And then they'll both do their thing at the same time.
And then when they're both done,
the parent agent can continue.
And so this can also speed you up.
So yeah,
I just talked through these things instead of giving demos of each of them.
I think in the lecture notes we have a couple more concrete examples of these things,
but at a high level we wanted to familiarize you with the concepts,
and then you can either go through this on your own or follow our exercises,
which will walk you through a bunch of these,
to really learn how to use these in practice.
So any questions about these more advanced features of coding agents?
Yeah,
so the question is when a language model starts in compaction,
is the general advice to let it do compaction or open up a new session?
I think this is one of the many things that's like,
it's a little bit more of an art than a science.
I think if you're continuing along the same thread,
like the LLM summarization that produces the compacted context is pretty decent.
So if you're still working on the same thing,
like just keep going.
If you're doing something unrelated,
like clear the context instead of just keeping a bunch of useless context around,
even if it's a summary.
Cool.
And then just as a final note before we wrap up,
just wanted to say these tools are really powerful,
but AI is not magic and AI tools can make mistakes.
They're,
I think,
hopefully to some degree demystified LLMs a little bit.
They're just these probabilistic models that,
given a bunch of input tokens,
give you the conditional probability on the things that come next.
That's all they are.
And there's a bunch of clever techniques that go into training a good pi theta there.
But yeah,
LLMs are not intelligent in the same way that humans are.
And so,
yeah,
make sure you review any output from your AI in terms of looking for correctness and security bugs.
Like,
at least in my personal usage,
I've had many situations where the AI generates some code that looks reasonable at first glance.
And it's just subtly wrong.
And it takes a lot of time to find the bug.
And sometimes verifying code can actually be harder than just writing the correct code yourself.
So for,
like,
really critical things,
oftentimes I will just do the thing myself instead of even trying to call an AI tool to do the task.
There are also many other things that can go wrong,
as I'm sure you'll experience if you start using these tools.
Like the AI can just like go off the rails,
go down rabbit holes.
It can like try to gaslight you.
Sometimes it'll like be wrong.
But if you try to tell it it's wrong,
it'll just like keep insisting that it's right.
And you can get really confused.
It can get stuck in debugging spirals.
So it'll be trying to fix code,
run the test.
It'll fix the code,
run the test,
and it's like fail every time.
It'll make your code worse and worse.
So you kind of do have to keep an eye on these things.
And so,
yeah,
a lot of potential downsides and things to be aware of.
And at a high level,
I think it's still valuable to have computer science and programming skills yourself.
We're far from the point where computer scientists are obsolete.
But at the same time,
these are really powerful tools and worth learning.
So that is all I have for you today on agentic coding.
And I highly recommend you go through some of the exercises on this topic to learn how to use these powerful tools in practice.
See you all tomorrow.
