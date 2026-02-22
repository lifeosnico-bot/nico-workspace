#!/bin/bash
# Claude Code SessionStart hook — runs at start of every session

DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H:%M EST')

mkdir -p /Users/lifeos.nico/Nico/Memory/Sessions

# Archive existing scratch if present
if [ -f /Users/lifeos.nico/Nico/Memory/session-scratch.md ]; then
    ARCHIVE_NAME="session-scratch-$(date '+%Y%m%d-%H%M%S').md"
    mv /Users/lifeos.nico/Nico/Memory/session-scratch.md \
       /Users/lifeos.nico/Nico/Memory/Sessions/$ARCHIVE_NAME
    echo "Archived previous scratch: $ARCHIVE_NAME"
fi

# Write fresh scratch file
cat > /Users/lifeos.nico/Nico/Memory/session-scratch.md << EOF
# Session Scratch — ${DATE}

**Session start:** ${TIME}
**Channel:**
**Agent:** Nico
**Machine:** M1 (nico-agent)

## Discoveries This Session

## Decisions Made

## Decisions Pending

## Open Questions

## Wrote to Memory Today

## Session End (fill in at close)

- What was accomplished:
- Decisions made:
- First thing next session:
EOF

echo "Session scratch initialized: $DATE $TIME"
