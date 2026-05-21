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
4. Render candidates as a numbered table: `code | title | tier | confidence | rationale`. Map confidence to one of three **explicit tiers**, shown verbatim in the table:
   - `EXACT` — confidence ≥ 0.85 AND no `ambiguous` flag from the response.
   - `PROBABLE` — confidence 0.55–0.85 OR top-N candidate spread within 0.15.
   - `TENTATIVE` — confidence < 0.55, or the API set `ambiguous: true` on any returned candidate.
5. If the response carries `advisory_disclaimer` (Group B endpoint), **always** print it verbatim under the table — never drop it.
6. Suffix: "Next: `/cleo-compliance \"<product>\" <ISO-2>` for full decision pack."

## Error handling

- Same as `/cleo-search` (402, 401).
- All candidates < 0.5 confidence: warn "All candidates are TENTATIVE. Refine the description (function + material + dimensions) before relying on the classification."
- Never present a tariff code as authoritative when the tier is `TENTATIVE` — phrase it as "best current guess, confirm with a licensed broker".
