# Personal OS Starter

A small, opinionated starter kit that turns Claude Code into your personal **operating system**: a folder that knows who you are, what you are working on, how you sound, and what it can reach on your behalf. It grows a little every week.

You do not need to be a developer. If you can open a folder and type a sentence, you can run this.

---

## What is in the box

Three skills. That is all. Everything else grows from them.

| Skill | What it does | When to run it |
|---|---|---|
| `/onboard` | A 7-question interview that fills in your OS for the first time. | Day 1, right after you clone this repo. About 15 minutes. |
| `/audit` | Scores your OS out of 100 across four layers and tells you the three highest-leverage gaps. Read-only. | Day 7, then weekly. Watch the score climb. |
| `/level-up` | A short interview that finds one thing worth automating this week, scopes it, and builds it. | Day 14, then weekly. One run = one shipped thing. |

`/audit` asks *"is the OS built right?"* `/level-up` asks *"what could it do for me that it cannot yet?"* Run them in that order.

---

## The four layers

Your OS is only as good as these four layers. `/audit` scores each one out of 25.

| Layer | Question it answers | You know it is in place when... |
|---|---|---|
| **Context** | Does it know me? | A fresh session can say what you do and what matters this quarter without you explaining. |
| **Reach** | Can it touch my stuff? | "What is on my calendar tomorrow?" returns live data, not a request to paste it. |
| **Skills** | Does it know how to do my work? | A short phrase triggers a multi-step job that produces something useful. |
| **Rhythm** | Does it run without being asked? | Something useful happens on a schedule while you are not at the keyboard. |

Context comes first and cannot be skipped. Reach and Skills grow in parallel. Rhythm comes last. Never automate something that does not work by hand yet.

The full explanation lives in [references/how-your-os-works.md](references/how-your-os-works.md).

---

## Quick start

1. **Clone this repo** into a folder on your machine (see the guide in `docs/` if you have never done this).
2. **Open the folder in VS Code** and open the Claude Code panel.
3. Type `/onboard` and answer the seven questions honestly. Paste real writing samples, do not describe them.
4. When it finishes, ask: **"What should I focus on this week?"**
5. Type `/audit` to see your first score. Most people start between 20 and 40. That is normal.
6. Use it for a week. Bring real questions. Log real decisions in `decisions/log.md`.
7. On Day 14, type `/level-up` and build your first automation.

---

## Repo layout

```
personal-os-starter/
├── README.md                    <- you are here
├── CLAUDE.md                    <- your operating manual (filled by /onboard)
├── os-intake.md                 <- the 7 questions; source of truth for /onboard
├── connections.md               <- registry of every system your OS can reach
├── context/                     <- about you, your work, your priorities
├── references/                  <- how the OS works, your voice, API notes, SOPs
├── decisions/log.md             <- append-only record of what you decided and why
├── memory/                      <- learnings + session journal
├── archives/                    <- old things; move here, do not delete
├── docs/                        <- the getting-started guide (PDF)
├── .env.example                 <- copy to .env for keys; .env is never committed
├── AGENTS.md                    <- pointer to CLAUDE.md for Codex users
├── .agents/skills/              <- Codex copies of the three skills ($onboard, $audit, $level-up)
└── .claude/
    ├── settings.json            <- session-end hook
    ├── hooks/session-end.sh     <- journals + commits + pushes at the end of a session
    └── skills/
        ├── onboard/SKILL.md
        ├── audit/SKILL.md
        └── level-up/SKILL.md
```

---

## What to add as you grow

The kit is lean on purpose. Add folders only when you feel the need three times.

| Add | When |
|---|---|
| `projects/<name>/` | You have two or more ongoing workstreams with their own context. |
| `templates/` | You keep pasting the same prompt or document scaffold. |
| `scripts/` | You write a small script to reach a tool that has no built-in connector. |
| `references/<tool>-api.md` | You figured out how a tool's API works. Write it down once, never research it again. |
| `.claude/agents/` | You want a helper that does a repeatable multi-step job in its own context. |

Do not add `notes/`, `misc/`, `tmp/` or `inbox/`. They become graveyards.

---

## Using Codex instead of Claude Code

The kit is written for Claude Code and works best there. It also runs under OpenAI's Codex extension for VS Code:

- Codex reads `AGENTS.md`, which points it at `CLAUDE.md`, so the operating manual is shared.
- The three skills are mirrored in `.agents/skills/`. Type `$onboard`, `$audit` and `$level-up` instead of the slash versions.
- There is no session-end hook in Codex, so ask it to commit and push at the end of each session. The rules in `CLAUDE.md` tell it to.

## Safety rules the kit ships with

- `.env` is git-ignored. Keys go there and nowhere else.
- `/audit` never writes to your files (except the optional audit report).
- `/level-up` only writes to `decisions/log.md` and the one new artifact it builds.
- The session-end hook commits and pushes whatever changed, so nothing is lost. It never fails the session if you are offline.

---

## License

MIT. See [LICENSE](LICENSE). Use it, fork it, make it yours.
