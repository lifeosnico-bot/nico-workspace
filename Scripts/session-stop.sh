#!/bin/bash
# Claude Code Stop hook — runs at end of every session

TIMESTAMP=$(date '+%Y-%m-%d %H:%M EST')

# Update Last Updated line in status.md
STATUS_FILE="/Users/lifeos.nico/Nico/Memory/status.md"
if [ -f "$STATUS_FILE" ]; then
    sed -i '' "s/\*\*Last Updated\*\*: [^|]*/\*\*Last Updated\*\*: ${TIMESTAMP} /" "$STATUS_FILE"
    echo "Updated status.md timestamp: $TIMESTAMP"
fi

# Auto-commit Letta memory changes if dirty
MEMORY_DIR="/Users/lifeos.nico/.letta/agents/agent-5a9b0e69-1f30-476d-a89a-30c8e21c9668/memory"
if [ -d "$MEMORY_DIR/.git" ]; then
    cd "$MEMORY_DIR"
    git add -A
    if ! git diff --cached --quiet; then
        git commit -m "auto: session end $(date '+%Y-%m-%d %H:%M')"
        git push 2>/dev/null || true
        echo "Memory committed and pushed"
    else
        echo "Memory: no changes to commit"
    fi
fi
