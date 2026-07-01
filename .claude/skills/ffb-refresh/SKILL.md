---
name: ffb-refresh
description: Refresh the warm 2026 season snapshot + NFL player map from Sleeper's public API before generating any data-dependent FFB content. Run this at the start of every content session so matchups/rosters/transactions are current. Not needed for cold historical (2025 and earlier) pieces.
---

# FFB — Refresh Data

Pull the current-season warm snapshot and the ID→name player map so every downstream piece is
grounded in fresh `data/`.

## Steps
1. Run `./scripts/refresh.sh` from the repo root.
2. Confirm the reported `week=` and `season_type=` match reality. In-season, it also pulls
   `matchups_wkN.json` + `transactions_wkN.json` for the live week.
3. Confirm the player map count is ~12,000+ (`data/players/nfl_players.json`). It's git-ignored and
   ~14MB — **never read it into context;** resolve only the IDs you need with `jq`.

## Notes
- If `season_type=off`, only the league/rosters/users/draft snapshot refreshes (no weekly files).
- This is the prerequisite for `ffb-recap`, `ffb-waiver-intel`, `ffb-matchup-preview`,
  `ffb-power-rankings`, and `ffb-trade-analysis`.
