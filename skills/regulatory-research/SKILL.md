---
name: regulatory-research
description: Look up real laws and regulations across 100+ countries using 66 official sources (EUR-Lex, eCFR, Gov.uk, BOE, BWB, WIPO Lex, Legifrance). Use whenever the user asks "what does the law say about X", needs grounded legal citations for code/contracts/audits, or asks about regulations in any country. Stops the agent from inventing article numbers or citing repealed directives.
version: 1.0.0
metadata:
  openclaw:
    requires:
      env: [CLEO_LEGAL_API_KEY]
    primaryEnv: CLEO_LEGAL_API_KEY
    envVars:
      - { name: CLEO_LEGAL_API_KEY, required: true, description: "Cleo Legal API key (ld_live_...). Get one at https://cleolabs.co/signup" }
    emoji: "⚖️"
    homepage: https://cleolabs.co/legal
---

# Regulatory Research

Use this skill when the user asks regulatory questions like:
- "What does the law say about X in country Y?"
- "Is X legal in Z?"
- "Find me the regulation on …"
- "Cite the article number for …"
- Any question that benefits from grounded legal citations.

## Workflow

1. **Search broadly.** Call MCP tool `search_legal` with a clean, jurisdiction-aware query. Use `country` filter (ISO-2) when the user names a country. Use `type` to narrow to `legislation`, `guideline`, `sanction`, etc.
2. **Open the top result.** Call `get_document_text` on the top UUID to read actual article text.
3. **Check recent changes.** Call `get_changes` with `since` set to 90 days ago + same `country`/`type` filters.
4. **Cite UUIDs + URLs + effective dates** in your final answer. Never paraphrase without citation.
5. **Never invent.** If Cleo doesn't return a clear match, say so: "Cleo Legal has no document matching `<query>` in `<country>`. Possible reasons: source not yet ingested, query too specific, or jurisdiction not covered."

## Example interactions

### Example 1: GDPR right to erasure

User: "Can I delete user data on request under GDPR?"

You:
1. Call `search_legal { q: "GDPR right to erasure", country: "EU", lang: "en", limit: 3 }`
2. Top result UUID `xxxx` is Article 17 of Regulation (EU) 2016/679.
3. Call `get_document_text { id: "xxxx" }` to read Article 17 in full.
4. Quote relevant paragraphs, cite UUID + effective_date (2018-05-25) + EUR-Lex CELEX.

### Example 2: Selling cosmetics in Brazil

User: "What ANVISA regulation applies to cosmetic labelling in Brazil?"

You:
1. `search_legal { q: "cosmetic labelling regulation", country: "BR", lang: "pt", limit: 5 }`
2. Top match → ANVISA RDC 7/2015 or successor.
3. `get_document_text` for full text.
4. `get_changes { since: "<90 days ago>", country: "BR", type: "guideline" }` to flag amendments.
5. Cite UUIDs + ANVISA URL + effective dates.

### Example 3: When no match is found

User: "What's the law on AI agents in Sri Lanka?"

You:
1. `search_legal { q: "AI agents regulation", country: "LK", limit: 5 }` → no relevant matches.
2. Try `search_legal { q: "artificial intelligence", country: "LK", limit: 5 }` → still nothing.
3. Tell the user: "Cleo Legal has no document on AI regulation in Sri Lanka. Sri Lanka's AI policy is still in draft form (CRA-LK 2025 proposal) and not yet enacted."

## Output format

Always conclude with a **Sources** section:

```
Sources:
- {title} — {country} ({effective_date}) — UUID `{uuid}` — {url}
- ...
```

If the user is going to act on the answer (write code, file a contract, run an audit), recommend they verify with a licensed practitioner.
