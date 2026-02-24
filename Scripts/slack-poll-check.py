#!/usr/bin/env python3
"""Called by slack-poll.sh to check for new messages."""
import os, json, urllib.request, sys

token = os.environ['SLACK_BOT_TOKEN']
channel = os.environ['CHANNEL_ID']
oldest = os.environ['LAST_TS']

try:
    url = f"https://slack.com/api/conversations.history?channel={channel}&oldest={oldest}&limit=10"
    req = urllib.request.Request(url, headers={"Authorization": f"Bearer {token}"})
    data = json.loads(urllib.request.urlopen(req, timeout=10).read())
except Exception as e:
    print(f"ERROR:fetch:{e}", file=sys.stderr)
    sys.exit(1)

if not data.get("ok"):
    err = data.get("error", "unknown")
    if err == "ratelimited":
        print("RATELIMITED")
        sys.exit(0)
    print(f"ERROR:api:{err}", file=sys.stderr)
    sys.exit(1)

msgs = data.get("messages", [])
if not msgs:
    print("OK")
    sys.exit(0)

new_ts = "0"
human_msgs = []

for msg in msgs:
    ts = msg.get("ts", "0")
    if float(ts) > float(new_ts):
        new_ts = ts
    if msg.get("bot_id") or msg.get("subtype"):
        continue
    uid = msg.get("user", "?")
    text = msg.get("text", "")[:200]
    try:
        req2 = urllib.request.Request(
            f"https://slack.com/api/users.info?user={uid}",
            headers={"Authorization": f"Bearer {token}"}
        )
        resp = json.loads(urllib.request.urlopen(req2).read())
        name = resp.get("user", {}).get("real_name", uid)
    except:
        name = uid
    human_msgs.append(f"{name}: {text}")

if human_msgs:
    print(f"NEW:{new_ts}")
    for m in human_msgs:
        print(m)
else:
    print(f"TS:{new_ts}")
