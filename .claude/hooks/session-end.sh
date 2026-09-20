#!/bin/bash
# Session-end safety net.
#
# 1. Drops a timestamp marker into today's journal in memory/sessions/.
# 2. Commits anything left uncommitted and pushes, so nothing is lost.
#
# Claude is still expected to make proper, well-described commits during the
# session (see "End of every task or session" in CLAUDE.md). This only sweeps
# up what was missed.
#
# Tolerant by design: no remote, offline, or no permission must never break
# the session, so every git call is guarded.

set -e

DATE=$(date -u +%Y-%m-%d)
TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M UTC")
FILE="memory/sessions/${DATE}.md"

mkdir -p memory/sessions

if [ ! -f "$FILE" ]; then
  printf "# Session journal — %s\n\n" "${DATE}" > "$FILE"
fi

printf "\n---\n*Session ended: %s*\n" "${TIMESTAMP}" >> "$FILE"

if git rev-parse --git-dir >/dev/null 2>&1; then
  if [ -n "$(git status --porcelain)" ]; then
    git add -A || true
    git commit -q -m "auto: session checkpoint ${TIMESTAMP}" || true
  fi
  # Push only if a remote named origin exists. Silent no-op otherwise.
  if git remote get-url origin >/dev/null 2>&1; then
    git push -q origin HEAD 2>/dev/null || true
  fi
fi
