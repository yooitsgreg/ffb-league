---
name: ffb-recap
description: Generate the Tuesday weekly recap for the Five Seven Bro league — results, biggest blowout + worst bad beat, one roast per loser, and the 🍦 Smirnoff Watch (any STARTED player who scored ≤0 owes a Smirnoff Ice video). Use after a week's games finish. Full-PPR IDP league — account for defensive slots.
---

# FFB — Weekly Recap + Roasts + Smirnoff Watch (Tue)

The week's results turned into brutal, decision-focused content. One guaranteed weekly bit: the
Smirnoff Watch.

## Before you start
- Run `ffb-refresh` so `data/2026/matchups_wkN.json` + `transactions_wkN.json` are current.
- Read `data/lore/storylines.md` (voice + running threads) and `data/lore/league-rules.md` (stakes).

## Data sources
- Scores/starters → `data/2026/matchups_wkN.json` (`starters`, `starters_points`, `points`).
- Adds/drops/trades → `data/2026/transactions_wkN.json`.
- Owner ↔ roster_id ↔ team → `data/owners.md` + `data/2026/rosters.json`.
- Player names → resolve IDs against `data/players/nfl_players.json` with `jq` (never load it whole).

## Steps
1. Pair up matchups by `matchup_id`; compute margins. Flag the **biggest blowout** and the
   **closest / worst bad beat** (high score in a loss).
2. Write one roast per losing team — aim at the *decision* (bad start/sit, benched a stud, IDP
   punt), not the person.
3. **🍦 Smirnoff Watch:** for every team, scan `starters` for any *started* player at **≤0 pts**.
   Bench zeros don't count. Each offender owes a Smirnoff Ice chug video — name them.
4. Weave in active threads from `storylines.md` (grudges, the Crown Watch, Toilet Watch once it's live).

## Output
Short header (tone + "claims data-verified"), then: headline result, blowout, bad beat, per-loser
roasts, and the Smirnoff Watch block. Greg reviews before it hits the group + Sleeper chat.

## Tone
Brutal, no-mercy, aimed at decisions and results — never cheap shots at people.
