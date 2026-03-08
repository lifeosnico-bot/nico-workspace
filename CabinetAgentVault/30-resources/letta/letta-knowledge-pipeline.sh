#!/bin/bash
# ============================================================
# LETTA KNOWLEDGE PIPELINE — Run on M1 (residential IP)
# Location: ~/Nico/Scripts/letta-knowledge-pipeline.sh
# Usage: bash letta-knowledge-pipeline.sh [--all | --new]
# ============================================================

set -e
VAULT="$HOME/Nico/CabinetAgentVault"
TRANSCRIPTS_DIR="$VAULT/30-resources/letta/transcripts"
DOCS_DIR="$VAULT/30-resources/letta/docs"
CATALOG="$VAULT/30-resources/letta/video-catalog.txt"
LOG="$HOME/Nico/Scripts/letta-pipeline.log"
PYTHON="python3"

mkdir -p "$TRANSCRIPTS_DIR" "$DOCS_DIR"

echo "[$(date)] Starting Letta Knowledge Pipeline" | tee -a "$LOG"

# ── STEP 1: Pull complete video catalog ──────────────────────
echo "→ Fetching video catalog..." | tee -a "$LOG"
yt-dlp --flat-playlist --print "%(id)s|%(title)s|%(upload_date)s" \
  "https://www.youtube.com/@letta-ai/videos" 2>/dev/null > "$CATALOG"
TOTAL=$(wc -l < "$CATALOG")
echo "  Found $TOTAL videos" | tee -a "$LOG"

# ── STEP 2: Pull transcripts for all videos ──────────────────
echo "→ Pulling transcripts..." | tee -a "$LOG"
$PYTHON << 'PYEOF'
import sys, os, json
from pathlib import Path

try:
    from youtube_transcript_api import YouTubeTranscriptApi
except ImportError:
    os.system("pip3 install youtube-transcript-api -q")
    from youtube_transcript_api import YouTubeTranscriptApi

api = YouTubeTranscriptApi()
catalog_file = os.path.expanduser("~/Nico/CabinetAgentVault/30-resources/letta/video-catalog.txt")
transcripts_dir = os.path.expanduser("~/Nico/CabinetAgentVault/30-resources/letta/transcripts")
index_file = os.path.expanduser("~/Nico/CabinetAgentVault/30-resources/letta/transcript-index.json")

# Load existing index
index = {}
if os.path.exists(index_file):
    with open(index_file) as f:
        index = json.load(f)

with open(catalog_file) as f:
    lines = [l.strip() for l in f if l.strip()]

new_count = 0
skip_count = 0

for line in lines:
    parts = line.split("|")
    if len(parts) < 2:
        continue
    vid_id = parts[0].strip()
    title = parts[1].strip()
    upload_date = parts[2].strip() if len(parts) > 2 else "unknown"
    
    # Skip if already processed
    if vid_id in index:
        skip_count += 1
        continue
    
    try:
        transcript = api.fetch(vid_id)
        text = " ".join([s.text for s in transcript])
        
        # Save individual transcript file
        safe_title = "".join(c if c.isalnum() or c in " -_" else "" for c in title)[:60]
        filename = f"{vid_id}_{safe_title}.txt"
        filepath = os.path.join(transcripts_dir, filename)
        with open(filepath, "w") as f:
            f.write(f"# {title}\n")
            f.write(f"Video ID: {vid_id}\n")
            f.write(f"URL: https://www.youtube.com/watch?v={vid_id}\n")
            f.write(f"Upload Date: {upload_date}\n\n")
            f.write("---\n\n")
            f.write(text)
        
        index[vid_id] = {
            "title": title,
            "upload_date": upload_date,
            "filename": filename,
            "words": len(text.split()),
            "pulled": True
        }
        new_count += 1
        print(f"  ✅ {title[:55]} ({len(text.split())} words)")
        
    except Exception as e:
        print(f"  ❌ {title[:55]} — {str(e)[:50]}")
        index[vid_id] = {
            "title": title,
            "upload_date": upload_date,
            "filename": None,
            "pulled": False,
            "error": str(e)[:100]
        }

