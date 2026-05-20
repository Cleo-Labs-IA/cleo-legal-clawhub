---
name: cleo-search
description: Hybrid semantic + keyword search across 66 legal sources in 100+ countries. Returns top results with title, country, excerpt, UUID.
user-invocable: true
disable-model-invocation: false
argument-hint: "<query> [country:XX] [lang:en] [type:legislation|sanction|...]"
allowed-tools: ["mcp__cleo-legal__search_legal"]
---

Search the Cleo Legal database. Argument: `$ARGUMENTS` is a natural-language query (2-500 chars).

## Steps

1. Parse `$ARGUMENTS`. If empty, ask: "What do you want to search? E.g., 'GDPR Article 17' or 'EAEU customs declarations for electronics'."
2. Detect optional inline filters: `country:FR`, `lang:en`, `type:legislation`, `context:oil_gas`, `from:2026-01-01`, `to:2026-05-01`. Strip them from the query and pass as MCP tool args.
3. Call MCP tool `search_legal` with:
   ```json
   {
     "q": "<stripped query>",
     "country": "<from filter>",
     "lang": "<from filter>",
     "type": "<from filter>",
     "context": "<from filter>",
     "date_from": "<from filter>",
     "date_to": "<from filter>",
     "limit": 10
   }
   ```
4. Render results as a numbered list. Each entry: `{title} — {country} ({source}) · {effective_date}\n  {excerpt}\n  UUID: {id}`.
5. Suffix: "Use `/cleo-doc <UUID>` to read full text."

## Error handling

- Empty results: "No matches. Try a broader query, or add `country:XX`."
- 402 quota_exhausted: "You've used your 3 free lookups. Upgrade at https://legaldata-public.legaldata-public.cleolabs.co/pricing?utm_source=clawhub&utm_medium=cli-quota-hit."
- 401: "API key is invalid. Run `/cleo-setup` to reconfigure."
