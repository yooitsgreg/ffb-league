#!/usr/bin/env bash
# Refresh WARM data (current season) + the NFL player map from Sleeper's public API.
# Cold/historical seasons are archived once via archive_season.sh and never refetched.
# Usage: ./scripts/refresh.sh
set -euo pipefail
cd "$(dirname "$0")/.."

API="https://api.sleeper.app/v1"
SEASON_2026_LEAGUE="1312820020279017472"
SEASON_2026_DRAFT="1312820020287389696"
DATADIR="data"

echo "==> NFL state"
curl -s --max-time 30 "$API/state/nfl" -o "$DATADIR/2026/nfl_state.json"
WEEK=$(jq -r '.week' "$DATADIR/2026/nfl_state.json")
TYPE=$(jq -r '.season_type' "$DATADIR/2026/nfl_state.json")
echo "    week=$WEEK season_type=$TYPE"

echo "==> Player map (14MB, straight to disk — never loaded into chat context)"
curl -s --max-time 180 "$API/players/nfl" -o "$DATADIR/players/nfl_players.json"
echo "    players: $(jq 'length' "$DATADIR/players/nfl_players.json")"

echo "==> 2026 league snapshot"
curl -s --max-time 30 "$API/league/$SEASON_2026_LEAGUE"         -o "$DATADIR/2026/league.json"
curl -s --max-time 30 "$API/league/$SEASON_2026_LEAGUE/rosters" -o "$DATADIR/2026/rosters.json"
curl -s --max-time 30 "$API/league/$SEASON_2026_LEAGUE/users"   -o "$DATADIR/2026/users.json"
curl -s --max-time 30 "$API/draft/$SEASON_2026_DRAFT"           -o "$DATADIR/2026/draft.json"
curl -s --max-time 30 "$API/draft/$SEASON_2026_DRAFT/picks"     -o "$DATADIR/2026/draft_picks.json" || true

# During the season, also pull the live week's matchups + transactions.
if [ "$TYPE" != "off" ] && [ "$WEEK" -gt 0 ] 2>/dev/null; then
  echo "==> Live week $WEEK matchups + transactions"
  curl -s --max-time 30 "$API/league/$SEASON_2026_LEAGUE/matchups/$WEEK"      -o "$DATADIR/2026/matchups_wk$WEEK.json"
  curl -s --max-time 30 "$API/league/$SEASON_2026_LEAGUE/transactions/$WEEK"  -o "$DATADIR/2026/transactions_wk$WEEK.json"
fi

echo "Done. Refreshed $(date)"
