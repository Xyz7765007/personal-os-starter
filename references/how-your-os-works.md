# How your OS works

Read this once. It explains what the three skills are trying to build and why the order matters.

---

## The idea

An "OS" here is not software. It is a folder that Claude reads at the start of every session, containing everything it needs to act like someone who has worked with you for a year: who you are, what matters, how you sound, what it can reach, what it knows how to do, and what it does on its own.

The test of a good OS is simple. **While you are away from your desk, it notices one real thing and produces an output that is faster and more accurate than what you would have produced yourself.**

Everything in the kit rolls up to that test.

---

## The four layers

### 1. Context — does it know me?

Files: `CLAUDE.md`, `context/`, `references/voice.md`, `decisions/log.md`, `memory/`.

**In place when:** a fresh session can answer "what does this person do and what matters to them this quarter?" without you typing a word.

Context is non-negotiable and comes first. Without it, every other layer produces generic output.

### 2. Reach — can it touch my stuff?

Files: `connections.md`, `.env`, `scripts/`, `references/<tool>-api.md`.

**In place when:** "what is on my calendar tomorrow and what tasks are due?" returns live data.

Seven areas matter for almost everyone: money and metrics, customers and contacts, calendar, communication, tasks, meetings and notes, documents. Wire the one that feeds your biggest priority first, not the easiest one.

At least one connection should be able to **write** (send, post, create). An OS that can only read is a viewer.

### 3. Skills — does it know how to do my work?

Files: `.claude/skills/<name>/SKILL.md`, later `.claude/agents/`.

**In place when:** a short phrase like `/weekly-review` runs a multi-step job and produces an artifact.

A skill is a markdown file with instructions. That is it. You will author your first one through `/level-up`. Keep skills small. A skill that does one thing well beats a skill that does five things badly.

### 4. Rhythm — does it run without being asked?

Files: `.claude/settings.json` hooks, scheduled skills, recurring rituals.

**In place when:** something useful happens on a schedule while you are not at the keyboard.

Rhythm comes last. Never schedule something you have not run by hand at least three times.

---

## The weekly rhythm

| Day | Do | Why |
|---|---|---|
| Day 1 | `/onboard` | Fill the Context layer. |
| Days 2 to 6 | Use it. Ask real questions. Wire one tool. | Reach grows when you need something it cannot see. |
| Day 7 | `/audit` | First score. Pick one gap. |
| Day 14 | `/level-up` | First automation. |
| Every Friday | `/audit` then `/level-up` | Score, then ship one thing. |

After five or six weeks you will notice you spot automation candidates mid-week without prompting. That is the real outcome. The folder is just where it lives.

---

## Five habits that keep it healthy

1. **Log the why.** A decision without reasoning is trivia. `decisions/log.md`.
2. **Research once.** The day you wire a tool, write `references/<tool>-api.md`.
3. **Stop before you automate.** If nothing breaks when you stop doing a task, stop doing it.
4. **Lowest autonomy that works.** Suggest before draft, draft before run, run before autonomous.
5. **Push after every session.** Your OS should survive your laptop.
