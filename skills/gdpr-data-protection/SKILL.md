---
name: gdpr-data-protection
description: Look up GDPR, CCPA, LGPD, PIPL, UK DPA, PIPEDA, APPI, POPIA, DPDP, and other data protection laws via official sources (EUR-Lex, ICO, CNIL, AEPD, ANPD-BR). Returns real article text, effective dates, and recent amendments. Use when the user asks about privacy law, data protection requirements, lawful bases, DSARs, breach notification, or any other data protection topic.
version: 1.0.0
metadata:
  openclaw:
    requires:
      env: [CLEO_LEGAL_API_KEY]
    primaryEnv: CLEO_LEGAL_API_KEY
    envVars:
      - { name: CLEO_LEGAL_API_KEY, required: true, description: "Cleo Legal API key." }
    emoji: "🔒"
    homepage: https://legaldata-public.cleolabs.co
---

# GDPR & Data Protection Law

Use this skill when the user asks about:
- **GDPR** (EU/EEA) — Regulation (EU) 2016/679
- **UK DPA** — Data Protection Act 2018 + UK GDPR
- **CCPA / CPRA** (California) — Cal. Civ. Code §§ 1798.100 et seq.
- **LGPD** (Brazil), **PIPL** (China), **PIPEDA** (Canada), **APPI** (Japan), **POPIA** (South Africa), **DPDP** (India), **PDPL** (Saudi Arabia/UAE)

## Workflow

1. **Identify the jurisdiction**. "GDPR" → country `EU`. "CCPA" → `US` + Cal filter. If unclear: ask.
2. **Search the specific article**. `search_legal { country: <ISO-2>, q: "<article keyword>", type: "legislation" }`.
3. **Fetch the full article**. Use `get_document_article` for the section, NOT the whole regulation.
4. **Cross-reference**. For GDPR, also check national implementations (Germany → BDSG, France → Loi Informatique et Libertés).
5. **Check amendments**. `get_changes { since: "<90 days ago>", country, type: "legislation" }`.
6. **Cite** UUIDs, article numbers, effective dates, source URLs.

## Common queries

| User asks | MCP call |
|---|---|
| "GDPR Article 17" | `get_document_article { document_id: <GDPR UUID>, article_number: "17" }` |
| "What's the lawful basis for marketing emails?" | `search_legal { q: "lawful basis direct marketing", country: "EU" }` → Art 6 |
| "How long to notify a breach?" | `search_legal { q: "personal data breach notification 72 hours", country: "EU" }` → Art 33 |
| "Does CCPA apply if I'm under $25M revenue?" | `search_legal { q: "California CCPA threshold revenue", country: "US" }` |
| "Compare GDPR and LGPD on consent" | Two `search_legal` calls (country EU + BR) then synthesize |

## Output format

Same as `regulatory-research`: structured answer + **Sources** section with UUIDs + URLs + effective dates.

**Never** summarize without citing. **Never** invent article numbers.
