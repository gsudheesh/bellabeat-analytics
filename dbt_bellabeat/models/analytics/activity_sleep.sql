-- Joins daily activity with sleep data
SELECT
    a.id,
    a.activity_date,
    a.totalsteps,
    a.total_active_minutes,
    a.sedentaryminutes,
    a.calories,
    a.activity_level,
    s.totalsleeprecords,
    s.totalminutesasleep,
    s.totaltimeinbed,
    s.sleep_efficiency
FROM {{ ref('daily_activity') }} a
LEFT JOIN {{ ref('stg_sleep') }} s
    ON a.id = s.id
    AND a.activity_date = s.sleep_date
