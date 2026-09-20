# Memory

Two things live here.

**`learnings.md`** — append-only. Anything Claude figures out that should survive to the next session: how a tool's API behaves, a gotcha, a preference you stated, a fact about your work that is not written anywhere else. Claude reads it at the start of non-trivial tasks and appends to it at the end.

**`sessions/`** — a daily journal. The session-end hook drops a timestamp marker in `sessions/YYYY-MM-DD.md` every time a session ends. Claude can also write short notes there about what was done. It is evidence of the work, not a place for long documents.

Keep interpreted facts here, not raw dumps. If you would not read it back, do not write it.
