---
title: "feat: Phase B — Package and distribute Coach"
type: feat
status: active
date: 2026-03-21
origin: docs/brainstorms/2026-03-19-public-sharing-readiness-brainstorm.md
---

# feat: Phase B — Package and distribute Coach

## Overview

Package Coach for installation via built-in plugin management commands across three channels:

1. **Claude Code Plugin Marketplace** — `/plugin install coach@andamio`
2. **npm Package** — `pi install npm:@andamio/coach` (Pi.dev) and `npx skills add andamio-platform/coach` (Vercel Skills CLI)
3. **Community Marketplaces** — automatic indexing by SkillsMP, SkillHub, and Vercel Skills crawlers

This also creates the **Andamio marketplace** — a Claude Code marketplace repo where Coach is the first plugin, with room for future Andamio plugins (CLI tools, platform integrations, etc.).

## Problem Statement / Motivation

Coach has 14 battle-tested skills and a compounding knowledge base, but installation requires cloning the repo and manually configuring agent paths. The target audience — pattern-builders who want to learn compounding AI skills — expects `install` to be a single command.

Phase A delivered the skills and documentation. Phase B makes Coach installable the way modern agent tools expect: a single command in your agent of choice.

(See brainstorm: `docs/brainstorms/2026-03-19-public-sharing-readiness-brainstorm.md` — "Plugin Pathway" section, items 1-5)

## Proposed Solution

### Architecture: The Knowledge Split

The central challenge is that Coach's `knowledge/` directory is both **shipped content** (seed patterns from 7+ courses) and **user-writable state** (accumulated via `/compound`). Package managers treat installed files as immutable; users need knowledge to persist across updates.

**Solution: Seed + Local separation using `${CLAUDE_PLUGIN_DATA}`**

```
Plugin installation (immutable, replaced on update):
  ${CLAUDE_PLUGIN_ROOT}/
    skills/
    knowledge/          ← seed data (read-only reference)
    research/

User data (persistent, survives updates):
  ${CLAUDE_PLUGIN_DATA}/
    knowledge/          ← user-accumulated data (writable)
```

**How skills resolve knowledge:**
1. Read from `${CLAUDE_PLUGIN_DATA}/knowledge/` first (user data)
2. Fall back to `${CLAUDE_PLUGIN_ROOT}/knowledge/` (seed data)
3. If neither exists, proceed without prior patterns (graceful degradation — already implemented)

**First-run initialization:** The `/start` skill detects whether `${CLAUDE_PLUGIN_DATA}/knowledge/` exists. If not, it copies seed data there. This gives users a working knowledge base immediately while making it theirs to accumulate into.

**On update:** Seed data in `${CLAUDE_PLUGIN_ROOT}/knowledge/` refreshes automatically. User data in `${CLAUDE_PLUGIN_DATA}/knowledge/` is untouched. Users who want upstream improvements can manually merge or re-initialize.

**For npm/clone users:** Same pattern, but `knowledge/` stays in the project directory (as today). No behavior change for existing users.

### Three Distribution Channels

#### Channel 1: Andamio Marketplace (Claude Code)

**New repo: `Andamio-Platform/andamio-marketplace`**

```
andamio-marketplace/
  .claude-plugin/
    marketplace.json
  README.md
```

`marketplace.json`:
```json
{
  "name": "andamio",
  "owner": {
    "name": "Andamio",
    "url": "https://andamio.io"
  },
  "metadata": {
    "description": "Plugins for Andamio — contribution-centered learning on Cardano",
    "version": "1.0.0"
  },
  "plugins": [
    {
      "name": "coach",
      "source": {
        "source": "github",
        "repo": "Andamio-Platform/coach"
      },
      "description": "AI-assisted course development with compounding skills — SLTs, lesson types, Fist to Five readiness assessment",
      "version": "1.0.0",
      "author": { "name": "Andamio" },
      "homepage": "https://github.com/Andamio-Platform/coach",
      "repository": "https://github.com/Andamio-Platform/coach",
      "license": "MIT",
      "keywords": ["course-development", "slt", "lesson-design", "compounding-skills", "education"],
      "category": "education",
      "tags": ["course-development", "slt", "education", "compounding-skills", "andamio"]
    }
  ]
}
```

