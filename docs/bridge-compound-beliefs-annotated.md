# Compound Engineering Beliefs, Annotated

Every's compound engineering guide articulates a set of beliefs for building with AI agents. These beliefs are sound and practical. What follows is an annotation of each one through the lens of SLTs as human-agent interface — not to replace what Every proposes, but to show where the SLT framework makes these beliefs more precise, more assessable, and in some cases more honest about their limits.

The original text from Every is quoted. Annotations follow each section.

---

## Extract Your Taste Into the System

> Every codebase reflects the taste of the developers who built it, from naming conventions to error handling patterns and testing approaches. That taste usually isn't documented anywhere. It lives in senior engineers' heads and is transferred through code review. This neither scales nor lets others on the team learn.
>
> The solution is to extract and document these choices. Write these preferences down in CLAUDE.md or AGENTS.md so the agent reads it every session. Build specialized agents for reviewing, testing, and deploying, as well as skills that reflect your taste. Add slash commands that encode your preferred approaches. Point the agent at your existing style guides, architecture docs, and decision records, which all include examples of the way that you like to build.
>
> Once the AI understands how you like to write code, it'll produce code you actually approve instead of code you have to fix.

### Annotation

This is correct as far as it goes. But "extract your taste" is an instruction with no definition of done. How do you know when you've extracted enough? How do you know the extraction worked?

SLTs give taste a falsifiable form. Instead of "document your naming conventions," write the SLT: "I can name variables, functions, and modules following the project's established conventions." Instead of "point the agent at your style guides," assess whether the agent, given those guides, can reliably produce code that meets the SLT. If it can, the taste has been extracted. If it can't, the gap analysis tells you what's missing — not "more style docs" in the abstract, but which specific conventions the agent fails on and what context would close the gap.

The extraction is not a one-time documentation exercise. It is a refinement loop: state what good looks like (SLT), attempt the work, assess whether it meets the target, refine the context, reassess. Taste is extracted when the skill reliably hits the SLTs that define it. Before that point, you have documentation. After that point, you have a capability.

The Fist to Five signal makes this measurable in real time. A skill that rates itself a 2 on "I can write error handling following the project's retry-with-backoff pattern" is telling you: the taste has been documented but not extracted. The documentation exists as context, but the skill cannot reliably produce output that reflects it. That gap is actionable. A vague instruction to "extract your taste" is not.

---

## The 50/50 Rule

> Previously, I suggested an 80/20 rule for building features: 80 percent of time planning and review, 20 percent on working and compounding. When you look at your broader responsibilities as a developer, you should allocate 50 percent of engineering time to building features, and 50 percent to improving the system — in other words, any work that helps build institutional knowledge rather than shipping something specific.
>
> In traditional engineering, teams put 90 percent of their time into features and 10 percent into everything else. Work that isn't a feature feels like a distraction — something you do when you have spare time, which you never do. But that "everything else" is what makes future features easier: things like creating review agents, documenting patterns, and building test generators. When you treat that work as overhead instead of an investment, the codebase accumulates debt.
>
> An hour spent creating a review agent saves 10 hours of review over the next year. You can spend time building a test generator that saves weeks of manual test writing. System improvements make work progressively faster and easier, but feature work doesn't.

### Annotation

The 50/50 rule is a resource allocation argument. It says: invest half your time in the system. The SLT framework says something more specific: invest in closing the gaps that the readiness assessment identifies.

The Context Shopping List from a readiness assessment is a prioritized investment roadmap. It tells you which resources unlock the most SLTs, ranked by leverage. That ranking is the 50% allocation made concrete. You are not investing in "system improvements" in the abstract. You are investing in the specific context that moves the most SLTs from Needs Context to Ready.

This reframing matters because "improve the system" is unbounded. Teams can spend the 50% on polishing documentation nobody reads, building review agents for code patterns that rarely occur, or creating test generators for edge cases that don't matter. The SLT framework constrains the investment to what's demonstrably useful: context that closes assessed gaps in assessed capabilities.

