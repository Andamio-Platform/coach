# SLTs as the Interface for Human-Agent Collaboration

## The Core Idea

Student Learning Targets were designed to make learning expectations concrete, assessable, and transparent between teachers and students. The same properties that make SLTs effective in education — specificity, measurability, decomposability — make them effective as the shared contract between humans and agentic systems.

An SLT like "I can build a command-line tool with multiple commands using the Cobra library" is a falsifiable capability claim. It doesn't matter whether the claimant is a human learner or an AI agent. What matters is: can the work be produced, and can a qualified assessor verify that it meets the target?

This document proposes SLTs as the unit of delegation between humans and Claude — not as a metaphor, but as an operational protocol.

## From Education to Delegation

### How Formative Assessment Works in Education

In a well-run classroom, the SLT is not just stated at the beginning and tested at the end. It structures the entire feedback cycle. Education research calls this **formative assessment** — ongoing evaluation that happens *during* learning, not just after it.

The cycle works in three phases:

**Before the lesson.** The teacher communicates the SLT so the student knows what they're aiming for. Critically, the teacher and student also establish **success criteria** — the specific evidence that will demonstrate the target is met. Research on co-constructed success criteria (where students help define what "good" looks like) shows this increases ownership and clarity. The student isn't just told the destination; they help define what arrival looks like.

**During the lesson.** The SLT is referenced as an ongoing check. The teacher observes student work, asks probing questions, and provides feedback — not a grade, but diagnostic information. "You've got the structure right, but your error handling doesn't cover this edge case." The student adjusts in real time. This mid-course correction is what makes formative assessment powerful: the gap between current performance and the target is identified and addressed while the work is still in progress.

**After the lesson.** A formative assessment measures whether the target was hit. If it was, the student moves on. If it wasn't, the teacher has specific information about *where* the gap is — not just "the student failed" but "the student can do X and Y but not Z." That specificity feeds the next cycle.

Research shows that when students have clear learning targets and formative feedback, their rate of learning can roughly double (effect sizes of 0.31–0.47, Marzano, Pickering, and Pollock). The effect comes not from the target itself but from the tightness of the feedback loop around it.

The key structural elements:
1. A **specific target** that both parties agree on
2. **Success criteria** that define what meeting the target looks like
3. **Diagnostic feedback** during the work, not just a verdict after
4. **Identification of specific gaps**, not pass/fail
5. A **next cycle** that addresses those gaps directly

### The Same Structure, Different Mechanism

In human-agent collaboration, every one of these elements has a direct counterpart:

| Formative Assessment (Education)                                 | Context Refinement (Agentic)                                                                                                          |
| ---------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| Teacher communicates SLT                                         | Human defines SLT for the agent                                                                                                       |
| Teacher and student co-construct success criteria                | Human defines acceptance criteria; agent's readiness assessment surfaces what it can and cannot do, informing what "success" requires |
| Student attempts the work                                        | Agent attempts the work                                                                                                               |
| Teacher observes and gives diagnostic feedback mid-task          | Human reviews output and identifies specific failures                                                                                 |
| "You've got the structure right but the error handling is wrong" | "The transaction structure is correct but you used a non-existent Apollo function"                                                    |
| Student adjusts approach based on feedback                       | Context is refined — a document is added, a constraint is tightened, an example is provided                                           |
| Formative assessment checks whether the target is met            | Human reassesses the output against the SLT                                                                                           |
| Gap identified → next learning cycle                             | Gap identified → next context refinement cycle                                                                                        |

The parallel is structural, not metaphorical. Both systems use the same loop: define the target, attempt the work, diagnose the gap, close the gap, reassess. The difference is in *how the gap is closed*:

- A student closes the gap by building internal understanding — studying, practicing, asking questions, making mistakes, and integrating feedback into their mental model.
- An agent closes the gap by receiving better external context — documentation, examples, API references, constraints, and instructions that make the correct output reliably producible.

The feedback loop itself — the cycle of attempt, diagnose, adjust, reattempt — is identical. What lives inside the loop is different.

