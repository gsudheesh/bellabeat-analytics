-- Combines both weight datasets, casts datetime
WITH combined AS (
    SELECT * FROM raw.weightloginfo_p1
    UNION ALL
    SELECT * FROM raw.weightloginfo_p2
)

SELECT
    id,
    TO_TIMESTAMP(
        SPLIT_PART(date, ' ', 1) || ' ' || SPLIT_PART(date, ' ', 2) || ' ' || SPLIT_PART(date, ' ', 3),
        'MM/DD/YYYY HH12:MI:SS AM'
    ) AS log_datetime,
    weightkg,
    weightpounds,
    NULLIF(fat, '')::FLOAT AS fat,
    bmi,
    (ismanualreport = 'True') AS is_manual_report,
    logid
FROM combined
