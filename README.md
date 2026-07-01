# Five Seven Bro — the league's AI content machine 🏈

This repo is an **AI-powered content system** for the Five Seven Bro fantasy league. Point Claude
Code at it and it writes the stuff we actually want in the group chat — matchup previews, brutal
recaps, power rankings, roasts, waiver intel, trade verdicts — all grounded in our **real league
history**, not made-up nonsense.

Every season since 2011 is archived in here. So when it roasts you, it roasts you with receipts.

> **The short version:** clone it, run one script, then type `/ffb-recap` (or any of the skills
> below) into Claude Code. It reads our actual Sleeper data and drafts content you review before
> pasting into the chat. You're always the last set of eyes — nothing auto-posts.

---

## What it can do

Each of these is a **skill** — type the slash command in Claude Code and it runs. Full-PPR **IDP**
league, so everything accounts for our defensive slots (`DL`/`LB`/`DB`), which generic fantasy tools
completely ignore.

| Skill | What you get |
|---|---|
| `/ffb-recap` | Tuesday weekly recap — results, biggest blowout, worst bad beat, a roast per loser, and the 🍦 **Smirnoff Watch** (any *started* player who scored ≤0 owes a Smirnoff Ice video). |
| `/ffb-power-rankings` | 1–8 rankings with movement arrows and one brutal line per team. Also does the pre-draft "way-too-early" version. |
| `/ffb-matchup-preview` | Thursday head-to-head previews before TNF — the week's pairings, edges, and a pick for each, leaning on running grudges. |
| `/ffb-waiver-intel` | Wednesday waiver targets framed by our **reverse-standings** priority (worst record picks first, no FAAB). Covers IDP adds. |
| `/ffb-trade-analysis` | When a trade drops: winner/loser verdict, both sides' rationale, and how it stacks up against **The Chase Trade** benchmark. |
| `/ffb-draft-grades` | Draft-week content — preview, same-night reactions, and the tentpole **Draft Grades + Roasts** (one brutal paragraph per team; grades whether you actually drafted your IDP slots or punted defense). |
| `/ffb-roast` | An ad-hoc, no-mercy roast of any single team or manager on demand — grounded in their actual moves, scores, and history. |
| `/ffb-showcase` | "The Hype Drop" — a short, chat-ready sizzle reel that sells the league on the season by showing real sample content. Good for getting the group chat buzzing. |
| `/ffb-refresh` | Pulls the latest live data before you generate anything. Run it at the start of a session. |

**You don't have to use a skill.** Those are the polished, repeatable pieces — but the whole archive
is sitting right here, so you can just *talk to it*. Ask it anything:

> "Who has the best head-to-head record against me all-time?"
> "How did aballa95's drafts go the last three years?"
> "Build me a case that I got screwed by the schedule in 2024."
> "What's the trash-talkiest stat you can find about the current last-place team?"

It'll dig through the data and answer. The skills are just the shortcuts for the stuff we do every
week.

The **tone is brutal / no-mercy**, but aimed at *decisions and results* — not people. And you review
everything before it goes out. You're the safety valve on your own posts.

---

## What's in the box

- **`data/`** — the league archive. Every completed season (`data/2025/` and earlier) is immutable
  cold storage; `data/2026/` is the live season, refreshed on demand. See `data/README.md` for the
  full data dictionary.
- **`data/lore/`** — the story canon: `storylines.md` (narrative threads — the Chase Trade,
  aballa95's title drought, the Toilet King's irony), `league-rules.md` (format, scoring quirks,
  buy-in/payouts, the cat-5k + Smirnoff penalties), `content-calendar.md` (what piece is due when),
  and `all-time-records.md` (career W-L, titles, single-season records across all 15 seasons).
- **`.claude/skills/`** — the skills above.
- **`scripts/refresh.sh`** — pulls fresh data from Sleeper's public API.

Everything is grounded in `data/` — never in the model's memory. When a claim and the data disagree,
the data wins.

---

## Quick start

You need [Claude Code](https://claude.com/claude-code) and this repo.

```bash
git clone https://github.com/yooitsgreg/ffb-league.git
cd ffb-league
./scripts/refresh.sh        # pull the current-season snapshot + NFL player map
claude                      # start Claude Code, then type e.g. /ffb-recap
```

That's it — no build, no server. `refresh.sh` gives every skill the `data/` files it reads from.

---

## Get the freshest data: the Sleeper MCP server (recommended)

There are two ways this repo gets Sleeper data, and they work best **together**:

1. **`./scripts/refresh.sh`** — pulls a full snapshot of the current season to `data/`. This is all
   you strictly *need*, and it's the right tool for bulk/historical data.
2. **The [Sleeper MCP server](https://github.com/yooitsgreg/sleeper-mcp)** — gives Claude **live,
   on-demand** access to Sleeper so it can pull the freshest numbers *itself*, mid-conversation:
   current-week scores as they update, trending adds/drops, anything that's changed since your last
   `refresh.sh`. It also means you can fire off ad-hoc questions ("what's the score right now?")
   without re-running anything.

It's technically optional — skip it and just lean on `refresh.sh` + `data/` if you'd rather not set
it up. But honestly **you want it**: `refresh.sh` for the snapshot, the MCP for real-time. Setup is a
couple of minutes:

1. **Install the server** as a sibling folder of this repo (needs Node 18+). Full instructions —
   other package managers, other AI clients — are in the
   [sleeper-mcp README](https://github.com/yooitsgreg/sleeper-mcp#installation); the short version:
   ```bash
   cd ..                                     # so it sits next to ffb-league/
   git clone https://github.com/yooitsgreg/sleeper-mcp.git
   cd sleeper-mcp && npm install             # auto-compiles to dist/index.js (no build step)
   ```
2. **Point this repo at it:** copy the bundled template.
   ```bash
   cd ../ffb-league
   cp .mcp.json.example .mcp.json
   ```
   The template already points at `../sleeper-mcp/dist/index.js`, so if it's a sibling folder you're
   done. Cloned it elsewhere? Put the absolute path to `dist/index.js` in `.mcp.json`. (`.mcp.json`
   is git-ignored — your machine-specific config, never tracked or overwritten by updates.)
3. **Restart Claude Code** in this folder; the `sleeper` tools will load.

One caveat: the MCP tools return their results into the chat context, so they're for **small** live
queries — never bulk pulls like the 14MB NFL player map (that's what `refresh.sh` handles, straight
to disk).

Now go run `/ffb-showcase` and drop it in the chat. 🎤
