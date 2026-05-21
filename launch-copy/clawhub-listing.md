# ClawHub listing copy

**Submission URL:** https://clawhub.ai/publish-plugin (or CLI: `clawhub package publish .`)

**Title shown on ClawHub** (≤ 80 chars):

```
Cleo Legal — Real laws from 66 sources across 100+ countries (MCP)
```

**Short description** (1-line; ClawHub uses vector search on this — be specific):

```
Stop your agent from hallucinating legal citations. GDPR, customs/HS codes, sanctions, dual-use, EAEU, GOST — real article text from 66 official regulatory sources across 100+ countries, via one MCP server.
```

**Long description** (markdown):

````markdown
## What it does

legal-data is an MCP plugin that gives your OpenClaw agent access to real regulatory data instead of LLM guesses. Wraps the Cleo Legal API's MCP server (19 tools) into a one-install package.

### 6 slash commands

- `/cleo-search "GDPR Article 17"` — Hybrid semantic search across 66 official sources
- `/cleo-classify "stainless steel beam"` — HS / TN VED / CN8 tariff classification (multilingual)
- `/cleo-compliance "drone with infrared camera" KZ` — Full compliance decision pack
- `/cleo-doc <UUID>` — Full text of any document
- `/cleo-changes 30d` — Regulations that moved in the last N days
- `/cleo-setup` — First-run onboarding (3 free lookups, then paid)

### 5 auto-invoked skills

`regulatory-research`, `gdpr-data-protection`, `customs-hs-classifier`, `dual-use-export-control`, `sanctions-screening` — your agent picks the right one based on the question.

## Coverage

66 official sources: EUR-Lex, Legifrance, eCFR, BOE, Gov.uk, BWB, WIPO Lex, EEC TR CU, GOST R, OFAC SDN, and more. Multilingual (RU, ZH, AR, EN, FR, …).

## Pricing

- **Free**: 3 lookups (lifetime)
- **Pro**: 300/min · 1M/mo
- **Enterprise**: 1500/min · 10M/mo

Get a key at https://legaldata-public.cleolabs.co/signup.

## Install

```bash
openclaw plugins install clawhub:@alexbloch-ia/legal-data
openclaw run /cleo-setup
```

## Source

[github.com/AlexBloch-IA/legal-data](https://github.com/AlexBloch-IA/legal-data) — MIT-0.
````

**Tags** (vector-search ranking — be exhaustive):

```
legal, regulatory, compliance, mcp, gdpr, ccpa, lgpd, pipl, customs, hs-code,
tn-ved, sanctions, ofac, sdn, dual-use, wassenaar, kyc, aml, eaeu, gost,
europe, usa, china, russia, data-protection, anti-hallucination,
openclaw-plugin, clawhub
```

**Category:** `Data & APIs` (no dedicated "Legal" category on ClawHub today).

**Cover image:** Cleo logo on dark background, 1200×630px → `assets/clawhub-cover.png`.

**Listing checklist:**

- [ ] GitHub publisher account is 1+ week old (`gh api user --jq '.created_at'`)
- [ ] Repository is public and tagged with the current release (e.g. `v1.2.1`)
- [ ] `package.json` has `openclaw.compat.pluginApi` + `openclaw.build.openclawVersion`
- [ ] `README.md` has install + signup instructions
- [ ] LICENSE is MIT-0
- [ ] No secrets in any committed file
- [ ] VirusTotal-clean (no suspicious scripts in `bin/` or hooks)

**Post-submission expectations:**

- VirusTotal scan: 5-30 min
- Listing public: 30-60 min after scan passes
- "Verified" badge: 100+ downloads + 3+ months active (community convention)
- Featured pick: editorial — depends on novelty + listing quality + recency
