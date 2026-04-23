-- Sleep quality vs activity level — key insight table
SELECT
    a.activity_level,
    AVG(a.totalsteps::FLOAT)          AS avg_steps,
    AVG(a.total_active_minutes::FLOAT) AS avg_active_minutes,
    AVG(a.sedentaryminutes::FLOAT)    AS avg_sedentary_minutes,
    AVG(s.totalminutesasleep::FLOAT)  AS avg_sleep_minutes,
    AVG(s.sleep_efficiency::FLOAT)    AS avg_sleep_efficiency
FROM {{ ref('daily_activity') }} a
LEFT JOIN {{ ref('stg_sleep') }} s
    ON a.id = s.id
    AND a.activity_date = s.sleep_date
WHERE s.totalminutesasleep IS NOT NULL
GROUP BY a.activity_level
