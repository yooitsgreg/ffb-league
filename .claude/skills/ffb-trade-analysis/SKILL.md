---
name: ffb-trade-analysis
description: Analyze a Five Seven Bro trade when one drops — winner/loser verdict, both sides' rationale, and how it stacks against The Chase Trade benchmark. Spike this the week before the ~Week 12 deadline. Full-PPR IDP league. Use when a trade posts.
---

# FFB — Trade Analysis

Fire when a trade drops. Deliver a verdict, not a hedge.

## Before you start
- Run `ffb-refresh` so the transactions file with the trade is current.
- Read `data/lore/storylines.md` — **The Chase Trade** is the league's benchmark for every deal.

## Data sources
- The trade → `data/2026/transactions_wkN.json`, filter `type=="trade"`.
  **A trade's real week is its `.leg` field, NOT the file it came back in** — this has caused bugs.
- Rosters before/after → `data/2026/rosters.json`. Player values incl. **IDP** matter.
- Owner ↔ team → `data/owners.md`. Names → `jq` on `nfl_players.json` (never load whole).

## Steps
1. State who gave/got what (resolve player IDs; note any pick swaps).
2. Grade each side's need vs. surplus, including defensive slots (IDP league).
3. Declare a **winner and a loser** — commit to the verdict.
4. Benchmark against **The Chase Trade**: is this a steal, a fair swap, or a future cautionary tale?

## Output
Short verdict piece: the deal, each side's angle, the winner/loser call, the Chase-Trade comp.
Greg reviews before posting.

## Tone
Brutal, decisive, results-oriented.