# Save updated index
with open(index_file, "w") as f:
    json.dump(index, f, indent=2)

total_words = sum(v.get("words", 0) for v in index.values())
print(f"\n  New: {new_count} | Skipped (already have): {skip_count}")
print(f"  Total corpus: {sum(1 for v in index.values() if v.get('pulled'))} videos, ~{total_words:,} words")
PYEOF

# ── STEP 3: Pull Letta Docs (key pages) ─────────────────────
echo "→ Fetching Letta documentation..." | tee -a "$LOG"
$PYTHON << 'PYEOF'
import os, urllib.request, json
from pathlib import Path

docs_dir = os.path.expanduser("~/Nico/CabinetAgentVault/30-resources/letta/docs")

# Key Letta doc pages to fetch
doc_pages = [
    ("overview",           "https://docs.letta.com/introduction"),
    ("memory-blocks",      "https://docs.letta.com/guides/agents/memory-blocks"),
    ("multi-agent",        "https://docs.letta.com/guides/agents/multi-agent"),
    ("sleep-time",         "https://docs.letta.com/guides/agents/architectures/sleeptime"),
    ("ade-overview",       "https://docs.letta.com/guides/ade/overview"),
    ("lettabot",           "https://docs.letta.com/guides/lettabot"),
    ("python-sdk",         "https://docs.letta.com/api/python"),
    ("tools",              "https://docs.letta.com/guides/agents/tools"),
    ("tool-rules",         "https://docs.letta.com/guides/agents/tool-rules"),
    ("memory-vars",        "https://docs.letta.com/guides/templates/variables"),
    ("multi-agent-custom", "https://docs.letta.com/guides/agents/multi-agent-custom-tools"),
    ("github-actions",     "https://docs.letta.com/guides/github-actions"),
]

print(f"  Fetching {len(doc_pages)} doc pages...")
for name, url in doc_pages:
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
        with urllib.request.urlopen(req, timeout=10) as r:
            content = r.read().decode("utf-8", errors="replace")
        filepath = os.path.join(docs_dir, f"{name}.html")
        with open(filepath, "w") as f:
            f.write(content)
        print(f"  ✅ {name}")
    except Exception as e:
        print(f"  ❌ {name} — {e}")
PYEOF

# ── STEP 4: Pull GitHub data ─────────────────────────────────
echo "→ Fetching GitHub data..." | tee -a "$LOG"
GITHUB_DIR="$VAULT/30-resources/letta/github"
mkdir -p "$GITHUB_DIR"

# README
curl -s "https://raw.githubusercontent.com/letta-ai/letta/main/README.md" \
  > "$GITHUB_DIR/README.md" && echo "  ✅ letta README"

# LettaBot README  
curl -s "https://raw.githubusercontent.com/letta-ai/lettabot/main/README.md" \
  > "$GITHUB_DIR/lettabot-README.md" 2>/dev/null && echo "  ✅ lettabot README"

# Recent releases via GitHub API (no auth needed for public)
curl -s "https://api.github.com/repos/letta-ai/letta/releases?per_page=10" \
  | python3 -c "
import json,sys
releases = json.load(sys.stdin)
for r in releases:
    print(f\"## {r['name']} ({r['published_at'][:10]})\")
    print(r.get('body','No notes')[:500])
    print()
" > "$GITHUB_DIR/releases.md" && echo "  ✅ letta releases"

# ── STEP 5: Commit to git ────────────────────────────────────
echo "→ Committing to vault..." | tee -a "$LOG"
cd "$VAULT"
git add 30-resources/letta/
git commit -m "nico/letta-knowledge: pipeline update $(date +%Y-%m-%d)" \
  --allow-empty 2>/dev/null || echo "  Nothing new to commit"

echo "[$(date)] Pipeline complete" | tee -a "$LOG"
echo "✅ Letta knowledge base updated."
