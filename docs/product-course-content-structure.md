# Course Content Structure

## The Units

An Andamio course is organized into two content types, each with a fixed relationship to SLTs:

**Lessons** — one per SLT. A lesson teaches the capability that the SLT defines. If the SLT is "I can create a new project on the Andamio Platform," there is exactly one lesson that shows the learner how to do that. The lesson is the coaching unit.

**Assignments** — one per Course Module. A module contains one or more SLTs. The assignment asks the learner to produce an artifact that demonstrates mastery of the module's SLTs. The assignment is the assessment unit. Every assignment produces a reviewable artifact — something a human teacher or an agent can evaluate against the SLTs.

```
Course
├── Module 1 (SLTs 1.1, 1.2, 1.3)
│   ├── Lesson 1.1 (teaches SLT 1.1)
│   ├── Lesson 1.2 (teaches SLT 1.2)
│   ├── Lesson 1.3 (teaches SLT 1.3)
│   └── Assignment 1 (assesses SLTs 1.1–1.3, produces artifact)
├── Module 2 (SLTs 2.1, 2.2)
│   ├── Lesson 2.1 (teaches SLT 2.1)
│   ├── Lesson 2.2 (teaches SLT 2.2)
│   └── Assignment 2 (assesses SLTs 2.1–2.2, produces artifact)
└── ...
```

The 1:1 mapping between SLTs and lessons means that the Fist to Five rating on an SLT is a rating on a lesson. If the agent rates itself a 4 on an SLT, it can produce and coach that lesson. If it rates itself a 1, it cannot. The readiness assessment is a lesson-by-lesson quality check.

## Lesson Types

There are four lesson types. Each type has a characteristic input pattern — what the lesson author provides — and a characteristic agent readiness profile — what the agent needs to produce the lesson.

### 1. Product Demo

**Purpose:** Show learners how to use Andamio Platform features.

**Typical inputs:**
- SLT
- Screenshot(s) of the platform feature

**What the lesson contains:** Visual walkthrough of a platform feature. The learner sees what the feature looks like, where to find it, and how to use it. The lesson answers: "Where do I click and what happens when I do?"

**Agent readiness profile:** The agent needs visual context — screenshots or descriptions of the current platform UI. Platform features change as the product evolves, so knowledge currency is the dominant concern. The agent's general capability (explaining UI flows, writing clear step-by-step instructions) is likely strong. What it lacks is current, specific knowledge of what the platform looks like and how it behaves right now.

| Dimension | Typical Rating | Why |
|-----------|---------------|-----|
| Conceptual Explanation | Strong | The agent can explain UI concepts and workflows |
| Code Demonstration | N/A | Product demos don't involve code |
| Learner Assessment | Partial | Can assess written descriptions but may struggle to evaluate screenshots of learner's own platform use |
| Knowledge Currency | Uncertain to Likely Stale | Platform UI changes with every release |

**Context the agent needs:** Current screenshots, feature descriptions, or access to platform documentation that reflects the latest UI. This context has a short shelf life — it must be updated when the platform changes.

**What the lesson author provides that the agent cannot:** The screenshots themselves. A human takes the screenshots, annotates them if needed, and provides them as input. The agent writes the lesson around them.

---

### 2. Developer Documentation

**Purpose:** Technical content for developers integrating with Andamio.

**Typical inputs:**
- SLT
- Code snippet(s)
- Documentation link(s)

**What the lesson contains:** Technical explanation of an API, library, or integration pattern. The learner sees working code, understands what it does and why, and learns how to use it in their own project. The lesson answers: "How does this work and how do I use it?"

**Agent readiness profile:** This is the lesson type where agents tend to be strongest — if the documentation and code examples are provided as context. The agent's core capabilities (explaining code, producing working examples, walking through logic) align directly with what developer documentation requires. The constraint is that Andamio-specific APIs and libraries are niche; the agent's training data may not cover them.

| Dimension | Typical Rating | Why |
|-----------|---------------|-----|
| Conceptual Explanation | Strong to Partial | Strong for well-known technologies, Partial for Andamio-specific APIs |
| Code Demonstration | Strong to Partial | Can produce working code if API reference is available |
| Learner Assessment | Strong to Partial | Can evaluate code submissions if it understands the correct patterns |
| Knowledge Currency | Uncertain | Depends on whether provided docs reflect the current API version |

