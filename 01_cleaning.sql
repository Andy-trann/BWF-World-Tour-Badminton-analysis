-- =============================================================
-- 01_cleaning.sql
-- Data cleaning and integrity checks for the BWF badminton dataset
-- =============================================================

-- Check distinct values in the 'retired' column to confirm data consistency
SELECT DISTINCT retired FROM ms;

-- Remove matches that ended in a player retirement (Men's Singles)
DELETE FROM ms
WHERE retired = 'True';

-- Remove matches that ended in a player retirement (Women's Singles)
DELETE FROM ws
WHERE retired = 'True';

-- Remove cutoff anomalies: players with only 2 matches and a 100% win rate
DELETE FROM combined_discipline
WHERE total_matches =< 2 AND win_rate = 100;