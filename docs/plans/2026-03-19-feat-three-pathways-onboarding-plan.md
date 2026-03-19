---
title: "feat: Three Pathways Onboarding for Coach"
type: feat
status: active
date: 2026-03-19
origin: orch session — substack editing surfaced need for coach rename + pathways
---

# feat: Three Pathways Onboarding for Coach

## Context

Coach is being prepared for public release as an agent-agnostic skills repo following the [Agent Skills open standard](https://agentskills.io). Current entry point is "try the `draft-slts` skill" — no onboarding, no welcome. The README should say "run the `start` skill" and have that fire up a delightful welcome showing three roles that dispatch to tailored pathways. Each pathway orchestrates existing skills in a different sequence and tone.

The Substack post (slt-self-audit) introduces coach inline: "I built a tool called coach that helps humans and AI agents figure this out together." The three pathways are the product story — not just a tool for teachers, but entry points for anyone building a course.

## Files to Create

| File | Purpose |
|------|---------|
| `skills/start/SKILL.md` | Welcome + role selection + inline dispatch |
| `skills/beginner/SKILL.md` | Interview-first, most hand-holding |
| `skills/apprentice/SKILL.md` | Collaborative, content expert needs structure |
| `skills/teacher/SKILL.md` | Fast-track, SLTs ready or nearly ready |

## Files to Modify

| File | Change |
|------|--------|
| `README.md` | Replace Quick Start: "run the `start` skill" |
| `AGENTS.md` | Update skill count (10 → 14), note onboarding skills |
| `CLAUDE.md` | No change needed (thin pointer to AGENTS.md) |

## `start` Skill

Welcome message (~10 lines, warm, not a wall of text). Presents three numbered choices:

1. **Beginner** — "I have a topic but I'm not sure what the learning targets should be."
2. **Apprentice** — "I know my content. I need help structuring it as a course."
3. **Teacher** — "I have learning targets ready. Let's go."

After selection, execute the chosen pathway's instructions inline (no extra skill invocation needed). One interaction: run `start`, pick a number, you're rolling.

### Spec Compliance

All four new skills must follow the [Agent Skills standard](https://agentskills.io/specification):

```yaml
---
name: start
description: Welcome to Coach. Choose your pathway — beginner, apprentice, or teacher — to start building a course.
license: MIT
---
```

- Names: `start`, `beginner`, `apprentice`, `teacher` (all valid per spec)
- Descriptions must explain what the skill does AND when to use it
- Directory names must match the `name` field

## Pathway Convergence

All three enter the `course-workflow` skill at different phases:

```
start
  ├── beginner ──→ interview → draft-slts → assess-slts → revise → course-workflow (phase 1)
  ├── apprentice → gather materials → draft-slts (collaborative) → assess → classify → course-workflow (phase 3)
  └── teacher ──→ accept SLTs → assess → classify → self-assess-readiness → course-workflow (phase 4)
```

## Pathway Details

### Beginner
**Tone:** Warm, explanatory. Defines terms as they come up.
1. Context interview (4-5 questions, one at a time): topic, audience, goals, length, existing materials
2. Explain what SLTs are in plain language
3. Execute `draft-slts` instructions with gathered context (don't re-ask)
4. Present draft with "here's what this means" gloss on each SLT
5. Execute `assess-slts`, frame results accessibly
6. Revise together — walk through weak SLTs, propose rewrites
7. Hand off to `course-workflow` at `slts-drafted`

### Apprentice
**Tone:** Collaborative, peer-to-peer. Explains pedagogy, not subject matter.
1. Brief orientation (one paragraph)
2. Ask for existing materials (docs, outlines, repos) + "what does a successful learner look like?"
3. Collaborative SLT drafting — propose 2-3 at a time, get feedback, iterate
4. Execute `assess-slts` as calibration check
5. Execute `classify-lesson-types` immediately (user is ready for it)
6. Hand off to `course-workflow` at `types-classified`

### Teacher
**Tone:** Efficient, respectful. Minimal explanation.
1. "Paste your SLTs, point me to a file, or describe what you have"
2. Quick format check — reformat to "I can..." if needed, no lectures
3. Execute `assess-slts` — table format, concise results
4. Execute `classify-lesson-types` in batch mode (present all guesses, confirm/override)
5. Execute `self-assess-readiness` immediately
6. Hand off to `course-workflow` at `readiness-assessed`

## Skill Chaining Approach

Pathway SKILL.md files instruct the agent to "Read and follow the instructions in `skills/[skill]/SKILL.md`" at the appropriate step. This keeps existing skills untouched while pathways orchestrate them with different tone and sequencing.

Teacher's "batch mode" for classify-lesson-types is handled in the Teacher SKILL.md instructions, not by modifying the original skill.

## README Quick Start (new)

```markdown
## Quick Start

git clone + cd coach

Open your AI coding agent and run the `start` skill. Coach will welcome you and ask how you'd like to work. Three paths, one destination:

- **Beginner** — Have a topic, need help defining learning targets
- **Apprentice** — Know your content, need help structuring a course
- **Teacher** — Have learning targets ready, let's build
```

## Acceptance Criteria

### Phase 1: Create Onboarding Skills

- [x] Create `skills/start/SKILL.md` with welcome message and three-choice dispatch
  - Frontmatter: name, description, license: MIT
  - Body: warm welcome (~10 lines), three numbered choices, inline dispatch to pathway
- [x] Create `skills/beginner/SKILL.md` with interview-first flow
  - Frontmatter: name, description, license: MIT
  - Body: 7-step flow with warm tone, skill chaining via `skills/[name]/SKILL.md` references
- [x] Create `skills/apprentice/SKILL.md` with collaborative flow
  - Frontmatter: name, description, license: MIT
  - Body: 6-step flow with peer-to-peer tone
- [x] Create `skills/teacher/SKILL.md` with fast-track flow
  - Frontmatter: name, description, license: MIT
  - Body: 6-step flow with efficient tone, batch mode for classify

### Phase 2: Update Documentation

- [x] Update `README.md` Quick Start to reference `start` skill
- [x] Update `AGENTS.md` skill count (10 → 14) and add onboarding skills to directory structure
- [x] Update skills tables in README to include onboarding skills (separate group)

### Phase 3: Verify

- [ ] Run `start` skill in coach repo → welcome message appears, three choices work
- [ ] Select each pathway → correct interview/flow begins
- [ ] Each pathway chains to existing skills without re-asking questions
- [ ] Each pathway hands off to `course-workflow` at the correct phase/status

## Implementation Order

1. `skills/start/SKILL.md` — entry point, testable immediately
2. `skills/beginner/SKILL.md` — most involved, needs iteration
3. `skills/apprentice/SKILL.md` — calibrate once beginner is solid
4. `skills/teacher/SKILL.md` — simplest, mostly compression
5. README.md + AGENTS.md updates
