---
title: "feat: Prepare public release as 'coach'"
type: feat
status: active
date: 2026-03-19
origin: docs/brainstorms/2026-03-19-public-sharing-readiness-brainstorm.md
---

# feat: Prepare public release as "coach"

## Overview

Transform this repo from an internal skills toolkit into a publicly shareable reference repo called **"coach"** — a teacher's approach to compounding AI skills. The Andamio course workflow is the concrete worked example; the reusable pattern is the framework (SLTs, Fist to Five, lesson types, knowledge accumulation).

Staged rollout: shareable repo now, installable Claude plugin later (see brainstorm: Phase B roadmap).

## Problem Statement / Motivation

This repo contains 10 battle-tested Claude Code skills, a compounding knowledge base, and framework documentation that embodies a novel approach to AI-assisted course development. It's currently only usable by the author due to hardcoded paths, missing license, and no onboarding for newcomers.

The target audience is **pattern builders** — people interested in how to build compounding AI skills, not necessarily Andamio users. The Andamio thread is a breadcrumb trail: people come for the pattern, discover SLTs, and eventually find on-chain credentials (see brainstorm: Narrative Strategy).

## Proposed Solution

A phased cleanup and documentation effort across 4 phases:

1. **Fix blockers** — remove personal data, add license, fix gitignore
2. **Improve first-run experience** — Quick Start, skill labeling, graceful degradation
3. **Rewrite documentation** — README for humans, CLAUDE.md for Claude, adaptation guide
4. **Ship** — clear git history, create new "coach" repo, archive old one

## Technical Considerations

### Hardcoded Paths

Three skills use absolute paths to `research/slt-research-report.md`. These must become relative paths. Claude Code resolves relative paths from the project root, so `research/slt-research-report.md` works correctly.

### Settings Architecture

- `.claude/settings.local.json` — personal permissions, must be gitignored (never shipped)
- `.claude/settings.json` — currently only enables `compound-engineering` plugin. Keep this and document it as an optional dependency that inspired coach. Users who don't have it won't get Context7 docs lookup but all skills function without it.

### Knowledge File Graceful Degradation

Skills like `/assess-slts` have "Pre-Execution Knowledge Check" steps that read YAML files. For fresh clones where users haven't run `/compound` yet, or for adapters who reset knowledge, skills must handle missing files gracefully. The knowledge base ships with Andamio data, so this only affects adapters who reset it — but the fallback should exist.

### Symlink Limitations

`setup-course-repo.sh` uses `ln -s`, which doesn't work on Windows without WSL or developer mode. Document this as a macOS/Linux tool. Windows users can use WSL or manually copy directories.

### Generic vs. Andamio-Specific Skills

| Category | Skills | Notes |
|----------|--------|-------|
| **Generic** (usable anywhere) | `draft-slts`, `assess-slts`, `self-assess-readiness`, `classify-lesson-types`, `gather-screenshots`, `gather-code-examples`, `compound`, `course-workflow` | 8 of 10 skills are platform-agnostic |
| **Andamio-specific** (worked example) | `compile`, `andamio-cli` | Must be adapted for other platforms |

This classification should be visible in the README skills table.

## Acceptance Criteria

### Phase 1: Fix Blockers

- [x] Replace hardcoded `/Users/james/...` paths in 3 skill files with relative `research/slt-research-report.md`
  - `.claude/skills/assess-slts/SKILL.md` line 34
  - `.claude/skills/draft-slts/SKILL.md` line 44
  - `.claude/skills/self-assess-readiness/SKILL.md` line 39
- [x] Add `.claude/settings.local.json` to `.gitignore`
- [x] Untrack `.obsidian/` directory — already untracked, `.gitignore` covers it
- [x] Fix `.gitignore` to use `**/.DS_Store` pattern and remove tracked `.DS_Store` files
- [x] Add MIT LICENSE file
- [x] Remove personal `$REPOS/...` paths from `CLAUDE.md` lines 99-101
- [x] Remove "Stale References in Skills (Fixed)" section from `CLAUDE.md`
- [x] Clean personal CLI source path from `andamio-cli/SKILL.md` line 13
- [x] Remove "from James" attribution in `knowledge/voice-patterns.md` line 95
- [x] Clean personal paths from `docs/setup-course-repo.md` lines 130-131
- [ ] Remove or clean `docs/plans/2026-02-25-feat-courses-in-progress-directory-structure-plan.md` — kept as-is, internal provenance only
- [ ] Clean up empty `courses-in-progress/` stub directories — untracked, will be excluded in new repo
- [ ] Clean up empty `compiled/` stub directories — untracked, will be excluded in new repo

