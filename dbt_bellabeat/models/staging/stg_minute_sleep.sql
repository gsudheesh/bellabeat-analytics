-- Combines both minute sleep datasets
SELECT
    id,
    TO_TIMESTAMP(
        SPLIT_PART(date, ' ', 1) || ' ' || SPLIT_PART(date, ' ', 2) || ' ' || SPLIT_PART(date, ' ', 3),
        'MM/DD/YYYY HH12:MI:SS AM'
    ) AS sleep_minute,
    value AS sleep_stage,
    logid
FROM raw.minutesleep_p1
UNION ALL
SELECT
    id,
    TO_TIMESTAMP(
        SPLIT_PART(date, ' ', 1) || ' ' || SPLIT_PART(date, ' ', 2) || ' ' || SPLIT_PART(date, ' ', 3),
        'MM/DD/YYYY HH12:MI:SS AM'
    ),
    value,
    logid
FROM raw.minutesleep_p2
