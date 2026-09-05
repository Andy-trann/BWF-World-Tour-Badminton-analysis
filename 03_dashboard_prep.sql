-- =============================================================
-- 03_dashboard_prep.sql
-- Combines cleaned singles data and prepares final table for Power BI
-- =============================================================

-- Combine MS and WS into one unified table for dashboard use
SELECT 'MS' AS discipline,
       tournament_type,
       player,
       country,
       total_matches,
       win_rate,
       avg_point_gap
FROM ms_final

UNION ALL

SELECT 'WS' AS discipline,
       tournament_type,
       player,
       country,
       total_matches,
       win_rate,
       avg_point_gap
FROM ws_final;


-- Add a numeric tier_order column to allow correct chronological
-- sorting of tournament tiers in Power BI visuals
SELECT CASE tournament_type
           WHEN 'BWF Tour Super 100' THEN 1
           WHEN 'HSBC BWF World Tour Super 300' THEN 2
           WHEN 'HSBC BWF World Tour Super 500' THEN 3
           WHEN 'HSBC BWF World Tour Super 750' THEN 4
           WHEN 'HSBC BWF World Tour Super 1000' THEN 5
           WHEN 'HSBC BWF World Tour Finals' THEN 6
       END AS tier_order,
       discipline,
       tournament_type,
       player,
       country,
       total_matches,
       win_rate,
       avg_point_gap
FROM combined_discipline;