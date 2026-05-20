# cleo-legal — OpenClaw plugin

> **Stop your OpenClaw agent from hallucinating legal citations.** Real regulations from 66 official sources across 100+ countries — GDPR, customs/HS codes, sanctions, dual-use, GOST, EAEU.

[![License: MIT-0](https://img.shields.io/badge/License-MIT--0-yellow.svg)](https://opensource.org/licenses/MIT-0)
[![ClawHub](https://img.shields.io/badge/ClawHub-cleo--legal-blue)](https://clawhub.ai/plugins/cleo-legal)
[![MCP](https://img.shields.io/badge/MCP-19%20tools-green)](https://modelcontextprotocol.io)
[![Coverage](https://img.shields.io/badge/coverage-66%20sources%20·%20100%2B%20countries-green)](https://cleolabs.co/legal)

## What it does

- **`/cleo-search "GDPR Article 17"`** — Real article text from EUR-Lex, not hallucinated
- **`/cleo-classify "stainless steel beam"`** — HS code with confidence + customs rationale (multilingual)
- **`/cleo-compliance "drone with infrared camera" KZ`** — Full decision pack: tariff + obligations + dual-use + EAEU + lead time
- **`/cleo-doc <UUID>`** — Full text of any document
- **`/cleo-changes 30d`** — Regulations that moved in the last 30 days
- **`/cleo-setup`** — First-run onboarding (3 free lookups, then pay-as-you-go)

Plus **5 SEO-targeted skills** that auto-invoke when your agent detects regulatory questions: `regulatory-research`, `gdpr-data-protection`, `customs-hs-classifier`, `dual-use-export-control`, `sanctions-screening`.

## Install

```bash
openclaw plugins install clawhub:cleo-legal
```

Then run setup:

```bash
openclaw run /cleo-setup
```

This opens [cleolabs.co/signup](https://cleolabs.co/signup) in your browser. Create an account, copy the `ld_live_...` API key, paste it back.

Set the env var:

```bash
echo 'export CLEO_LEGAL_API_KEY="ld_live_..."' >> ~/.zshrc
source ~/.zshrc
openclaw mcp restart cleo-legal
```

## Verify

```bash
openclaw run /cleo-search "GDPR Article 17"
```

You should get real Article 17 text from EUR-Lex.

## Pricing

| Tier | Quota | Price |
|---|---|---|
| **Free** | 3 lookups (lifetime) | $0 |
| **Pro** | 300/min · 1M/mo | (see cleolabs.co/pricing) |
| **Enterprise** | 1500/min · 10M/mo | Contact sales |

Composite endpoints (`/cleo-compliance`) consume 5 units per call.

## Coverage

66 official sources, including:

- **EU**: EUR-Lex, EDPB, ECHA, EFSA
- **France**: Legifrance (PISTE), CNIL
- **Germany**: BWB, BaFin, BfArM
- **UK**: legislation.gov.uk, ICO, FCA
- **US**: eCFR, Federal Register, FDA, OFAC SDN
- **Spain**: BOE, AEPD
- **Italy**: Normattiva
- **Russia / EAEU**: EEC TR CU, GOST R
- **WIPO Lex** as universal fallback for 100+ countries

Full list: [coverage report](https://cleolabs.co/legal/coverage).

## Examples

- [GDPR audit on user data flows](docs/examples/gdpr-audit.md)
- [Customs HS classification for a complex product](docs/examples/customs-classify.md)
- [Composite compliance check for cross-border shipment](docs/examples/compliance-check.md)

## Troubleshooting

See [docs/troubleshooting.md](docs/troubleshooting.md) — covers the streamable-http header bug workaround (OpenClaw issue #65590, May 2026).

## Architecture

This plugin wraps the [Cleo Legal API's MCP server](https://api.legaldata.cleolabs.co/mcp) (Streamable HTTP, Bearer auth, 19 tools). The MCP server itself handles 66 sources, multi-language search, embeddings, content-change detection, and the WIPO Lex universal fallback for geo-blocked jurisdictions.

For the backend architecture, see [the main repo](https://github.com/Cleo-Labs-IA/cleo-legal-api).

## License

MIT-0 (ClawHub requirement). Plugin source is fully open; API access requires an account.

## Issues & feedback

[github.com/Cleo-Labs-IA/cleo-legal-clawhub/issues](https://github.com/Cleo-Labs-IA/cleo-legal-clawhub/issues)

## Maintainer setup

CI requires two GitHub secrets (Settings → Secrets → Actions):

- `CLAWHUB_TOKEN`: ClawHub publisher token (obtain via `clawhub login` locally, copy from `~/.clawhub/credentials`)
- `NPM_TOKEN`: npm automation token with publish rights to `@cleo-legal/*`

Release: `git tag v1.0.x && git push origin v1.0.x`. CI publishes to ClawHub + npm.
