# Andamio CLI — Agent Context

> Complete reference for agents and tools that need to interact with the Andamio Protocol via the CLI.
> Last updated: 2026-03-19

## Quick Start

```bash
# Install (macOS/Linux)
brew install andamio-platform/tap/andamio

# Authenticate
andamio auth login --api-key <key>       # Read-only API access
andamio user login                       # Browser wallet signing (required for write operations)

# Check status
andamio user status
andamio config show
```

## Environments

| Environment | API Base URL | App URL |
|-------------|-------------|---------|
| Preprod (default) | `https://preprod.api.andamio.io` | `https://preprod.app.andamio.io` |
| Mainnet | `https://mainnet.api.andamio.io` | `https://mainnet.app.andamio.io` |

Switch environment: `andamio config set-url https://mainnet.api.andamio.io`

## Authentication

Two auth methods coexist:

| Method | Command | Header Sent | Access Level |
|--------|---------|-------------|-------------|
| API Key | `andamio auth login --api-key <key>` | `X-API-Key` | Read-only |
| Wallet JWT | `andamio user login` | `Authorization: Bearer <jwt>` | Read + Write |

- Config stored at `~/.andamio/config.json` (permissions 0600)
- Environment variable `ANDAMIO_JWT` overrides stored JWT (useful for CI/CD)
- Both headers are sent simultaneously when both credentials exist
- Some endpoints require specific auth (e.g., `apikey` commands require API key only)

## Output Formats

All data commands support `--output` (`-o`) flag:

```bash
andamio course list                    # text (default) — human-readable table
andamio course list --output json      # JSON — stable scripting surface
andamio course list --output csv       # CSV
andamio course list --output markdown  # Markdown table
```

**For agents: always use `--output json`**. This is the stable, machine-parseable interface.

## Exit Codes

| Code | Meaning | When |
|------|---------|------|
| 0 | Success | Command completed normally |
| 1 | Generic error | Network, server, unexpected errors |
| 2 | Not found | Resource doesn't exist (404) |
| 3 | Auth required | No credentials or invalid credentials (401/403) |

## Composability Contract

- **stdout** = structured data only (JSON, CSV, tables)
- **stderr** = progress messages, status updates
- **No interactive prompts** — all commands work without a TTY
- **Required args are enforced** — omitting them returns an error with a hint

### Two-Step Discovery Pattern

```bash
# 1. Discover IDs
COURSE_ID=$(andamio course list --output json | jq -r '.data[0].course_id')

# 2. Use them
andamio course modules "$COURSE_ID" --output json
```

## Complete Command Reference

### auth — API key management

| Command | Description |
|---------|-------------|
| `auth login --api-key <key>` | Store API key |
| `auth status` | Check API key status |

### config — CLI configuration

| Command | Description |
|---------|-------------|
| `config show` | Show current config |
| `config set-url <url>` | Switch environment |
| `config set-submit-url <url>` | Set Cardano submit API URL |

### user — Wallet auth and user info

| Command | Auth | Description |
|---------|------|-------------|
| `user login` | wallet | Authenticate via browser wallet signing |
| `user logout` | none | Clear stored JWT |
| `user status` | none | Show auth status (API key + JWT + session remaining) |
| `user me` | either | Current user dashboard |
| `user exists <alias>` | none | Check if alias is taken |

### course — Course content (read)

| Command | Auth | Description |
|---------|------|-------------|
| `course list` | either | List courses |
| `course get <id>` | either | Course details |
| `course modules <id>` | either | List modules (shows SLT/lesson counts with JWT) |
| `course slts <id> <module>` | either | List SLTs (shows lesson presence with JWT) |
| `course lesson <id> <module> <slt>` | either | Lesson content |
| `course assignment <id> <module>` | either | Module assignment |
| `course intro <id> <module>` | either | Module introduction |

### course — Course content (write)

| Command | Auth | Description |
|---------|------|-------------|
| `course create-module <course-id>` | jwt | Create a new module |
| `course export <course-id> <module>` | jwt | Export module to local files |
| `course import <course-id> <module>` | jwt | Import local files to update module |
| `course import-all <course-id>` | jwt | Import all modules from compiled directory |

### teacher — Teacher operations

| Command | Auth | Description |
|---------|------|-------------|
| `teacher courses` | jwt | List courses where you are a teacher |
| `teacher assignments list` | jwt | List pending assignment commitments |
| `teacher assignments list --course <id>` | jwt | List commitments for a specific course (includes full submission) |
| `teacher assignments get <course> <module> <student>` | jwt | Get a specific student's commitment |

### project — Project data

| Command | Auth | Description |
|---------|------|-------------|
| `project list` | either | List projects |
| `project get <id>` | either | Project details |

### project task — Task management (manager role)

| Command | Auth | Description |
|---------|------|-------------|
| `project task list <project-id>` | jwt | List tasks |
| `project task get <index> --project-id <id>` | jwt | Get task by index |
| `project task create <project-id>` | jwt | Create task (flags: --title, --lovelace, --expiration, --content, --content-file, --github-issue) |
| `project task update <index> --project-id <id>` | jwt | Update task fields |
| `project task delete <index> --project-id <id>` | jwt | Delete draft task |
| `project task export <project-id>` | jwt | Export tasks to Markdown files |
| `project task import <project-id>` | jwt | Import tasks from Markdown (--dry-run supported) |

### manager — Manager operations

| Command | Auth | Description |
|---------|------|-------------|
| `manager projects` | jwt | List projects where you are a manager |

### tx — Cardano transactions

