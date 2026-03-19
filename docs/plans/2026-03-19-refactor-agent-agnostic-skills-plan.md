---
title: "refactor: Make skills agent-agnostic per Agent Skills open standard"
type: refactor
status: active
date: 2026-03-19
origin: docs/brainstorms/2026-03-19-agent-agnostic-refactor-brainstorm.md
---

# refactor: Make skills agent-agnostic per Agent Skills open standard

## Overview

Refactor coach from a Claude Code-specific skills repo to an agent-agnostic one following the [Agent Skills open standard](https://agentskills.io). The SKILL.md format is already adopted by 30+ agents (Claude Code, Cursor, GitHub Copilot, Gemini CLI, OpenAI Codex, VS Code, Goose, Roo Code, and more). Coach's skills are already 90% spec-compliant — this refactor is structural (move skills) and linguistic (replace "Claude" with "you").

## Problem Statement / Motivation

Coach currently lives in `.claude/skills/` with Claude-specific language throughout. This limits the audience to Claude Code users. The Agent Skills spec is an open standard that makes these same SKILL.md files portable across 30+ agents. By aligning with the standard, coach's audience expands from "Claude Code users interested in compounding skills" to "anyone using any AI agent for course development."

(See brainstorm: Narrative Strategy from the public-sharing brainstorm — breadcrumb trail to Andamio works better with a wider audience.)

## Proposed Solution

Four phases of work:

1. **Move skills** — `.claude/skills/` → top-level `skills/`
2. **Update language** — replace "Claude" with "you" in skill instructions
3. **Add spec fields** — `license: MIT` on all skills, `compatibility` on platform-specific ones
4. **Restructure docs** — AGENTS.md as source of truth, thin CLAUDE.md, update README

## Technical Considerations

### Skill Directory Move

The Agent Skills spec doesn't prescribe a discovery path — each agent has its own convention. A top-level `skills/` directory is the most portable and discoverable. Claude Code users can configure discovery via CLAUDE.md or by adding a `.claude/skills/` symlink.

### Claude-Specific Language Audit

From research, "Claude" appears in these tracked files:

| File | Lines | What to change |
|------|-------|---------------|
| `self-assess-readiness/SKILL.md` | 3, 9 | "Claude's readiness" → "your readiness" |
| `README.md` | 3, 12, 45, 76, 136, 141, 155 | Multiple references — generalize |
| `docs/how-to-adapt.md` | 15, 40, 50 | Path refs + "Claude's coaching readiness" |
| `docs/framework-fist-to-five-for-agents.md` | 32, 34, 40, 178+ | Conceptual discussion — keep "Claude" where it's a proper noun in framework history, change to "agent" where it's generic |
| `docs/framework-slts-as-agentic-interface.md` | 9, 201 | Similar treatment as above |
| `CLAUDE.md` | 3, 7, 14, 75 | This file stays Claude-specific (that's its purpose) |

### Spec Compliance (Already Passing)

All 10 skills pass the Agent Skills spec validation:
- Directory names match `name` fields
- Names are lowercase, hyphens only, 13-24 chars
- Descriptions are 62-148 chars (under 1024 limit)

### Settings Architecture

`.claude/settings.json` (currently tracks compound-engineering plugin) will be gitignored. Power users can add it locally. Documentation will explain the setup for Claude Code users who want the full experience.

### Setup Script Update

`scripts/setup-course-repo.sh` currently symlinks `.claude/skills/` — needs to symlink `skills/` instead.

## Acceptance Criteria

### Phase 1: Move Skills to Top-Level

- [ ] Create `skills/` directory at repo root
- [ ] Move all 10 skill directories from `.claude/skills/` to `skills/`
  - `skills/andamio-cli/`
  - `skills/assess-slts/`
  - `skills/classify-lesson-types/`
  - `skills/compile/`
  - `skills/compound/`
  - `skills/course-workflow/`
  - `skills/draft-slts/`
  - `skills/gather-code-examples/`
  - `skills/gather-screenshots/`
  - `skills/self-assess-readiness/`
- [ ] Update `scripts/setup-course-repo.sh` to symlink `skills/` instead of `.claude/skills/`
- [ ] Add `.claude/settings.json` to `.gitignore`
- [ ] Remove `.claude/settings.json` from tracking (`git rm --cached`)

### Phase 2: Update Language

- [ ] Replace "Claude" with "you" in skill instructions (body content):
  - `skills/self-assess-readiness/SKILL.md` lines 3, 9 — "Assess your readiness...", "Evaluates your own readiness..."
- [ ] Update README.md Claude-specific language:
  - Line 3: "Ten Claude Code skills" → "Ten agent skills" or similar
  - Line 12: "Open Claude Code and try" → "Open your AI agent and try"
  - Line 45: "Evaluates Claude's coaching readiness" → "Evaluates coaching readiness per SLT"
  - Line 76: "Can Claude do this?" → "Can this agent do this?" (keep the pedagogical point)
  - Line 136: Prerequisites — list "Any Agent Skills-compatible tool" instead of just Claude Code
  - Lines 141, 155: Remove Claude-specific plugin and marketplace references
- [ ] Update `docs/how-to-adapt.md`:
  - Change `.claude/skills/` path references to `skills/`
  - Replace "Claude's coaching readiness" with "coaching readiness"
- [ ] Update framework docs (light touch — keep "Claude" where it's historical context):
  - `docs/framework-fist-to-five-for-agents.md`: Change generic "Claude" to "the agent" or "you" where it's used as a placeholder for any agent. Keep "Claude" where it refers to specific implementation history.
  - `docs/framework-slts-as-agentic-interface.md`: Same treatment

### Phase 3: Add Spec Fields

- [ ] Add `license: MIT` to all 10 skill frontmatters
- [ ] Add `compatibility` field to platform-specific skills:
  - `compile/SKILL.md`: `compatibility: Designed for Andamio platform. Adapt output format for other learning platforms.`
  - `andamio-cli/SKILL.md`: `compatibility: Requires the Andamio CLI binary (andamio). See andamio.io for installation.`
- [ ] Validate all skills with `skills-ref validate` (if available) or manual check against spec

### Phase 4: Restructure Documentation

- [ ] Create `AGENTS.md` as the source of truth for all agents:
  - Project overview (what coach is)
  - Directory structure (updated to show `skills/` not `.claude/skills/`)
  - Conventions (SLT format, readiness tiers, lesson types, writing style)
  - Workflow phases (12-phase reference)
  - Multi-repo setup
  - Skill dependencies and knowledge compounding
- [ ] Rewrite `CLAUDE.md` as thin pointer:
  - "Read AGENTS.md for project context"
  - Claude-specific notes: slash command invocations, how to add compound-engineering plugin, how Claude Code discovers skills in `skills/`
- [ ] Update `README.md`:
  - Add "Supported Agents" section after Quick Start listing compatible agents and linking to agentskills.io
  - Update Quick Start to be agent-agnostic ("Open your AI coding agent and try...")
  - Update Prerequisites to list any Agent Skills-compatible tool
  - Remove compound-engineering plugin reference from public docs
  - Add note in a "For Claude Code Users" subsection explaining how to configure for best experience
- [ ] Update `CLAUDE.md` directory structure to show `skills/` not `.claude/skills/`
- [ ] Update all internal references from `.claude/skills/` to `skills/`

## Success Metrics

- All 10 skills pass Agent Skills spec validation (name, description, frontmatter)
- No "Claude" references in skill SKILL.md files (except in brainstorm/plan docs which are historical)
- README and AGENTS.md make no assumptions about which agent the user is running
- A Cursor/Copilot/Gemini CLI user can clone the repo, point their agent to `skills/`, and run `/draft-slts` successfully
- CLAUDE.md still provides an optimized experience for Claude Code users

## Dependencies & Risks

- **Claude Code skill discovery**: Moving from `.claude/skills/` to `skills/` means Claude Code won't auto-discover skills. CLAUDE.md must instruct Claude Code to look in `skills/`. Alternatively, the setup can symlink `skills/` → `.claude/skills/`.
- **Slash commands**: `/draft-slts` syntax is Claude Code-specific. Other agents trigger skills by description matching. The skills work either way — this is just a UX difference, not a blocker.
- **Framework docs**: Some framework docs use "Claude" as a proper noun in their conceptual arguments. Changing these to "agent" may lose the historical context. Light touch recommended — only change where "Claude" is used as a generic placeholder.
- **Setup script**: The symlink paths change. Active course repos using the old symlinks will need to re-run the setup script.

## Sources & References

- **Origin brainstorm:** [docs/brainstorms/2026-03-19-agent-agnostic-refactor-brainstorm.md](docs/brainstorms/2026-03-19-agent-agnostic-refactor-brainstorm.md) — key decisions: top-level `skills/`, "you" language, AGENTS.md as source of truth, gitignore `.claude/settings.json`, license+compatibility fields
- **Agent Skills specification:** https://agentskills.io/specification
- **Agent Skills overview:** https://agentskills.io/home
- **Claude Agent Skills docs:** https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview
- **Prior plan:** [docs/plans/2026-03-19-feat-public-release-as-coach-plan.md](docs/plans/2026-03-19-feat-public-release-as-coach-plan.md) — public release prep (Phase 1-3 complete)
