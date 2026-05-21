#!/usr/bin/env bash
# Manually publish to ClawHub. (CI does this automatically on v* tags.)
#
# Pre-req: `clawhub login` (GitHub OAuth, account must be 1+ week old).

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if ! command -v clawhub &>/dev/null; then
  echo "Installing clawhub CLI..."
  npm install -g clawhub
fi

# Dry-run first
echo "==> Dry run"
clawhub package publish . --dry-run

read -rp "Proceed with actual publish? [y/N] " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "Aborted."
  exit 0
fi

echo "==> Publishing"
clawhub package publish .

echo "==> Done. Listing at https://clawhub.ai/plugins/@alexbloch-ia/legal-data within 30 min (VirusTotal scan)."
