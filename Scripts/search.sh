#!/bin/bash
# Free web search via Brave Search public endpoint — no API key required
# Usage: search.sh "your query"
QUERY="${1}"
if [ -z "$QUERY" ]; then echo "Usage: search.sh <query>"; exit 1; fi
ENCODED=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "$QUERY")
curl -s -A "Mozilla/5.0" \
  -H "Accept: text/html" \
  "https://html.duckduckgo.com/html/?q=${ENCODED}" \
  | python3 -c "
import sys, re
html = sys.stdin.read()
results = re.findall(r'class=\"result__title\".*?<a[^>]+href=\"([^\"]+)\"[^>]*>(.*?)</a>.*?class=\"result__snippet\"[^>]*>(.*?)</div>', html, re.DOTALL)
for i, (url, title, snippet) in enumerate(results[:8], 1):
    title = re.sub('<[^>]+>', '', title).strip()
    snippet = re.sub('<[^>]+>', '', snippet).strip()
    print(f'{i}. {title}')
    print(f'   {url}')
    print(f'   {snippet}')
    print()
"
