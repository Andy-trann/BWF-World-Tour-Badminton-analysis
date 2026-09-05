# BWF World Tour – Badminton Competition Analysis

## Overview

This project analyses **6,224 men's and women's singles matches (2018–2021)** across all six BWF World Tour tiers, from Super 100 to the World Tour Finals. It looks at match volume, win rate patterns, and point margin trends to explore how competition changes as players climb the tour, and whether elite badminton is really dominated by a small circle of players or if genuine competition runs deeper than the top rankings suggest.

## Key Findings

### Win Rate vs. Total Matches 

Players with under 10 matches have a large spread in win rate, anywhere from 0% to 100%, which makes sense because a single win or loss dramatically swings the whole percentage. On top of that, a small sample size is inherently more volatile. As the match count goes up, the spread starts tightening and win rates settle into the 40 to 70% range. The main takeaway is that **match count kind of acts like a filter for reliability**. Only players who keep winning accumulate more total matches, which itself reflects their overall strength. 

### Average Win Rate Across Tiers

The average win rate stays fairly consistent at around **30% across Super 100 through Super 1000**, then jumps up to about **41% at the Finals** for both MS and WS. The consistency across most tiers makes sense since these are knockout tournaments, meaning most players lose in the early rounds and the average win rate naturally sits low. The Finals jump is the interesting part. Only 8 players qualify due to draw size and BWF regulations, so with such a small and elite sample it makes sense that their win rates skew much higher. Both disciplines follow almost the same shape.

### Point Gaps Across Tiers 
Point gaps stay in a tight **12 to 14 range across every tier**, from Super 100 all the way through the Finals, with only a very mild downward trend as tier increases. This finding suggests that competition at the professional level is genuinely fierce, and matches are fairly competitive even at the very top of the sport. While the field narrows in terms of who qualifies at higher tiers, the matches themselves remain closely contested throughout. It shows that once players earn their way into these tournaments, they've proven they belong there. 

## Data Source

BWF World Tour match data (April 2018 – March 2021), sourced from Kaggle:
[https://www.kaggle.com/datasets/sanderp/badminton-bwf-world-tour](https://www.kaggle.com/datasets/sanderp/badminton-bwf-world-tour)

## Tools Used

- **SQL (SQLite)** — data cleaning, filtering, and aggregation
- **Power BI** — interactive dashboard and visual analysis

## Methodology

- **SQL** — cleaned and filtered the raw match data, then aggregated key metrics per player and per tier (win rate, average point gap, competitive depth across tiers).
- **Power BI** — built an interactive dashboard with discipline and player filters, enabling multi-level exploration and comparison across tiers.

## Key Columns

**From the raw dataset:**
- `tournament_type` — segments analysis by tier (Super 100 through World Tour Finals)
- `discipline` — Men's Singles (MS) or Women's Singles (WS)
- `team_one_players`, `team_two_players` — player identifiers per match
- `winner` — indicates the winning side (1 = team one, 2 = team two)
- `team_one_total_points`, `team_two_total_points` — used to calculate point gap
- `team_one_nationalities`, `team_two_nationalities` — used for country-level analysis
- `retired` — used to filter out matches ending in retirement

**Created for analysis:**
- `total_matches` — total number of matches per player per tier
- `win_rate` — percentage of matches won per player per tier
- `avg_point_gap` — average point margin across all of a player's matches
- `tier_order` — a numeric column mapping each tier to its correct rank order (1–6), used to sort visuals in Power BI
- `discipline` label — added during the SQL UNION to distinguish MS vs. WS rows in the combined table

## Data Cleaning & Known Limitations

- **Excluded doubles disciplines**: The MD, WD, and MXD datasets contained a scraping error causing missing or duplicated player values, compromising data integrity. Analysis was scoped to singles disciplines (MS, WS) only.
- **Corrected inaccurate match totals**: One row in the men's singles dataset had `total_points` values that didn't match the actual game scores. Manually corrected using the verified game-by-game data.
- **Standardised player name**: Some player names appeared with inconsistent capitalisation, causing duplicate entries during aggregation. Applied `LOWER()` in SQL to consolidate them, then `=PROPER()` in Excel to restore proper formatting for display.
- **Removed retired matches**: Excluded matches that ended in a player retirement, as these don't reflect genuine competitive outcomes.
- **Removed anomalies**: Filtered out players with 2 or fewer matches and a 100% win rate, as these reflect incomplete match histories. 

## Dashboard
*<img width="1277" height="717" alt="image" src="https://github.com/user-attachments/assets/91486a06-7cf2-42b4-aacf-ccece5b54c21" />*

## What I'd Explore Next

- **Re-scrape doubles data** from a corrected source, allowing the analysis to extend across all five BWF disciplines.
- **Apply statistical significance testing** to the match-count vs. win-rate relationship to formally validate the observed pattern.





