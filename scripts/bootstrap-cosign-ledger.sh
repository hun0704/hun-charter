#!/usr/bin/env bash
# Repurpose issue #1 as the co-sign ledger, pin it, close #2 as duplicate.
# Requires: gh auth login (as hun0704)
set -euo pipefail
REPO="hun0704/hun-charter"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

gh issue edit 1 --repo "$REPO" \
  --title "Co-sign the Hun Charter v1 — comment here" \
  --body-file "$ROOT/.github/co-sign-ledger-body.md"

gh issue pin 1 --repo "$REPO"

if gh issue view 2 --repo "$REPO" --json state -q .state 2>/dev/null | grep -q open; then
  gh issue close 2 --repo "$REPO" \
    --comment "Duplicate — please co-sign on #1 (comment on the ledger) instead."
fi

echo "Done. Ledger: https://github.com/$REPO/issues/1"
