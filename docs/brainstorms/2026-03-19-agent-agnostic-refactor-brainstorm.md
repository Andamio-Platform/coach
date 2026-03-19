# Brainstorm: Agent-Agnostic Refactor

**Date:** 2026-03-19
**Status:** Draft

## What We're Building

Refactor coach from a Claude Code-specific skills repo into an agent-agnostic skills repo that follows the open [Agent Skills standard](https://agentskills.io). The SKILL.md format is already adopted by 30+ agents (Claude Code, Cursor, GitHub Copilot, Gemini CLI, OpenAI Codex, VS Code, Goose, Roo Code, Mistral Vibe, and more). Coach's skills are already 90% compliant — the refactor is mostly structural and linguistic.

## Why This Approach

The Agent Skills spec (agentskills.io) is the emerging open standard for portable agent capabilities. Coach's SKILL.md format is already nearly compliant. By fully aligning with the spec, coach becomes usable by any developer regardless of their preferred AI agent — massively expanding the audience while maintaining Claude optimization via CLAUDE.md.

## Key Decisions

1. **Move skills to top-level `skills/` directory** — currently in `.claude/skills/`. The open standard doesn't prescribe a path, but top-level is cleanest and most discoverable. Claude Code can be configured to find them there.

2. **Replace "Claude" with "you" in skill instructions** — address the agent as "you" throughout ("Evaluate your readiness to coach..."). Natural instruction style that works for any agent.

3. **Keep CLAUDE.md + add AGENTS.md** — CLAUDE.md stays for Claude users (auto-loaded). Add AGENTS.md as the generic equivalent that other agents can be pointed to. Both reference the same skills and conventions.

4. **Remove `.claude/settings.json` from public repo** — gitignore it alongside `settings.local.json`. Document compound-engineering as an optional power-user addition for Claude Code users. Ship zero agent-specific config.

5. **Add `license: MIT` to all 10 skill frontmatters** — signals open use at the skill level per the spec.

6. **Add `compatibility` field to platform-specific skills only** — `compile` and `andamio-cli` get compatibility notes explaining their Andamio dependencies. Generic skills get no compatibility field (they work everywhere).

7. **Validate skills against the spec** — use `skills-ref validate` to ensure all skills pass the open standard validation.

## Resolved Questions

1. **How do other agents discover skills?** Each agent has its own convention, but the SKILL.md format is universal. Some agents look in specific directories, others can be pointed to any path. A top-level `skills/` directory is the most portable.

2. **Will Claude Code still auto-discover skills if moved from `.claude/skills/`?** Claude Code looks in `.claude/skills/` by default but can be configured via CLAUDE.md or settings to look elsewhere. We may need to add a symlink or CLAUDE.md instruction pointing to `skills/`.

3. **Does the `name` field need to match the directory name?** Yes, per the spec. Coach's current names already comply (lowercase, hyphens, no uppercase).

4. **What about slash commands (`/draft-slts`)?** Slash commands are a Claude Code-specific invocation mechanism. Other agents trigger skills by matching the description to the task. The skills work either way — slash commands are just a shortcut.

## Resolved Questions (continued)

5. **AGENTS.md is the source of truth.** It has all project context (conventions, directory structure, workflow). CLAUDE.md is a thin pointer: "Read AGENTS.md for project context" plus Claude-specific notes (slash commands, settings, plugin tips).

6. **Dedicated "Supported Agents" section in README.** Placed after Quick Start. Lists compatible agents and links to agentskills.io. Not the headline, but prominent enough that people know it's multi-agent.
