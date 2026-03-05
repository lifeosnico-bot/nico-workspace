#!/usr/bin/env python3
"""Overnight Runner (nico-workspace)

Current behavior:
- Load queue from ops/overnight/queue.json
- Pick the first pending item (P1..P5, then id)
- YouTube intake (notes-only): convert untriaged YouTube links in CabinetAgentVault into per-video stub notes
- Print a short report (launchd captures stdout/stderr to log files)

Safety constraints (enforced by design):
- No git changes
- No PR creation

Future versions may add branch+PR creation behind gates.
"""

from __future__ import annotations

import json
import re
import sys
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from urllib.parse import parse_qs, urlparse

REPO_ROOT = Path(__file__).resolve().parents[1]
QUEUE_PATH = REPO_ROOT / "ops/overnight/queue.json"

VAULT_ROOT = Path.home() / "Nico" / "CabinetAgentVault"
YOUTUBE_INBOX_PATH = VAULT_ROOT / "30-resources" / "letta-youtube-research.md"
YOUTUBE_OUT_DIR = VAULT_ROOT / "50-clippings" / "youtube"
YOUTUBE_SOP_REL = "new-vault-build/video-processing-sop.md"


@dataclass
class QueueItem:
    id: str
    priority: str
    status: str
    title: str


def now_stamp() -> str:
    return datetime.now().strftime("%Y-%m-%d %H:%M")


def load_queue() -> dict:
    return json.loads(QUEUE_PATH.read_text())


def pick_next_item(queue: dict) -> QueueItem | None:
    items = [i for i in queue.get("items", []) if i.get("status") == "pending"]
    items.sort(key=lambda i: (i.get("priority", "P9"), i.get("id", "")))
    if not items:
        return None
    i = items[0]
    return QueueItem(
        id=i.get("id", ""),
        priority=i.get("priority", "P3"),
        status=i.get("status", "pending"),
        title=i.get("title", ""),
    )


def extract_youtube_id(url: str) -> str | None:
    try:
        p = urlparse(url)
    except Exception:
        return None

    host = (p.netloc or "").lower()
    path = (p.path or "").strip("/")

    if "youtu.be" in host:
        vid = path.split("/")[0] if path else ""
        return vid or None

    if "youtube.com" in host:
        if path == "watch":
            return parse_qs(p.query).get("v", [None])[0]
        if path.startswith("shorts/"):
            parts = path.split("/")
            return parts[1] if len(parts) > 1 else None
        if path.startswith("live/"):
            parts = path.split("/")
            return parts[1] if len(parts) > 1 else None
        if path.startswith("embed/"):
            parts = path.split("/")
            return parts[1] if len(parts) > 1 else None

    return None


def parse_incoming_youtube_links(md_text: str) -> list[tuple[str, str]]:
    """Return list of (captured_date, url) from the 'Incoming YouTube Links' section."""

    lines = md_text.splitlines()
    in_section = False
    out: list[tuple[str, str]] = []

    for line in lines:
        if line.strip().startswith("## Incoming YouTube Links"):
            in_section = True
            continue

        if in_section and line.startswith("## "):
            break

        if not in_section:
            continue

        m = re.match(r"^\s*-\s*(\d{4}-\d{2}-\d{2})\s+—\s+(https?://\S+)\s*$", line)
        if not m:
            continue

        out.append((m.group(1), m.group(2)))

    return out


def build_stub_note(video_id: str, video_url: str, captured_date: str) -> str:
    created = datetime.now().strftime("%Y-%m-%d")

    return "\n".join(
        [
            "---",
            f'title: "YouTube (Untriaged) — {video_id}"',
            "type: clipping",
            "status: untriaged",
            f"created: {created}",
            f"modified: {created}",
            "tags: [youtube, untriaged, letta]",
            f"video_id: {video_id}",
            f"source: \"{video_url}\"",
            f"captured: {captured_date}",
            "---",
            "",
            f"# YouTube (Untriaged) — {video_id}",
            "",
            f"Source: {video_url}",
            "",
            "## Intake",
            "- Captured from: `30-resources/letta-youtube-research.md` (Incoming YouTube Links)",
            f"- Next step: process via `{YOUTUBE_SOP_REL}`",
            "",
            "## Notes",
            "",
        ]
    )


def run_youtube_intake(report_lines: list[str]) -> None:
    if not YOUTUBE_INBOX_PATH.exists():
        report_lines.append(f"YouTube intake: inbox not found: {YOUTUBE_INBOX_PATH}")
        return

    YOUTUBE_OUT_DIR.mkdir(parents=True, exist_ok=True)

    incoming = parse_incoming_youtube_links(YOUTUBE_INBOX_PATH.read_text(encoding="utf-8"))

    created = 0
    skipped = 0
    invalid = 0
    created_ids: list[str] = []

    for captured_date, url in incoming:
        video_id = extract_youtube_id(url)
        if not video_id:
            invalid += 1
            continue

        out_path = YOUTUBE_OUT_DIR / f"{video_id}-untriaged.md"
        if out_path.exists():
            skipped += 1
            continue

        out_path.write_text(build_stub_note(video_id, url, captured_date), encoding="utf-8")
        created += 1
        created_ids.append(video_id)

    report_lines.append(
        f"YouTube intake: {created} created, {skipped} existing, {invalid} invalid (incoming={len(incoming)})"
    )
    if created_ids:
        report_lines.append(f"YouTube created: {', '.join(created_ids[:10])}{'…' if len(created_ids) > 10 else ''}")
        report_lines.append(f"YouTube folder: {YOUTUBE_OUT_DIR}")


def main() -> int:
    if not QUEUE_PATH.exists():
        print(f"Queue not found: {QUEUE_PATH}", file=sys.stderr)
        return 2

    queue = load_queue()
    item = pick_next_item(queue)

    lines = [
        f"Overnight Runner Report — {now_stamp()}",
        f"Repo: {REPO_ROOT}",
    ]

    if not item:
        lines.append("Queue: no pending items")
    else:
        lines.append(f"Queue next: {item.id} {item.priority} — {item.title}")

    run_youtube_intake(lines)

    print("\n".join(lines))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
