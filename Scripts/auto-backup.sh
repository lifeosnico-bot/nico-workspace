#!/bin/bash
# Auto-backup: commits all changes and pushes to the 'backup' branch.
# Never pushes to master — master is protected and requires PRs.
cd ~/Nico
git add -A
git commit -m "auto-backup: $(date +%Y-%m-%d_%H:%M)" --allow-empty

# Push to backup branch (not master — master requires PR)
git push origin HEAD:backup --force
