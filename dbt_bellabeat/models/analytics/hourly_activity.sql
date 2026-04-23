-- Enriches hourly staging with time dimensions
SELECT
    id,
    activity_datetime,
    activity_datetime::DATE                   AS activity_date,
    EXTRACT(HOUR FROM activity_datetime)::INT AS hour_of_day,
    TRIM(TO_CHAR(activity_datetime, 'Day'))   AS day_name,
    steptotal,
    calories,
    totalintensity,
    averageintensity
FROM {{ ref('stg_hourly_activity') }}
