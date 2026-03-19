# Dual-Audience Courses

## The Shift

An Andamio course has always been defined by its SLTs. A set of Student Learning Targets, organized into modules with prerequisite chains, assessed through evidence submission and teacher review, recorded on-chain as credentials. The audience was the human learner.

That audience hasn't changed. But there is now a second one.

The same SLTs that define what a human learner must demonstrate also define what an agent must be capable of. The agent needs to coach the learner through the SLT, produce working examples, explain concepts at the right depth, and assess whether the learner's submission meets the target. Every one of those requirements is itself a capability claim — assessable, refinable, and conditional on context.

A course on Andamio now has two audiences:

1. **The human learner**, who needs to acquire skills and demonstrate mastery of each SLT to earn a credential and become a contributor to real projects.
2. **The agent**, who needs sufficient context and capability to support the learner through each SLT — while also being capable of the outcomes the SLTs define.

The SLT is the shared contract between them.

## What This Means for the Agent

For a human learner, the SLT says: "Here is what you need to demonstrate." The learner studies, practices, and submits evidence. The teacher (or agent) assesses the submission.

For the agent, the same SLT implies four obligations:

**1. Conceptual explanation.** The agent must be able to explain the topic the SLT covers — accurately, at the right depth, in language that serves the learner. If the SLT is "I can build a command-line tool with multiple commands using the Cobra library," the agent must be able to explain what Cobra is, how command routing works, and why the pattern matters.

**2. Code demonstration.** If the SLT involves producing something (code, configuration, analysis), the agent must be able to produce a working example. Not a description of what the example would look like — the actual artifact. The learner needs to see what correct output looks like before they can produce their own.

**3. Learner assessment.** The agent must be able to evaluate whether the learner's submission meets the SLT. This is the Fist to Five level 5 threshold: "I can produce this, explain it, catch errors in it, and evaluate someone else's attempt." If the agent cannot assess submissions, a human teacher must handle every review, which constrains how the course scales.

**4. Knowledge currency.** The agent's knowledge must be current enough that its explanations, examples, and assessments reflect the actual state of the tools and libraries the SLT references. An agent coaching with outdated API patterns teaches the learner things that won't work.

These four obligations are exactly the four dimensions of the readiness assessment. The `self-assess-readiness` skill was designed to evaluate them. What changes is the framing: the readiness assessment is not a one-time experiment. It is a course quality check. Running it against a course's SLT set answers: can the agent serve this course?

## What This Means for Course Design

### A Course Is Not Ready Until Both Audiences Are Served

Traditionally, a course is ready when the content is written, the SLTs are clear, and the learning pathway makes sense for the human learner. That remains necessary. But it is no longer sufficient.

A course is ready when:
- The SLTs are well-crafted (assessed by `assess-slts`)
- The agent can support every SLT at the required level (assessed by `self-assess-readiness`)
- Where the agent cannot, the gap is documented and either filled with context or assigned to human instruction

The readiness assessment becomes a gating check for course launch. A course with 30 SLTs where the agent rates Needs Human on 15 of them is a course that requires a human teacher for half its content. That's not necessarily wrong — but it should be a known, deliberate choice, not a surprise discovered when learners start submitting work.

### The Context Shopping List Is a Course Development Checklist

The readiness assessment produces a Context Shopping List: the specific resources needed to move SLTs from Needs Context to Ready, prioritized by how many SLTs each resource unlocks. In the dual-audience model, this list is not just an agent optimization. It is a course development artifact.

If the Go PBL course needs the Apollo API reference to move 12 SLTs from Needs Context to Ready, that reference is as much a course deliverable as the lesson content itself. The lesson is for the learner. The reference is for the agent. Both are necessary for the course to function.

Course development, then, has two parallel workstreams:

| Workstream | Audience | Deliverables |
|-----------|----------|-------------|
| Content development | Human learner | Lessons, exercises, project briefs, assessment rubrics |
| Context development | Agent | API references, code examples, constraint documents, skill files |

Both workstreams serve the same SLTs. Both are required for the course to work.

### Prerequisite Chains Apply to Both Audiences

Andamio courses organize SLTs into modules with prerequisite chains: Module 3 requires Module 2, which requires Module 1. For human learners, this sequencing reflects how knowledge builds — you need to understand Go fundamentals before you build a CLI, and you need to build a CLI before you interact with a blockchain node.

