---
title: "URGENT: Push ~/Nico/ workspace to GitHub"
date: 2026-02-16
source: Cowork
priority: CRITICAL — do this before anything else
---

# PASTE THIS INTO CLAUDE CODE ON THE M1

```
You are Nico. This is URGENT — we have zero backup redundancy right now. Execute these steps immediately. Do not ask for confirmation.

STEP 1: Fix and commit the ~/Nico/ workspace repo
cd ~/Nico
rm -f .git/index.lock
git add -A
git commit -m "Initial workspace commit — CLAUDE.md, Memory, status.md, session logs, plans"

STEP 2: Push to GitHub as private repo
gh repo create nico-workspace --private --source=. --push

STEP 3: Verify
gh repo view nico-workspace
git log --oneline -3

STEP 4: Set up auto-backup (commit and push daily via launchd or cron)
Create a script at ~/Nico/Scripts/auto-backup.sh:
#!/bin/bash
cd ~/Nico
git add -A
git commit -m "auto-backup: $(date +%Y-%m-%d_%H:%M)" --allow-empty
git push origin master

Make it executable: chmod +x ~/Nico/Scripts/auto-backup.sh

Create a launchd plist at ~/Library/LaunchAgents/com.nico.workspace-backup.plist that runs the script every 6 hours.

STEP 5: Report what worked and what didn't.
```

# WHY THIS IS URGENT
Everything we've built — CLAUDE.md, status.md with 10 phases of tasks, all session logs, all imported plans — exists ONLY on the local filesystem right now. No backup. If the M1 has any issue, we lose days of architecture and planning work.

This takes 2 minutes and gives us:
- GitHub repo as backup (nico-workspace, private)
- Auto-commit every 6 hours
- Full version history of all changes
- Accessible from M3 or any machine via `gh repo clone`