The compounding trajectory makes the return on investment visible. Session 1: 6 Ready out of 44. After investing in the top items on the shopping list and stabilizing the context: Session N: 20 Ready. The 50% investment has a measurable yield. Without that measurement, the 50/50 rule is a conviction. With it, it's a strategy.

There is a deeper point here about what "system improvement" means for education. In Andamio's context, the system being improved is not just a codebase — it is a learning platform. The 50% invested in context refinement, readiness assessment, and skill development serves both the engineering team (who build the platform) and the learners (who use it). Every SLT that moves from Needs Context to Ready means a lesson that can be reliably coached, a capability that can be delegated, a gap that has been closed. The system improvement and the learner outcome are the same thing.

---

## Trust the Process, Build Safety Nets

> AI assistance doesn't scale if every line requires human review. You need to trust the AI.
>
> Trust doesn't mean blind faith. It means setting up guardrails such as tests, automatic review, and monitoring that flag issues so you don't have to watch every step.
>
> When you feel as if you can't trust the output, don't compensate by switching to manually reviewing the code. Add a system that makes that step trustworthy, such as creating a review agent that flags issues.

### Annotation

This is the most important belief to annotate, because the SLT framework both supports and complicates it.

Fist to Five is a safety net. It is the agent telling you, in real time, where it is trustworthy and where it is not. A level 4 or 5 says: trust this output, spot-check is sufficient. A level 2 says: do not trust this output without review. A level 0 says: I would be fabricating, stop here. The signal is the safety net. It routes human attention to where it's needed and away from where it isn't.

This is structurally better than the alternative Every describes — building review agents that flag issues after the fact. Fist to Five flags issues *before* the output is produced. The agent knows, before it writes a line, whether it has grounded knowledge or is guessing. Emitting that signal upfront prevents wasted work: the human doesn't review a 2-page lesson only to discover the agent hallucinated an API that doesn't exist. The agent says "1 — I can name what's needed but cannot produce it" and the human either provides context or writes that section themselves.

But the SLT framework also complicates the trust argument. Every says "trust doesn't mean blind faith" and proposes guardrails as the solution. The SLT framework says something stronger: agent mastery is conditional on context, and context drifts. A skill that was trustworthy last month may not be trustworthy today, because the library it depends on released a new version, or the API it references changed, or the examples it uses became outdated.

Safety nets that only check output (tests, review agents, monitoring) catch failures after they happen. The readiness assessment catches failures before they happen — or more precisely, it catches the *conditions* for failure: stale knowledge, missing references, partial understanding. Periodic reassessment is not paranoia. It is the maintenance discipline that keeps trust warranted.

The honest position: trust is not a binary you achieve and maintain. It is a distribution across SLTs. Some SLTs are fully delegatable (level 5, stable knowledge, no context drift risk). Others require permanent human oversight (level 3 with rapidly evolving tools). Others are permanently human-authored (Needs Human classification). The goal is not to make everything trustworthy. The goal is to know exactly where trust is warranted and where it is not, and to route work accordingly.

---

## Make Your Environment Agent-Native

> If a developer can see or do something, the agent should be allowed to see or do it too.
>
> Running tests. Checking production logs. Debugging with screenshots. Creating pull requests.
>
> Anything that you don't let the agent handle, you have to do yourself manually. The goal should be full environmental parity between human and AI developers.

### Annotation

The SLT framework reframes "agent-native" from an environment property to a capability map.

"Full environmental parity" is an infrastructure goal: give the agent access to the same tools humans use. That's necessary but not sufficient. Access does not imply capability. An agent with access to production logs can read them. Whether it can *diagnose issues from them* is a different question — one that an SLT and a readiness assessment can answer.

Credentials as delegation maps make this concrete. For any Andamio credential, you can produce a table:

