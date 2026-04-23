-- Combines both daily activity datasets, casts date, removes duplicates
WITH combined AS (
    SELECT * FROM raw.dailyactivity_p1
    UNION ALL
    SELECT * FROM raw.dailyactivity_p2
),

casted AS (
    SELECT
        id,
        TO_DATE(activitydate, 'MM/DD/YYYY') AS activity_date,
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
        calories
    FROM combined
),

deduped AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY id, activity_date
            ORDER BY activity_date
        ) AS rn
    FROM casted
)

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
    calories
FROM deduped
WHERE rn = 1
