# Operationalizing SLTs: From Skills to Plugin

## Where We Are

The lesson-coach project has produced two working Claude Code skills and a conceptual framework. The skills (`assess-slts` and `self-assess-readiness`) evaluate SLT quality and agent readiness. The framework (documented in `slts-as-agentic-interface.md`, `fist-to-five-for-agents.md`, and `compound-engineering-and-slts.md`) describes how SLTs function as the operational interface between humans and agentic systems, how skills are the assessable unit, and how compound engineering provides the infrastructure for making capability gains persist.

The skills work. The Go PBL test demonstrated that: 47 SLTs assessed for quality, revised to 44, then classified as 6 Ready, 33 Needs Context, 5 Needs Human. The framework is coherent. The question is how to make it executable and portable.

## What Exists

### Skills (Assessment)

| Skill | What It Does | Status |
|-------|-------------|--------|
| `assess-slts` | Evaluates SLT quality across five dimensions (student-facing language, learning focus, specificity, cognitive level, standalone clarity). Rates each SLT, provides concrete rewrite suggestions. | Working, tested against Go PBL |
| `self-assess-readiness` | Evaluates Claude's readiness to coach each SLT across four dimensions (conceptual explanation, code demonstration, learner assessment, knowledge currency). Produces tiered prioritization and context shopping list. | Working, tested against Go PBL |

### Concept Documents (Framework)

| Document | What It Establishes |
|----------|-------------------|
| `slts-as-agentic-interface.md` | SLTs as delegation contracts. The six-phase refinement loop. Credentials as delegation maps. |
| `fist-to-five-for-agents.md` | Skills as the assessable unit. The 0–5 confidence scale. Why skills — not CLAUDE.md, MCP servers, or hooks — are "the student." |
| `compound-engineering-and-slts.md` | How compound engineering's `/compound` maps to Phase 6 (Context Stabilization). The practical composition of the two systems. |

### Research Foundation

| Document | What It Provides |
|----------|-----------------|
| `slt-research-report.md` | Education research synthesis. Bloom's Taxonomy alignment. Formative assessment coupling. Andamio protocol implementation. Both skills depend on this as reference context. |

## What's Missing

The six-phase refinement loop is the core operational model:

```
1. Readiness Assessment    ← built (self-assess-readiness)
2. Attempt                 ← manual (human runs skill, reviews output)
3. Human Assessment        ← manual (human evaluates against SLT)
4. Context Refinement      ← manual (human adds docs, constraints, examples)
5. Reassessment            ← manual (re-run self-assess-readiness)
6. Context Stabilization   ← not built (no structured capture)
```

Phases 1 and 2 are tooled. Phases 3–5 are manual but structurally sound — the human does the assessment and refinement, the skill re-runs. Phase 6 has no implementation. The loop works today, but it doesn't compound. Each session starts from scratch because nothing captures what was learned.

Three pieces are needed to close the gap:

### 1. Workflow Commands

The two skills run independently. There is no command that chains them into a single assessment pass, and no command that orchestrates the refinement loop. Two workflow commands would make the process executable:

**`/workflows:assess`** — Chains `assess-slts` and `self-assess-readiness` in sequence against a given SLT set. Produces a single document containing: SLT quality review, readiness classification, gap analysis, and context shopping list. This is the "where do we stand?" command. Run it at the start of a session.

**`/workflows:refine`** — Orchestrates the refinement loop. Takes an SLT set and a context package (docs, examples, constraints). Runs readiness assessment, attempts the Ready SLTs, emits Fist to Five inline, and structures output so human assessment is natural. After human feedback, accepts context refinements and re-runs. This is the "move forward" command. Run it iteratively within a session.

### 2. Context Stabilization Agent

When the refinement loop moves an SLT from Needs Context to Ready, something changed — a document was added, a constraint was tightened, an example was provided. That change needs to be captured in a structured format so it persists.

A context stabilization agent would:
- Identify what context was added during the refinement cycle
- Record what SLT(s) it unlocked
- Classify the context type (API reference, code example, constraint, guardrail)
- Write a structured artifact that can be loaded in future sessions

This agent bridges the SLT framework to compound engineering's `/compound` workflow. It captures not just "what we solved" but "what context enables this SLT" — the information needed to maintain the capability over time.

### 3. Readiness Tracking

The compounding trajectory — how the Ready/Needs Context/Needs Human distribution changes over time — is currently invisible. There is no record of past assessments. You cannot see whether the skill is improving, stagnating, or regressing due to context drift.

A simple tracking mechanism would store timestamped assessment summaries:

```
docs/assessments/
├── 2026-02-23-go-pbl-readiness.md
├── 2026-03-10-go-pbl-readiness.md
└── 2026-03-25-go-pbl-readiness.md
```

Each file records: date, SLT set assessed, skill used, per-SLT verdicts, summary distribution, and delta from previous assessment. Over time, this directory shows the compounding curve — or reveals where drift has eroded capability.

## The Build Path

### Phase A: Build in Lesson-Coach