| Command | Auth | Description |
|---------|------|-------------|
| `tx build <endpoint> --body <json>` | jwt | Build unsigned transaction. `--body-file` for file input |
| `tx sign --tx <hex> --skey <path>` | none | Sign with local .skey file. `--tx-file` for file input |
| `tx submit --tx <hex>` | none | Submit signed tx. `--submit-url`, `--submit-header` |
| `tx register --tx-hash <hash> --tx-type <type>` | jwt | Register tx for tracking |
| `tx pending` | either | List pending transactions |
| `tx types` | either | List transaction types |
| `tx status <hash>` | either | Get transaction status |

### apikey — API key info

| Command | Auth | Description |
|---------|------|-------------|
| `apikey usage` | api-key | Key usage stats |
| `apikey profile` | api-key | Key profile |

### spec — API discovery

| Command | Description |
|---------|-------------|
| `spec fetch` | Download OpenAPI spec to openapi.json |
| `spec paths [--filter <pattern>]` | List available API endpoints |

## Agent Workflow Examples

### Explore a course

```bash
# List courses
COURSE=$(andamio course list --output json | jq -r '.data[0].course_id')

# List modules with SLT/lesson counts
andamio course modules "$COURSE" --output json

# List SLTs with lesson presence
andamio course slts "$COURSE" 100 --output json

# Get lesson content
andamio course lesson "$COURSE" 100 2 --output json | jq '.content_json'
```

### Assess student assignments (teacher)

```bash
# 1. Get SLTs for evaluation criteria
SLTS=$(andamio course slts "$COURSE" "$MODULE" --output json)

# 2. Get the assignment prompt
ASSIGNMENT=$(andamio course assignment "$COURSE" "$MODULE" --output json)

# 3. List pending submissions
SUBMISSIONS=$(andamio teacher assignments list --course "$COURSE" --output json)

# 4. Get a specific student's submission
SUBMISSION=$(andamio teacher assignments get "$COURSE" "$MODULE" "$STUDENT" --output json)
# The submission content is at: .content.evidence (Tiptap JSON)

# 5. After evaluation, build assess transaction
andamio tx build /v2/tx/course/teacher/assignments/assess \
  --body '{"course_id":"...","assessments":[{"student_alias":"...","result":"pass"}]}'
```

### Manage project tasks

```bash
# Discover project ID
PROJECT=$(andamio project list --output json | jq -r '.data[0].project_id')

# List tasks
andamio project task list "$PROJECT" --output json

# Create a task
andamio project task create "$PROJECT" \
  --title "Build API endpoint" \
  --lovelace 5000000 \
  --expiration 2026-06-01

# Create with rich Markdown content
andamio project task create "$PROJECT" \
  --title "Design system" \
  --lovelace 5000000 \
  --expiration 2026-06-01 \
  --content-file task-description.md

# Export/import tasks as Markdown
andamio project task export "$PROJECT"
andamio project task import "$PROJECT" --dry-run
```

### Transaction lifecycle

```bash
# 1. Build unsigned transaction
TX_HEX=$(andamio tx build /v2/tx/course/teacher/assignments/assess \
  --body-file assess-payload.json --output json | jq -r '.tx_hex')

# 2. Sign with local key
SIGNED=$(andamio tx sign --tx "$TX_HEX" --skey payment.skey --output json | jq -r '.tx_hex')

# 3. Submit to network
andamio tx submit --tx "$SIGNED"

# 4. Register for tracking
andamio tx register --tx-hash "$TX_HASH" --tx-type assess_assignments
```

### Discover API endpoints

```bash
# Find available endpoints
andamio spec paths --filter teacher
andamio spec paths --filter assignment
andamio spec paths --filter project

# Download full OpenAPI spec
andamio spec fetch
cat openapi.json | jq '.paths | keys[]'
```

## API Response Shapes

### List responses

All list endpoints return:
```json
{
  "data": [
    { "field": "value", ... },
    { "field": "value", ... }
  ]
}
```

Empty lists return `{"data": []}`.

### Error responses (--output json)

```json
{"error": "error message here"}
```

Combined with exit codes: `0` = success, `1` = generic, `2` = not found, `3` = auth.

### Common nested fields

- Course data: `data[].course_id`, `data[].content.title`
- Module data: `data[].content.course_module_code`, `data[].content.title`, `data[].content.module_status`
- SLT data: `data[].slt_index`, `data[].slt_text`, `data[].lesson` (object if lesson exists)
- Task data: `data[].task_index`, `data[].content.title`, `data[].task_status`, `data[].lovelace_amount`
- Assignment commitments: `data[].student_alias`, `data[].course_module_code`, `data[].content.evidence`

## Content Formats

### Tiptap JSON (content_json)

Rich content (lessons, assignments, task descriptions) uses Tiptap JSON format:

```json
{
  "type": "doc",
  "content": [
    {
      "type": "heading",
      "attrs": {"level": 1},
      "content": [{"type": "text", "text": "Title"}]
    },
    {
      "type": "paragraph",
      "content": [{"type": "text", "text": "Body text"}]
    }
  ]
}
```

The CLI converts between Markdown and Tiptap JSON for import/export. When using `--content-file`, Markdown is automatically converted.

## Key Identifiers

| Identifier | Format | Example |
|-----------|--------|---------|
| course_id | 56-char hex | `013f0ac76f0e1ac4c878070ccc44e84bf296d84b047e4de4932137e4` |
| course_module_code | numeric string | `100`, `200`, `300` |
| slt_index | integer | `1`, `2`, `3` |
| project_id | 56-char hex | `cb72d1a86ae046df8c200b2cefdadf1322bfcfe72d1787b4662d1587` |
| task_index | integer | `0`, `1`, `2` |
| student_alias | string | `test-admin-001`, `contrib22` |
| tx_hash | 64-char hex | `cfd58c772c21a6a281b207d6999595b81771e911cb8450a34cf323af61a61b4e` |
