# Knowledge Compounding Guide

How the knowledge base works, what each file stores, and how to make it yours.

## How It Works

Every skill reads from `knowledge/` before running. The `/compound` skill writes back to `knowledge/` after you complete a course phase. Each course you build makes the next one better.

```
Skills read knowledge → You build a course → /compound extracts patterns → Knowledge grows → Skills read updated knowledge
```

## Seed Data

Coach ships with generic patterns extracted from 7+ real courses:

| File | What it stores | Seed entries |
|------|---------------|-------------|
| `slt-patterns/verb-bank.yaml` | Effective verbs by Bloom's level with success counts | 33 verbs |
| `slt-patterns/quality-issues.yaml` | Common SLT quality problems and how to detect them | 6 patterns |
| `slt-patterns/successful-rewrites.yaml` | Before/after SLT improvement examples | 15 rewrites |
| `readiness/calibration.yaml` | Self-assessment accuracy data and adjustment rules | 3 examples + 11 rules |
| `readiness/context-leverage.yaml` | Which resource types unlock the most SLTs | 4 examples |
| `lesson-types/heuristics.yaml` | Verb and subject patterns for lesson type classification | 33 heuristics |
| `lesson-types/edge-cases.yaml` | Ambiguous classifications and how they were resolved | 1 case + 1 pattern |
| `lesson-writing/style-patterns.yaml` | Writing anti-patterns and acceptable patterns | 9 anti-patterns |
| `compile/import-gotchas.yaml` | File format validation issues caught during platform import | 2 patterns |
| `voice-patterns.md` | Prose style guide for lesson writing | Full guide |
| `research/slt-research-report.md` | Education research grounding (Bloom's, Marzano, Stiggins) | Full report |

All platform-specific references have been removed. The seed data is useful regardless of which platform you're building courses for.

## How Skills Use Knowledge

| Skill | Reads | Uses it for |
|-------|-------|-------------|
| `/draft-slts` | verb-bank, quality-issues | Prefer effective verbs, avoid known problems |
| `/assess-slts` | quality-issues, successful-rewrites | Flag known issues, suggest proven fixes |
| `/self-assess-readiness` | calibration, context-leverage | Adjust confidence, prioritize context shopping |
| `/classify-lesson-types` | heuristics, edge-cases | Improve initial guesses, handle known ambiguities |

## How /compound Writes Knowledge

After completing a course phase, run `/compound` with the phase name:

```
/compound quality-review    # Extract from SLT quality review
/compound readiness         # Extract from readiness assessment
/compound classification    # Extract from lesson type classification
/compound lesson-build      # Extract from completed lessons
/compound context-add       # Extract from newly added context
/compound --course=slug --rollup  # Full course retrospective
```

Each phase writes to specific files:

| Phase | Writes to |
|-------|-----------|
| quality-review | successful-rewrites, quality-issues, verb-bank |
| readiness | context-leverage, calibration |
| classification | heuristics, edge-cases |
| lesson-build | calibration (updates self-assessed vs actual) |
| context-add | context-leverage (updates effectiveness) |

The `/compound` skill always reads before writing — it increments counts, appends entries, and merges patterns. It never overwrites existing data.

## Making It Yours

### Add your patterns

Just build courses and run `/compound`. Your data accumulates alongside the seed data automatically.

### Reset to blank

To start with an empty knowledge base:

1. Delete the `entries:` or `rewrites:` content from each YAML file (keep the schema headers and comments)
2. Reset `index.yaml` stats to 0
3. Run `/compound` on your first course to begin building your own patterns

### Curate the seed data

If some seed patterns don't apply to your domain:

- Edit individual YAML files to remove entries that aren't relevant
- Keep the file structure intact — skills expect specific files to exist
- Files that don't exist are handled gracefully (skills proceed without prior patterns)

## Where Knowledge Lives

Where your accumulated patterns are stored depends on how you installed Coach:

| Installation | Knowledge location | Shared across projects? |
|-------------|-------------------|------------------------|
| **Clone into a project** | `./knowledge/` in the cloned repo | No — each project has its own |
| **Symlink setup** (multi-repo) | Coach repo's `knowledge/` | Yes — all symlinked projects share one knowledge base |
| **Claude Code plugin** | `~/.claude/plugins/data/{coach}/knowledge/` | Yes — all projects compound into one place |
| **npm install** | `node_modules/@andamio/coach/knowledge/` (read-only) | No — compounding doesn't persist |

**Plugin users:** Your knowledge is shared across every project you use Coach in. Patterns from one course improve every future course. This works well because the knowledge is domain-agnostic — verb effectiveness, quality issues, and lesson type heuristics apply regardless of subject matter.

**Clone users who want shared knowledge:** Use the symlink setup (`scripts/setup-course-repo.sh`). All course repos symlink back to one Coach installation, so knowledge compounds across projects.

**Clone users who want isolation:** Clone Coach into each project separately. Each project builds its own knowledge base from scratch.

### Plugin details

- **Seed data** lives at `${CLAUDE_PLUGIN_ROOT}/knowledge/` (immutable, replaced on update)
- **Your data** lives at `${CLAUDE_PLUGIN_DATA}/knowledge/` (persistent, survives updates)
- The `/start` skill initializes your data directory from seed data on first run
- The `/compound` skill writes to your data directory, not the plugin's seed data
