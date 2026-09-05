-- =============================================================
-- 02_analysis.sql
-- Per-player and per-tier analysis for both singles disciplines
-- Produces final tables (ms_final and ws_final) used in the dashboard
-- This query is the refined result of several iterations, consolidating earlier exploratory steps into a single large query
-- =============================================================

-- Create the Men's Singles analysis table: win rate, nationality, and average point gap
-- per player, per tournament tier
CREATE TABLE ms_final AS
WITH cte AS (
    SELECT tournament_type,
           LOWER(team_one_players) AS player,
           team_one_nationalities AS country,
           COUNT(*) AS total_matches,
           SUM(CASE WHEN winner = 1 THEN 1 ELSE 0 END) AS wins,
           SUM(ABS(team_one_total_points - team_two_total_points)) AS total_point_gap
    FROM ms
    GROUP BY tournament_type, player, team_one_nationalities

    UNION ALL

    SELECT tournament_type,
           LOWER(team_two_players) AS player,
           team_two_nationalities AS country,
           COUNT(*) AS total_matches,
           SUM(CASE WHEN winner = 2 THEN 1 ELSE 0 END) AS wins,
           SUM(ABS(team_one_total_points - team_two_total_points)) AS total_point_gap
    FROM ms
    GROUP BY tournament_type, player, team_two_nationalities
)
SELECT tournament_type,
       player,
       country,
       SUM(total_matches) AS total_matches,
       ROUND(SUM(wins) * 100.0 / SUM(total_matches), 2) AS win_rate,
       ROUND(SUM(total_point_gap) * 1.0 / SUM(total_matches), 2) AS avg_point_gap
FROM cte
GROUP BY tournament_type, player, country
ORDER BY total_matches DESC;


-- Create the Women's Singles analysis table using the same logic
CREATE TABLE ws_final AS
WITH cte AS (
    SELECT tournament_type,
           LOWER(team_one_players) AS player,
           team_one_nationalities AS country,
           COUNT(*) AS total_matches,
           SUM(CASE WHEN winner = 1 THEN 1 ELSE 0 END) AS wins,
           SUM(ABS(team_one_total_points - team_two_total_points)) AS total_point_gap
    FROM ws
    GROUP BY tournament_type, player, team_one_nationalities

    UNION ALL

    SELECT tournament_type,
           LOWER(team_two_players) AS player,
           team_two_nationalities AS country,
           COUNT(*) AS total_matches,
           SUM(CASE WHEN winner = 2 THEN 1 ELSE 0 END) AS wins,
           SUM(ABS(team_one_total_points - team_two_total_points)) AS total_point_gap
    FROM ws
    GROUP BY tournament_type, player, team_two_nationalities
)
SELECT tournament_type,
       player,
       country,
       SUM(total_matches) AS total_matches,
       ROUND(SUM(wins) * 100.0 / SUM(total_matches), 2) AS win_rate,
       ROUND(SUM(total_point_gap) * 1.0 / SUM(total_matches), 2) AS avg_point_gap
FROM cte
GROUP BY tournament_type, player, country
ORDER BY total_matches DESC;