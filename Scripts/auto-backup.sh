#!/bin/bash
cd ~/Nico
git add -A
git commit -m "auto-backup: $(date +%Y-%m-%d_%H:%M)" --allow-empty
git push origin master
