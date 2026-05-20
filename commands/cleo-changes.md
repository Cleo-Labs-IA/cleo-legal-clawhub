---
name: cleo-changes
description: List regulations whose text changed since a given ISO 8601 timestamp (up to 90 days back). Detect what moved since you last reviewed a regulated area.
user-invocable: true
disable-model-invocation: false
argument-hint: "[ISO timestamp | Nd (e.g. 30d)] [country:XX] [type:legislation|...]"
allowed-tools: ["mcp__cleo-legal__get_changes"]
---

List recent regulation changes. Argument: `$ARGUMENTS` is an ISO 8601 timestamp or relative spec (`7d`, `30d`).

## Steps

1. Parse `$ARGUMENTS`:
   - `7d` / `14d` / `30d` / `90d` → ISO timestamp = `now - N days`
   - ISO 8601 → use as-is
   - Empty → default `7d`
2. Detect inline filters: `country:XX`, `source:eur-lex`, `type:legislation|sanction|...`.
3. Call MCP tool `get_changes` with:
   ```json
   {
     "since": "<ISO timestamp>",
     "country": "<from filter>",
     "source": "<from filter>",
     "type": "<from filter>",
     "limit": 50
   }
   ```
4. Render a table: `date | title | country | source | change_type | UUID`.
5. Suffix: "Use `/cleo-doc <UUID>` to read any of these."

## Error handling

- Same as `/cleo-search`.
- `since` > 90 days ago: clarify the 90-day limit, default to `90d`.
