---
name: cleo-compliance
description: Composite compliance check from product + destination. Full decision pack (tariff + obligations + dual-use + EAEU + lead time). Consumes 5 quota units.
user-invocable: true
disable-model-invocation: false
argument-hint: "<product description> <ISO-2 destination> [--client government|defense|oil_gas|...]"
allowed-tools: ["mcp__cleo-legal__compliance_check"]
---

Composite compliance check. Arguments: `$ARGUMENTS` must contain a product description AND a destination ISO-2 country code.

## Steps

1. Parse `$ARGUMENTS`. Expected formats:
   - `"<description>" <ISO-2>` (e.g., `"drone with infrared camera" KZ`)
   - `<description> --to <ISO-2>`
2. If destination missing: "What's the destination country (ISO-2, e.g., KZ, DE, US)?"
3. If description missing: "What's the product?"
4. Optional inline filter: `--client government|defense|oil_gas|retail|...`.
5. Call MCP tool `compliance_check` with:
   ```json
   {
     "product": { "description": "<description>" },
     "destination_country": "<ISO-2>",
     "client_type": "<--client or undefined>",
     "options": {
       "include_alternatives": true,
       "include_dual_use_check": true,
       "include_parallel_import": true
     }
   }
   ```
6. Render decision pack with explicit confidence tiers per item. Use one of three labels next to each conclusion:
   - `EXACT` — direct retrieval / authoritative source returned.
   - `PROBABLE` — synthesis based on classification + obligations mapping with confidence ≥ 0.6.
   - `TENTATIVE` — synthesis with confidence < 0.6, or partial matches only.

   Structure:
   - **Primary tariff code** — `tier` (confidence), with rationale.
   - **Legally required obligations** — each item tagged `EXACT` (cited regulation) or `PROBABLE` (rule-engine inference).
   - **Contractually expected** — always `PROBABLE` or `TENTATIVE`; never `EXACT`.
   - **Dual-use status** — print `clear` / `possible flag` / `high-confidence flag` based on the API response (`flagged: false`, low-confidence flag, or `>=0.7` confidence flag respectively). Never collapse "possible" into "high-confidence".
   - **EAEU parallel import** (if applicable) — `tier` per the EAEU resolver response.
   - **Estimated lead time** — always `PROBABLE` (model-based estimate).
7. **ALWAYS** append the `advisory_disclaimer` from the response verbatim. Never drop it.
8. Warn: "This call consumed **5 quota units**."

## Error handling

- Same as `/cleo-search`.
- If `advisory_disclaimer` missing: show fallback "Final classification must be validated by a licensed broker."
- If dual-use is flagged but the product description is short (< 80 chars) or generic (e.g., "pump", "camera"): downgrade the displayed tier to `possible flag` even if the API returned high confidence, and prompt the user to add technical specs (power rating, range, sensor sensitivity, etc.) for a more reliable check.
