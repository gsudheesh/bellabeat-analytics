-- Combines and casts all minute-level narrow tables
WITH calories AS (
    SELECT id, TO_TIMESTAMP(activityminute, 'MM/DD/YYYY HH12:MI:SS AM') AS activity_minute, calories
    FROM raw.minutecaloriesnarrow_p1
    UNION ALL
    SELECT id, TO_TIMESTAMP(activityminute, 'MM/DD/YYYY HH12:MI:SS AM'), calories
    FROM raw.minutecaloriesnarrow_p2
),

intensities AS (
    SELECT id, TO_TIMESTAMP(activityminute, 'MM/DD/YYYY HH12:MI:SS AM') AS activity_minute, intensity
    FROM raw.minuteintensitiesnarrow_p1
    UNION ALL
    SELECT id, TO_TIMESTAMP(activityminute, 'MM/DD/YYYY HH12:MI:SS AM'), intensity
    FROM raw.minuteintensitiesnarrow_p2
),

steps AS (
    SELECT id, TO_TIMESTAMP(activityminute, 'MM/DD/YYYY HH12:MI:SS AM') AS activity_minute, steps
    FROM raw.minutestepsnarrow_p1
    UNION ALL
    SELECT id, TO_TIMESTAMP(activityminute, 'MM/DD/YYYY HH12:MI:SS AM'), steps
    FROM raw.minutestepsnarrow_p2
),

mets AS (
    SELECT id, TO_TIMESTAMP(activityminute, 'MM/DD/YYYY HH12:MI:SS AM') AS activity_minute, mets
    FROM raw.minutemetsnarrow_p1
    UNION ALL
    SELECT id, TO_TIMESTAMP(activityminute, 'MM/DD/YYYY HH12:MI:SS AM'), mets
    FROM raw.minutemetsnarrow_p2
)

SELECT
    s.id,
    s.activity_minute,
    s.steps,
    c.calories,
    i.intensity,
    m.mets
FROM steps s
LEFT JOIN calories c ON s.id = c.id AND s.activity_minute = c.activity_minute
LEFT JOIN intensities i ON s.id = i.id AND s.activity_minute = i.activity_minute
LEFT JOIN mets m ON s.id = m.id AND s.activity_minute = m.activity_minute
