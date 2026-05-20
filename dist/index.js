// Bundle plugin entry — no runtime code required.
// The plugin's functionality lives entirely in declarative bundle assets:
//   - .claude-plugin/plugin.json   (Claude-compat plugin manifest)
//   - openclaw.plugin.json         (OpenClaw native plugin manifest)
//   - .mcp.json                    (MCP server config — auto-detected by OpenClaw)
//   - skills/<name>/SKILL.md       (5 auto-invoked skills)
//   - commands/<name>.md           (6 user-invocable slash commands)
//
// OpenClaw's validator requires `openclaw.extensions` in package.json to point
// at a runtime entry. We satisfy that with this no-op default export.

export default {
  activate() {},
  deactivate() {},
};
