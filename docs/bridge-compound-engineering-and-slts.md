# Compound Engineering and SLTs

## The Shared Problem

Compound engineering and the SLT-as-interface framework solve the same problem from different directions: how do you make capability gains persist and accumulate rather than evaporate between sessions?

In compound engineering, the answer is documentation. The first time you solve a problem, it takes research. Document it, and the next occurrence takes minutes. Knowledge compounds.

In the SLT framework, the answer is context stabilization. A skill that meets an SLT today will meet it tomorrow — as long as the context that enabled it is still present. When context is refined through the formative assessment loop and then captured as a stable artifact, the skill's capability compounds.

Both systems convert ephemeral work into durable capability. They just describe different parts of the process.

## Where They Compose

### Context Stabilization Is Compounding

The SLT refinement loop has six phases. The last one — Context Stabilization — is where a skill's context graduates from "thing we figured out during this session" to "thing that persists across sessions." That phase is exactly what compound engineering's `/compound` workflow does: it takes a solved problem and documents it so the solution is available next time.

The refinement loop without compounding:

```
Readiness Assessment → Attempt → Human Assessment → Context Refinement → Reassessment → ??? (context lost)
```

The refinement loop with compounding:

```
Readiness Assessment → Attempt → Human Assessment → Context Refinement → Reassessment → /compound (context stabilized)
```

Without the compounding step, the loop produces a one-time result. With it, the loop produces a durable capability gain. The skill's Fist to Five level stays elevated because the context that raised it has been captured.

### Skills Are the Unit in Both Systems

Compound engineering organizes capability into skills — structured context packages that configure the agent for specific kinds of work. The SLT framework identifies skills as "the student" — the assessable, refinable unit against which SLTs are evaluated.

These are the same insight. The model is infrastructure. The skill — model plus context — is where capability lives. Compound engineering provides the machinery for building and maintaining skills. The SLT framework provides the theory for assessing what skills can do and where their gaps are.

A well-maintained skill in compound engineering terms is a mature student in SLT terms: mostly 4s and 5s on its target SLT set, with the occasional 2 or 3 where the domain is still evolving. A newly created skill with minimal context is a student on day one: scattered 1s and 2s.

### Agents Map to the Delegation Framework

Compound engineering includes specialized agents — security-sentinel, performance-oracle, architecture-strategist, and others. Each agent has implicit SLTs it can meet. The security sentinel can assess OWASP vulnerabilities. The Rails reviewer can evaluate convention compliance. The design iterator can refine UI components through screenshot cycles.

The SLT framework makes this implicit capability structure explicit. Instead of assuming what an agent can do, you write the SLTs, run a readiness assessment, and get a classified result: Ready, Needs Context, Needs Human. The compound engineering agents are pre-built skills with pre-loaded context. The SLT framework gives you a way to evaluate whether that context is sufficient for a given target.

### The `/compound` Workflow Is Phase 6

The `/compound` workflow runs after a problem is solved. It dispatches five parallel research agents — context analyzer, solution extractor, related docs finder, prevention strategist, and category classifier — then assembles their findings into a documented solution with YAML frontmatter, categorized in `docs/solutions/`.

This is operationally identical to what Phase 6 (Context Stabilization) calls for. When an SLT moves from "not met" to "reliably met" through context refinement, the context that closed the gap needs to be captured somewhere persistent. The `/compound` workflow provides the pipeline for doing that: structured documentation, categorized by problem type, cross-referenced with related solutions, and searchable by future agents.

The difference is scope. The SLT framework describes what *should* be stabilized (the context that enables reliable SLT performance). The `/compound` workflow describes *how* to stabilize it (five-agent research pipeline, YAML-fronted documentation, categorical organization).

## What the SLT Framework Adds

Compound engineering is engineer-facing. It compounds knowledge about solving engineering problems. The SLT framework adds three things that compound engineering doesn't address on its own.

### Falsifiable Capability Claims

An SLT is a testable statement: "I can build a command-line tool with multiple commands using the Cobra library." Compound engineering documents solutions but doesn't formalize what capability was gained in a way that can be independently reassessed. A documented solution tells you what was done. An SLT tells you what can be done — and lets you verify it.

### The Readiness Assessment Loop

Compound engineering captures what worked. The SLT framework also captures what the skill *cannot yet do*. The Fist to Five 0s and 1s, the Needs Context and Needs Human classifications, the Context Shopping List — these are gap maps. They show where to invest next. Compound engineering optimizes the capture of gains. The SLT framework also optimizes the identification of gaps.

### Learner-Facing Output

Compound engineering serves engineers building software. The SLT framework serves learners building capability. The coaching use case is distinct: the agent isn't just producing code, it's producing lessons, assessments, explanations, and feedback. The SLT is the contract between the learner and the system, not between the developer and the codebase.

## What Compound Engineering Adds

The SLT framework describes the theory. Compound engineering provides operational machinery that the framework needs but doesn't specify.

### Multi-Agent Orchestration

