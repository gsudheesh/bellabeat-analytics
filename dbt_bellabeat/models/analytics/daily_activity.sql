-- Enriches staging daily activity with derived fields
SELECT
    id,
    activity_date,
    totalsteps,
    totaldistance,
    trackerdistance,
    loggedactivitiesdistance,
    veryactivedistance,
    moderatelyactivedistance,
    lightactivedistance,
    sedentaryactivedistance,
    veryactiveminutes,
    fairlyactiveminutes,
    lightlyactiveminutes,
    sedentaryminutes,
    calories,
    (veryactiveminutes + fairlyactiveminutes + lightlyactiveminutes) AS total_active_minutes,
    CASE
        WHEN totalsteps < 5000 THEN 'Sedentary'
        WHEN totalsteps BETWEEN 5000 AND 7499 THEN 'Low Active'
        WHEN totalsteps BETWEEN 7500 AND 9999 THEN 'Moderately Active'
        ELSE 'Highly Active'
    END AS activity_level,
    TRIM(TO_CHAR(activity_date, 'Day'))    AS day_name,
    EXTRACT(DOW FROM activity_date)::INT   AS day_number,
    EXTRACT(MONTH FROM activity_date)::INT AS month_number,
    EXTRACT(YEAR FROM activity_date)::INT  AS year_number
FROM {{ ref('stg_daily_activity') }}
