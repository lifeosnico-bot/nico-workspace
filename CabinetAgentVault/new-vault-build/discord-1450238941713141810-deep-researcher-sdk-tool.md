---
title: "Librarian Intake — Deep Researcher SDK Tool Setup"
date: 2026-03-09
tags: [librarian, discord-intake, letta, docker, tools, deep-research]
status: active
type: research
project: nico-agent
source: "https://discord.com/channels/1161736243340640419/1450238941713141810/1450238941713141810"
---

# Librarian Intake — Deep Researcher SDK Tool Setup

## Captured Instructions

### 1) Docker image extension
```dockerfile
FROM letta/letta:latest

RUN /app/.venv/bin/python3 -m pip install deep-researcher-sdk
```

### 2) Required environment variable
- `GEMINI_API_KEY` must be set in runtime environment.

### 3) Letta tool function
```python
def deep_research(query: str) -> str:
    """
    Conduct deep research on a topic and return a comprehensive report.
    Use this tool when you need to research a topic thoroughly before
    making recommendations or answering complex questions. The query
    should be specific and well-defined.
    Args:
        query (str): The research topic or question to investigate
    Returns:
        str: A comprehensive markdown report with findings and sources
    """
    from deep_research import research
    result = research(query)
    return result.report
```

### 4) Register + attach to an agent
```python
from letta_client import Letta

client = Letta(base_url="http://localhost:8283")

tool = client.tools.create_from_file(filepath="deep_research_tool.py")
client.tools.attach_to_agent(agent_id="your-agent-id", tool_id=tool.id)
```

## Notes for Nico workflow
- This is an integration recipe, not yet validated in local runtime.
- Next implementation step would be creating a dedicated test agent and running a smoke query.