```
         ┌─────────────────────────────────────────┐
         │           SLT + Success Criteria         │
         └──────────────────┬──────────────────────┘
                            │
                            ▼
                   ┌─────────────────┐
                   │  Attempt Work   │
                   └────────┬────────┘
                            │
                            ▼
                ┌───────────────────────┐
                │   Human Assesses      │
                │   Against SLT         │
                └───────────┬───────────┘
                            │
                   ┌────────┴────────┐
                   │                 │
                   ▼                 ▼
              Met: Done       Not Met: Diagnose Gap
                                     │
                            ┌────────┴────────┐
                            │                 │
                            ▼                 ▼
                       Education:         Agentic:
                    Student studies,    Context refined —
                    practices, gets     docs added,
                    tutoring            constraints
                            │           tightened,
                            │           examples provided
                            │                 │
                            └────────┬────────┘
                                     │
                                     ▼
                              Reattempt Work
```

### Why This Parallel Matters

The formative assessment model is the most empirically validated approach to closing learning gaps. Its power comes from three properties:

1. **Specificity of diagnosis.** Not "you failed" but "here is what is wrong and why." In context refinement, this means: not "the output was bad" but "you used a non-existent function because you lack the Apollo API reference."

2. **Tight iteration cycles.** Formative assessment happens continuously, not just at the end. Context refinement works the same way — you don't wait until an entire lesson is written to check whether the agent knows the library. You check early, refine, and check again.

3. **Shared understanding of the target.** The SLT is visible to both parties. Both the teacher and student (or the human and agent) can point to the same concrete statement and ask: "Does this work meet this target?" There is no ambiguity about what success means.

The educational research confirms what this parallel predicts: clear targets with tight feedback loops produce faster convergence toward mastery. The mechanism is different — internalization vs. context augmentation — but the loop dynamics are the same.

## What Changes, What Stays the Same

| Property | Human Learner | Agentic System |
|----------|--------------|----------------|
| SLT format | "I can..." | "I can..." |
| What mastery means | Demonstrated capability through evidence | Reliable output given well-designed context |
| How mastery is reached | Study, practice, feedback | Context refinement, prompt engineering, tool access |
| How mastery is assessed | Teacher evaluates submitted work | Human evaluates produced output |
| What "not yet" means | Needs more learning time | Needs better context or human co-authorship |
| Mastery is persistent | Yes — the student retains capability | Conditionally — the context must be present |
| Assessment is reusable | Yes — same rubric, different students | Yes — same rubric, different sessions or agents |

The critical difference: human mastery is durable. Agent mastery is conditional on context. An agent that reliably builds Cobra CLIs today will do so in every future session — as long as the context that enables it is present. Strip the context, and the capability disappears. This is not a deficiency to hide. It is a design property to make explicit.

## The Refinement Loop

The practical workflow for achieving agent mastery of an SLT:

### 1. Readiness Assessment

Run a self-assessment against the SLT set. This produces a three-tier classification:

- **Ready**: The agent can attempt this SLT now with high confidence.
- **Needs Context**: The agent can attempt this with supplementary materials.
- **Needs Human**: The agent cannot reliably attempt this without expert co-authorship.

### 2. Attempt

For Ready and Needs Context SLTs (with context provided), the agent does the work. Not a description of the work. Not a plan for the work. The actual deliverable — code, a lesson, a configuration, an analysis.

### 3. Human Assessment

A human evaluates the output against the SLT, the same way a teacher evaluates a student submission. Did the agent actually do the thing the SLT claims? The assessment is binary at the SLT level: met or not met. Where it's not met, the human identifies what went wrong — wrong API, outdated pattern, missing edge case, structural error.

### 4. Context Refinement

The gap identified in assessment becomes a context improvement. This could be:

- A document added to the agent's reference set
- A constraint added to instructions ("always use Apollo v0.4+ patterns")
- An example that demonstrates the correct pattern
- A guardrail that prevents a known failure mode

### 5. Reassessment

The agent attempts the SLT again with the refined context. The human assesses again. This loop repeats until the agent reliably produces work that meets the SLT.

### 6. Context Stabilization

When an SLT is reliably met across multiple attempts, the context that enables it is captured as a stable artifact — a skill file, a reference document, a set of examples. This is the agent equivalent of a student who has internalized a capability. The capability lives in the context, not in the model.

