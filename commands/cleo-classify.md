---
name: cleo-classify
description: Classify a product into customs tariff codes (HS6, TN VED, CN8, HTS) from any-language description. Top candidates with confidence + customs rationale.
user-invocable: true
disable-model-invocation: false
argument-hint: "<product description> [to:XX] [system:hs6|tn_ved|cn8|hts]"
allowed-tools: ["mcp__cleo-legal__customs_lookup"]
---

Classify a product. Argument: `$ARGUMENTS` is the product description (2-2000 chars, any language).

## Steps

1. Parse `$ARGUMENTS`. If empty, ask: "Describe the product — e.g., 'stainless steel beam, 6m, structural'. Any language."
2. Detect optional inline `to:XX` (destination ISO-2) and `system:hs6|tn_ved|cn8|hts`.
3. Call MCP tool `customs_lookup` with:
   ```json
   {
     "description": "<stripped description>",
     "country": "<to: filter or undefined>",
     "system": "<system: filter or undefined>",
     "top": 5
   }
   ```
4. Render candidates as a numbered table: `code | title | confidence | rationale`.
5. Suffix: "Next: `/cleo-compliance \"<product>\" <ISO-2>` for full decision pack."

## Error handling

- Same as `/cleo-search` (402, 401).
- All candidates < 0.5 confidence: warn "Please refine the description (function + material + dimensions)."
