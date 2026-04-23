-- Primary BI table: activity + sleep combined with all dimensions
SELECT
    id,
    activity_date,
    TRIM(TO_CHAR(activity_date, 'Day'))    AS day_name,
    EXTRACT(DOW FROM activity_date)::INT   AS day_number,
    EXTRACT(MONTH FROM activity_date)::INT AS month_number,
    totalsteps,
    total_active_minutes,
    sedentaryminutes,
    calories,
    activity_level,
    totalminutesasleep,
    totaltimeinbed,
    sleep_efficiency,
    CASE
        WHEN totalsteps < 5000 THEN 'Sedentary'
        WHEN totalsteps BETWEEN 5000 AND 7499 THEN 'Low Active'
        WHEN totalsteps BETWEEN 7500 AND 9999 THEN 'Moderately Active'
        ELSE 'Highly Active'
    END AS activity_segment
FROM {{ ref('activity_sleep') }}
