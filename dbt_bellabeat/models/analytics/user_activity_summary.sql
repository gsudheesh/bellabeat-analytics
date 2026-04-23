-- Per-user aggregated activity metrics
SELECT
    id,
    COUNT(*)                              AS tracked_days,
    AVG(totalsteps::FLOAT)                AS avg_daily_steps,
    AVG(calories::FLOAT)                  AS avg_daily_calories,
    AVG(totaldistance::FLOAT)             AS avg_daily_distance,
    AVG(sedentaryminutes::FLOAT)          AS avg_sedentary_minutes,
    AVG(veryactiveminutes::FLOAT)         AS avg_very_active_minutes,
    AVG(fairlyactiveminutes::FLOAT)       AS avg_fairly_active_minutes,
    AVG(lightlyactiveminutes::FLOAT)      AS avg_lightly_active_minutes,
    AVG(total_active_minutes::FLOAT)      AS avg_total_active_minutes
FROM {{ ref('daily_activity') }}
GROUP BY id
