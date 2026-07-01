---
name: ffb-draft-grades
description: Draft-week content for the Five Seven Bro league — draft preview, same-night reactions, and the tentpole Draft Grades + Roasts (one brutal paragraph per team, ≤24h after the draft). Grades whether anyone actually drafted their IDP slots or punted defense. Snake draft, no keepers.
---

# FFB — Draft Preview & Grades (Draft Week)

The year's biggest content spike. Draft is live data the moment it happens.

## Before you start
- Run `ffb-refresh` to pull `draft.json` and (post-draft) `draft_picks.json`.
- Read `data/lore/storylines.md` (per-owner threads, callbacks) + `league-rules.md` (IDP, snake, no keepers).

## Data sources
- Draft order / status → `data/2026/draft.json`.
- Picks → `data/2026/draft_picks.json` (pull post-draft via `refresh.sh`).
- Resulting rosters → `data/2026/rosters.json`. Names → `jq` on `nfl_players.json` (never load whole).

## Pieces
1. **Draft Preview (day before):** snake order, 1.01 watch, who's on the clock to embarrass themselves.
2. **Same-night reactions:** hot takes as picks land.
3. **Draft Grades + Roasts (≤24h) — the tentpole:** one brutal paragraph per team. Call out reaches,
   an early kicker/DST, and **whether they drafted their IDP slots (DL/LB/DB) or punted defense** —
   ignoring IDP is a gradeable sin in this league. Lean on callbacks (does Steve's 1.01 survive Week 7?
   does Aaron draft like a man who never wants to see cat ears again?).

## Output
Separate deliverables per piece above; grades are one graded paragraph per team. Greg reviews before posting.

## Tone
Brutal, callback-heavy, decision-focused.