**Context the agent needs:** API reference documentation, working code examples, and version-specific information. The documentation link the lesson author provides is the critical input — the agent transforms reference material into teachable content.

**What the lesson author provides that the agent cannot:** The code snippet and documentation link. These are the ground truth. The agent builds the lesson on this foundation but does not generate the foundation itself.

---

### 3. How To Guide

**Purpose:** Clear procedures for accomplishing specific tasks.

**Typical inputs:**
- SLT
- (Optional) supporting materials

**What the lesson contains:** Step-by-step instructions for completing a task. The learner follows the procedure and arrives at a defined outcome. The lesson answers: "What are the exact steps?"

**Agent readiness profile:** Procedural content is a natural fit for agents. The structure is predictable (numbered steps, expected outcomes, common pitfalls), and the agent's ability to organize information sequentially is strong. The variable is whether the agent knows the specific procedure — which depends on whether the task involves well-documented tools (strong) or niche Andamio-specific workflows (needs context).

| Dimension | Typical Rating | Why |
|-----------|---------------|-----|
| Conceptual Explanation | Strong | Procedural context is straightforward to explain |
| Code Demonstration | Varies | Strong for general tools, Partial for Andamio-specific procedures |
| Learner Assessment | Strong | Procedural outcomes are binary — the learner either completed the steps correctly or didn't |
| Knowledge Currency | Varies | Current for stable procedures, Uncertain for evolving workflows |

**Context the agent needs:** If the procedure involves Andamio-specific tools or workflows, the agent needs documentation for those tools. If the procedure involves well-known technologies (Git, npm, Docker), the agent likely needs minimal additional context.

**What the lesson author provides that the agent cannot:** Domain judgment about which procedures matter and in what order. The SLT defines the target; the lesson author decides the procedure is the right way to reach it. The agent executes the writing; the author provides the editorial decision.

---

### 4. Organization Onboarding

**Purpose:** Getting started content for organizations setting up and using Andamio.

**Typical inputs:**
- SLT
- (Optional) organization-specific context

**What the lesson contains:** Guidance for organizations adopting Andamio. This may include platform setup, team configuration, course creation workflows, or integration with existing processes. The lesson answers: "How does our organization start using this?"

