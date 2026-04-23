-- Casts sleep datetime, calculates sleep efficiency
SELECT
    id,
    TO_DATE(SPLIT_PART(sleepday, ' ', 1), 'MM/DD/YYYY') AS sleep_date,
    totalsleeprecords,
    totalminutesasleep,
    totaltimeinbed,
    totalminutesasleep::FLOAT / NULLIF(totaltimeinbed, 0) AS sleep_efficiency
FROM raw.sleepday
