---
name: ffb-power-rankings
description: Generate 1–8 power rankings for the Five Seven Bro league with movement arrows and one brutal line per team. Weekly early season, can slow to biweekly. Also supports the pre-draft "way-too-early" v0 (ranked by prior finish + offseason narrative). Full-PPR IDP league.
---

# FFB — Power Rankings (1–8)

Rank all eight teams with movement + one savage line each.

## Before you start
- In-season: run `ffb-refresh` for season-to-date results.
- Read `data/lore/storylines.md` (threads, Crown/Toilet watches) + `league-rules.md`.

## Data sources
- Season-to-date record + points → all `data/2026/matchups_wk*.json` + `rosters.json` (`settings`).
- Rosters / IDP strength → `data/2026/rosters.json`. Names → `jq` on `nfl_players.json` (not whole).
- Offseason / pre-draft (no games yet) → last year's finish in `data/2025/` + `storylines.md`.

## Steps
1. Rank 1–8. In-season use record, points for/against, and roster strength **including IDP**; the
   champ starts with the target painted on (Crown Watch).
2. Show a movement arrow vs. the prior ranking (▲/▼/—).
3. One brutal one-liner per team, aimed at their trajectory/decisions.

## Variants
- **v0 "Way-Too-Early" (pre-draft):** rank by 2025 finish + offseason narrative only. Pure
  shit-stirring — no rosters exist yet. Champion at #1 with a bullseye.

## Output
Numbered 1–8 with arrows + one line each. Greg reviews before posting.

## Tone
Brutal, movement-driven, decision-focused.