**In the coach repo, add `.claude-plugin/plugin.json`:**

```json
{
  "name": "coach",
  "version": "1.0.0",
  "description": "AI-assisted course development with compounding skills. Draft SLTs, assess quality, classify lesson types, evaluate readiness, build lessons, and compound knowledge.",
  "author": {
    "name": "Andamio",
    "url": "https://andamio.io"
  },
  "homepage": "https://github.com/Andamio-Platform/coach",
  "repository": "https://github.com/Andamio-Platform/coach",
  "license": "MIT",
  "keywords": [
    "course-development",
    "slt",
    "lesson-design",
    "compounding-skills",
    "education",
    "fist-to-five",
    "andamio"
  ]
}
```

**User installation flow:**
```bash
# One-time: add the Andamio marketplace
/plugin marketplace add Andamio-Platform/andamio-marketplace

# Install coach
/plugin install coach@andamio

# Use skills (auto-namespaced by plugin system)
/coach:start
/coach:draft-slts
/coach:assess-slts
```

**Namespacing:** Claude Code automatically namespaces plugin skills as `coach:<skill-name>`. This eliminates collision risk with generic names like `start` and `compile`. No skill renaming needed.

#### Channel 2: npm Package (Pi.dev, Vercel Skills CLI, skills-npm)

**Add `package.json` to coach repo:**

```json
{
  "name": "@andamio/coach",
  "version": "1.0.0",
  "description": "AI-assisted course development with compounding skills — SLTs, lesson types, Fist to Five readiness assessment",
  "license": "MIT",
  "repository": {
    "type": "git",
    "url": "https://github.com/Andamio-Platform/coach.git"
  },
  "homepage": "https://github.com/Andamio-Platform/coach",
  "author": "Andamio <dev@andamio.io> (https://andamio.io)",
  "keywords": [
    "agent-skill",
    "agent-skills",
    "pi-package",
    "pi-skill",
    "course-development",
    "slt",
    "education",
    "compounding-skills"
  ],
  "files": [
    "skills/**",
    "knowledge/**",
    "research/**",
    ".claude-plugin/**",
    "AGENTS.md",
    "CLAUDE.md",
    "LICENSE",
    "README.md"
  ],
  "pi": {
    "skills": ["./skills"]
  }
}
```

**User installation flows:**
```bash
# Pi.dev
pi install npm:@andamio/coach

# Vercel Skills CLI
npx skills add Andamio-Platform/coach

# skills-npm (Anthony Fu's approach — for npm-based projects)
npm install -D @andamio/coach
# Then in package.json scripts: "prepare": "skills-npm"
```

**What ships:** Only `skills/`, `knowledge/`, `research/`, `.claude-plugin/`, and root metadata files. Excludes `docs/`, `scripts/`, `compiled/`, `courses-in-progress/`, `.obsidian/`.

#### Channel 3: Community Marketplaces (Automatic)

These crawl GitHub repos. Requirements for indexing:

| Marketplace | Requirement | Status |
|-------------|-------------|--------|
| **SkillsMP** | Public repo, 2+ stars, SKILL.md files with frontmatter | Skills exist, need stars |
| **SkillHub** | Public repo, SKILL.md files | Already compliant |
| **Vercel Skills** | `skills/` directory or `.claude-plugin/marketplace.json` | `skills/` exists |

**Action items:**
- Add `agent-skill` and `agent-skills` GitHub topics to the repo
- Ensure all 14 SKILL.md frontmatter fields are complete (name, description, license)
- Add `metadata` frontmatter field with `author` and `version` to each skill (optional but improves ranking)

No additional files needed. Once the repo has the plugin manifest and a few stars, crawlers index it automatically.

## Technical Considerations

### Skill Path References

Skills currently reference shared files with paths like:
- `knowledge/slt-patterns/verb-bank.yaml`
- `research/slt-research-report.md`

