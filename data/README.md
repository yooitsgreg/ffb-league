# Five Seven Bro — Data Archive

Local archive of league data pulled from Sleeper's **public** API (no auth). The point:
read from these files instantly instead of hitting the API on every content generation.

## Source of truth
- The big NFL player map (`players/nfl_players.json`, ~14MB, 12,200 players) is the
  ID→name "Rosetta Stone." Player IDs in rosters/trades/picks resolve through it.
- It's git-ignored (too big); regenerate anytime with `scripts/refresh.sh`.

## Cold vs warm
- **Cold (immutable):** `data/2025/` — a completed season. Written once, never refetched.
- **Warm (changes):** `data/2026/` — current season. Refresh on a cadence with `scripts/refresh.sh`.
- **Manual (no API archive yet):** `data/2011/`–`data/2024/` — only `standings.md` each. **All seasons
  2011–2024 are now fully transcribed** from screenshots (regular-season W-L/Stk/PF/PA + Top-3/playoff
  finish). Full final placements exist for **2011–2019** (1–12 for 2011, 1–14 for 2012/2013, 1–10 for
  2014–2017, 1–8 for 2018/2019); **2020–2024 are Top-3 only.** Not full API pulls; run `archive_season.sh`
  to cold-archive them properly once each year's league_id/draft_id are known. (2011 and 2012 were 14-game
  regular seasons; 2013–2020 were 13-game; 2021+ are 14.) **2011 is the founding year.** 2011 was a 12-team
  3-division league; 2012 was a 14-team 3-division league; 2013 was a 14-team 4-division league; 2014 was a
  10-team 2-division league; 2015–17 were 10-team leagues (2015 also had two divisions); contracted to 8 from
  2018 onward. **Platform history:** NFL.com 2011–2013 + 2015–2024, **FleaFlicker in 2014 only**, Sleeper 2025+.
  Brien was a 2011–2015 member (2014 3rd at 12-1), came back as Corey's 2019 placeholder. Tyler→Ryan swap for
  2017; Preston+Ryan departed 2018. Former members in the archive: Josh, Retail Tom, Brien, Tyler, Ryan,
  Preston, chris, Frank, Justin, Evan, **Schawn-Paul (2011 champion)**, **Will McLaughlin (2011-only)** —
  kept separate from current members, never in `owners.md`.

## Layout
```
data/
  owners.md                  # real name <-> Sleeper handle <-> team <-> user_id (join by user_id)
  players/nfl_players.json   # ID -> {full_name, position, team, injury_status, ...}
  2011/                      # MANUAL (NFL.com screenshot; 14-game, 12-team 3-division) — founding year; full 1–12 + PF/PA
    standings.md             # final placements + regular-season W-L/Stk/PF/PA, all owners confirmed
  2012/                      # MANUAL (screenshot only, 14-game season; 14-team 3-division format; full 1-14 + PF/PA) — all 14 owners confirmed
    standings.md             # final placements + regular-season W-L/Stk/PF/PA, all owners confirmed
  2013/                      # MANUAL (screenshot only, 13-game season; 14-team 4-division format; full 1-14 + PF/PA) — all 14 owners confirmed
    standings.md             # final placements + regular-season W-L/Stk/PF/PA, all owners confirmed
  2014/                      # MANUAL (FleaFlicker screenshot; 13-game, 10-team 2-division) — full 1–10 + PF/PA
    standings.md             # final placements + regular-season W-L/Strk/PF/PA, all owners confirmed
  2015/                      # MANUAL (screenshot only, 13-game season; full 1-10 + PF/PA) — 10-team, 2-division (Kalimdor/Eastern Kingdoms); all owners confirmed
    standings.md             # final placements + regular-season W-L/Stk/PF/PA by division + overall seed
  2016/                      # MANUAL (screenshot only, 13-game season; full 1-10 + PF/PA) — 10-team league; all owners confirmed
    standings.md             # final placements + regular-season W-L/Stk/PF/PA, all owners confirmed
  2017/                      # MANUAL (screenshot only, 13-game season; full 1-10 + PF/PA) — 10-team league; all owners confirmed
    standings.md             # final placements + regular-season W-L/Stk/PF/PA, all owners confirmed
  2018/                      # MANUAL (screenshot only, 13-game season; full 1-8 + PF/PA)
    standings.md             # final placements + regular-season W-L/Stk/PF/PA, team->owner mapped
  2019/                      # MANUAL (screenshot only, 13-game season; full 1-8 + PF/PA)
    standings.md             # final placements + regular-season W-L/PF/PA, team->owner mapped
  2020/                      # MANUAL (screenshot only, 13-game season)
    standings.md             # regular-season W-L/Stk/PF/PA + Top-3 finish, team->owner mapped
  2021/                      # MANUAL (screenshot only, not an API pull)
    standings.md             # regular-season W-L/Stk/PF/PA + Top-3 finish, team->owner mapped
  2022/                      # MANUAL (screenshot only, not an API pull)
    standings.md             # regular-season W-L/Stk/PF/PA + Top-3 finish, team->owner mapped
  2023/                      # MANUAL (screenshot only, not an API pull)
    standings.md             # regular-season W-L/Stk/PF/PA + Top-3 finish, team->owner mapped
  2024/                      # MANUAL (screenshot only, not an API pull)
    standings.md             # regular-season W-L/Stk/PF/PA + Top-3 finish, team->owner mapped
  2025/                      # COLD archive (final)
    standings.md             # full 1-8 placements + regular-season W-L/Stk/PF/PA (derived from API)
    league.json rosters.json users.json
    winners_bracket.json losers_bracket.json
    draft.json draft_picks.json
    transactions_wk1..17.json
    trades.json              # trades only, .week == true leg (NOT file order)
    trades_resolved.json     # trades with real player names (human-readable)
  2026/                      # WARM snapshot
    league.json rosters.json users.json draft.json nfl_state.json
    (matchups_wkN / transactions_wkN added during the season)
```

## Gotchas learned the hard way
- **Trade week = the `leg` field**, not the transactions file it came back in. Tagging by
  file order produced wrong weeks; always use `.leg`.
- The 2026 `league.json` `settings` block is mostly **unconfigured Sleeper defaults**
  (e.g. shows keepers/FAAB the league doesn't use). Treat real rules as commissioner-stated,
  not API-derived.

## Scripts
- `scripts/refresh.sh` — re-pull player map + current-season warm data (+ live week in season).
- `scripts/archive_season.sh <league_id> <draft_id> <year>` — one-time cold archive of a finished season.

## League/draft IDs
- 2026: league `1312820020279017472`, draft `1312820020287389696`
- 2025: league `1255979703882219520`, draft `1255979705220222976`
