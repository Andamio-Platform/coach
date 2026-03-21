# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-03-21

### Added

- Release skill for publishing new versions across all distribution channels
- Plugin-aware path resolution in all knowledge-dependent skills (`${CLAUDE_PLUGIN_ROOT}`, `${CLAUDE_PLUGIN_DATA}`)
- Plugin initialization in `/start` skill — copies seed knowledge on first run
- Knowledge compounding guide (`docs/knowledge-compounding.md`)
- Installation section in README with all three channels (Claude Code, npm, clone)
- Releasing updates guide (`docs/releasing-updates.md`)

### Changed

- Consolidated `research/` into `knowledge/research/` — one parent directory for all compounding content
- Curated knowledge base to generic patterns (120KB → 46KB) — removed Andamio-specific course references while preserving universal SLT quality patterns, verb bank, lesson type heuristics, and calibration rules
- Aligned compounding loop with skills table in README
- Updated setup script to include release skill (15 skills)

### Fixed

- Skills now resolve knowledge paths correctly in both plugin and clone contexts

## [1.0.0] - 2026-03-21

### Added

- 14 agent skills following the [Agent Skills](https://agentskills.io) open standard
  - 4 onboarding skills: `start`, `beginner`, `apprentice`, `teacher`
  - 8 course development skills: `course-workflow`, `draft-slts`, `assess-slts`, `self-assess-readiness`, `classify-lesson-types`, `gather-screenshots`, `gather-code-examples`, `compound`
  - 2 Andamio-specific skills: `compile`, `andamio-cli`
- Compounding knowledge base with patterns from 7+ courses (102 SLTs, 33 verbs, 41 calibration entries)
- SLT research report grounding the framework in Marzano, Stiggins, and Bloom's Taxonomy
- Framework documentation: SLTs as Agentic Interface, Fist to Five for Agents, Dual-Audience Courses
- 12-phase course development workflow
- Multi-repo setup via symlinks (`scripts/setup-course-repo.sh`)
- Claude Code plugin manifest (`.claude-plugin/plugin.json`)
- npm package configuration (`package.json`) for Pi.dev and Vercel Skills CLI compatibility

[1.1.0]: https://github.com/Andamio-Platform/coach/releases/tag/v1.1.0
[1.0.0]: https://github.com/Andamio-Platform/coach/releases/tag/v1.0.0
