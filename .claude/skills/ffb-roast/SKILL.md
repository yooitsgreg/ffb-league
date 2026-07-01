---
name: ffb-roast
description: Write an ad-hoc, brutal roast of a single Five Seven Bro team or owner on demand (outside the weekly cadence) — grounded in their actual roster moves, scores, and history. Full-PPR IDP league. Use when asked to roast a specific team/manager.
---

# FFB — Ad-hoc Roast

A savage, data-grounded takedown of one team on request.

## Before you start
- Run `ffb-refresh` if roasting current-season decisions.
- Read `data/lore/storylines.md` for that owner's running threads (title droughts, past chokes,
  the cat-5k history, grudges).

## Data sources
- Owner ↔ team ↔ history → `data/owners.md`, `data/2026/rosters.json`, prior-season archives.
- Their moves/scores → `matchups_wk*.json`, `transactions_wk*.json`. Names → `jq` on `nfl_players.json`.

## Steps
1. Pull the target's real material: bad starts, benched studs, an ignored IDP slot, a lopsided trade,
   a Smirnoff/cat-5k callback, a relevant storyline thread.
2. Build the roast around **decisions and results** — specific, dated, verifiable. Never a personal
   attack on the person.
3. Land at least one callback to canon so it stings with history.

## Output
A tight, brutal paragraph (or short set). Greg reviews before it's shared.

## Tone
No-mercy — but every jab is earned by the data.
