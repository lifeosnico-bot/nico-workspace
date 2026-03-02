#!/usr/bin/env python3
"""Overnight Runner (nico-workspace)

v1 behavior:
- Load queue from ops/overnight/queue.json
- Pick the first pending item (P1..P5, then id)
- Write a short report to Logs/overnight-runner.log

Safety constraints (enforced by design in v1):
- No git changes
- No PR creation

Next version will add branch+PR creation behind gates.
"""

from __future__ import annotations

import json
import sys
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
QUEUE_PATH = REPO_ROOT / "ops/overnight/queue.json"
LOG_PATH = REPO_ROOT / "Logs/overnight-runner.log"


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
        lines.append(f"Next item: {item.id} {item.priority} — {item.title}")
        lines.append("Action: v1 no-op (report only)")

    LOG_PATH.parent.mkdir(exist_ok=True)
    LOG_PATH.write_text("\n".join(lines) + "\n")
    print("\n".join(lines))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
