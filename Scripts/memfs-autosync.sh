#!/usr/bin/env bash
set -euo pipefail

MEMORY_DIR="${MEMORY_DIR:-/Users/lifeos.nico/.letta/agents/agent-5a9b0e69-1f30-476d-a89a-30c8e21c9668/memory}"
OUT_LOG="/Users/lifeos.nico/Nico/Logs/memfs-autosync.log"
LOCK_DIR="/tmp/memfs-autosync.lock"

STAMP() { date '+%Y-%m-%d %H:%M:%S'; }

# Prevent overlapping runs
if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  exit 0
fi
trap 'rmdir "$LOCK_DIR" 2>/dev/null || true' EXIT

cd "$MEMORY_DIR"

# If there are unresolved conflicts, do nothing.
if git diff --name-only --diff-filter=U | grep -q .; then
  echo "[$(STAMP)] autosync: conflict detected, skipping" >>"$OUT_LOG"
  exit 0
fi

# Nothing to do
if [[ -z "$(git status --porcelain)" ]]; then
  exit 0
fi

# Only sync pinned memory by default
if [[ -d system ]]; then
  git add system/ || true
else
  git add -A || true
fi

# If nothing staged, exit
if git diff --cached --quiet; then
  exit 0
fi

MSG="chore: memfs autosync $(date '+%Y-%m-%d %H:%M:%S')"
if ! git commit -m "$MSG" >>"$OUT_LOG" 2>&1; then
  exit 0
fi

# Rebase on remote; if it fails, leave for manual resolution
if ! git pull --rebase >>"$OUT_LOG" 2>&1; then
  echo "[$(STAMP)] autosync: pull --rebase failed (manual fix needed)" >>"$OUT_LOG"
  exit 0
fi

if ! git push >>"$OUT_LOG" 2>&1; then
  echo "[$(STAMP)] autosync: push failed (manual fix needed)" >>"$OUT_LOG"
  exit 0
fi

echo "[$(STAMP)] autosync: pushed" >>"$OUT_LOG"
