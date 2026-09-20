# Connections

Registry of every system your OS can reach. `/onboard` fills the first seven rows from your intake answers. You update it every time you wire a new tool. `/audit` reads it to score the **Reach** layer.

Last reviewed: —

| # | Area | Tool(s) | How it is reached | Auth status | Last checked | Notes |
|---|---|---|---|---|---|---|
| 1 | Money and metrics | — | not yet connected | — | — | |
| 2 | Customers and contacts | — | not yet connected | — | — | |
| 3 | Calendar | — | not yet connected | — | — | |
| 4 | Communication | — | not yet connected | — | — | |
| 5 | Tasks and projects | — | not yet connected | — | — | |
| 6 | Meetings and notes | — | not yet connected | — | — | |
| 7 | Documents and files | — | not yet connected | — | — | |

**How a tool can be reached** (any of these counts):

- `connector` — a built-in Claude connector or an MCP server you added.
- `script` — a small script in `scripts/` that calls the tool's API with a key from `.env`.
- `export` — a regular file export (CSV, JSON) that a script refreshes.
- `manual` — you paste things in. Honest, but it does not count as connected.

When you wire a tool, also write `references/<tool>-api.md` with how it authenticates, the endpoints you use, and two or three example queries. Research once, never again.
