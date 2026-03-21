---
title: "refactor: Consolidate compounding directories under knowledge/"
type: refactor
status: active
date: 2026-03-21
origin: docs/brainstorms/2026-03-21-knowledge-curation-and-documentation-brainstorm.md
---

# refactor: Consolidate compounding directories under knowledge/

## Overview

Move `research/` into `knowledge/` so all compounding-related content lives under one parent directory. Curate the knowledge base to generic patterns. Add documentation explaining how compounding works and how users make it their own.

## Problem Statement / Motivation

Coach has two top-level directories that serve the compounding loop: `knowledge/` (patterns written by `/compound`) and `research/` (SLT research report read by 3 skills). Having them separate is a minor organizational friction — new users see two directories and don't immediately understand they're part of the same system.

The brainstorm also decided to curate `knowledge/` to generic patterns only, stripping Andamio-specific course references. This refactor is the right time to do both: consolidate the structure and curate the content.

(See brainstorm: `docs/brainstorms/2026-03-21-knowledge-curation-and-documentation-brainstorm.md` — key decisions: keep tracked, curate to generic, document in README + full guide)

## Proposed Solution

### Directory Change

```
Before:
  knowledge/          # Compounding patterns
  research/           # SLT research report

After:
  knowledge/
    research/         # Moved here — SLT research report
    slt-patterns/     # Unchanged
    readiness/        # Unchanged
    lesson-types/     # Unchanged
    lesson-writing/   # Unchanged
    compile/          # Unchanged
    index.yaml        # Unchanged
    voice-patterns.md # Unchanged
```

One directory. One concept. Everything the skills read from and write to lives under `knowledge/`.

### Content Curation

Strip Andamio-specific references from knowledge files while preserving universal patterns. (See brainstorm for the full file-by-file curation table.)

### Documentation

- README: expand Knowledge Compounding section with "Making It Yours" guidance
- New `docs/knowledge-compounding.md`: full guide on seed data, `/compound`, reset, curation

## Technical Considerations

### Reference Updates

84 references to `knowledge/` and 29 references to `research/` across 17 files. The `research/` → `knowledge/research/` rename requires updating:

**Skills (path resolution sections + inline references):**
- `skills/assess-slts/SKILL.md` — 3 references to `research/`
- `skills/draft-slts/SKILL.md` — 3 references to `research/`
- `skills/self-assess-readiness/SKILL.md` — 3 references to `research/`
- `skills/classify-lesson-types/SKILL.md` — 2 references to `research/`

**Docs:**
- `README.md` — 2 references
- `AGENTS.md` — 1 reference
- `docs/how-to-adapt.md` — 1 reference
- `docs/setup-course-repo.md` — 3 references

**Package config:**
- `package.json` — `files` array includes `"research/**"`, change to `"knowledge/**"` (already covered)

**Plan/brainstorm docs** — these are historical records; update only if they contain instructions that would be followed, otherwise leave as-is.

### Plugin Path Resolution

The B2 path resolution preambles in skills already reference `${CLAUDE_PLUGIN_ROOT}/research/`. These become `${CLAUDE_PLUGIN_ROOT}/knowledge/research/`. Same pattern, just a deeper path.

### Setup Script

`scripts/setup-course-repo.sh` creates a `research` symlink. This becomes unnecessary since `research/` is now inside `knowledge/` — the existing `knowledge` symlink covers it. The script needs updating.

### npm Package

`package.json` `files` array currently has both `"knowledge/**"` and `"research/**"`. After the move, `"research/**"` can be removed since `"knowledge/**"` catches everything.

### Git History

Use `git mv research knowledge/research` to preserve history.

## Acceptance Criteria

### Phase 1: Move research/ into knowledge/

- [ ] `git mv research knowledge/research`
- [ ] Update `package.json` — remove `"research/**"` from `files` array
- [ ] Update `scripts/setup-course-repo.sh` — remove research symlink
- [ ] Update all skill Path Resolution sections: `research/` → `knowledge/research/`
- [ ] Update all skill inline references: `research/slt-research-report.md` → `knowledge/research/slt-research-report.md`
- [ ] Update `README.md` references
- [ ] Update `AGENTS.md` directory structure and references
- [ ] Update `docs/how-to-adapt.md`
- [ ] Update `docs/setup-course-repo.md`
- [ ] Verify: `grep -r "research/" skills/ --include="*.md"` returns only `knowledge/research/` paths

### Phase 2: Curate knowledge to generic patterns

- [ ] `slt-patterns/verb-bank.yaml` — strip Andamio course names from `example_slts`
- [ ] `slt-patterns/quality-issues.yaml` — strip `courses_seen_in`, genericize examples
- [ ] `slt-patterns/successful-rewrites.yaml` — strip `course` field or replace with generic label
- [ ] `readiness/calibration.yaml` — reduce to schema + 2-3 example entries
- [ ] `readiness/context-leverage.yaml` — reduce to schema + 2-3 generic examples
- [ ] `lesson-types/heuristics.yaml` — strip course-specific examples, keep generic
- [ ] `lesson-types/edge-cases.yaml` — strip course slugs
- [ ] `compile/import-gotchas.yaml` — reduce to schema + 1 example
- [ ] `index.yaml` — reset stats to reflect curated counts, update `last_updated`
- [ ] `voice-patterns.md` — already generic, no changes needed
- [ ] `lesson-writing/style-patterns.yaml` — already generic, no changes needed

### Phase 3: Documentation

- [ ] Expand README "Knowledge Compounding" section with "Making It Yours" guidance
- [ ] Create `docs/knowledge-compounding.md` — full guide: seed vs user data, how `/compound` works, how to reset, how to curate
- [ ] Update README directory tree to show `knowledge/research/`
- [ ] Update AGENTS.md directory structure

## Success Metrics

- A new user sees one `knowledge/` directory and understands the compounding system
- No Andamio course slugs in shipped knowledge files
- The knowledge base still provides useful seed patterns (verb bank, lesson type heuristics, quality issues)
- All skills resolve paths correctly after the move
- `npm pack --dry-run` shows correct file list

## Dependencies & Risks

- **npm version bump required.** This changes the package contents — needs a minor version bump and re-publish.
- **Marketplace version bump.** The andamio-marketplace entry needs updating after publish.
- **Existing clone users.** Anyone who cloned before this change will need to `git pull`. The `research/` directory disappears at the top level. Low risk — the repo has few users currently.
- **Andamio course repos with symlinks.** Any course repo that symlinked `research/` separately will need updating. The setup script handles this going forward.

## Sources & References

- **Origin brainstorm:** [docs/brainstorms/2026-03-21-knowledge-curation-and-documentation-brainstorm.md](docs/brainstorms/2026-03-21-knowledge-curation-and-documentation-brainstorm.md) — key decisions: keep tracked, curate to generic, document in README + full guide
- **Phase B plan:** [docs/plans/2026-03-21-feat-phase-b-package-and-distribute-plan.md](docs/plans/2026-03-21-feat-phase-b-package-and-distribute-plan.md) — plugin path resolution architecture
- **Release guide:** [docs/releasing-updates.md](docs/releasing-updates.md) — version bump process for all channels