**Agent readiness profile:** This is the lesson type most dependent on context the agent cannot generate on its own. Organization onboarding involves Andamio platform specifics (which change), organizational context (which varies per customer), and strategic guidance (which requires understanding of the organization's goals). The agent's general capability — writing clear onboarding content — is strong. What it lacks is the specific knowledge of what Andamio's onboarding process looks like today and what the target organization needs.

| Dimension | Typical Rating | Why |
|-----------|---------------|-----|
| Conceptual Explanation | Partial | Can explain onboarding concepts but may lack Andamio-specific details |
| Code Demonstration | N/A or Partial | Some onboarding involves technical setup; most is procedural |
| Learner Assessment | Partial | Can assess whether setup steps were completed but may miss organizational nuance |
| Knowledge Currency | Uncertain to Likely Stale | Platform onboarding flows change; organization context is always new |

**Context the agent needs:** Current Andamio platform onboarding documentation, organization-specific context (if the lesson is customized for a particular organization), and any recent changes to the setup process.

**What the lesson author provides that the agent cannot:** Organization-specific context. A lesson built for Organization A's onboarding requires knowledge of Organization A's structure, goals, and constraints. That context comes from the relationship, not from documentation.

---

## Lesson Types and Agent Readiness

Across the four types, a pattern emerges:

| Lesson Type | Agent Strength | Agent Weakness | Primary Context Need |
|-------------|---------------|----------------|---------------------|
| Product Demo | Writing clear instructions from visual inputs | Knowledge of current platform UI | Current screenshots and feature docs |
| Developer Documentation | Explaining code, producing examples | Niche API knowledge (Andamio-specific) | API references, working code examples |
| How To Guide | Procedural writing, step sequencing | Niche workflow knowledge | Procedure documentation for Andamio tools |
| Organization Onboarding | Clear onboarding content structure | Platform specifics, org-specific context | Current onboarding docs, org context |

Two observations:

**1. The agent's general capabilities are strong across all types.** Writing clearly, organizing steps, explaining concepts, producing code — these are reliable capabilities regardless of lesson type. What varies is the domain-specific knowledge the agent needs to apply those capabilities correctly.

**2. The context need is predictable by type.** Product Demos need visual assets. Developer Documentation needs API references. How To Guides need procedure docs. Organization Onboarding needs platform and org context. This predictability means the Context Shopping List can be organized by lesson type, and context development can be prioritized by which types have the most lessons in a given course.

## Assignments

An assignment is one per module. It assesses all SLTs in the module by asking the learner to produce an artifact. The artifact is the evidence of mastery.

Assignments have a different agent readiness profile than lessons. A lesson requires the agent to coach (explain, demonstrate, guide). An assignment requires the agent to assess (evaluate the artifact against the SLTs, provide diagnostic feedback, determine whether the target is met).

Assessment is the Fist to Five level 5 capability: "I can produce this, explain it, catch errors in it, and evaluate someone else's attempt." Not every lesson-ready agent is assignment-ready. An agent that can write a good lesson on building a CLI with Cobra (level 4) may or may not be able to evaluate a learner's CLI submission and identify where it falls short (level 5).

This means assignment readiness is a higher bar than lesson readiness:

| Content Type | Minimum Fist to Five for Agent | What the Agent Does |
|-------------|-------------------------------|-------------------|
| Lesson | Level 4 | Explain, demonstrate, coach |
| Assignment | Level 5 | Evaluate artifacts, diagnose gaps, give diagnostic feedback |

A course readiness assessment should distinguish between these two bars. An agent that is level 4 across all SLTs can produce every lesson but may not be able to assess every assignment. The delegation map should reflect this:

| Module | Lesson Readiness | Assignment Readiness | Implication |
|--------|-----------------|---------------------|-------------|
| Module 1 | Agent (level 4–5) | Agent (level 5) | Fully delegatable |
| Module 2 | Agent (level 4) | Human required (level 3) | Agent coaches, human assesses |
| Module 3 | Human required (level 1) | Human required (level 1) | Human teaches and assesses |

## Lesson Types as Skills

Each lesson type has a characteristic input pattern and a characteristic output structure. This makes them natural candidates for Claude Code skills:

| Lesson Type | Skill Input | Skill Output |
|-------------|------------|-------------|
| Product Demo | SLT + screenshot(s) | Lesson with annotated visual walkthrough |
| Developer Documentation | SLT + code snippet + documentation link | Lesson with explained code examples and integration guidance |
| How To Guide | SLT + (optional) supporting materials | Lesson with numbered steps, expected outcomes, and troubleshooting |
| Organization Onboarding | SLT + (optional) org-specific context | Lesson with setup guidance, configuration steps, and next actions |

Each skill would:
1. Accept the typed inputs for that lesson type
2. Emit a Fist to Five signal based on its readiness for the specific SLT
3. Produce the lesson if confidence is level 3 or above
4. Flag what's missing if confidence is level 2 or below

Four skills, one per lesson type. Each skill is "the student" for its category of lessons. Each can be independently assessed, refined, and compounded.

## Assignment as a Skill

Assignments could also be a skill — but a different kind. The lesson skills produce content. The assignment skill evaluates content. Its input is the learner's submitted artifact plus the module's SLTs. Its output is diagnostic feedback: which SLTs are met, which are not, and where the gaps are.

This skill maps to the assessment dimension of readiness. Building it requires not just knowledge of the domain but the ability to evaluate work against criteria — the highest cognitive level in Bloom's Taxonomy (Evaluate) and the Fist to Five level 5 threshold.

The assignment skill is the hardest to build and the most valuable to get right. If it works, every assignment in a course can be assessed at scale — the agent reviews submissions and the human teacher handles only the cases the agent flags as uncertain. If it doesn't work, every assignment requires human review, and the course scales linearly with teaching capacity.

## Summary

The content structure is:

- **Lessons**: 1 per SLT, 4 types (Product Demo, Developer Documentation, How To Guide, Organization Onboarding), each with characteristic inputs and agent readiness profiles.
- **Assignments**: 1 per Module, always produces a reviewable artifact, requires level 5 agent capability for full delegation.

The lesson types map to skills. The assignment maps to a different skill (evaluation rather than production). The readiness assessment distinguishes between lesson readiness (level 4) and assignment readiness (level 5). The delegation map shows, for each module, what the agent handles and where humans are needed.

Course development has two parallel workstreams: content for learners (lessons and assignments) and context for the agent (references, examples, and constraints organized by lesson type). Both serve the same SLTs. Both are gated by assessment. Both compound over time.
