-- Peak activity times by hour — for time-of-day analysis charts
SELECT
    hour_of_day,
    AVG(steptotal::FLOAT)      AS avg_steps,
    AVG(calories::FLOAT)       AS avg_calories,
    AVG(totalintensity::FLOAT) AS avg_intensity
FROM {{ ref('hourly_activity') }}
GROUP BY hour_of_day
ORDER BY hour_of_day
