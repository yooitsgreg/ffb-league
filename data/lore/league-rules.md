# Five Seven Bro — League Rules & Constants

> Static reference facts (format, scoring quirks, stakes, penalties). Content generation reads this
> for accuracy; narrative threads live separately in `storylines.md`. Commissioner-stated rules
> override the Sleeper `settings` block (which is mostly unconfigured defaults). Verified 2026-06-29.

## Format
- **8 teams**, full **PPR**, continuing league (new Sleeper league_id each season; join history by `owner_id`).
- **IDP** league: roster has `DL`, `LB`, `DB`, and `IDP_FLEX` slots with full defensive scoring
  (sacks, tackles, INTs, forced fumbles, etc.). Analysis/content must account for defense or it's wrong.
- **No keepers.** **Snake draft** (runs until rosters are full; date TBD for 2026).
- **Reverse-standings waivers** (worst record gets first priority) — no FAAB/bidding.
- Playoffs: 6 teams, start Week 15. Trade deadline ~Week 12.

## Stakes — buy-in & payouts
- **Buy-in:** $100/team → **$800 pot.**
- **1st:** $700 · **2nd:** $100 (money back) · **3rd–8th:** lose their $100.
- Winner-take-most: only 1st actually profits (+$600); 2nd breaks even. Sharpens every late-season game.

## Penalties (content engines)
- **Last place → the cat 5k.** The season's last-place finisher runs a 5k **dressed as a cat**
  (ears, tail, whiskers) **in a sports bra.** The league's marquee humiliation; the whole loser arc points here.
- **Started a zero → Smirnoff Ice.** **Start** a player who scores **0 or fewer points** and you must
  send the group a **video chugging a Smirnoff Ice.** **Started players only** — bench goose-eggs don't
  count. Recurring weekly callout: scan each starting lineup (`starters` in `matchups_wkN.json`) for ≤0.

## Last-place history
- **2025: Aaron (mayyer23, Atomic Underdog)** finished last (3-11, fewest points) and **ran the cat 5k in 2026.**
  - ⚠️ Data gotcha: in the toilet bowl, Sleeper's `losers_bracket` marks `mayyer23` (Aaron) as the `w` (winner) of
    the final game — but in this league the toilet-bowl "winner" is the one relegated to **last place**.
    `Robbslyy` (Rob, The Toilet King) was the `l` and finished **7th**, escaping the punishment. Do not naively
    map Sleeper's `w`/`l` to "avoided last."