The swarm, pipeline, and parallel specialist patterns in compound engineering are ready-made infrastructure for running multiple skills against multiple SLTs concurrently. A readiness assessment across 44 SLTs could dispatch parallel agents — one per SLT or per module — rather than running sequentially. The orchestration patterns exist. The SLT framework provides the task decomposition.

### Structured Documentation Pipeline

The YAML frontmatter schema, category directories, and cross-referencing in `docs/solutions/` could serve as the storage format for stabilized context artifacts. When the refinement loop produces a context package that reliably enables an SLT, that package needs a home. Compound engineering's documentation infrastructure — with its categories, frontmatter validation, and searchability — is a natural fit.

### Review Agents as Assessment Tools

The SLT readiness dimension "Learner Assessment" asks whether a skill can evaluate student work against an SLT. Compound engineering's review agents are specialized evaluators — they assess code quality, security, performance, architecture. Adapting these agents from reviewing code to reviewing learner submissions against SLTs would close the loop: the same agent infrastructure that reviews engineering work could review learning evidence.

### The Learnings Researcher

Compound engineering includes a `learnings-researcher` agent that searches `docs/solutions/` for relevant past solutions by frontmatter metadata. In the SLT context, this agent becomes the mechanism for skills to access their own compounded knowledge. Before attempting an SLT, a skill could query past solutions for relevant context — checking whether a previous refinement cycle already produced the documentation needed. This prevents re-solving solved problems, which is the core promise of compounding.

## The Practical Composition

The two systems compose into a single workflow:

### 1. Design

Use `/brainstorm` and `/plan` to design lesson content and SLT sets. These workflows produce structured documents that define what the skill will be asked to do.

### 2. Assess

Use `assess-slts` to evaluate SLT quality. Use `self-assess-readiness` to classify each SLT as Ready, Needs Context, or Needs Human. The readiness assessment produces the Context Shopping List — the prioritized set of resources needed to close gaps.

### 3. Build

Use `/work` to build lessons for Ready SLTs (Fist to Five 4s and 5s). For Needs Context SLTs (2s and 3s), provide the context identified in the shopping list, then build.

### 4. Review

Use `/review` with appropriate specialist agents. For lesson content, this means evaluating both technical accuracy and pedagogical quality. The review produces specific gap diagnoses — not "this is wrong" but "this section uses a non-existent API function because the skill lacks the Apollo v0.4 reference."

### 5. Compound

Use `/compound` to capture what was learned. When a Needs Context SLT becomes Ready through context refinement, document the solution: what context was missing, what was added, what the skill can now do. This is Phase 6 — Context Stabilization — executed through compound engineering's documentation pipeline.

### 6. Reassess

Periodically re-run `self-assess-readiness` against the full SLT set. The Fist to Five distribution should trend upward as compounded knowledge accumulates. Where it doesn't, the gap analysis identifies what drifted or what was never properly stabilized.

## The Compounding Trajectory

The trajectory over time:

```
Session 1:  6 Ready, 33 Needs Context, 5 Needs Human
            ↓ (build Ready lessons, compound solutions)
Session N:  20 Ready, 19 Needs Context, 5 Needs Human
            ↓ (provide context, compound solutions)
Session M:  35 Ready, 4 Needs Context, 5 Needs Human
            ↓ (periodic reassessment catches drift)
Session P:  33 Ready, 6 Needs Context, 5 Needs Human
```

The Needs Human set may not shrink — those SLTs represent irreducible human contribution. But the Needs Context set steadily converts to Ready as context is refined, tested, and compounded. Each `/compound` invocation ratchets the skill's capability forward. Each reassessment verifies the ratchet held.

This is the compounding curve. Not every session produces a breakthrough. But every session that resolves a gap and compounds the solution makes the next session start from a higher baseline. The SLT framework measures the height. Compound engineering builds the ratchet.

## The Limits of Composition

### Context Drift Requires Re-Compounding

A compounded solution documents what worked at a point in time. Libraries change. APIs evolve. A solution that moved an SLT from Needs Context to Ready in February may not hold in August. Periodic reassessment catches this, but it means compounded knowledge has a shelf life. The solution isn't to avoid compounding — it's to version solutions and tie them to specific assessments, so staleness is detectable.

### Compounding Doesn't Replace Human Assessment

The `/compound` workflow captures *what the agent learned*. It does not verify that the captured knowledge is correct. A skill could compound a wrong solution — one that appeared to work in a specific context but fails under different conditions. Human assessment remains the corrective. The refinement loop requires human evaluation at Phase 3. Compounding without assessment compounds errors as readily as solutions.

### Not Everything Is Compoundable

Some SLTs require judgment, taste, or domain expertise that resists capture in documentation. "I can evaluate whether a set of SLTs covers a topic comprehensively" depends on understanding what comprehensiveness means in context — a judgment call that shifts by domain, audience, and purpose. These SLTs may stay in the Needs Human category permanently. Compound engineering doesn't change that. What it does is ensure that everything *around* those human-dependent SLTs — the context, the tooling, the reference materials — is as strong as possible, so the human contribution is focused on the irreducible parts.
