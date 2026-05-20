---
name: cleo-doc
description: Fetch the full text of a single legal document by UUID. Use after /cleo-search.
user-invocable: true
disable-model-invocation: false
argument-hint: "<UUID>"
allowed-tools: ["mcp__cleo-legal__get_document_text"]
---

Fetch full document text. Argument: `$ARGUMENTS` is a UUID.

## Steps

1. Validate `$ARGUMENTS` against UUID regex `/^[0-9a-f-]{36}$/i`. If invalid: "Argument must be a UUID — get one from `/cleo-search`."
2. Call MCP tool `get_document_text` with `{ id: "<uuid>" }`.
3. Render: title + country + effective_date + full text. If > 50k chars, show first 50k + suggest `get_document_article`.

## Error handling

- 404: "Document not found. Search again with `/cleo-search`."
- Same as `/cleo-search` for 401/402.
