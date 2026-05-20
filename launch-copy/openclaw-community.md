# OpenClaw community launch copy

ClawHub doesn't have a dedicated forum. Use these channels in parallel.

## Channel 1: OpenClaw documentation site

If `documentation.openclaw.ai` accepts community announcements, submit a "new plugin" note linking to the ClawHub listing.

## Channel 2: r/OpenClaw (if exists) — or r/LocalLLaMA (overlapping audience)

See `launch-copy/reddit-localllama.md`.

## Channel 3: Twitter/X — OpenClaw angle

See `launch-copy/x-openclaw.md`.

## Channel 4: Discord (if community-run)

OpenClaw's community Discord. Brief intro:

```
Hi all — just published cleo-legal on ClawHub. Regulatory data plugin (GDPR, HS codes, sanctions, dual-use) that grounds your OpenClaw agent in real laws from 66 official sources. Free tier 3 lookups.

Install: openclaw plugins install clawhub:legal-data
Source: https://clawhub.ai/plugins/cleo-legal

Happy to do a demo if interested.
```

## Tracking

Every launch URL must carry UTM:

| Source | `utm_source` | `utm_medium` |
|---|---|---|
| ClawHub listing page | `clawhub` | `marketplace` |
| OpenClaw docs announce | `openclaw-docs` | `announce` |
| r/OpenClaw or r/LocalLLaMA | `reddit-openclaw` / `reddit-localllama` | `comment` |
| OpenClaw X post | `x-openclaw` | `tweet` |
| Discord | `discord-openclaw` | `chat` |

## Anti-patterns specific to OpenClaw audience

- Don't lean on "Anthropic" or "Claude Code" branding — OpenClaw was banned by Anthropic. Name-dropping hurts.
- Lead with "for your OpenClaw agent" or "for MCP" — not "for Claude Code".
- Don't use Anthropic-colored imagery in cover assets.
- Be honest if asked about cross-publishing — OpenClaw users respect transparency.
- Address the ClawHavoc security incident proactively: "VirusTotal-clean, no executable scripts, MIT-0 license, source on GitHub."