**In plugin context:** These paths resolve relative to the project working directory, not the plugin root. Skills need to be updated to use `${CLAUDE_PLUGIN_ROOT}/` prefix when running as a plugin.

**Approach:** Each skill's "Pre-Execution Knowledge Check" section gets a path resolution preamble:

```markdown
## Path Resolution

If running as a plugin (`${CLAUDE_PLUGIN_ROOT}` is set):
- Knowledge: `${CLAUDE_PLUGIN_DATA}/knowledge/` (user) → `${CLAUDE_PLUGIN_ROOT}/knowledge/` (seed)
- Research: `${CLAUDE_PLUGIN_ROOT}/research/`

If running from a cloned repo (no plugin context):
- Knowledge: `knowledge/` (relative to project root)
- Research: `research/` (relative to project root)
```

This is backwards-compatible: clone users see no change; plugin users get correct paths.

### .gitignore Update

The `.claude-plugin/` directory must be tracked (currently `.claude/` is gitignored, but `.claude-plugin/` is a different path). Verify this does not conflict.

Current `.gitignore` has `.claude/` — this does NOT match `.claude-plugin/`, so no change needed. The `plugin.json` will be tracked automatically.

### Knowledge Base on npm

For npm, `knowledge/` ships as read-only inside `node_modules/`. The compounding loop does not work from `node_modules/` — this is by design. npm users who want compounding should clone the repo or use the plugin channel.

Document this clearly: "npm installation provides skills and seed knowledge. For the full compounding loop, install via Claude Code plugin or clone the repo."

### Andamio-Specific Skills

The two platform-specific skills (`compile`, `andamio-cli`) already have `compatibility` frontmatter. In the plugin context, they are namespaced as `coach:compile` and `coach:andamio-cli`, making it clear they belong to Coach. No need for a separate "generic-only" package — the skills self-document their requirements.

### Version Strategy

**Semver for a skills-only project:**
- **Major (2.0.0):** Knowledge schema changes that break existing compound data, or skill removals
- **Minor (1.1.0):** New skills, significant instruction rewrites, new knowledge seed patterns
- **Patch (1.0.1):** Wording improvements, typo fixes, minor knowledge corrections

**Starting version: 1.0.0** — the skills have been tested across 7+ courses with 102 SLTs. This is production-grade.

## Acceptance Criteria

### Phase B1: Plugin Manifest and Repo Prep

- [x] Create `.claude-plugin/plugin.json` in coach repo
- [x] Create `package.json` with npm metadata and `files` whitelist
- [x] Create `CHANGELOG.md` (Keep a Changelog format, starting at 1.0.0)
- [x] Add `agent-skill` and `agent-skills` GitHub topics to the repo
- [x] Verify `.gitignore` does not exclude `.claude-plugin/`
- [x] Add `metadata` frontmatter field (author, version) to all 14 SKILL.md files

### Phase B2: Knowledge Architecture

- [x] Update `/start` skill to detect plugin context and initialize `${CLAUDE_PLUGIN_DATA}/knowledge/` from seed data on first run
- [x] Update `/compound` skill to write to `${CLAUDE_PLUGIN_DATA}/knowledge/` when running as plugin
- [x] Update all skills with knowledge reads to use the seed → local fallback pattern
- [x] Add path resolution preamble to each skill's Pre-Execution Knowledge Check
- [ ] Test: fresh plugin install → `/start` → knowledge initialized → `/draft-slts` reads seed data
- [ ] Test: `/compound` → knowledge written to persistent location → survives simulated update

### Phase B3: Andamio Marketplace

- [x] Create `Andamio-Platform/andamio-marketplace` repo on GitHub
- [x] Add `.claude-plugin/marketplace.json` listing coach
- [x] Add `README.md` explaining the marketplace and how to add it
- [ ] Test: `/plugin marketplace add Andamio-Platform/andamio-marketplace` works
- [ ] Test: `/plugin install coach@andamio` installs and skills are accessible as `coach:*`
- [ ] Test: `/coach:start` runs correctly and offers pathway selection

