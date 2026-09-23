# Operating manual pointer (for Codex and other AGENTS.md readers)

If you are Codex, or any agent that reads `AGENTS.md`, the operating manual for this OS is **`CLAUDE.md` in this same folder**. Read it in full before doing anything else and follow it exactly as if its contents were written here. `CLAUDE.md` is the single source of truth; this file only points to it so that both Claude Code and Codex users get the same OS.

## Skills

The three skills live in two identical copies:

- `.claude/skills/` is read by Claude Code, invoked as `/onboard`, `/audit`, `/level-up`.
- `.agents/skills/` is read by Codex, invoked as `$onboard`, `$audit`, `$level-up`.

Wherever a skill's text says `/audit` or `/level-up`, a Codex user types `$audit` or `$level-up`. The behaviour is the same.

If you ever edit or add a skill, change both copies so the two folders stay identical.

## Session end

Codex has no equivalent of the Claude Code session-end hook in `.claude/settings.json`. The "End of every task or session" rules in `CLAUDE.md` therefore apply to you in full: update `decisions/log.md` and `memory/learnings.md`, then commit and push if GitHub is connected.