For the agent, prerequisite chains have a different implication: the context needed for later modules may depend on context developed for earlier ones. If the agent's skill file accumulates context through the refinement loop — starting with Go fundamentals and building toward blockchain interactions — the context compounds along the same path the learner follows. The prerequisite chain is the context accumulation path.

This suggests that course development should follow the prerequisite chain for context development too. Start by building context for Module 1 SLTs, stabilize it, then build Module 2 context on that foundation. The agent's capability grows in the same sequence as the learner's.

## The Credential as Dual Attestation

An Andamio credential is defined by a set of SLTs. When a human earns the credential, it attests: this person has demonstrated mastery of every SLT in the set.

In the dual-audience model, the same credential carries a second attestation about the agent: for each SLT in this credential, the agent's readiness level is known. The credential becomes a delegation map:

| SLT | Human Mastery | Agent Readiness | Implication |
|-----|--------------|----------------|-------------|
| Build CLI with Cobra | Credential held | Ready (level 5) | Agent can coach, demonstrate, and assess independently |
| Build transaction with Apollo | Credential held | Ready with context (level 4) | Agent can coach with API reference loaded; spot-check sufficient |
| Deploy parameterized contract | Credential held | Needs Human (level 1) | Human instructor required for coaching and assessment |

An organization looking at this credential knows three things:
1. What the human can do (every SLT in the set)
2. What the agent can support (Ready and Needs Context SLTs)
3. Where human instruction is irreplaceable (Needs Human SLTs)

This is operationally valuable for scaling. A course where the agent is Ready on 90% of SLTs can serve many learners with minimal human instruction. A course where the agent is Needs Human on 50% of SLTs requires significant human teaching capacity. The credential's delegation map is a scaling forecast.

## The Agent as Learner, the Agent as Coach

There is a productive tension in the dual-audience model. The agent is both a learner and a coach.

As a learner: the agent goes through the refinement loop. It is assessed against each SLT. Where it falls short, context is provided. It re-attempts. Over time, its capability grows. This process mirrors what the human learner does — define the target, attempt the work, diagnose the gap, close the gap, try again.

As a coach: the agent uses its capability to support the human learner. It explains concepts, produces examples, provides feedback, and assesses submissions. Its effectiveness as a coach depends on its own mastery — you cannot coach what you do not know.

This tension is the same one that exists in education: the best teachers are also the best learners. They continue to develop their own mastery so they can serve their students. The agent's context refinement is its continuing education.

The dual-audience model makes this explicit. Building a course means developing both the learner's pathway (content) and the coach's capability (context). The SLT is the contract that both parties are measured against. When both can meet it — the learner through demonstrated mastery, the agent through reliable output — the course works.

## What This Means for Andamio

### The Product Is the Dual-Audience Course

Andamio's product has always been the learning pathway: SLTs, modules, prerequisite chains, on-chain credentials. The dual-audience model extends the product to include the agent capability that supports the pathway. A course on Andamio is not just content and structure. It is content, structure, and the verified agent context that enables coaching at scale.

This is a differentiator. Other learning platforms offer content. Some offer AI features. Andamio offers a course where every SLT has been assessed for both learner quality and agent readiness — where the delegation map is known, the gaps are documented, and the agent's capability is an explicit part of the product.

### Course Quality Has Two Dimensions

Course quality is no longer a single axis. It is two:

**Pedagogical quality** — Are the SLTs well-crafted? Do they use student-facing language, target the right cognitive level, build in a logical sequence? Is the content clear, relevant, and appropriately challenging? This is what `assess-slts` evaluates.

**Agent readiness** — Can the agent support each SLT? Where it can, at what confidence level? Where it can't, what's missing? This is what `self-assess-readiness` evaluates.

A course can score high on one dimension and low on the other. Beautifully written SLTs with no agent context produce a course that works in a traditional classroom but not at scale. Full agent readiness on poorly written SLTs produces an agent that can do the work but cannot teach a learner to do it. Both dimensions matter.

### The Compounding Applies to Courses

Every time a course goes through the refinement loop — SLTs assessed, agent readiness checked, context developed, capabilities stabilized — the course gets better on both dimensions. The compounding trajectory is a course-level metric: over time, the agent's readiness distribution improves, the content matures, and the delegation map expands.

A mature course on Andamio is one where the compounding has happened: most SLTs at level 4 or 5, context stabilized and maintained, human instruction focused on the irreducible SLTs where it adds the most value. That maturity is measurable, visible, and the result of deliberate investment in both audiences.
