# CLAUDE.md — Five Seven Bro (league-member edition)

This is the **shared, read-only edition** of the Five Seven Bro content system. It's generated
from the commissioner's private project by `publish.sh` — so **this repo is a derived artifact**.
Edits you make here are yours to keep locally, but they do **not** flow back upstream, and the
next publish will overwrite anything that collides with a published file. Treat `data/` and
`data/lore/` as a **read-only snapshot** you generate content *from*, not a canon you edit.

## What this is

A system for generating AI content for the **Five Seven Bro** fantasy football league (8-team
Sleeper league, `yooitsgreg` is commissioner): matchup breakdowns, roasts, power rankings, league
narratives, waiver intel, trade analysis. There's no app to build/serve — it's a **data archive +
generated content**. You review anything before you paste it into the group/Sleeper chat.

## Personas

- **Member (you):** query the archive and **generate** content. All the read/generate skills
  (`ffb-*`) are here for you.
- **Commissioner (Greg):** owns the canon, archives finished seasons, adjudicates penalties, and
  publishes to the league. Those tools (`ffb-admin-*`, `archive_season.sh`) live only in the
  private project and are intentionally **not** in this repo.

## Setup

- **Refresh live data (all you need to start):** `./scripts/refresh.sh` re-pulls the NFL player map
  + current-season snapshot from Sleeper's public API. Everything in this repo works from the `data/`
  files this produces — **no MCP required.**

### Optional: live Sleeper MCP server

For small, ad-hoc, interactive Sleeper queries you can add the `sleeper` MCP server. It's optional —
skip it and just use `data/` + `refresh.sh` if you'd rather not configure it. To enable it:

1. **Clone + build the server** (once), as a sibling folder of this repo:
   ```bash
   cd ..                                            # so it sits next to ffb-league/
   git clone https://github.com/yooitsgreg/sleeper-mcp.git
   cd sleeper-mcp && npm install && npm run build    # produces dist/index.js
   ```
2. **Point this repo at it:** copy the template and (if you cloned it somewhere else) edit the path:
   ```bash
   cd ../ffb-league
   cp .mcp.json.example .mcp.json
   ```
   The template assumes `../sleeper-mcp/dist/index.js`. If you cloned it elsewhere, put the absolute
   path to `dist/index.js` in `.mcp.json`. (`.mcp.json` is git-ignored — it's your machine-specific
   config and won't be tracked or overwritten by updates.)
3. **Restart Claude Code** in this folder; the `sleeper` tools will load.

Note the MCP tools return into the chat context, so they're for **small** queries only — never the
14MB player map (see below).

## Two ways to get Sleeper data — pick deliberately

Sleeper's API is **public and unauthenticated** (`https://api.sleeper.app/v1/...`).

1. **`curl` to disk** — for bulk/historical pulls. **Always** use this for the NFL player map
   (`data/players/nfl_players.json`, ~14MB / 12,200 players): it's the player_id→name resolver and
   must NEVER be loaded into the chat context (it will blow the context window). curl it to a file,
   then read only the IDs you need with `jq`. It's git-ignored — regenerate with `refresh.sh`.
2. **The `sleeper` MCP server** — small, ad-hoc, interactive queries only. Its tools return into
   context, so they're wrong for bulk data.

## Data architecture: cold vs warm

- `data/2025/` and earlier — **cold archive** of completed seasons. Immutable.
- `data/2026/` — **warm snapshot** of the active season (refreshed via `refresh.sh`).
- `data/players/nfl_players.json` — the ID→name map (git-ignored; regenerate, don't commit).
- `data/lore/` — the story canon + generated content (read-only here).
- `data/README.md` — the data dictionary; read it before touching `data/`.

Past seasons live under a **different Sleeper league_id each year**. Owner IDs are stable across
seasons, so join history by `owner_id`, not league_id.

## Non-obvious conventions (these have already caused bugs)

- **A trade's week is its `.leg` field, NOT the transactions file it came back in.** Filter
  `type=="trade"` and use `.leg`.
- **Toilet bowl: Sleeper's `losers_bracket` `w`/`l` is inverted vs. "who finished last."** The
  toilet-bowl "winner" (`w`) is the one relegated to **last place** (cat-5k penalty). Confirm final
  placement with the commissioner; don't infer it from `w`/`l` naively.
- **The 2026 `league.json` `settings` are mostly unconfigured Sleeper defaults.** Real rules are
  commissioner-stated: 8-team, full PPR, **IDP** (`DL`/`LB`/`DB`/`IDP_FLEX`), reverse-standings
  waivers, snake draft, no keepers, continuing league. See `data/lore/league-rules.md`.
- **IDP is a hard constraint.** Matchup/waiver/roast content must account for defensive roster
  slots and scoring or it's wrong.
- **Ground every factual claim in `data/`, never in the model's own memory.** Player situations,
  injuries, and scores come from the archive/API — not model recall. When data and a claim
  disagree, the data wins.

## Content generation

- **Tone:** brutal / no-mercy, aimed at *decisions and results*, not people. You review everything
  before it's published — you're the safety valve on your own posts.
- **`data/lore/storylines.md`** is the narrative canon and **`data/lore/league-rules.md`** is the
  rules/stakes reference. Read both before writing any piece so facts stay consistent. (Here they're
  read-only — the commissioner maintains the upstream canon.)
- **`data/lore/content-calendar.md`** is the publishing schedule — what piece is due when.
