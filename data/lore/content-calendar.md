# Five Seven Bro — Content Calendar

> The publishing schedule: what to write, when, and which data it reads from. Maps the content
> engine (matchup breakdowns, roasts, power rankings, narratives, waiver intel, trade analysis)
> onto the league timeline. Every piece pulls from `storylines.md` (voice/threads) +
> `league-rules.md` (facts/stakes) and is grounded in `data/`. Tone: brutal, aimed at
> decisions/results, not people. Greg reviews everything before it hits the group chat + Sleeper chat.
>
> _Created 2026-06-30. Draft date TBD — in-season dates anchor to that once set._

---

## How to read this

- **Cadence is a default, not a deadline.** Greg publishes manually; this is the rhythm to write *to*.
- **Distribution:** AI drafts → Greg reviews → paste into group chat + Sleeper league chat. No bot.
- **Every in-season piece must respect IDP** (DL/LB/DB/IDP_FLEX) — defensive slots/scoring are live.
- **Refresh first.** Run `./scripts/refresh.sh` before writing any data-dependent piece so the
  warm snapshot (`data/2026/`) and player map are current.

---

## Phase 1 — Offseason (now → draft day)

The slow burn. Build anticipation, bank lore, set up rivalries before a single snap.

| Piece | Status | Reads from | Notes |
|---|---|---|---|
| **2025 Season in Review** | ✅ Done | `data/2025/`, `storylines.md` | Showcase piece. The Chase trade, Ant's choke, Greg's 6-8 Cinderella, the cat-5k basement. |
| **The Cat 5k Photo Drop** | 📌 When Aaron's 5k photo exists | `league-rules.md` | The marquee humiliation made real. Short, savage caption piece. The payoff of his entire 2025 arc — *don't* let it pass without content. |
| **Power Rankings v0 (Way-Too-Early)** | ⏳ Pre-draft | `storylines.md`, `data/2025/` | Rank by 2025 finish + offseason narrative. Pure shit-stirring; no rosters yet. Champion at #1 with the target painted on. |
| **Draft Primer / Order Reveal** | ⏳ When draft date + order set | `data/2026/draft.json` | Snake order, 1.01 watch, "who's on the clock to embarrass themselves." Hype the date. |

**Offseason posting rhythm:** ~1 piece every 1–2 weeks to keep the chat warm. Don't flood a dead offseason — scarcity keeps the brutal stuff landing.

---

## Phase 2 — Draft week

The single biggest content spike of the year. Draft is live data the moment it happens.

| Piece | Timing | Reads from |
|---|---|---|
| **Draft Preview** | Day before | `data/2026/draft.json`, `storylines.md` |
| **Live / Same-Night Reactions** | During & right after | `draft_picks.json` (pull post-draft via refresh) |
| **Draft Grades + Roasts** | Morning after (≤24h) | `draft_picks.json`, `rosters.json` |

**Draft Grades is a tentpole.** One brutal paragraph per team. Call out: reaches, the early kicker/DST,
**whether anyone actually drafted their IDP slots or punted defense** (IDP league — ignoring it is a gradeable sin),
and callbacks (does Steve's 1.01 survive Week 7 this year? does Aaron draft like a man who never wants to see cat ears again?).

---

## Phase 3 — In-season weekly rhythm (Weeks 1–14)

The engine. A repeatable weekly loop, anchored to the NFL Thu→Mon game flow + the league's waiver day.
Each NFL week, run this cycle:

| Day | Piece | Reads from | The brief |
|---|---|---|---|
| **Tue** | **Recap + Roasts** + **🍦 Smirnoff Watch** | `matchups_wkN.json`, `transactions_wkN.json` | The week's results, biggest blowout/bad beat, one roast per loser. **Smirnoff Watch:** scan every team's `starters` for any *started* player at **≤0 pts** → they owe a Smirnoff Ice video. Bench zeros don't count. |
| **Wed** | **Waiver Wire Intel** | `transactions`, trending, `data/2026/rosters.json` | Pre-waiver-run targets. **Reverse-standings priority** (worst record picks first) — frame who *should* get who. **Must cover IDP adds** (DL/LB/DB), which everyone else's waiver advice ignores. |
| **Thu** | **Matchup Breakdowns / Previews** | `matchups_wkN.json` (new week), `storylines.md` | Head-to-head previews before TNF kickoff. Lean on running threads + grudges. Pick winners so you have material when you're wrong. |
| **Weekly or biweekly** | **Power Rankings** | season-to-date `matchups`, `rosters` | 1–8 with movement arrows + one brutal line each. Weekly early, can slow to biweekly mid-season. |
| **As it happens** | **Trade Analysis** | `transactions_wkN.json` (`type=="trade"`, week=`.leg`) | Fire when a trade drops. Winner/loser verdict. Every trade measured against **The Chase Trade** benchmark. |

**Recurring segments that ride inside the above:**
- **🍦 Smirnoff Watch** (Tue) — the week's started-a-zero offenders. A guaranteed weekly bit.
- **🚽 Toilet Watch** (mid-season on) — track the basement race; the cat 5k is the looming stakes. Whose name is on the start line?
- **👑 Crown Watch** — the league ganging up (or not) on Corey, the reigning champ.

> **Trade deadline ~Week 12:** spike trade content the week before (deadline-day winners/losers, "who quit").

---

## Phase 4 — Playoffs (Weeks 15–17)

6 teams in, stakes maxed (only 1st profits +$600; 2nd breaks even; 3rd–8th eat their $100).

| Piece | Timing | Notes |
|---|---|---|
| **Playoff Bracket Preview** | Before Wk 15 | Seeds, paths, the money math. 2025 callback: the 6-seed (Greg) wrecked the 2 & 3 seeds — nobody's safe. |
| **Round Recaps + Roasts** | Each playoff Tue | Smirnoff Watch continues — a started zero in the playoffs is *premium* material. |
| **🚽 Toilet Bowl Coverage** | Wks 15–17 | The losers' bracket decides the cat 5k. **Data gotcha: Sleeper's `losers_bracket` `w` = the team relegated to LAST.** Confirm final placement with commissioner before naming the loser (this bit us in 2025). |
| **Championship Preview + Recap** | Wk 17 | The big one. Crown the champ, name the cat-5k loser. |

---

## Phase 5 — Post-season wrap

| Piece | Reads from |
|---|---|
| **2026 Season in Review** | full `data/2026/` archive | The bookend. Same showcase treatment as the 2025 piece. |
| **Cat 5k Assignment** | final standings | Officially hand the last-place finisher their costume + start line. Sets up next offseason's photo drop. |
| **Archive 2026 → cold** | — | Run `./scripts/archive_season.sh <league_id> <draft_id> 2026` so it's immutable lore for 2027. |

---

## Quick reference — segment → data source

- **Matchups / scores / Smirnoff Watch** → `data/2026/matchups_wkN.json` (`starters`, points)
- **Trades** → `transactions_wkN.json`, filter `type=="trade"`, week = `.leg`
- **Waivers / adds-drops** → `transactions_wkN.json` + trending players
- **Rosters / IDP slots** → `data/2026/rosters.json` + `league.json` roster_positions
- **Names** → resolve IDs against `data/players/nfl_players.json` with `jq` (never load it into context)
- **Voice & threads** → `storylines.md` · **Facts & stakes** → `league-rules.md`
