# Setting Up a Course Repo with Lesson Coach Skills

This guide explains how to set up a standalone course repository that uses lesson-coach skills while compounding knowledge back to the shared knowledge base.

## Quick Setup (for colleagues)

After cloning both repos:

```bash
cd /path/to/your-course-repo
/path/to/coach/scripts/setup-course-repo.sh /path/to/coach
```

Or set the environment variable once in your shell profile:
```bash
export LESSON_COACH_PATH="$HOME/path/to/coach"
```

Then just:
```bash
cd /path/to/your-course-repo
$LESSON_COACH_PATH/scripts/setup-course-repo.sh
```

## Pattern Overview

```
lesson-coach/                    # Skills + knowledge source of truth
├── skills/              # 14 agent skills
├── knowledge/                   # Compounding knowledge base
├── research/                    # SLT research and frameworks
└── ...

course-repo/                     # Standalone course content
├── skills/ -> symlinks  # Points to lesson-coach skills
├── knowledge/ -> symlink        # Points to lesson-coach knowledge
├── research/ -> symlink         # Points to lesson-coach research
├── 00-course.md                 # Course metadata + outline
├── 01-slts.md                   # Working SLT file
├── 04-readiness-assessment.md   # Coaching readiness
├── lessons/                     # Course content
└── ...
```

**Key insight:** Skills run in the course repo context, but knowledge compounds back to lesson-coach. All courses contribute to one shared knowledge base.

## Setup Script

The setup script lives at `scripts/setup-course-repo.sh` in the lesson-coach repo.

**What it does:**
1. Creates `skills/` directory in the course repo
2. Symlinks all 14 coach skills
3. Symlinks `knowledge/` and `research/` directories

**Re-running is safe** - it removes old symlinks before creating new ones.

**Important:** Add symlinks to `.gitignore` (they're machine-specific):
```gitignore
# Lesson Coach symlinks (machine-specific, recreated via setup script)
knowledge
research
skills/
```

## Required Course Files

After running the setup script, create these files:

### `00-course.md`

```yaml
---
course: Course Name
credential: Credential Name
audience: Who this course is for
duration: Estimated time
prerequisites: What learners need first
status: slts-drafted  # or readiness-assessed, building, complete
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
notes: Current status notes
---

# Course Name

## Course Purpose
...

## Modules
### Module 1: ...
- **1.1**: I can...
```

### `01-slts.md`

Working file for SLT drafting and revision. Start with your SLTs here, then copy finalized versions to `00-course.md`.

## Workflow

1. **Draft SLTs** in `01-slts.md`
2. **Run `/assess-slts`** to quality review
3. **Run `/self-assess-readiness`** to assess coaching capability
4. **Run `/classify-lesson-types`** to categorize lessons
5. **Gather context** for "Needs Context" SLTs (use `/gather-screenshots`, `/gather-code-examples`)
6. **Build lessons** in `lessons/`
7. **Run `/compile`** to package for Andamio import format
8. **Run `/andamio-cli`** to import compiled modules to the platform
9. **Run `/compound`** to extract patterns (writes to shared knowledge base)

## All 14 Skills

| Skill | Invocation | Phase | Purpose |
|-------|-----------|-------|---------|
| `course-workflow` | `/course-workflow` | Orchestration | Tracks status, recommends next step |
| `draft-slts` | `/draft-slts` | 1 | Generates SLTs from topic + audience + goals |
| `assess-slts` | `/assess-slts` | 2 | Quality review across 5 dimensions |
| `classify-lesson-types` | `/classify-lesson-types` | 4 | Categorize SLTs by lesson type |
| `self-assess-readiness` | `/self-assess-readiness` | 5 | Coaching readiness per SLT |
| `gather-screenshots` | `/gather-screenshots` | 7 | Screenshot checklists for Product Demo |
| `gather-code-examples` | `/gather-code-examples` | 7 | Code example checklists for Dev Docs |
| `compile` | `/compile` | 9 | Package module for Andamio import format |
| `andamio-cli` | `/andamio-cli` | 10 | Import/export via CLI, manage platform content |
| `compound` | `/compound` | 11 | Extract patterns into knowledge base |

## Example Course Repos

| Repo | Status |
|------|--------|
| Andamio Lesson Coach Content | active (8 courses) |
| Cardano Go PBL 2026 | readiness-assessed |

*Add your course repos to this table as you set them up.*
