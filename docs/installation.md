# Installation

## OpenClaw (ClawHub)

1. Make sure OpenClaw + ClawHub CLI are installed:
   ```bash
   npm install -g openclaw clawhub
   ```

2. Install the plugin:
   ```bash
   openclaw plugins install clawhub:@alexbloch-ia/legal-data
   ```

3. Run setup:
   ```bash
   openclaw run /cleo-setup
   ```

   Opens legaldata-public.cleolabs.co/signup in your browser. Sign up, copy the `ld_live_...` API key, paste back.

4. Export the env var (your shell):
   ```bash
   echo 'export CLEO_LEGAL_API_KEY="ld_live_..."' >> ~/.zshrc
   source ~/.zshrc
   openclaw mcp restart cleo-legal
   ```

5. Verify:
   ```bash
   openclaw run /cleo-search "GDPR Article 17"
   ```

## Verification

The plugin ships with:
- 6 slash commands (visible via `openclaw commands list | grep cleo`)
- 5 auto-invoked skills (visible via `openclaw skills list | grep cleo`)
- 1 MCP server (`openclaw mcp list` → `cleo-legal`)

## Updating

```bash
openclaw plugins update --all
```

Or specifically:

```bash
openclaw plugins update clawhub:@alexbloch-ia/legal-data
```

## Uninstall

```bash
openclaw plugins uninstall legal-data
rm -rf ~/.cleo-legal
unset CLEO_LEGAL_API_KEY
```
