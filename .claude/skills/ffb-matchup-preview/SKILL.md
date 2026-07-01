---
name: ffb-matchup-preview
description: Generate Thursday head-to-head matchup previews for the Five Seven Bro league before TNF kickoff — the week's pairings, edges, and a pick for each, leaning on running grudges/threads. Full-PPR IDP league; account for defensive slots. Use at the start of a new week.
---

# FFB — Matchup Previews (Thu)

Head-to-head previews for the upcoming week. Pick winners so there's material when you're wrong.

## Before you start
- Run `ffb-refresh` so the **new** week's `matchups_wkN.json` + rosters are current.
- Read `data/lore/storylines.md` (grudges, rivalries, running threads) + `league-rules.md`.

## Data sources
- This week's pairings + projected starters → `data/2026/matchups_wkN.json`.
- Rosters / IDP slots → `data/2026/rosters.json` + `league.json` `roster_positions`.
- Season-to-date form → prior weeks' `matchups_wk*.json`.
- Owner ↔ team → `data/owners.md`. Player names → `jq` against `nfl_players.json` (never load whole).

## Steps
1. List the week's matchups by `matchup_id` (owner + team names).
2. For each: the key position edge, an X-factor player, **the IDP angle** (whose defense wins the
   week), and any live storyline/grudge between the two.
3. Make an explicit pick per game — commit, so the recap has ammo when it flops.

## Output
One tight preview block per matchup with a bolded pick. Greg reviews before posting.

## Tone
Brutal, thread-aware, decision-focused.