### Phase 2: Improve First-Run Experience

- [x] Add graceful degradation to skills for missing knowledge files — each "Pre-Execution Knowledge Check" should include: "If this file does not exist, proceed without prior patterns and note 'No prior data available' in output"
  - `assess-slts/SKILL.md`
  - `draft-slts/SKILL.md`
  - `self-assess-readiness/SKILL.md`
  - `classify-lesson-types/SKILL.md`
- [x] Label skills as Generic or Andamio-specific in the README skills table
- [x] Add a "Prerequisites" section to README (Claude Code required, macOS/Linux for symlink setup)
- [x] Document `compound-engineering` plugin as optional/inspirational in README

### Phase 3: Rewrite Documentation

- [x] **README.md** — rewrite for humans with this structure:
  1. What is coach? (1 paragraph — pattern, not product)
  2. Quick Start (clone → run `/draft-slts` with a topic you care about → see the pattern)
  3. The Compounding Loop (how skills feed knowledge back)
  4. Skills table (grouped: Generic / Andamio-specific)
  5. Key Concepts (SLTs, Fist to Five, Lesson Types)
  6. How to Adapt for Your Platform (link to guide)
  7. The Andamio Worked Example (breadcrumb — "this toolkit was built for Andamio courses, which put SLT credentials on-chain")
  8. Research Foundation
  9. Roadmap
  10. License + Contributing
- [x] **CLAUDE.md** — strip to agent-only instructions:
  - Project overview (what this repo is)
  - Directory structure
  - Conventions (SLT format, readiness tiers, lesson types)
  - Workflow phases (reference only, not full explanation)
  - Remove "Active course repos" section (personal)
  - Remove "Stale References" section
  - Keep multi-repo setup reference but make paths generic
- [x] **docs/how-to-adapt.md** — new guide covering:
  - Which skills are generic vs. platform-specific
  - How to modify `compile` for your output format
  - How to reset or seed the knowledge base
  - How to add new lesson types
  - How to modify SLT conventions
- [x] **CONTRIBUTING.md** — minimal: "open an issue first, PRs welcome for skill improvements and knowledge patterns"
- [ ] Annotate framework docs with which skills implement them (brainstorm item #16) — deferred to post-ship

### Phase 4: Ship

- [ ] Create new GitHub repo named `coach` (or `lesson-coach` if `coach` is taken)
- [ ] Initialize with clean `git init` — no history from this repo
- [ ] Copy all cleaned files to new repo
- [ ] Push initial commit
- [ ] Archive old `andamio-lesson-coach-v2` repo
- [ ] Update symlinks in active course repos to point to new location
- [ ] Update CLAUDE.md memory/aliases for new repo path

## Success Metrics

- A new user can clone, run `/draft-slts` with their own topic, and get useful output within 5 minutes
- No personal paths, names, or machine-specific artifacts in the public repo
- Framework docs + adaptation guide make the pattern clear without requiring Andamio knowledge
- Andamio breadcrumbs are present but not prominent — curious explorers find them naturally

## Dependencies & Risks

- **compound-engineering plugin**: documented as optional. Skills function without it; users just lose Context7 docs lookup.
- **andamio-cli binary**: only needed for the Andamio-specific `/andamio-cli` skill. Clearly labeled as platform-specific.
- **Windows support**: symlink setup doesn't work on Windows. Documented as limitation. WSL is the workaround.
- **Risk: knowledge base noise for adapters**: if someone forks and runs `/compound` on their own courses, Andamio-specific calibration data mixes with theirs. Low impact now; may need scoping in plugin phase.

## Sources & References

- **Origin brainstorm:** [docs/brainstorms/2026-03-19-public-sharing-readiness-brainstorm.md](docs/brainstorms/2026-03-19-public-sharing-readiness-brainstorm.md) — key decisions: rename to "coach", MIT license, both layers (pattern + worked example), breadcrumb narrative strategy, audience is pattern-builders
- **Learnings from cardano-xp**: template-to-standalone identity separation patterns (externalize all vendor references, audit with grep before release)
- **Learnings from andamio-app-template**: solutions directory pattern for compounding knowledge
- **Setup script**: `scripts/setup-course-repo.sh` — already clean, no changes needed
- **Framework docs**: `docs/framework-*.md` — excellent and portable, need annotation only
