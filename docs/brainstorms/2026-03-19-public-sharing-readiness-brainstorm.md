# Brainstorm: Public Sharing as "Coach"

**Date:** 2026-03-19
**Status:** Draft

## What We're Building

A publicly shareable Claude Code skills toolkit called **"coach"** that demonstrates a teacher's approach to compounding AI skills. The Andamio course development workflow is the concrete worked example; the reusable pattern is the compounding skills framework (SLTs, Fist to Five, lesson types, knowledge accumulation).

**Staged rollout:**
1. **Now:** Shareable repo (clone/fork, adapt)
2. **Later:** Installable Claude plugin (`andamio-slt` or similar)

**Target audience:** People interested in the pattern of building compounding AI skills — not necessarily Andamio users or even course developers specifically.

## Why This Approach

The repo already has the concrete implementation. Rather than abstracting away the Andamio specifics, we add a pattern layer on top — framework docs, generic explanations — so people can see both the reusable ideas and a real working example. This is how teachers teach: concrete first, then generalize.

## Key Decisions

1. **Rename to "coach"** — short, memorable, platform-agnostic
2. **Clear git history** — fresh start, removes residual personal paths and artifacts
3. **MIT license** — maximum permissiveness
4. **Both layers** — keep Andamio implementation as worked example, add pattern-level documentation on top
5. **Keep compound-engineering dependency** — document it as inspiration, acknowledge lineage
6. **Audience is pattern-builders** — people learning how to build compounding AI skills, not just Andamio course creators

## Required Cleanup (Before Public)

### Must Fix (Blockers)

| # | Issue | Files | Fix |
|---|-------|-------|-----|
| 1 | Hardcoded `/Users/james/...` paths in 3 skills | `assess-slts/SKILL.md`, `draft-slts/SKILL.md`, `self-assess-readiness/SKILL.md` | Replace with relative path `research/slt-research-report.md` |
| 2 | `.claude/settings.local.json` with personal paths + course ID | `.claude/settings.local.json` | Add to `.gitignore`, remove from tracking |
| 3 | No LICENSE file | root | Add MIT license |
| 4 | `.obsidian/` tracked despite `.gitignore` | `.obsidian/` | `git rm -r --cached .obsidian` |
| 5 | `.DS_Store` files committed | `compiled/`, `courses-in-progress/` | Remove from tracking, fix `.gitignore` pattern |

### Should Fix (Clarity)

| # | Issue | Files | Fix |
|---|-------|-------|-----|
| 6 | Personal `$REPOS/` paths in CLAUDE.md | `CLAUDE.md` lines 100-101 | Replace with generic example paths |
| 7 | Personal paths in docs | `setup-course-repo.md`, `plans/*.md` | Clean up or frame as examples |
| 8 | CLI source path in andamio-cli skill | `andamio-cli/SKILL.md` line 13 | Make generic |
| 9 | "from James" in voice-patterns.md | `voice-patterns.md` line 95 | Remove name |
| 10 | "Stale References" section in CLAUDE.md | `CLAUDE.md` lines 105-110 | Remove (historical noise) |
| 11 | Empty stub directories | `courses-in-progress/`, `compiled/` | Add `.gitkeep` + README or remove |
| 12 | `compound-engineering` plugin undocumented | `.claude/settings.json` | Document in README |
| 13 | No CONTRIBUTING.md | root | Add contribution guidelines |

### Add (Pattern Layer)

| # | What | Purpose |
|---|------|---------|
| 14 | Pattern-level README | Frame the repo for pattern-builders, not just Andamio users |
| 15 | "How to adapt this" guide | Show how to fork and customize for a different platform/domain |
| 16 | Annotate framework docs | Connect existing framework docs to the skills that implement them |

## Plugin Pathway (Phase B)

When ready to evolve from repo to plugin:

1. **Create `plugin.json` manifest** — declare skills, dependencies, metadata
2. **Resolve symlink pattern** — plugins need a different mechanism than symlinking course repos
3. **Version the knowledge base** — ship baseline patterns, let users accumulate their own
4. **Handle the andamio-cli dependency** — declare as optional external dependency
5. **Publish to marketplace** — follow `compound-engineering` as precedent

## Resolved Questions

1. **Knowledge base ships intact with Andamio data.** The Andamio examples are breadcrumbs, not the headline. People come for the compounding skills pattern, discover SLTs, and eventually find "wait, you can put these on-chain?" Long-term strategy: drive unexpected attention toward Andamio by introducing the how and why of SLTs first.

2. **README for humans, CLAUDE.md for Claude.** README covers what this is, how to use it, how to adapt it. CLAUDE.md narrows to agent instructions only (conventions, file paths, workflow rules).

3. **andamio-cli skill included as a worked example** of a platform-specific skill. Annotated that it requires the Andamio CLI binary.

## Narrative Strategy

The public framing is: **"A teacher's approach to compounding AI skills."**

- **Lead with the pattern** — SLTs, Fist to Five, compounding knowledge, lesson types
- **Andamio is the worked example** — concrete, real, not abstracted away
- **Breadcrumb trail** — curious explorers discover SLTs → discover on-chain credentials → discover Andamio
- **Not a pitch** — the repo earns attention by being genuinely useful, not by selling
