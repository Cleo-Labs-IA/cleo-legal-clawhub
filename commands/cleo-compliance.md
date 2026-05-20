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
6. Render decision pack:
   - **Primary tariff code** with confidence
   - **Legally required obligations** (bulleted)
   - **Contractually expected** (bulleted)
   - **Dual-use status** (clear / flagged)
   - **EAEU parallel import** (if applicable)
   - **Estimated lead time**
7. **ALWAYS** append the `advisory_disclaimer` from the response verbatim. Never drop it.
8. Warn: "This call consumed **5 quota units**."

## Error handling

- Same as `/cleo-search`.
- If `advisory_disclaimer` missing: show fallback "Final classification must be validated by a licensed broker."
