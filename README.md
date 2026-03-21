# Coach

## Installation

### Claude Code (plugin)

```
/plugin marketplace add Andamio-Platform/andamio-marketplace
/plugin install coach@andamio
```

### Pi.dev (npm)

```
pi install npm:@andamio/coach
```

### Other agents (clone)

```bash
git clone https://github.com/Andamio-Platform/coach.git
cd coach
```

Then point your agent at the `skills/` directory.

## Quick Start

Run the `start` skill. Coach will welcome you and ask how you'd like to work. Three paths, one destination:

- **Beginner** - You want to design a personalized learning experience about something new
- **Apprentice** - You know some of the content and you're ready to build a course
- **Teacher** - Have learning targets ready, and you're an expert on the subject

## Supported Agents

Coach follows the open [Agent Skills](https://agentskills.io) standard. The `skills/` directory works with any compatible agent:

- [Claude Code](https://claude.ai/code) / [Claude](https://claude.ai)
- [Cursor](https://cursor.com)
- [GitHub Copilot](https://github.com/features/copilot) / [VS Code](https://code.visualstudio.com)
- [Gemini CLI](https://geminicli.com)
- [OpenAI Codex](https://developers.openai.com/codex)
- [Goose](https://block.github.io/goose/)
- [Roo Code](https://roocode.com)
- And [many more](https://agentskills.io/home)

Point your agent at the `skills/` directory to get started. See your agent's documentation for how it discovers skills.

## How It Works

### The Compounding Loop

Each course you develop makes the system smarter for the next one:

| Step | Skill | What happens |
|------|-------|-------------|
| Draft SLTs | `draft-slts` | Generate learning targets from topic, audience, and goals |
| Assess | `assess-slts` | Evaluate quality across 5 dimensions, suggest rewrites |
| Revise | *(you + agent)* | Apply feedback, tighten SLT wording |
| Classify | `classify-lesson-types` | Interview to assign each SLT a lesson type |
| Assess Readiness | `self-assess-readiness` | Rate coaching confidence per SLT, build context shopping list |
| Gather Context | `gather-screenshots` / `gather-code-examples` | Checklists for Product Demo and Developer Documentation inputs |
| Build Lessons | *(you + agent)* | Write lessons using gathered context |
| Compile | `compile` | Package modules into platform import format |
| Compound | `compound` | Extract patterns into `knowledge/` — verb effectiveness, quality issues, calibration, heuristics |
| **Next course** | | Every skill reads `knowledge/` before running. The loop tightens. |

The `course-workflow` skill orchestrates this loop, tracking which phase you're in and suggesting the next step.

### Skills

#### Onboarding Skills

| Skill | Purpose |
|-------|---------|
| `start` | Welcome and pathway selection |
| `beginner` | Conversation-first flow for designing a learning experience |
| `apprentice` | Collaborative flow for structuring content into a course |
| `teacher` | Fast-track flow for experts with learning targets ready |

#### Course Development Skills

| Skill | Loop Step | Purpose |
|-------|----------|---------|
| `course-workflow` | All | Orchestrates the workflow, tracks status, guides next steps |
| `draft-slts` | Draft SLTs | Generates SLTs from topic, audience, and learning goals |
| `assess-slts` | Assess | Evaluates SLT quality across 5 dimensions with rewrite suggestions |
| `self-assess-readiness` | Assess Readiness | Evaluates coaching readiness per SLT |
| `classify-lesson-types` | Classify | Interviews user to classify each SLT by lesson type |
| `gather-screenshots` | Gather Context | Screenshot capture checklists for Product Demo lessons |
| `gather-code-examples` | Gather Context | Code example checklists for Developer Documentation lessons |
| `compound` | Compound | Extracts patterns from course artifacts to improve future runs |

## Key Concepts

### Student Learning Targets (SLTs)

"I can..." statements that define specific, measurable learning outcomes. Each module has one SLT. The skills help you draft them well, assess their quality, and evaluate whether an agent can coach a learner through them.

### Fist to Five

A confidence rating (0-5) adapted from Marzano's classroom technique. An agent emits a Fist to Five rating against each SLT based on four dimensions: conceptual explanation, code demonstration, learner assessment, and knowledge currency. Level 5 means the skill can produce work, explain it, catch errors, and evaluate submissions.

### The Skill Is the Student

In the classroom, teachers ask "can this student do these things?". Coach asks: "given the context, can these agents do these things?"

### Lesson Types

1. **Product Demo** - SLT + screenshots → visual walkthrough
2. **Developer Documentation** - SLT + code + docs link → technical lesson
3. **How To Guide** - SLT + optional materials → step-by-step procedure
4. **Organization Onboarding** - SLT + org context → setup guidance
5. **Exploration** - SLT + framing questions → big ideas, thought leadership, worldview challenges

## Usage Example

Clone coach, open your agent, and run `start`. Pick "Beginner" and say you want to teach people how to build CLI tools in Go.

Coach interviews you about your audience and goals, then drafts learning targets like:

> "I can parse command-line flags using the `flag` package by writing a CLI that accepts at least two named arguments."

You pick the ones that fit, refine the wording together, and coach classifies each into a lesson type (walkthrough, documentation, hands-on guide). From there, the workflow builds lessons, compiles them, and extracts patterns into `knowledge/` so the next course starts smarter.

Your work-in-progress lives in `courses-in-progress/`, and compiled output goes to `compiled/`. Both directories are gitignored except for their ABOUT files - your content stays local.

```
courses-in-progress/
├── ABOUT.md              # Tracked - explains the directory
└── go-cli-tools/         # Gitignored - your course content
    ├── 00-course.md
    ├── 01-slts.md
    └── lessons/

compiled/
├── ABOUT.md              # Tracked - explains the directory
└── go-cli-tools/         # Gitignored - compiled output
    └── 101/
```

## Using Coach Skills in Another Project

You can bring coach's skills into any project.

### Option 1: Plugin install (recommended for Claude Code)

Install via the Andamio marketplace — skills are automatically available as `coach:start`, `coach:draft-slts`, etc.

```
/plugin install coach@andamio
```

### Option 2: npm install

```bash
npm install -D @andamio/coach
```

Skills and seed knowledge are available in `node_modules/@andamio/coach/skills/`. Note: the compounding loop does not persist in `node_modules/` — for full compounding, use the plugin or clone method.

### Option 3: Git submodule

Add coach as a submodule and symlink the skills:

```bash
cd your-project
git submodule add https://github.com/Andamio-Platform/coach.git .coach
ln -s .coach/skills .agents/skills
```

Your agent discovers the skills automatically. Knowledge and research are available at `.coach/knowledge/`.

### Option 4: Setup script

For course repos that want full symlink integration (skills, knowledge, and research):

```bash
cd /path/to/your-course-repo
/path/to/coach/scripts/setup-course-repo.sh /path/to/coach
```

See [docs/setup-course-repo.md](docs/setup-course-repo.md) for the full guide.

### Option 5: Clone alongside

Clone coach next to your project and point your agent to it:

```bash
git clone https://github.com/Andamio-Platform/coach.git
```

Then configure your agent to look for skills in `../coach/skills/`. How you do this depends on your agent - check its documentation for custom skill paths.

## Knowledge Compounding

The `knowledge/` directory stores structured patterns extracted from course development:

```
knowledge/
├── index.yaml                    # Master index, aggregate stats
├── voice-patterns.md             # Prose style guide for lesson writing
├── slt-patterns/                 # Verb bank, quality issues, successful rewrites
├── readiness/                    # Context leverage rankings, calibration data
├── lesson-types/                 # Heuristics and edge cases
├── lesson-writing/               # Style anti-patterns and acceptable patterns
└── compile/                      # Import gotchas discovered during platform uploads
```

## Research Foundation

The skills are grounded in education research. See `knowledge/research/slt-research-report.md` for the full report on SLT definitions, Bloom's Taxonomy alignment, and formative assessment coupling.

## Adapting for Your Platform

Coach was built for Andamio courses, but 12 of 14 skills are platform-agnostic. The SLT framework, readiness assessment, lesson types, and compounding loop work for any course platform.

See [How to Adapt](docs/how-to-adapt.md) for a guide on making coach work with your platform.

## The Andamio Worked Example

This toolkit was built to develop courses on [Andamio](https://andamio.io), a contribution-centered learning platform. The `knowledge/` directory ships with real patterns extracted from 7+ Andamio courses.

In Andamio, SLTs are content-addressed by blake2b-256 hash and stored on-chain as credentials. The SLT becomes the bridge between learning and verifiable contribution. If that sounds interesting, explore:

- [SLTs as an Agentic Interface](docs/framework-slts-as-agentic-interface.md) - how SLTs work as the operational interface for human-agent collaboration
- [Fist to Five for Agents](docs/framework-fist-to-five-for-agents.md) - Marzano's technique adapted for AI agents
- [Dual-Audience Courses](docs/framework-dual-audience-courses.md) - designing courses that serve multiple skill levels

#### Andamio-Specific Skills

| Skill | Purpose |
|-------|---------|
| `compile` | Packages a completed module into Andamio import format |
| `andamio-cli` | Import/export content via Andamio CLI |

## Prerequisites

- Any [Agent Skills](https://agentskills.io)-compatible AI coding agent
- macOS or Linux for the multi-repo symlink setup (Windows users can use WSL)

### For Claude Code Users

Coach was originally built with Claude Code. For the best experience, add the [compound-engineering](https://github.com/EveryInc/compound-engineering-plugin) plugin to your local `.claude/settings.json` for Context7 documentation lookup during skill execution. See [CLAUDE.md](CLAUDE.md) for Claude-specific tips.

## Roadmap

### Phase A: Build Workflow and Lesson Skills

- [x] 14 skills (10 course development + 4 onboarding pathways)
- [x] Knowledge compounding loop
- [x] Multi-repo setup pattern
- [x] Agent Skills open standard compliance
- [ ] Lesson type skills (product-demo, developer-documentation, etc.)
- [ ] `evaluate-assignment` skill for learner submissions

### Phase B: Package and Distribute (Current)

- [x] Claude Code plugin (`.claude-plugin/plugin.json`)
- [x] [Andamio marketplace](https://github.com/Andamio-Platform/andamio-marketplace) for Claude Code
- [x] npm package (`@andamio/coach`) for Pi.dev and Vercel Skills CLI
- [x] Community marketplace compatibility (SkillsMP, SkillHub)
- [x] Plugin-aware knowledge architecture (`${CLAUDE_PLUGIN_DATA}` for persistent compounding)

### Phase C: Extend

- Readiness dashboard
- Platform integration APIs

## License

[MIT](LICENSE)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).
