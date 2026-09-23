---
name: level-up
description: Use weekly to find and ship one new automation. A three-part interview - Find (surface the candidate), Scope (define exactly one), Build (ship it as a prompt, skill or agent). Trigger on "let's level up", "what should I automate next", "find me leverage this week", or as a Friday ritual. One run = one shipped artifact.
---

## What this skill does

Walks the user through a short interview each week to surface and ship **one** automation. One interview, one artifact. Over time the questions become the user's own defaults: after a month or two they start spotting candidates mid-week without being asked.

## What it is not

- Not `/audit`. `/audit` is structural (is the OS built right?). `/level-up` is functional (what leverage is missing?). If the structure is a mess, run `/audit` first.
- Not a planner for five things. One run, one artifact.
- Not a coach. The user does the thinking. The skill asks the questions.

## When it runs

- **First run: Day 14**, after the user has wired at least one connection and run `/audit` once. Earlier than that the answers are too generic to be useful.
- **Then weekly**, ideally Friday afternoon: review the week, pick one thing, ship it Monday.
- **Any time** a manual task starts to itch.

## What it reads first

- `context/priorities.md` — what the user said matters
- `context/about-me.md` — the task that eats their week
- `connections.md` — what is reachable, and how
- `decisions/log.md` — what was already shipped or rejected
- `.claude/skills/*/SKILL.md` frontmatter — what already exists
- The most recent `audits/audit-*.md` if present

## Execution — three parts

### Part 1: Find (surface the candidate)

Ask these in order, conversationally. Do not ask all five at once.

1. *"Walk me through your week. What did you do three or more times?"* (frequency)
2. *"What felt manual, boring, or copy-paste?"* (drudgery)
3. *"What made you think 'a smart intern could do this'?"* (delegation)
4. *"If ten times the work showed up tomorrow, what would break first?"* (constraint)
5. *"What would get you ten times the results tomorrow?"* (growth lever)

Cross-reference the answers with the priorities and the pain point from the context files. Say it out loud when they connect: *"That is the same thing you named as the task that eats your week."*

**Output:** a numbered list of one to three candidates, each with one line on why it is leverage. Then ask: *"Pick one to scope."*

### Part 2: Scope (define exactly one)

Five questions, in order. Each one can end the run early, and that is fine.

**1. Which constraint does this remove?** Tie it back to the answers in Part 1. If it does not remove a bottleneck or open a growth lever, ask why they picked it.

**2. Stop it, automate it, or hand it off?** Always in that order.
- **Stop first:** *"What happens if you just stop doing this?"* If the answer is "nothing breaks", congratulate them, log the decision to stop, and end the run. That is a win. Do not automate waste.
- **Automate second:** roughly 60 percent of the task should be deterministic steps, 30 percent judgement an AI can assist with, 10 percent human. If it is mostly judgement, go to the next option.
- **Hand it off third:** if it is too variable or too judgement-heavy, suggest a person. Log it and end the run.

**3. Map the process.** Five parts, one line each:
- Trigger: what kicks it off
- Inputs: where the information comes from
- Transformations: how the information changes shape
- Decisions: where it branches
- Destination: where the output goes

If the user cannot describe any of the five: *"If you cannot explain it to a person, you cannot explain it to an AI. Sketch it on paper first and come back."* End the run.

**4. Pick the autonomy level.**

| Level | Name | What happens |
|---|---|---|
| 0 | Manual | No AI |
| 1 | Suggested | AI suggests, the human decides every step |
| 2 | Drafted | AI drafts, the human reviews and edits |
| 3 | Supervised | AI runs, the human checks periodically |
| 4 | Autonomous | AI handles it end to end |

**Default is the lowest level that solves the problem.** Push back on level 4 unless lower levels have already been run for real. If a decision does not have to be made by AI, do not let AI make it.

**5. Tie it to a number.** Which of these does it move: more customers, more value per customer, less cost, or less time? And which specific metric: response time, error rate, conversion, hours per week? If the user cannot name one, end the run: *"If it does not move a number, why build it?"*

**Output:** a dated entry appended to `decisions/log.md` with all five answers, the autonomy level and the metric. This is the durable record.

### Part 3: Build (ship it)

Ask: *"How do you want to ship this?"* Options, in order of preference:

1. **Saved prompt** — a prompt template in `templates/` the user runs by hand. Zero infrastructure.
2. **Script skill** — a `SKILL.md` that runs a script with no AI step. Best for transformations with clear rules.
3. **AI-assisted skill** — a `SKILL.md` with one AI step inside. Drafts, classifies, summarises.
4. **Agent** — a multi-step agent in `.claude/agents/`. Last resort. Only if the work genuinely needs reasoning plus tools.

**Default is the highest option that has no AI in it and still solves the problem.** The user has to explicitly choose more autonomy.

Write the artifact inline: correct location, YAML frontmatter with `name` and `description`, and the contents. Every artifact ships with this line in its frontmatter:

```yaml
maturity: manual-first   # run it by hand at least three times before scheduling it
```

That line stops the user silently skipping validation. They advance it by editing it, on purpose.

While building, say the three build principles once, briefly:
- **Smallest step first.** Zero-AI where possible.
- **Test each step before chaining.**
- **Ship the rough version, improve from real use.**

## Output contract

Every run produces:

1. One entry in `decisions/log.md`
2. One artifact: a prompt template, a skill, or an agent (or a logged decision to stop or hand off)
3. A one-screen close: what was scoped, what was built, and the reminder to run it by hand three times

## Rules

1. **One interview, one artifact.**
2. **Part 1 always runs**, even if the user arrives with an idea. The idea might not be the best candidate.
3. **Stop comes before automate.** Ending early with "just stop doing it" is a success.
4. **Lowest autonomy that works.** Push back on level 4.
5. **Prefer the boring option** in Part 3.
6. **A metric is mandatory.** No number, no build.
7. **`maturity: manual-first`** in every artifact.
8. **Read-only on everything** except `decisions/log.md` and the new artifact.

## How to tell it worked

- Run with no prompt on a real setup. It surfaces candidates pulled from the actual priorities and pain point. Generic suggestions mean it failed.
- Feed it an obviously stoppable task. It suggests stopping, logs it, and ends cheerfully.
- Ask for an autonomous email replier on the first build. It insists on level 1 or 2 first.
- Give it a task solvable with a plain script. It defaults to option 2, not 3 or 4.
