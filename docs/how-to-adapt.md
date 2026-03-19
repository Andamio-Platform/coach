# How to Adapt Coach for Your Platform

Coach was built for Andamio courses, but 12 of 14 skills are platform-agnostic. This guide explains how to adapt it for your own learning platform or course format.

## What's Generic vs. Platform-Specific

### Generic (works anywhere)

These skills operate on SLTs, knowledge patterns, and lesson structures — none of which require a specific platform:

| Skill | What it does |
|-------|-------------|
| `draft-slts` | Drafts "I can..." learning targets from your topic and audience |
| `assess-slts` | Evaluates SLT quality across 5 dimensions |
| `self-assess-readiness` | Rates coaching readiness per SLT |
| `classify-lesson-types` | Classifies SLTs into lesson types (Product Demo, Developer Documentation, etc.) |
| `gather-screenshots` | Creates screenshot checklists for Product Demo lessons |
| `gather-code-examples` | Creates code example checklists for Developer Documentation lessons |
| `compound` | Extracts patterns from completed courses into `knowledge/` |
| `course-workflow` | Orchestrates the full workflow across all skills |

### Platform-Specific (need adaptation)

| Skill | What to change |
|-------|---------------|
| `compile` | Rewrite to match your platform's import format. Currently produces Andamio's Tiptap JSON format with specific YAML frontmatter conventions. |
| `andamio-cli` | Replace with your platform's CLI or API integration. This skill manages authentication, module creation, and content import for Andamio specifically. |

## Step-by-Step Adaptation

### 1. Fork and Clone

```bash
git clone https://github.com/YOUR-ORG/coach.git
cd coach
```

### 2. Rewrite the Compile Skill

The compile skill at `skills/compile/SKILL.md` converts course content into your platform's import format. Read the existing skill to understand the structure, then rewrite the output format section.

Key things to change:
- Output file format (Andamio uses Tiptap JSON; you might use Markdown, HTML, SCORM, etc.)
- Frontmatter conventions (module codes, SLT references)
- Asset handling (image CDN, file uploads)

### 3. Replace or Remove the CLI Skill

If your platform has a CLI or API:
- Rewrite `skills/andamio-cli/SKILL.md` to wrap your platform's tools
- Update authentication flow, import commands, and query patterns

If your platform doesn't have a CLI:
- Delete the `andamio-cli` skill directory
- Remove it from the skills table in AGENTS.md and README.md
- The workflow still works — you'll just import content manually

### 4. Modify SLT Conventions (Optional)

If your platform uses different terminology:
- Update the SLT format in AGENTS.md (currently "I can..." phrasing)
- Adjust `research/slt-research-report.md` if your learning outcomes follow a different framework
- The verb bank in `knowledge/slt-patterns/verb-bank.yaml` uses Bloom's Taxonomy — adapt if your curriculum framework differs

### 5. Add New Lesson Types (Optional)

The five lesson types (Product Demo, Developer Documentation, How To Guide, Organization Onboarding, Exploration) are defined in the `classify-lesson-types` skill. To add a new type:

1. Edit `skills/classify-lesson-types/SKILL.md`
2. Add your lesson type to the classification options
3. Add discriminating questions that distinguish it from existing types
4. Run `/compound` after building courses with the new type to extract heuristics

### 6. Reset or Keep the Knowledge Base

The `knowledge/` directory ships with patterns from Andamio courses. You have three options:

**Keep as examples**: Leave the data as-is. Your own patterns will be added alongside when you run `/compound`. The Andamio data provides useful starting points for verb selection and quality assessment.

**Reset to structure only**: Delete the content of YAML files but keep the file structure. Skills will proceed without prior data (they handle missing data gracefully).

**Start completely fresh**: Delete all files in `knowledge/` except `index.yaml`. The `/compound` skill will recreate files as you build courses.

## Lesson Types as Skills

If you build an authoring skill for a specific lesson type, consider contributing it back — the lesson type framework is the most reusable part of coach.

## Questions?

Open an issue on the repo.
