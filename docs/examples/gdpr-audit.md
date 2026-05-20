# Example: GDPR audit on user data flows

You're building a SaaS that handles user data. You want to audit whether your auth flow is GDPR-compliant.

## Conversation

You: "Audit my auth flow for GDPR. We collect email + hashed password + IP at signup, then session cookies after login. We store everything in PostgreSQL hosted in eu-west-3."

OpenClaw agent (with cleo-legal): *invokes `gdpr-data-protection` skill*

1. Call `search_legal { q: "GDPR lawful basis user authentication", country: "EU", lang: "en", limit: 5 }`
2. Top result: Article 6 of Regulation (EU) 2016/679.
3. `get_document_article { document_id: "<UUID>", article_number: "6" }` → reads Art 6(1)(b) — performance of contract.
4. `search_legal { q: "GDPR data minimisation principle", country: "EU" }` → Art 5(1)(c).
5. `search_legal { q: "GDPR data residency third country transfer", country: "EU" }` → Art 44-49.
6. `get_changes { since: "<90 days ago>", country: "EU", type: "legislation" }` → no recent amendments.

Answer:

```
Your auth flow is fine on lawful basis (Art 6(1)(b), performance of contract) and data minimisation (Art 5(1)(c) — email + hashed password are necessary).

However, IP addresses are personal data (CJEU Breyer C-582/14). Storing them needs:
- A specific purpose (security / fraud prevention OK under Art 6(1)(f))
- A retention period (typically 90 days for security logs)
- Disclosure in your privacy notice

Your data residency (eu-west-3 = Paris) is within the EEA. ✓

Recommendations:
1. Add IP retention policy (90 days, then anonymize or delete).
2. Update privacy notice to disclose IP collection + retention.
3. Document the lawful basis (Art 6(1)(f) for IP) in your record of processing.

Sources:
- Regulation (EU) 2016/679 — EU (2018-05-25) — UUID `xxxx` — eur-lex.europa.eu/eli/reg/2016/679
- CJEU Breyer (Case C-582/14) — EU (2016-10-19) — UUID `xxxx`
```

## What this saved

- 2h reading EUR-Lex for the right articles
- 30min verifying CJEU caselaw on IP addresses
- 15min drafting policy recommendations

Total cost: **3 quota units**.