### Phase B4: npm Publish

- [ ] Register `@andamio` org on npm (if not already registered)
- [ ] `npm publish --access public` from coach repo
- [ ] Test: `pi install npm:@andamio/coach` installs and skills are discoverable
- [ ] Test: `npx skills add Andamio-Platform/coach` installs skills
- [x] Document npm limitations (no compounding loop) in README

### Phase B5: Documentation and Launch

- [x] Update README.md "Roadmap" section — mark Phase B complete, add installation commands
- [x] Add "Installation" section to README with all three channels:
  - Claude Code: marketplace add + plugin install
  - Pi.dev: `pi install npm:@andamio/coach`
  - Other agents: `npx skills add` or clone
- [x] Update "Using Coach Skills in Another Project" section — add plugin/npm methods alongside existing git methods
- [x] Update AGENTS.md roadmap status
- [ ] Announce on relevant channels

## Success Metrics

- A Claude Code user can run 2 commands (add marketplace + install plugin) and immediately use `/coach:start`
- A Pi.dev user can `pi install npm:@andamio/coach` and access all 14 skills
- The repo appears in SkillsMP search results within 2 weeks of stars reaching threshold
- Knowledge compounding works correctly for plugin users (persists across updates)
- No breaking changes for existing clone/symlink users

## Dependencies & Risks

- **npm `@andamio` org:** Must be registered. If taken, use `@andamio-platform`.
- **Claude Code plugin validation:** Run `claude plugin validate .` before publishing. Unknown edge cases with skills-only plugins (no hooks, no MCP).
- **`${CLAUDE_PLUGIN_DATA}` behavior:** The persistent data directory is documented but Coach will be an early adopter. Test thoroughly.
- **Community marketplace indexing lag:** SkillsMP and SkillHub crawl on their own schedule. No way to force re-index.
- **Backwards compatibility:** Existing clone/symlink users must not be broken. All changes must be additive.

## Implementation Order

B1 → B2 → B3 → B4 → B5 (sequential — each phase builds on the previous)

B1 is safe to ship immediately (adding manifests doesn't affect existing users). B2 is the main engineering work. B3 and B4 are distribution mechanics. B5 wraps up.

## Sources & References

- **Origin brainstorm:** [docs/brainstorms/2026-03-19-public-sharing-readiness-brainstorm.md](docs/brainstorms/2026-03-19-public-sharing-readiness-brainstorm.md) — key decisions: rename to "coach", Plugin Pathway steps 1-5, audience is pattern-builders
- **Prior Phase B thinking:** [docs/product-operationalizing-slts-plugin-roadmap.md](docs/product-operationalizing-slts-plugin-roadmap.md) — `andamio-slt` plugin structure (pre-rename), extraction requirements
- **Phase A release plan:** [docs/plans/2026-03-19-feat-public-release-as-coach-plan.md](docs/plans/2026-03-19-feat-public-release-as-coach-plan.md) — cleanup completed, Phase 4 shipping
- **Agent Skills specification:** https://agentskills.io/specification — SKILL.md format, frontmatter fields, directory conventions
- **Claude Code plugin reference:** https://code.claude.com/docs/en/plugins-reference — plugin.json schema, `${CLAUDE_PLUGIN_ROOT}`, `${CLAUDE_PLUGIN_DATA}`
- **Claude Code marketplace docs:** https://code.claude.com/docs/en/plugin-marketplaces — marketplace.json format, source types, team auto-install
- **Compound-engineering plugin (reference implementation):** https://github.com/EveryInc/compound-engineering-plugin — monorepo marketplace pattern, plugin.json example, skills + agents + MCP structure
- **Vercel Skills CLI:** https://github.com/vercel-labs/skills — `npx skills add` installation
- **skills-npm:** https://github.com/antfu/skills-npm — npm-based skill distribution via symlinks
- **SkillsMP:** https://skillsmp.com — community marketplace, auto-indexes GitHub repos with 2+ stars
