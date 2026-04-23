-- Combines, casts, deduplicates and joins all three hourly tables
WITH steps_combined AS (
    SELECT id, TO_TIMESTAMP(activityhour, 'MM/DD/YYYY HH12:MI:SS AM') AS activity_datetime, steptotal
    FROM raw.hourlysteps_p1
    UNION ALL
    SELECT id, TO_TIMESTAMP(activityhour, 'MM/DD/YYYY HH12:MI:SS AM'), steptotal
    FROM raw.hourlysteps_p2
),

calories_combined AS (
    SELECT id, TO_TIMESTAMP(activityhour, 'MM/DD/YYYY HH12:MI:SS AM') AS activity_datetime, calories
    FROM raw.hourlycalories_p1
    UNION ALL
    SELECT id, TO_TIMESTAMP(activityhour, 'MM/DD/YYYY HH12:MI:SS AM'), calories
    FROM raw.hourlycalories_p2
),

intensities_combined AS (
    SELECT id, TO_TIMESTAMP(activityhour, 'MM/DD/YYYY HH12:MI:SS AM') AS activity_datetime, totalintensity, averageintensity
    FROM raw.hourlyintensities_p1
    UNION ALL
    SELECT id, TO_TIMESTAMP(activityhour, 'MM/DD/YYYY HH12:MI:SS AM'), totalintensity, averageintensity
    FROM raw.hourlyintensities_p2
),

steps_deduped AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY id, activity_datetime ORDER BY activity_datetime) AS rn
    FROM steps_combined
),

calories_deduped AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY id, activity_datetime ORDER BY activity_datetime) AS rn
    FROM calories_combined
),

intensities_deduped AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY id, activity_datetime ORDER BY activity_datetime) AS rn
    FROM intensities_combined
)

SELECT
    s.id,
    s.activity_datetime,
    s.steptotal,
    c.calories,
    i.totalintensity,
    i.averageintensity
FROM steps_deduped s
LEFT JOIN calories_deduped c ON s.id = c.id AND s.activity_datetime = c.activity_datetime AND c.rn = 1
LEFT JOIN intensities_deduped i ON s.id = i.id AND s.activity_datetime = i.activity_datetime AND i.rn = 1
WHERE s.rn = 1
