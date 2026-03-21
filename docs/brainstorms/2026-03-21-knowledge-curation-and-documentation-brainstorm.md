# Brainstorm: Knowledge Base Curation and Documentation

**Date:** 2026-03-21
**Status:** Draft

## What We're Building

Curate the shipped `knowledge/` directory to contain only generic, platform-agnostic patterns and add documentation that clearly explains how compounding works and how users make it their own.

This is NOT about gitignoring knowledge — the directory stays tracked. It's about ensuring the seed data helps rather than overwhelms new users, and that the documentation makes the compounding process transparent.

## Why This Approach

The knowledge base currently contains 120KB of data from 7+ Andamio courses. While the patterns are real and battle-tested, much of it is Andamio-specific: course slugs like `go-pbl:099.1`, platform calibration entries, Andamio CLI import gotchas. For non-Andamio users, this is noise that obscures the universal value.

**Goal:** A new user clones coach, sees a knowledge base with useful universal patterns (verb effectiveness, Bloom's mappings, lesson type heuristics), and understands immediately that running `/compound` on their own courses will grow these patterns for their context.

## Key Decisions

1. **Keep knowledge/ tracked in git.** Not gitignored. Seed data ships with the repo and the npm package.

2. **Curate to generic patterns only.** Strip Andamio-specific course references (course slugs, platform-specific calibration, CLI import gotchas). Keep universal patterns:
   - Verb bank with Bloom's level mappings and success counts (generic)
   - Quality issue patterns with examples (generic)
   - Successful rewrite patterns (genericize course references)
   - Lesson type heuristics and edge cases (generic)
   - Voice/style patterns (generic)
   - Readiness calibration structure (keep schema, strip Andamio-specific entries)
   - Context leverage structure (keep schema, strip Andamio-specific resources)

3. **Document compounding in two places:**
   - README: Brief "Knowledge Compounding" section explaining seed data, `/compound`, and linking to the full guide
   - `docs/knowledge-compounding.md`: Full guide covering seed vs user data, how `/compound` works, how to reset, how to curate, how patterns flow between skills

4. **Preserve Andamio knowledge for Andamio course repos.** The curated generic seed ships with coach. The full Andamio-specific knowledge can live in Andamio course repos that symlink to coach (or be restored from git history if needed).

## What to Curate

### Files to genericize (strip course-specific references, keep patterns)

| File | What to keep | What to strip |
|------|-------------|---------------|
| `slt-patterns/verb-bank.yaml` | All verbs with Bloom's levels and success counts | Strip `example_slts` that reference Andamio courses by name |
| `slt-patterns/quality-issues.yaml` | Pattern descriptions, impacts, example bad/fix | Strip `courses_seen_in` arrays, genericize examples |
| `slt-patterns/successful-rewrites.yaml` | Before/after pairs, issue types, key changes | Strip `course` field or replace with generic label |
| `lesson-types/heuristics.yaml` | Verb patterns, subject patterns, confidence levels | Strip course-specific examples, keep generic ones |
| `lesson-types/edge-cases.yaml` | Deciding factors, discriminating questions | Strip course slugs |
| `voice-patterns.md` | All style guidance | Already generic |
| `lesson-writing/style-patterns.yaml` | Anti-patterns and acceptable patterns | Already generic |

### Files to reduce to schema + minimal examples

| File | Reason |
|------|--------|
| `readiness/calibration.yaml` | Entries are all Andamio SLT-specific. Keep schema with 1-2 example entries showing the format. |
| `readiness/context-leverage.yaml` | Resources are Andamio-specific. Keep schema with 1-2 generic examples. |
| `compile/import-gotchas.yaml` | Entirely Andamio CLI-specific. Keep schema with 1 example showing the format. |

### Files to update

| File | Change |
|------|--------|
| `index.yaml` | Reset stats to reflect curated seed data counts. Update `last_updated`. |

## Open Questions

*None — all resolved during discussion.*

## Resolved Questions

1. **Should knowledge/ be gitignored?** No. Keep it tracked. The seed data is valuable and ships with npm/plugin.
2. **How much seed data to ship?** Generic patterns only. Strip Andamio-specific references.
3. **Where to document compounding?** Both: brief in README, full guide at `docs/knowledge-compounding.md`.
4. **What happens to Andamio-specific knowledge?** Lives in Andamio course repos or can be restored from git history.
