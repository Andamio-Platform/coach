# Fist to Five for Agents

## The Classroom Version

In competency-based classrooms, **Fist to Five** (also called Marzano's Self-Assessment Protocol) is a quick self-assessment technique. Students hold up 0–5 fingers to signal their confidence against a learning target:

| Level | Student Signal |
|-------|---------------|
| 0 (fist) | I don't understand at all |
| 1 | I recognize this topic |
| 2 | I understand some but need help |
| 3 | I understand but I'm not fully confident |
| 4 | I understand well |
| 5 | I could teach this to someone |

The technique has three properties that make it effective:

1. **It's fast.** Takes seconds, not minutes. It can happen at any point in a lesson without breaking the flow of work.
2. **It happens mid-task.** Not a pre-assessment or post-test — a real-time signal during the learning process. The teacher uses it to decide what to do next: reteach, move on, pair students up, or provide targeted support.
3. **It makes the invisible visible.** Without Fist to Five, the teacher has to guess who is struggling. With it, the distribution of confidence across the room is immediately apparent.

The highest level — "I could teach this to someone" — is the critical design choice. It's not enough to understand. Mastery means you can transfer, explain, and evaluate. That level corresponds to the upper reaches of Bloom's Taxonomy: not just applying knowledge but analyzing, evaluating, and creating with it.

## The Student Is the Unit

In the classroom, the question "Can this SLT be met?" is meaningless without specifying *who*. A student is not a generic person — they are a specific individual with specific prior knowledge, specific study habits, and a specific history of formative feedback. The same SLT gets a 5 from one student and a 2 from another. The target is constant. The capability varies by student.

This is obvious in education. It becomes important when we ask what the agent equivalent is.

## The Skill Is the Student

"Claude" is not the right unit to assess, for the same reason "a person" is not the right unit to assess in a classroom. Claude without context is general intelligence without domain preparation — capable in the abstract, unreliable on specifics. What makes an agent capable against a particular SLT is not the base model. It's the model plus its context: the skill file, reference documents, examples, constraints, and instructions that shape its behavior for a specific domain.

In Andamio's tooling, that context is packaged as a **Claude Skill** — a structured set of instructions, assessment criteria, and reference materials that configures the agent for a specific kind of work.

The parallel:

| Education | Agentic |
|-----------|---------|
| The student | The skill (Claude + specific context) |
| Prior knowledge the student has internalized | Reference docs, examples, API specs loaded into the skill |
| Study and practice that built the student's capability | Context refinement that shaped the skill |
| The student's confidence on an SLT | The skill's confidence on an SLT |
| "I can build a CLI with Cobra" | "With skill X, I can build a CLI with Cobra" |

This reframing has a concrete consequence: **the same SLT can get different Fist to Five ratings depending on which skill is active.** A lesson-writing skill with Apollo documentation loaded might rate a 4 on "I can build a simple transaction with Apollo." The same agent without that skill rates a 1. The SLT is the constant. The skill is the variable. Just like in the classroom, where the target is the constant and the student is the variable.

## Agent Fist to Five

With the skill as the unit, the agent Fist to Five scale becomes:

| Level | Agent Signal (with skill X) | What this means operationally |
|-------|----------------------------|-------------------------------|
| 0 | I would be fabricating — I have no grounded knowledge here | **Stop.** Do not attempt. Flag for human. |
| 1 | I can name what's needed but cannot produce it | **Pause.** Request specific context before proceeding. |
| 2 | I can produce something but significant parts are uncertain | **Proceed with caution.** Mark uncertain sections explicitly. Human review required. |
| 3 | I can produce this but wouldn't reliably catch my own errors | **Proceed.** Output is likely usable but needs human verification. |
| 4 | I can produce this and explain why it's correct | **Proceed with confidence.** Spot-check is sufficient. |
| 5 | I can produce this, explain it, catch errors in it, and evaluate someone else's attempt | **Full delegation.** The skill can handle this SLT end-to-end, including assessment of others' work. |

Level 5 — "I could teach this to someone" — maps directly to the educational version. For the agent, it means all four readiness dimensions are strong: conceptual explanation, code demonstration, learner assessment, and knowledge currency. The agent can not only do the work but evaluate whether someone else's work meets the SLT. That's the threshold for full delegation.

### Mapping to Readiness Assessment Dimensions

The Fist to Five level compresses the four-dimension readiness assessment into a single scalar. The mapping:

| Level | Conceptual Explanation | Code Demonstration | Learner Assessment | Knowledge Currency |
|-------|----------------------|-------------------|-------------------|-------------------|
| 0 | Weak | Weak | Weak | Likely Stale or unknown |
| 1 | Partial | Weak or N/A | Weak | Uncertain |
| 2 | Partial | Partial | Weak or Partial | Uncertain |
| 3 | Strong | Strong or Partial | Partial | Uncertain or Current |
| 4 | Strong | Strong | Partial or Strong | Current |
| 5 | Strong | Strong | Strong | Current |

This mapping isn't rigid — a level 3 could have different dimension profiles than what's shown. The point is that the Fist to Five level is a quick summary signal, while the four dimensions are the detailed diagnostic underneath it. Fist to Five is what you check mid-task. The full dimensional breakdown is what you consult when you need to understand *why* the level is what it is.

## How It Works in Practice

### In the Classroom

The teacher says: "Show me your Fist to Five on today's target." Students hold up fingers at chest level (reducing social pressure). The teacher scans the room:

- Mostly 4s and 5s → Move on to the next target.
- A cluster of 2s and 3s → Reteach or provide additional practice.
- A few 0s and 1s → Pull those students for small-group support.

The signal is fast, visible, and actionable. The teacher makes a real-time decision based on the distribution.

### For Agents

The agent is working through a set of SLTs — writing lessons, building code, producing deliverables. At each SLT, the skill emits a Fist to Five signal inline:

```
### Lesson 102.1: Creating a Wallet with Bursa
[Confidence: 1 — I can describe wallet concepts but cannot produce working Bursa code.
 I need: Bursa API reference showing wallet creation functions.]

### Lesson 099.3: Building a CLI with Cobra
[Confidence: 5 — I can produce this, explain it, and assess a learner's submission.]
```

The human scanning the output sees the same pattern the teacher sees in the classroom:

- **5s and 4s**: Accept the output, move on.
- **3s and 2s**: Review the output carefully. Provide additional context if the skill is missing something. Re-run after context refinement.
- **1s and 0s**: Don't use this output. Either provide the required context and re-run, or write this section yourself.

### The Actionable Difference

In the classroom, the teacher acts on the signal. In the agentic system, the signal can also be acted on programmatically:

- A **0 or 1** could automatically halt work on that SLT and surface the relevant entry from the Context Shopping List — "To proceed, provide: Bursa API reference showing wallet creation functions."
- A **2 or 3** could tag the output section for human review, without stopping the overall task.
- A **4 or 5** could mark the output as ready for final review with no special flags.

This is tighter than the classroom loop. The teacher has to visually scan the room and interpret the signals. The agentic system can route work based on confidence levels automatically. The human is still the assessor — they still decide whether the output actually meets the SLT — but the triage is handled by the signal.

## The Skill Development Cycle

In the classroom, a student who consistently rates themselves a 2 on a target gets additional instruction, practice, and feedback until they can rate themselves higher. Their confidence increases because their capability increases.

For skills, the same cycle exists, but the mechanism is context refinement instead of learning:

```
1. Skill emits Fist to Five on an SLT                    → Level 2
2. Human reviews and confirms the gap                     → "Yes, you're missing the API reference"
3. Context is added to the skill (docs, examples)         → Skill is updated
4. Skill re-attempts the SLT                              → Level 4
5. Human verifies the output meets the SLT                → Confirmed
6. Context is stabilized as part of the skill             → Persistent capability
```

Over time, a well-maintained skill accumulates context that raises its Fist to Five levels across the SLT set it's designed for. A mature skill is like a well-prepared student: mostly 4s and 5s, with the occasional 2 or 3 where the domain is still evolving.

A new skill with minimal context is like a student on day one: scattered 1s and 2s, a few 3s where the base model's general knowledge happens to cover the topic.

The trajectory is the same. The mechanism is different.

## What This Means for Andamio

### Credentials Define the Target Set

An Andamio credential is defined by a set of SLTs. Those SLTs are the same whether the claimant is a human or a skill. The credential doesn't change. What changes is the evidence: a human submits work demonstrating mastery. A skill emits Fist to Five levels plus output that a human can verify.

### Skills Are Assessable Entities

If the skill is the student, then skills can be assessed the same way students are. A readiness assessment is the comprehensive evaluation. Fist to Five is the formative check. Both use the SLT as the unit of assessment. Both produce actionable signal about where the gaps are.

This means you can ask questions like:
- "What is this skill's current Fist to Five distribution across credential X's SLTs?"
- "Which SLTs in this credential can be fully delegated to this skill?"
- "What context would move the most SLTs from 2 to 4?"

These are the same questions a teacher asks about a class, rephrased for skills.

### The Qualification Threshold Is Configurable

In the classroom, the teacher decides what confidence level is sufficient to move on. Some targets need a 5 (safety-critical skills). Others are fine at a 3 (the student will continue building proficiency over time).

For skills, the same configurability applies. An organization using Andamio could set thresholds per SLT or per credential:

- **SLTs involving fund-sensitive transactions**: Require level 5. Full delegation only when the skill can produce, explain, and catch errors.
- **SLTs involving conceptual explanation**: Level 4 may be sufficient. The skill can produce and explain; human spot-checks are enough.
- **SLTs involving rapidly evolving tools**: Level 3 with mandatory human review, regardless of the skill's self-reported confidence, because knowledge currency is inherently uncertain.

The threshold encodes the organization's risk tolerance for delegation — the same way a teacher's standards encode the school's expectations for mastery.

## Summary

Fist to Five works for agents because the structural properties are the same:

1. **The signal is fast.** A single number and a short rationale, emitted inline during work.
2. **The signal happens mid-task.** Not a separate assessment phase — a real-time annotation.
3. **The signal is actionable.** Humans (and systems) can route decisions based on it.
4. **The highest level means transfer.** Level 5 is "I can do this AND assess someone else's attempt" — the same as "I could teach this" in the classroom.

The key reframing is that **the skill is the student**. "Can Claude do this?" is the wrong question, just as "Can a person do this?" is the wrong question in a classroom. The right question is: "Can this skill, with its current context, meet this SLT?" Fist to Five answers that question quickly, honestly, and at the moment it matters.

## Annotation: Why Skills, Not Other Claude Patterns

Claude Code has several context mechanisms beyond Skills: CLAUDE.md files, MCP Servers, hooks. Each plays a role, but Skills are the right unit of assessment. Here's why, and what the others are.

### CLAUDE.md: The Baseline, Not the Student

CLAUDE.md files load automatically on every interaction. They provide persistent, always-on context that isn't task-specific. In the student analogy, this is general education — the prerequisites every student has before they walk into a specific class. CLAUDE.md sets the floor. It's not the thing you assess against SLTs. It's the thing that makes assessment possible at all.

### MCP Servers: The Reference Shelf, Not the Student

MCP Servers give Claude access to external tools — APIs, databases, live systems. This is the difference between a closed-book and open-book exam. An MCP server that queries Apollo API docs on demand doesn't change what the skill "knows" — it changes what the skill can look up in real time. It's a resource, not a capability. But it can raise the Fist to Five level, because access to the right reference at the right moment is often the difference between a 2 and a 4.

### Hooks: The Guardrails, Not the Student

Hooks are reactive — they execute in response to events. They're enforcement and automation infrastructure. They could enforce thresholds (block output below a confidence level, require human approval for certain SLTs), but they aren't the assessable unit.

### The Skill Within Its Environment

A skill's effective capability against an SLT is the skill file + the CLAUDE.md baseline + any MCP servers available + the referenced docs it can access. Stripping any of those changes the Fist to Five level, just as a student performs differently in a well-resourced classroom versus an empty one.

Skills remain the right primary focus because:

1. **They're the unit you invoke and test.** You run a skill against an SLT set and get back a signal. You don't run CLAUDE.md.
2. **They're the unit you refine.** When an SLT gets a 2 and you add context, you add it to the skill or its referenced docs. The refinement loop is skill-scoped.
3. **They're independently assessable.** Two different skills can be assessed against the same SLT set and produce different results. That's the "different students, same classroom" property.
4. **They're portable.** A skill can be shared, versioned, and reused across projects. That's the basis for treating them as credentialed entities.

As skills mature, they may depend heavily on MCP servers or CLAUDE.md content that isn't portable with the skill file. At that point, the skill as an assessable unit would need a manifest of its dependencies — "this skill requires MCP server X and assumes CLAUDE.md contains Y." That's the equivalent of listing course prerequisites. A future design concern, not a current blocker.

**Skills are the student. Everything else is the classroom. Assess the student.**