Build the missing pieces in this project. Test against the Go PBL SLT set, which has a known baseline (6 Ready, 33 Needs Context, 5 Needs Human from the initial assessment).

| Step | Deliverable | What It Proves |
|------|-------------|---------------|
| A1 | `/workflows:assess` command | The two skills chain cleanly into a single assessment pass |
| A2 | `/workflows:refine` command | The refinement loop is executable, not just described |
| A3 | Readiness tracking format | Assessment results can be stored and compared over time |
| A4 | Context stabilization agent | Refinement gains can be captured as persistent artifacts |
| A5 | Full-cycle test on Go PBL | Run assess → refine (with context for a few Needs Context SLTs) → stabilize → reassess. Verify the distribution shifts. |

Phase A stays inside lesson-coach. No portability concerns, no plugin packaging. The goal is to prove the workflow works end-to-end with real SLTs.

### Phase B: Extract to Plugin

Once the workflow is tested, extract everything into a standalone plugin that any Andamio project can enable.

**Plugin name:** `andamio-slt`

**Structure:**

```
andamio-slt/
├── .claude-plugin/
│   └── plugin.json
├── agents/
│   └── workflow/
│       └── context-stabilization.md
├── commands/
│   └── workflows/
│       ├── assess.md
│       └── refine.md
├── skills/
│   ├── assess-slts/
│   │   ├── SKILL.md
│   │   └── references/
│   │       └── slt-research-report.md
│   └── self-assess-readiness/
│       ├── SKILL.md
│       └── references/
│           └── slt-research-report.md
├── README.md
├── CHANGELOG.md
└── LICENSE
```

**Extraction requires:**

1. **Decouple paths.** Both skills currently hardcode a path to `slt-research-report.md` in the lesson-coach project. The plugin bundles the research report as `references/slt-research-report.md` within each skill directory, and the skills reference it via relative path.

2. **Generalize SLT input.** The skills currently expect the user to point at a markdown file. The plugin should accept SLTs in any format the user provides — a file path, inline text, or a URL — and normalize before assessment.

3. **Document integration with compound engineering.** The context stabilization agent should work with or without compound engineering installed. If `/compound` is available, use it. If not, write standalone artifacts.

4. **Version and publish.** Semver in `plugin.json`. CHANGELOG in Keep a Changelog format. README with component tables.

### Phase C: Extend

Once the plugin exists, the framework opens up to broader application:

- **Other Andamio courses.** Any course with SLTs can be assessed and refined using the plugin. The Go PBL test was proof-of-concept. Scaling to other courses tests generalization.
- **Credential delegation maps.** For any Andamio credential, run `/workflows:assess` to produce a delegation map showing what agents can handle and where humans are irreplaceable.
- **Skill maturity dashboards.** The readiness tracking data, accumulated over time, shows skill maturity across the SLT sets the organization cares about. This is the compounding trajectory made visible.
- **Assessment agents for learner submissions.** Compound engineering's review agent pattern adapted for evaluating student work against SLTs — the Fist to Five level 5 case where the skill can assess others' attempts.

## Design Decisions to Make

Several decisions should be made before building. These don't need to be resolved now, but they shape the implementation:

### How should the refinement loop handle Needs Human SLTs?

The current framework classifies them and moves on. But in practice, a human working through a lesson might want to co-author with the agent even on Needs Human SLTs — providing expert input while the agent handles structure and formatting. Should `/workflows:refine` support a co-authorship mode, or should it skip Needs Human SLTs entirely?

### Should Fist to Five be emitted automatically or on request?

The concept doc describes inline confidence signals during work. The question is whether this should be default behavior (every SLT attempt includes a Fist to Five annotation) or opt-in (human requests confidence check when they want it). Default adds noise. Opt-in risks missing important signals.

### What format should stabilized context take?

The context stabilization agent needs to write artifacts that future sessions can load. Options include: markdown files with YAML frontmatter (consistent with compound engineering's `docs/solutions/`), additions to the skill's own `references/` directory, or entries in a structured manifest that maps SLTs to their required context. Each has different tradeoffs for discoverability, portability, and maintenance.

### Should the plugin depend on compound engineering?

The context stabilization agent is designed to bridge to `/compound`. If compound engineering is a hard dependency, the plugin gets the full documentation pipeline but limits its audience. If it's optional, the plugin needs its own lightweight stabilization format. The practical question: will every team using SLTs also use compound engineering?

## Summary

The SLT framework works as theory and has been validated through the two assessment skills. Operationalizing it means building the workflow layer — commands that chain assessment into action, agents that capture refinement gains, and tracking that makes the compounding trajectory visible.

The path is: build in lesson-coach (Phase A), extract to plugin (Phase B), extend to broader use (Phase C). Phase A is where the real work happens. Phase B is packaging. Phase C is scaling.

The plugin — `andamio-slt` — gives any Andamio project the ability to assess SLT quality, evaluate agent readiness, run the refinement loop, stabilize context gains, and track capability over time. Combined with compound engineering, it creates a system where every session that resolves a gap makes the next session start from a higher baseline.