| SLT | Agent Can Access? | Agent Can Do? | Context Required |
|-----|------------------|---------------|-----------------|
| Run and interpret test suites | Yes (Bash access) | Ready | None |
| Diagnose failing deploy from logs | Yes (log access) | Needs Context | Deploy architecture docs, common failure patterns |
| Review learner submission for correctness | Yes (file access) | Needs Human | Domain expertise the agent lacks |

The first column is the agent-native question Every asks: can the agent access this? The second column is the SLT question: can it actually do the work? The third column is what closes the gap.

Agent-native environments matter. But an agent with full access and no context is like a new hire with all the right permissions and none of the institutional knowledge. The SLT framework says: parity means matching not just access but assessed capability. Give the agent access *and* the context to use it effectively, verified through the readiness assessment.

---

## Parallelization Is Your Friend

> You used to be the bottleneck because human attention only allows one task at a time. The new bottleneck is compute — how many agents you can run at once.
>
> Run multiple agents and multiple features at the same time. Perform review, testing, and documentation all at once. When you are stuck on one task, start another, and let agents work while planning the next step.

### Annotation

SLTs are the natural decomposition unit for parallelization.

Every frames parallelization as running multiple tasks at once. The SLT framework makes this precise: each SLT is an independently addressable target. A readiness assessment that classifies 44 SLTs produces three parallel work streams immediately:

- **Ready SLTs (levels 4–5)**: dispatch agents to produce output now, in parallel, with no additional context.
- **Needs Context SLTs (levels 2–3)**: dispatch agents to attempt, but flag for human review. Run in parallel with Ready work.
- **Needs Human SLTs (levels 0–1)**: queue for human authorship. The human works on these while agents handle the other two streams.

This is not just "run more agents." It is targeted parallelization based on assessed capability. You do not waste compute on SLTs the agent cannot meet. You do not waste human attention on SLTs the agent handles reliably. The readiness assessment is the dispatcher.

Compound engineering's multi-agent orchestration patterns — parallel specialists, pipelines, self-organizing swarms — provide the infrastructure. The SLT classification provides the task decomposition. The two compose: classify with SLTs, dispatch with compound engineering's orchestration, compound the results.

---

## Plans Are the New Code

> The plan document is now the most important thing you produce. Instead of coding first and documenting later, as you might have traditionally, start with a plan. This becomes the source of truth your agents use to generate, test, and validate code.
>
> Having a plan helps capture decisions before they become bugs. Fixing ideas on paper is cheaper than fixing code later.

### Annotation

Plans are important. But the SLT framework suggests something more foundational: **SLTs are the new plans.**

A plan describes what to build and how. An SLT describes what capability the result should demonstrate. The plan is implementation-scoped — it expires when the feature ships. The SLT is capability-scoped — it persists as long as the capability matters. Plans tell agents what to do. SLTs tell agents (and humans) what success looks like.

In practice, the two compose. A plan organizes work into steps. SLTs organize outcomes into assessable targets. The plan says "build a transaction builder module." The SLT says "I can construct and submit a valid Cardano transaction using Apollo." The plan guides the agent's process. The SLT guides the human's assessment of the result.

The deeper shift is about what persists. Plans are consumed during execution and archived afterward. SLTs persist as the ongoing contract between the human and the agent. They are the basis for readiness assessment, Fist to Five signals, credential schemas, and delegation maps. They compound in a way that plans do not, because they describe reusable capabilities rather than one-time implementation steps.

"Plans are the new code" captures something true: planning matters more when agents execute. "SLTs are the new plans" extends it: assessable capability claims matter more than implementation plans, because they tell you not just what to build but whether the builder can build it, and whether the result actually works.

---

## Core Principles, Annotated

> Every unit of work makes subsequent work easier.

**SLT annotation:** This is the compounding thesis. The SLT framework makes it measurable. The readiness distribution across sessions is the metric: if the Ready count increases over time, work is compounding. If it doesn't, you are running in place. The distribution is the honest signal.

