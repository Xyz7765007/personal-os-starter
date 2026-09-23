---
name: audit
description: Use when someone asks to audit their OS, score their setup, or says "is my OS working", "audit my setup", "find the gaps", "what is my score". Reads the project (never writes, except an optional saved report), scores four layers out of 25 each, and returns the top three fixes ranked by leverage.
---

## What this skill does

Scores the current project as a personal OS across four layers: **Context, Reach, Skills, Rhythm**. Each layer is worth 25 points. It reads the operating manual, context files, memory, connections registry, skills, agents, decisions and hooks, then reports strengths and the three gaps most worth fixing, each with one concrete next step.

The scope is **structural**: is the OS built right? It is not a capability planner. "You could build a daily brief" belongs to `/level-up`. The audit answers: are the files, registries and connections in good shape?

The first run is the baseline. Re-run weekly and watch the score climb.

## Today's context

- **Date:** !`date +%Y-%m-%d`
- **Project root:** the current working directory

## Execution

### Step 1: Discover the shape of the project

Look for patterns and intent, not exact paths. Names vary. Use file search and targeted reads.

- **Operating manual:** `CLAUDE.md` at the root.
- **Context:** `context/*.md`, `references/voice.md`.
- **Memory:** `memory/learnings.md`, `memory/sessions/`, or a `MEMORY.md`.
- **Decisions:** `decisions/log.md` or any append-only decisions file.
- **References:** `references/`, `docs/`, `sops/`.
- **Connections registry:** `connections.md`.
- **Reach mechanisms** (any counts as reachable): MCP or connector config in `.mcp.json` or `.claude/settings*.json`; scripts in `scripts/` that are documented; export pipelines with a refresh script; a `.env` key plus a matching `references/<tool>-api.md`.
- **Skills:** `.claude/skills/*/SKILL.md`. Read frontmatter only.
- **Agents:** `.claude/agents/*.md`.
- **Rhythm:** hooks in `.claude/settings.json`; skills named `daily-*`, `weekly-*`, `morning-*`, `monthly-*`; any documented schedule.
- **Templates:** `templates/` or `.claude/templates/`.

Do not penalise non-standard names if the intent is clearly captured somewhere.

### Step 2: Score each layer (25 points each)

#### Context (25)

| Criterion | Points | How to check |
|---|---|---|
| `CLAUDE.md` exists, has no unfilled `{{...}}` placeholders, and is over 200 words | 5 | Read and count |
| Identity, role and voice are captured | 5 | `context/about-me.md` and `references/voice.md` exist with real content |
| Priorities are captured and specific | 5 | `context/priorities.md` has 2 or more lines with a number, date or deliverable |
| Memory has entries | 5 | `memory/learnings.md` has 3 or more entries, or `memory/sessions/` has 3 or more files |
| Decisions are logged | 5 | `decisions/log.md` has at least one dated entry |

#### Reach (25)

The seven areas: money and metrics, customers and contacts, calendar, communication, tasks and projects, meetings and notes, documents and files. A row counts as reachable if its mechanism is `connector`, `script` or `export` and the auth status is not expired or missing.

| Criterion | Points | How to check |
|---|---|---|
| Area coverage | 10 | 1.4 points per reachable area, rounded to the nearest 0.5, capped at 10 |
| Reference guide per connected tool | 5 | Minus 1 for each connected tool with no `references/<tool>-api.md`. Floor 0. |
| Freshness | 5 | Minus 1 for each connection marked needs-auth or expired, or a script not run in 30 days. Floor 0. |
| Registry quality | 3 | 0 if `connections.md` missing; 1 if sparse; 2 if most rows filled; 3 if every reachable tool is documented with a date |
| Can write, not just read | 2 | At least one connection can send, post or create. 0 if everything is read-only. |

#### Skills (25)

| Criterion | Points | How to check |
|---|---|---|
| Three or more skills installed | 10 | Count `.claude/skills/*/SKILL.md` |
| At least one user-built skill | 10 | Any skill whose name is not `onboard`, `audit` or `level-up` |
| At least one agent | 5 | Count `.claude/agents/*.md` |

#### Rhythm (25)

| Criterion | Points | How to check |
|---|---|---|
| At least one recurring trigger | 10 | A hook in `.claude/settings.json`, or a skill named `daily-*`, `weekly-*`, `morning-*` or `monthly-*` |
| Recent activity | 10 | Any file under `.claude/skills/` modified in the last 30 days, or a decision logged in the last 30 days |
| Templates in use | 5 | `templates/` has at least one file |

### Step 3: Rank the gaps by leverage

For every criterion that lost points: leverage = points lost × multiplier.

| Situation | Multiplier |
|---|---|
| Zero areas reachable | 4 |
| Operating manual missing, thin, or still has placeholders | 3 |
| Two or fewer areas reachable | 3 |
| Zero skills | 2 |
| No recurring trigger | 2 |
| All connections read-only | 2 |
| Connected tools with no reference guide | 1.5 |
| No decisions log | 1.5 |
| Everything else | 1 |

Sort descending. Take the top three. For each, give one concrete next step:

- **Need to reach an area?** Prefer a built-in connector if one exists. Otherwise: "write `scripts/<tool>.py` using a key in `.env`, and save `references/<tool>-api.md`."
- **Missing a reference guide?** "Research the API once, save auth + endpoints + three example queries to `references/<tool>-api.md`."
- **Need a skill?** "Run `/level-up`, or write `.claude/skills/<name>/SKILL.md` with `name` and `description` in the frontmatter."
- **Need a decision?** "Append an entry to `decisions/log.md`."
- **Need rhythm?** "Add a hook to `.claude/settings.json`, or write a `daily-*` skill and run it every morning until it earns a schedule."

### Step 4: Print the report

Print directly in chat, in this shape:

```
# OS audit — {date}
**Score: {total}/100** ({stage})

Stages: 0-39 Foundation · 40-69 Built · 70-89 Compounding · 90-100 Autonomous

## Scoreboard

Context   {bar}  {n}/25  {label}
Reach     {bar}  {n}/25  {label}
Skills    {bar}  {n}/25  {label}
Rhythm    {bar}  {n}/25  {label}

(bar = one # per 5 points; label = Strong at 20+, Solid 15-19, Thin 8-14, Missing under 8)

## Strengths
- {one to three bullets from the highest-scoring criteria}

## Top 3 gaps (ranked by leverage)
1. **{gap}** (-{points} × {multiplier})
   → {next step}
2. **{gap}** (-{points} × {multiplier})
   → {next step}
3. **{gap}** (-{points} × {multiplier})
   → {next step}

## Do this next: {the single most leveraged action}

---
Structural gaps only. To find what your OS could DO that it cannot yet, run /level-up.
```

### Step 5: Offer to save it

Ask once: "Save this to `audits/audit-{date}.md` so you can track the score over time?" If yes, write it, creating `audits/` if needed. This is the only write this skill ever does.

## Rules

- **Read-only by default.** Never modify `CLAUDE.md`, context, memory, skills or any project file.
- **Be honest, not generous.** Most fresh setups land between 20 and 40. A 90 should be rare.
- **Do not recommend tools or skills that do not exist.**
- **Be fast.** Targeted reads, frontmatter only for skills. Under a minute.
- **Rhythm detection is fuzzy.** Infer from names when schedule data is not clean.
