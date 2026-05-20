# Troubleshooting

## "401 Unauthorized" even though my API key is correct

Known issue in OpenClaw streamable-http transport (#65590, May 2026): custom HTTP headers are not always forwarded to the remote MCP server. If you set `CLEO_LEGAL_API_KEY` correctly but still get 401:

**Workaround A — Force header injection via `openclaw doctor --fix`**

```bash
openclaw doctor --fix
openclaw mcp test cleo-legal
```

**Workaround B — Use SSE transport instead**

Edit your local `.mcp.json` (in the plugin install path or a project override) and change `transport: "streamable-http"` to `transport: "sse"`. Restart OpenClaw.

**Workaround C — Inject the auth via headersHelper**

Replace the `headers` block with:

```json
"headersHelper": {
  "command": "echo",
  "args": ["{\"Authorization\": \"Bearer ${CLEO_LEGAL_API_KEY}\", \"X-Client\": \"openclaw-plugin/1.0.0\"}"]
}
```

OpenClaw runs `headersHelper.command` and merges the returned JSON into the request headers. This bypasses the streamable-http header-forwarding bug.

## "No skill matched"

The plugin's 5 skills auto-invoke based on the user's question. If your question is too short or ambiguous, the agent may not trigger any skill. Try a longer query, or use the explicit slash command:

- `/cleo-search "GDPR Article 17"` instead of "what's article 17"
- `/cleo-classify "stainless steel beam"` instead of "what HS code"

## "402 quota_exhausted"

You've used your 3 free lookups. Upgrade at https://legaldata-public.legaldata-public.cleolabs.co/pricing?utm_source=clawhub.

## Other issues

Open an issue: https://github.com/AlexBloch-IA/cleo-legal-clawhub/issues
