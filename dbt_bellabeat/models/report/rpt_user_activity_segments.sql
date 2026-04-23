-- User segmentation by average daily steps
SELECT
    id,
    avg_daily_steps,
    avg_daily_calories,
    avg_total_active_minutes,
    CASE
        WHEN avg_daily_steps < 5000 THEN 'Sedentary'
        WHEN avg_daily_steps BETWEEN 5000 AND 7499 THEN 'Low Active'
        WHEN avg_daily_steps BETWEEN 7500 AND 9999 THEN 'Moderately Active'
        ELSE 'Highly Active'
    END AS activity_segment
FROM {{ ref('user_activity_summary') }}