> Taste belongs in systems, not in review.

**SLT annotation:** Taste belongs in SLTs. An SLT is taste made falsifiable. "I can write error handling that follows the project's retry-with-backoff pattern" is a taste claim you can assess. If the skill meets it, the taste is in the system. If not, the gap analysis tells you what's missing. Review without SLTs is subjective. Review against SLTs is diagnostic.

> Teach the system, don't do the work yourself.

**SLT annotation:** Teaching the system is context refinement. The six-phase refinement loop is the teaching process: identify the gap, provide context, verify the result, stabilize the knowledge. The SLT framework adds: not all teaching succeeds. Some SLTs stay in Needs Human permanently. The system has a learning ceiling for each SLT, determined by the gap between what context can provide and what the task requires. Knowing where that ceiling is prevents wasted investment.

> Build safety nets, not review processes.

**SLT annotation:** Fist to Five is the safety net that makes review processes targeted rather than universal. The agent self-reports confidence. The human reviews only where confidence is low. This is not "no review." It is review routed by the agent's own honest assessment of its capability. The safety net is not after-the-fact detection. It is before-the-fact signal.

> Make environments agent-native.

**SLT annotation:** Agent-native means capability parity, not just access parity. The delegation map — SLTs classified as Ready, Needs Context, Needs Human — shows where true parity exists and where it does not. Access is infrastructure. Capability is assessed through the refinement loop. Both are needed.

> Apply compound thinking everywhere.

**SLT annotation:** The SLT framework is compound thinking applied to capability assessment. Every refinement cycle that moves an SLT from Needs Context to Ready, and every stabilization that captures that context for future sessions, is a compounding event. The readiness tracking over time is the compounding curve made visible.

> Embrace the discomfort of letting go.

**SLT annotation:** The SLT framework makes letting go less uncomfortable by making it specific. You are not letting go in the abstract. You are letting go of SLTs that the skill has demonstrated it can meet — level 4 and 5 targets with verified output and stable context. You are holding on to SLTs where the skill rates 0, 1, or 2. The discomfort dissolves when you have an assessed basis for the delegation decision rather than a general injunction to trust.

> Ship more value. Type less code.

**SLT annotation:** The SLT framework extends this beyond code. Ship more assessed capability. Type less unverified output. The value is not in the code or the lesson or the documentation. The value is in the SLT being met — the capability being demonstrated and verified. Code is one artifact that can meet an SLT. A lesson is another. A credential is another. The metric is SLTs met, not lines shipped.

---

## What This Annotation Reveals

Every's beliefs are practical and directionally correct. They describe what to do: extract taste, invest in the system, build safety nets, parallelize, plan first.

The SLT framework adds three things:

**1. A definition of done.** Every's beliefs are instructions without completion criteria. "Extract your taste" — when is it extracted? "Build safety nets" — when are they sufficient? "Trust the process" — when is trust warranted? SLTs provide the completion criteria: the taste is extracted when the skill reliably meets the SLTs that define it. The safety net is sufficient when Fist to Five accurately predicts output quality. Trust is warranted when the readiness assessment says Ready and the human assessment confirms it.

**2. An honest accounting of limits.** Every's beliefs are optimistic by design — they are motivating a shift in practice. The SLT framework is diagnostic by design — it reveals where things work and where they don't. Not every SLT will become Ready. Not every gap is closable with context. Not every delegation will succeed. The readiness assessment shows the ceiling as clearly as it shows the floor. That honesty is operationally valuable: it prevents over-delegation and under-investment.

**3. A bridge to education.** Every's beliefs describe engineering practice. The SLT framework connects engineering practice to learning theory. The same loop that makes agents more capable — assess, attempt, diagnose, refine, reassess — is the loop that makes students more capable. The mechanism differs (context vs. internalization) but the structure is identical. This matters for Andamio specifically, because the platform serves both audiences: engineers building the system and learners using it. The SLT framework unifies both under a single protocol.
