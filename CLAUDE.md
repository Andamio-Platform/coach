# CLAUDE.md

Read [AGENTS.md](AGENTS.md) for full project context, conventions, and workflow.

## Claude Code-Specific Notes

**Skill discovery**: Skills live in `skills/` (not `.claude/skills/`). Claude Code will discover them when you work in this repo.

**Slash commands**: Each skill can be invoked as a slash command (e.g., `/draft-slts`, `/assess-slts`). Other agents trigger skills by description matching.

**compound-engineering plugin**: For the best experience, add the [compound-engineering](https://github.com/EveryInc/compound-engineering-plugin) plugin to your `.claude/settings.json`:

```json
{
  "enabledPlugins": {
    "compound-engineering@every-marketplace": true
  }
}
```

This provides Context7 documentation lookup during skill execution. All skills function without it.
