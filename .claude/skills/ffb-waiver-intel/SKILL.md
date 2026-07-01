---
name: ffb-waiver-intel
description: Generate the Wednesday waiver-wire intel for the Five Seven Bro league — pre-waiver-run pickup targets framed by REVERSE-STANDINGS priority (worst record picks first, no FAAB). Must cover IDP adds (DL/LB/DB), which generic waiver advice ignores. Use before the weekly waiver run.
---

# FFB — Waiver Wire Intel (Wed)

Who should get whom before the waiver run — grounded in this league's rules, not generic advice.

## Before you start
- Run `ffb-refresh` so rosters + the latest transactions are current.
- Read `data/lore/league-rules.md` (reverse-standings waivers, IDP) + `storylines.md` (threads).

## Data sources
- Current rosters + open needs → `data/2026/rosters.json` + `league.json` `roster_positions`.
- Recent adds/drops → `data/2026/transactions_wkN.json`.
- Trending adds → `sleeper` MCP `get_trending_players` (optional) or infer from transactions.
- Player names/positions/injuries → `jq` against `data/players/nfl_players.json` (never load whole).

## Steps
1. Establish **waiver order = reverse standings** (worst record first). Name who holds priority.
2. Identify top available targets by position, including **IDP (DL/LB/DB/IDP_FLEX)** — this is the
   differentiator; call out defensive streamers everyone else forgets.
3. For each target, say **which team should claim them and why** (roster hole, bye, injury replacement),
   and who's likely to be outbid by the reverse-standings order.
4. Flag notable drops worth a speculative add.

## Output
Ranked target list with the "who should get who" framing + an explicit IDP section. Greg reviews
before posting.

## Tone
Brutal but useful — the intel is real; the framing is savage.
