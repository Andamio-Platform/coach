# AGENTS.md

Project context for AI agents working in this repository. Read this file to understand the project, conventions, and workflow.

## Project Overview

**Coach** is a skills and knowledge workspace for AI-assisted course development. The primary artifacts are agent skill definitions (`skills/`), YAML knowledge files (`knowledge/`), and markdown documentation.

This is **not a code project**. Course content lives in separate repos that symlink to this one. See `docs/setup-course-repo.md` for the pattern.

## Directory Structure

```
skills/                   # Agent skill definitions (14 skills, Agent Skills standard)
  start/                  # Entry point — welcome and pathway selection
  beginner/               # Guided pathway for new course creators
  apprentice/             # Collaborative pathway for content experts
  teacher/                # Fast-track pathway for experienced educators
  course-workflow/        # Orchestrates the 12-phase workflow
  draft-slts/             # Generates SLTs from topic, audience, and goals
  assess-slts/            # Evaluates SLT quality across 5 dimensions
  self-assess-readiness/  # Evaluates coaching readiness per SLT
  classify-lesson-types/  # Classifies SLTs by lesson type
  gather-screenshots/     # Screenshot checklists for Product Demo lessons
  gather-code-examples/   # Code example checklists for Developer Documentation
  compound/               # Extracts patterns to improve future runs
  compile/                # Packages modules into Andamio import format
  andamio-cli/            # Import/export content via Andamio CLI
knowledge/                # Compound knowledge base (YAML files)
  index.yaml              # Master index and aggregate stats
  voice-patterns.md       # Prose style guide for lesson writing
  slt-patterns/           # Verb bank, quality issues, successful rewrites
  readiness/              # Context leverage rankings, calibration data
  lesson-types/           # Heuristics and edge cases
  lesson-writing/         # Style anti-patterns and acceptable patterns
  compile/                # Import gotchas discovered during platform uploads
docs/                     # Framework and product documentation
research/                 # SLT research report
scripts/                  # Setup script for course repos
```

## Conventions

**SLT Format**: Always "I can..." or "Learner can..." phrasing. Tool/library names are fine; implementation details belong in lessons.

**Readiness Tiers**:
- **Ready**: All dimensions Strong/Current — can coach now
- **Needs Context**: At least one dimension Partial/Uncertain — needs supplementary docs
- **Needs Human**: At least one dimension Weak/Likely Stale — requires expert co-authorship

**Lesson Types**:
1. Product Demo — SLT + screenshots → visual walkthrough
2. Developer Documentation — SLT + code + docs link → technical lesson
3. How To Guide — SLT + optional materials → step-by-step procedure
4. Organization Onboarding — SLT + org context → setup guidance
5. Exploration — SLT + framing questions → big ideas, thought leadership, worldview challenges

**Lesson Writing Style** (from `knowledge/voice-patterns.md` and `knowledge/lesson-writing/style-patterns.yaml`):
- Avoid em-dash flourishes, dangling participles after em-dashes, route-path-only descriptions, non-decisional UI element descriptions, and over-explaining what just happened
- See `knowledge/lesson-writing/style-patterns.yaml` for the full anti-pattern list with examples

## Course Development Workflow (12 Phases)

1. **Draft SLTs** → `01-slts.md`
2. **Assess quality** → `assess-slts` skill → `02-slts-quality-review.md`
3. **Revise SLTs** → apply feedback to `01-slts.md` and `00-course.md`
4. **Classify lesson types** → `classify-lesson-types` skill → `03-lesson-type-classification.md`
5. **Assess readiness** → `self-assess-readiness` skill → `04-readiness-assessment.md`
6. **Create delegation map** → `05-delegation-map.md`
7. **Gather context** → `gather-screenshots` and `gather-code-examples` skills
8. **Build lessons** → `lessons/` with Fist to Five signals
9. **Compile modules** → `compile` skill → `compiled/`
10. **Import to platform** → `andamio-cli` skill
11. **Compound** → `compound` skill → `knowledge/`
12. **Promote** → move to `courses/[slug]/`

## Multi-Repo Setup

Course content lives in standalone repos that symlink to this skills repo. See `docs/setup-course-repo.md` for the full pattern and setup script. Knowledge compounds back to this repo regardless of where skills are invoked.

## Skill Dependencies

All assessment skills read from `knowledge/` before running. If knowledge files don't exist (fresh install or after reset), skills proceed without prior patterns.

The `compound` skill writes back to `knowledge/`, closing the compounding loop.

## Roadmap

Current phase: Phase A (Build Workflow and Lesson Skills). Phase B packages this for distribution across agent ecosystems. Phase C extends to additional platforms.
