# Post-launch checklist

## T-24h (day before launch)

- [ ] `validate-plugin` CI green
- [ ] PostHog production env vars set (`POSTHOG_API_KEY`, `POSTHOG_HOST` on Railway)
- [ ] PostHog dashboard "ClawHub funnel" created (events: `cli_first_lookup`, `cli_lookup_success`, `cli_quota_hit`, `signup_completed`, `paid_conversion`, all filtered to `install_source=clawhub`)
- [ ] UTM params tested on signup landing (`?utm_source=clawhub&utm_campaign=launch-2026-05`)
- [ ] 30s/45s/120s demo videos shot (Screen Studio)
- [ ] Pre-write 4 r/OpenClaw replies for likely questions
- [ ] Brief 5 friends in OpenClaw community for authentic engagement (NO fake upvotes)

## Launch day (T=0)

- [ ] Run `scripts/publish-clawhub.sh` (manual first time — or `git tag v1.0.0 && git push origin v1.0.0` for CI)
- [ ] Verify https://clawhub.ai/plugins/cleo-legal is live (~30-60 min)
- [ ] Verify cover image displays correctly
- [ ] Post Reddit r/OpenClaw OR r/LocalLLaMA thread (launch-copy/reddit-localllama.md)
- [ ] Post X with native video (launch-copy/x-openclaw.md)
- [ ] Post on OpenClaw Discord (if community Discord exists)
- [ ] PostHog dashboard check — first install events arriving?

## T+1d

- [ ] Reply to all comments within 30 min
- [ ] Submit OpenClaw docs announce (if accepts)
- [ ] DMs to 20-30 OpenClaw-active devs (personalized)
- [ ] Funnel check 1 — installs, first lookups, conversion

## T+1w

- [ ] Blog post on cleolabs.co/blog: "Launching on ClawHub: what I learned about OpenClaw"
- [ ] X follow-up thread (architecture deep-dive on WIPO Lex)
- [ ] Awesome-openclaw PRs (Task 16)

## Funnel KPIs (daily for 14 days)

| Metric | Target (6w) | PostHog query |
|---|---|---|
| ClawHub installs | 300-500 | `cli_first_lookup` filtered to `install_source=clawhub` |
| First-lookup conversion | 80%+ | install → first lookup |
| Activation (2nd lookup, 7d) | 35% | first → second lookup within 7d |
| Quota → signup | 25%+ | `cli_quota_hit` → `signup_completed` (UTM match) |
| Signup → Pro | 5-8% | `signup_completed` → `paid_conversion` |

If any metric drops 50% below target, pause amplification and fix the funnel.

## ClawHub-specific metrics (weekly)

| Metric | Target | Where |
|---|---|---|
| Install count on listing | growing | `clawhub stats @cleo-legal/openclaw-plugin` |
| Verified badge | week 12 | clawhub.ai listing |
| Featured pick | week 4 | editorial |
| Recently updated rank | top 20 in "Data & APIs" | listing search results |

If install count is low after 2 weeks:
- Rewrite description (vector search uses it heavily)
- Add/refine tags (check what top automation plugins use)
- Ship a patch v1.0.x to bump "Recently updated"
- Re-engage community with a new demo or use case

## Awesome list PRs (Task 16 placeholder)

| Repo | PR # | Date submitted | Status |
|---|---|---|---|
| awesome-openclaw | #XX | YYYY-MM-DD | open / merged |
| awesome-clawhub-plugins | #XX | … | … |
| awesome-mcp-servers | #XX | … | … |
| modelcontextprotocol/servers | #XX | … | … |