## SLTs as Credential Schema for Agents

Andamio credentials are defined by sets of SLTs. If we can assess agents against the same SLTs, then every credential carries a dual interpretation:

- **For humans**: "A person who holds this credential can do these things."
- **For agents**: "An agent operating with the right context can do these things, and here is the evidence that it can."

This creates a capability manifest for any credential:

| SLT | Human Status | Agent Status | Context Required |
|-----|-------------|-------------|-----------------|
| Build CLI with Cobra | Credential held | Ready | None — stable knowledge |
| Build transaction with Apollo | Credential held | Ready (with context) | Apollo API reference, examples |
| Deploy parameterized contract | Credential held | Needs Human | Expert co-authorship |

The manifest answers a practical question: for this credential, what can be delegated to an agent, what needs human oversight, and what needs human authorship?

## What This Means for Andamio

### Credentials Become Delegation Maps

Every Andamio credential, defined by its SLTs, implicitly describes a delegation surface. Organizations using Andamio can look at a credential and know: if we invest in context for these SLTs, we can automate this portion of the work. The SLTs that remain human-only define the irreducible human contribution.

### The Context Is the Curriculum (for Agents)

In education, curriculum is the material that helps a student reach mastery. For agents, context plays the same role. A well-designed context package — reference docs, examples, constraints, skill files — is the "curriculum" that enables an agent to meet a set of SLTs. Andamio already has infrastructure for organizing learning materials around SLTs. The same infrastructure could organize agent context.

### Assessment Closes the Loop for Both

The on-chain assessment model (student submits evidence, teacher evaluates, credit is recorded) works for agent output too. The agent produces work. A human assesses it against the SLT. The result is recorded. Over time, this builds a verifiable track record of which SLTs an agent can reliably meet — and under what context conditions.

### The Shopping List Becomes a Roadmap

The Context Shopping List from a readiness assessment is operationally identical to a curriculum development roadmap. It tells you: here are the resources needed, here is how many SLTs each one unlocks, here is the priority order. The difference is that instead of building lessons for students, you are building context packages for agents. Both serve the same function — closing the gap between current capability and the SLT target.

## The Limits

### Agent mastery is not human mastery

A human who holds an Andamio credential has internalized the capability. They can adapt, improvise, and apply knowledge in contexts they haven't seen before. An agent that meets the same SLTs through context is performing pattern matching against well-structured reference material. The outputs may be equivalent. The underlying capability is not.

This is important to state clearly because conflating the two would undermine the value of both. Human credentials attest to durable, transferable expertise. Agent readiness attests to reliable output under known conditions.

### Self-assessment has a ceiling

The readiness assessment skill asks Claude to honestly evaluate its own capabilities. The honesty calibration tests help, and the niche library default forces conservatism in low-data domains. But self-assessment cannot catch unknown unknowns. An agent might rate itself Partial on something it's actually Weak on, because it doesn't know what it doesn't know.

Human assessment is the corrective. The refinement loop depends on humans catching failures that the agent cannot self-diagnose. This is not a temporary limitation to be engineered away — it is a structural feature of the system. Humans remain the ground truth holders.

### Context drift

Libraries change. APIs evolve. What made an agent Ready for an SLT six months ago may not hold today. Agent mastery requires maintenance — periodic reassessment and context updates. This is analogous to continuing education for humans, but the failure mode is different: a human with stale knowledge knows they're rusty. An agent with stale context will confidently produce outdated output.

Versioning context packages and tying them to specific SLT assessments mitigates this. If the context was validated against the SLT on a known date, you have a freshness indicator.

## Summary

SLTs work as the interface for human-agent collaboration because they are:

1. **Specific** — they make capability claims falsifiable
2. **Assessable** — humans can evaluate agent output against them
3. **Decomposable** — a complex capability breaks into individually addressable targets
4. **Already the unit of Andamio credentials** — no new schema is needed

The operational model is: assess readiness, attempt the work, evaluate the output, refine the context, repeat until reliable. The SLT is the contract. The context is the curriculum. The human is the assessor. The credential becomes a delegation map that describes what humans do, what agents do, and where the boundary sits.
