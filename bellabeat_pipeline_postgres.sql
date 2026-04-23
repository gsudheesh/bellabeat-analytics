-- =============================================================
-- BELLABEAT DATA PIPELINE — PostgreSQL
-- Paths hardcoded for: /Users/sudheeshgangishetty/Downloads/bellabeat_data/
-- Run via Terminal: psql bellabeat -f ~/Downloads/bellabeat_pipeline_postgres.sql
-- =============================================================


-- =============================================================
-- STEP 1: RAW TABLES — load all CSVs
-- =============================================================

-- dailyActivity (both parts)
DROP TABLE IF EXISTS raw.dailyactivity_p1;
CREATE TABLE raw.dailyactivity_p1 (
    Id BIGINT, ActivityDate TEXT, TotalSteps INT, TotalDistance FLOAT,
    TrackerDistance FLOAT, LoggedActivitiesDistance FLOAT, VeryActiveDistance FLOAT,
    ModeratelyActiveDistance FLOAT, LightActiveDistance FLOAT, SedentaryActiveDistance FLOAT,
    VeryActiveMinutes INT, FairlyActiveMinutes INT, LightlyActiveMinutes INT,
    SedentaryMinutes INT, Calories INT
);
\COPY raw.dailyactivity_p1 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_3.12.16-4.11.16/Fitabase Data 3.12.16-4.11.16/dailyActivity_merged.csv' CSV HEADER;

DROP TABLE IF EXISTS raw.dailyactivity_p2;
CREATE TABLE raw.dailyactivity_p2 (LIKE raw.dailyactivity_p1);
\COPY raw.dailyactivity_p2 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/dailyActivity_merged.csv' CSV HEADER;

-- dailyCalories (p2 only)
DROP TABLE IF EXISTS raw.dailycalories;
CREATE TABLE raw.dailycalories (Id BIGINT, ActivityDay TEXT, Calories INT);
\COPY raw.dailycalories FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/dailyCalories_merged.csv' CSV HEADER;

-- dailyIntensities (p2 only)
DROP TABLE IF EXISTS raw.dailyintensities;
CREATE TABLE raw.dailyintensities (
    Id BIGINT, ActivityDay TEXT, SedentaryMinutes INT, LightlyActiveMinutes INT,
    FairlyActiveMinutes INT, VeryActiveMinutes INT, SedentaryActiveDistance FLOAT,
    LightActiveDistance FLOAT, ModeratelyActiveDistance FLOAT, VeryActiveDistance FLOAT
);
\COPY raw.dailyintensities FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/dailyIntensities_merged.csv' CSV HEADER;

-- dailySteps (p2 only)
DROP TABLE IF EXISTS raw.dailysteps;
CREATE TABLE raw.dailysteps (Id BIGINT, ActivityDay TEXT, StepTotal INT);
\COPY raw.dailysteps FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/dailySteps_merged.csv' CSV HEADER;

-- sleepDay (p2 only)
DROP TABLE IF EXISTS raw.sleepday;
CREATE TABLE raw.sleepday (
    Id BIGINT, SleepDay TEXT, TotalSleepRecords INT,
    TotalMinutesAsleep INT, TotalTimeInBed INT
);
\COPY raw.sleepday FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/sleepDay_merged.csv' CSV HEADER;

-- weightLogInfo (both parts)
DROP TABLE IF EXISTS raw.weightloginfo_p1;
CREATE TABLE raw.weightloginfo_p1 (
    Id BIGINT, Date TEXT, WeightKg FLOAT, WeightPounds FLOAT,
    Fat TEXT, BMI FLOAT, IsManualReport TEXT, LogId BIGINT
);
\COPY raw.weightloginfo_p1 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_3.12.16-4.11.16/Fitabase Data 3.12.16-4.11.16/weightLogInfo_merged.csv' CSV HEADER;

DROP TABLE IF EXISTS raw.weightloginfo_p2;
CREATE TABLE raw.weightloginfo_p2 (LIKE raw.weightloginfo_p1);
\COPY raw.weightloginfo_p2 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/weightLogInfo_merged.csv' CSV HEADER;

-- hourlySteps (both parts)
DROP TABLE IF EXISTS raw.hourlysteps_p1;
CREATE TABLE raw.hourlysteps_p1 (Id BIGINT, ActivityHour TEXT, StepTotal INT);
\COPY raw.hourlysteps_p1 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_3.12.16-4.11.16/Fitabase Data 3.12.16-4.11.16/hourlySteps_merged.csv' CSV HEADER;

DROP TABLE IF EXISTS raw.hourlysteps_p2;
CREATE TABLE raw.hourlysteps_p2 (LIKE raw.hourlysteps_p1);
\COPY raw.hourlysteps_p2 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/hourlySteps_merged.csv' CSV HEADER;

-- hourlyCalories (both parts)
DROP TABLE IF EXISTS raw.hourlycalories_p1;
CREATE TABLE raw.hourlycalories_p1 (Id BIGINT, ActivityHour TEXT, Calories FLOAT);
\COPY raw.hourlycalories_p1 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_3.12.16-4.11.16/Fitabase Data 3.12.16-4.11.16/hourlyCalories_merged.csv' CSV HEADER;

DROP TABLE IF EXISTS raw.hourlycalories_p2;
CREATE TABLE raw.hourlycalories_p2 (LIKE raw.hourlycalories_p1);
\COPY raw.hourlycalories_p2 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/hourlyCalories_merged.csv' CSV HEADER;

-- hourlyIntensities (both parts)
DROP TABLE IF EXISTS raw.hourlyintensities_p1;
CREATE TABLE raw.hourlyintensities_p1 (
    Id BIGINT, ActivityHour TEXT, TotalIntensity INT, AverageIntensity FLOAT
);
\COPY raw.hourlyintensities_p1 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_3.12.16-4.11.16/Fitabase Data 3.12.16-4.11.16/hourlyIntensities_merged.csv' CSV HEADER;

DROP TABLE IF EXISTS raw.hourlyintensities_p2;
CREATE TABLE raw.hourlyintensities_p2 (LIKE raw.hourlyintensities_p1);
\COPY raw.hourlyintensities_p2 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/hourlyIntensities_merged.csv' CSV HEADER;

-- minuteCaloriesNarrow (both parts)
DROP TABLE IF EXISTS raw.minutecaloriesnarrow_p1;
CREATE TABLE raw.minutecaloriesnarrow_p1 (Id BIGINT, ActivityMinute TEXT, Calories FLOAT);
\COPY raw.minutecaloriesnarrow_p1 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_3.12.16-4.11.16/Fitabase Data 3.12.16-4.11.16/minuteCaloriesNarrow_merged.csv' CSV HEADER;

DROP TABLE IF EXISTS raw.minutecaloriesnarrow_p2;
CREATE TABLE raw.minutecaloriesnarrow_p2 (LIKE raw.minutecaloriesnarrow_p1);
\COPY raw.minutecaloriesnarrow_p2 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/minuteCaloriesNarrow_merged.csv' CSV HEADER;

-- minuteIntensitiesNarrow (both parts)
DROP TABLE IF EXISTS raw.minuteintensitiesnarrow_p1;
CREATE TABLE raw.minuteintensitiesnarrow_p1 (Id BIGINT, ActivityMinute TEXT, Intensity INT);
\COPY raw.minuteintensitiesnarrow_p1 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_3.12.16-4.11.16/Fitabase Data 3.12.16-4.11.16/minuteIntensitiesNarrow_merged.csv' CSV HEADER;

DROP TABLE IF EXISTS raw.minuteintensitiesnarrow_p2;
CREATE TABLE raw.minuteintensitiesnarrow_p2 (LIKE raw.minuteintensitiesnarrow_p1);
\COPY raw.minuteintensitiesnarrow_p2 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/minuteIntensitiesNarrow_merged.csv' CSV HEADER;

-- minuteStepsNarrow (both parts)
DROP TABLE IF EXISTS raw.minutestepsnarrow_p1;
CREATE TABLE raw.minutestepsnarrow_p1 (Id BIGINT, ActivityMinute TEXT, Steps INT);
\COPY raw.minutestepsnarrow_p1 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_3.12.16-4.11.16/Fitabase Data 3.12.16-4.11.16/minuteStepsNarrow_merged.csv' CSV HEADER;

DROP TABLE IF EXISTS raw.minutestepsnarrow_p2;
CREATE TABLE raw.minutestepsnarrow_p2 (LIKE raw.minutestepsnarrow_p1);
\COPY raw.minutestepsnarrow_p2 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/minuteStepsNarrow_merged.csv' CSV HEADER;

-- minuteMETsNarrow (both parts)
DROP TABLE IF EXISTS raw.minutemetsnarrow_p1;
CREATE TABLE raw.minutemetsnarrow_p1 (Id BIGINT, ActivityMinute TEXT, METs INT);
\COPY raw.minutemetsnarrow_p1 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_3.12.16-4.11.16/Fitabase Data 3.12.16-4.11.16/minuteMETsNarrow_merged.csv' CSV HEADER;

DROP TABLE IF EXISTS raw.minutemetsnarrow_p2;
CREATE TABLE raw.minutemetsnarrow_p2 (LIKE raw.minutemetsnarrow_p1);
\COPY raw.minutemetsnarrow_p2 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/minuteMETsNarrow_merged.csv' CSV HEADER;

-- minuteSleep (both parts)
DROP TABLE IF EXISTS raw.minutesleep_p1;
CREATE TABLE raw.minutesleep_p1 (Id BIGINT, date TEXT, value INT, logId BIGINT);
\COPY raw.minutesleep_p1 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_3.12.16-4.11.16/Fitabase Data 3.12.16-4.11.16/minuteSleep_merged.csv' CSV HEADER;

DROP TABLE IF EXISTS raw.minutesleep_p2;
CREATE TABLE raw.minutesleep_p2 (LIKE raw.minutesleep_p1);
\COPY raw.minutesleep_p2 FROM '/Users/sudheeshgangishetty/Downloads/bellabeat_data/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/minuteSleep_merged.csv' CSV HEADER;

-- Raw load validation
SELECT 'dailyactivity_p1' AS table_name, COUNT(*) AS rows FROM raw.dailyactivity_p1
UNION ALL SELECT 'dailyactivity_p2',        COUNT(*) FROM raw.dailyactivity_p2
UNION ALL SELECT 'dailycalories',           COUNT(*) FROM raw.dailycalories
UNION ALL SELECT 'dailyintensities',        COUNT(*) FROM raw.dailyintensities
UNION ALL SELECT 'dailysteps',              COUNT(*) FROM raw.dailysteps
UNION ALL SELECT 'sleepday',               COUNT(*) FROM raw.sleepday
UNION ALL SELECT 'weightloginfo_p1',        COUNT(*) FROM raw.weightloginfo_p1
UNION ALL SELECT 'weightloginfo_p2',        COUNT(*) FROM raw.weightloginfo_p2
UNION ALL SELECT 'hourlysteps_p1',          COUNT(*) FROM raw.hourlysteps_p1
UNION ALL SELECT 'hourlysteps_p2',          COUNT(*) FROM raw.hourlysteps_p2
UNION ALL SELECT 'hourlycalories_p1',       COUNT(*) FROM raw.hourlycalories_p1
UNION ALL SELECT 'hourlycalories_p2',       COUNT(*) FROM raw.hourlycalories_p2
UNION ALL SELECT 'hourlyintensities_p1',    COUNT(*) FROM raw.hourlyintensities_p1
UNION ALL SELECT 'hourlyintensities_p2',    COUNT(*) FROM raw.hourlyintensities_p2
UNION ALL SELECT 'minutecaloriesnarrow_p1', COUNT(*) FROM raw.minutecaloriesnarrow_p1
UNION ALL SELECT 'minutecaloriesnarrow_p2', COUNT(*) FROM raw.minutecaloriesnarrow_p2
UNION ALL SELECT 'minuteintensitiesnarrow_p1', COUNT(*) FROM raw.minuteintensitiesnarrow_p1
UNION ALL SELECT 'minuteintensitiesnarrow_p2', COUNT(*) FROM raw.minuteintensitiesnarrow_p2
UNION ALL SELECT 'minutestepsnarrow_p1',    COUNT(*) FROM raw.minutestepsnarrow_p1
UNION ALL SELECT 'minutestepsnarrow_p2',    COUNT(*) FROM raw.minutestepsnarrow_p2
UNION ALL SELECT 'minutemetsnarrow_p1',     COUNT(*) FROM raw.minutemetsnarrow_p1
UNION ALL SELECT 'minutemetsnarrow_p2',     COUNT(*) FROM raw.minutemetsnarrow_p2
UNION ALL SELECT 'minutesleep_p1',          COUNT(*) FROM raw.minutesleep_p1
UNION ALL SELECT 'minutesleep_p2',          COUNT(*) FROM raw.minutesleep_p2;


-- =============================================================
-- STEP 2: STAGING — dailyActivity
-- =============================================================

DROP TABLE IF EXISTS stg.dailyactivity;
CREATE TABLE stg.dailyactivity AS
SELECT
    Id,
    TO_DATE(ActivityDate, 'MM/DD/YYYY') AS ActivityDate,
    TotalSteps, TotalDistance, TrackerDistance, LoggedActivitiesDistance,
    VeryActiveDistance, ModeratelyActiveDistance, LightActiveDistance, SedentaryActiveDistance,
    VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes, Calories
FROM (
    SELECT * FROM raw.dailyactivity_p1
    UNION ALL
    SELECT * FROM raw.dailyactivity_p2
) d;

SELECT COUNT(*) AS stg_dailyactivity_rows FROM stg.dailyactivity;
SELECT COUNT(*) AS null_dates FROM stg.dailyactivity WHERE ActivityDate IS NULL;
SELECT MIN(ActivityDate), MAX(ActivityDate) FROM stg.dailyactivity;
SELECT Id, ActivityDate, COUNT(*) AS dup FROM stg.dailyactivity GROUP BY Id, ActivityDate HAVING COUNT(*) > 1;


-- =============================================================
-- STEP 3: STAGING — dailyActivity deduplicated
-- =============================================================

DROP TABLE IF EXISTS stg.dailyactivity_clean;
CREATE TABLE stg.dailyactivity_clean AS
WITH ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY Id, ActivityDate ORDER BY ActivityDate) AS rn
    FROM stg.dailyactivity
)
SELECT Id, ActivityDate, TotalSteps, TotalDistance, TrackerDistance, LoggedActivitiesDistance,
    VeryActiveDistance, ModeratelyActiveDistance, LightActiveDistance, SedentaryActiveDistance,
    VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes, Calories
FROM ranked WHERE rn = 1;

SELECT COUNT(*) AS stg_dailyactivity_clean_rows FROM stg.dailyactivity_clean;


-- =============================================================
-- STEP 4: STAGING — sleep
-- =============================================================

DROP TABLE IF EXISTS stg.sleep;
CREATE TABLE stg.sleep AS
SELECT
    Id,
    TO_DATE(SPLIT_PART(SleepDay, ' ', 1), 'MM/DD/YYYY') AS SleepDate,
    TotalSleepRecords,
    TotalMinutesAsleep,
    TotalTimeInBed,
    TotalMinutesAsleep::FLOAT / NULLIF(TotalTimeInBed, 0) AS SleepEfficiency
FROM raw.sleepday;

SELECT COUNT(*) AS stg_sleep_rows FROM stg.sleep;
SELECT COUNT(*) AS null_sleep_dates FROM stg.sleep WHERE SleepDate IS NULL;


-- =============================================================
-- STEP 5: STAGING — weightlog
-- =============================================================

DROP TABLE IF EXISTS stg.weightlog;
CREATE TABLE stg.weightlog AS
SELECT
    Id,
    TO_TIMESTAMP(
        SPLIT_PART(Date, ' ', 1) || ' ' || SPLIT_PART(Date, ' ', 2) || ' ' || SPLIT_PART(Date, ' ', 3),
        'MM/DD/YYYY HH12:MI:SS AM'
    ) AS LogDateTime,
    WeightKg,
    WeightPounds,
    NULLIF(Fat, '')::FLOAT AS Fat,
    BMI,
    (IsManualReport = 'True') AS IsManualReport,
    LogId
FROM (
    SELECT * FROM raw.weightloginfo_p1
    UNION ALL
    SELECT * FROM raw.weightloginfo_p2
) w;

SELECT COUNT(*) AS stg_weightlog_rows FROM stg.weightlog;


-- =============================================================
-- STEP 6: STAGING — hourly tables
-- =============================================================

DROP TABLE IF EXISTS stg.hourlysteps;
CREATE TABLE stg.hourlysteps AS
SELECT Id, TO_TIMESTAMP(ActivityHour, 'MM/DD/YYYY HH12:MI:SS AM') AS ActivityDateTime, StepTotal
FROM (SELECT * FROM raw.hourlysteps_p1 UNION ALL SELECT * FROM raw.hourlysteps_p2) x;

DROP TABLE IF EXISTS stg.hourlysteps_clean;
CREATE TABLE stg.hourlysteps_clean AS
WITH ranked AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY Id, ActivityDateTime ORDER BY ActivityDateTime) AS rn
    FROM stg.hourlysteps
)
SELECT Id, ActivityDateTime, StepTotal FROM ranked WHERE rn = 1;

DROP TABLE IF EXISTS stg.hourlycalories;
CREATE TABLE stg.hourlycalories AS
SELECT Id, TO_TIMESTAMP(ActivityHour, 'MM/DD/YYYY HH12:MI:SS AM') AS ActivityDateTime, Calories
FROM (SELECT * FROM raw.hourlycalories_p1 UNION ALL SELECT * FROM raw.hourlycalories_p2) x;

DROP TABLE IF EXISTS stg.hourlycalories_clean;
CREATE TABLE stg.hourlycalories_clean AS
WITH ranked AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY Id, ActivityDateTime ORDER BY ActivityDateTime) AS rn
    FROM stg.hourlycalories
)
SELECT Id, ActivityDateTime, Calories FROM ranked WHERE rn = 1;

DROP TABLE IF EXISTS stg.hourlyintensities;
CREATE TABLE stg.hourlyintensities AS
SELECT Id, TO_TIMESTAMP(ActivityHour, 'MM/DD/YYYY HH12:MI:SS AM') AS ActivityDateTime,
    TotalIntensity, AverageIntensity
FROM (SELECT * FROM raw.hourlyintensities_p1 UNION ALL SELECT * FROM raw.hourlyintensities_p2) x;

DROP TABLE IF EXISTS stg.hourlyintensities_clean;
CREATE TABLE stg.hourlyintensities_clean AS
WITH ranked AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY Id, ActivityDateTime ORDER BY ActivityDateTime) AS rn
    FROM stg.hourlyintensities
)
SELECT Id, ActivityDateTime, TotalIntensity, AverageIntensity FROM ranked WHERE rn = 1;

SELECT 'hourlysteps_clean' AS table_name, COUNT(*) AS rows FROM stg.hourlysteps_clean
UNION ALL SELECT 'hourlycalories_clean',     COUNT(*) FROM stg.hourlycalories_clean
UNION ALL SELECT 'hourlyintensities_clean',  COUNT(*) FROM stg.hourlyintensities_clean;


-- =============================================================
-- STEP 7: STAGING — unified hourly
-- =============================================================

DROP TABLE IF EXISTS stg.hourly;
CREATE TABLE stg.hourly AS
SELECT s.Id, s.ActivityDateTime, s.StepTotal, c.Calories, i.TotalIntensity, i.AverageIntensity
FROM stg.hourlysteps_clean s
LEFT JOIN stg.hourlycalories_clean c ON s.Id = c.Id AND s.ActivityDateTime = c.ActivityDateTime
LEFT JOIN stg.hourlyintensities_clean i ON s.Id = i.Id AND s.ActivityDateTime = i.ActivityDateTime;

SELECT COUNT(*) AS stg_hourly_rows FROM stg.hourly;


-- =============================================================
-- STEP 8: STAGING — minute-level tables
-- =============================================================

DROP TABLE IF EXISTS stg.minutecalories;
CREATE TABLE stg.minutecalories AS
SELECT Id, TO_TIMESTAMP(ActivityMinute, 'MM/DD/YYYY HH12:MI:SS AM') AS ActivityMinute, Calories
FROM (SELECT * FROM raw.minutecaloriesnarrow_p1 UNION ALL SELECT * FROM raw.minutecaloriesnarrow_p2) x;

DROP TABLE IF EXISTS stg.minuteintensities;
CREATE TABLE stg.minuteintensities AS
SELECT Id, TO_TIMESTAMP(ActivityMinute, 'MM/DD/YYYY HH12:MI:SS AM') AS ActivityMinute, Intensity
FROM (SELECT * FROM raw.minuteintensitiesnarrow_p1 UNION ALL SELECT * FROM raw.minuteintensitiesnarrow_p2) x;

DROP TABLE IF EXISTS stg.minutesteps;
CREATE TABLE stg.minutesteps AS
SELECT Id, TO_TIMESTAMP(ActivityMinute, 'MM/DD/YYYY HH12:MI:SS AM') AS ActivityMinute, Steps
FROM (SELECT * FROM raw.minutestepsnarrow_p1 UNION ALL SELECT * FROM raw.minutestepsnarrow_p2) x;

DROP TABLE IF EXISTS stg.minutemets;
CREATE TABLE stg.minutemets AS
SELECT Id, TO_TIMESTAMP(ActivityMinute, 'MM/DD/YYYY HH12:MI:SS AM') AS ActivityMinute, METs
FROM (SELECT * FROM raw.minutemetsnarrow_p1 UNION ALL SELECT * FROM raw.minutemetsnarrow_p2) x;

DROP TABLE IF EXISTS stg.minutesleep;
CREATE TABLE stg.minutesleep AS
SELECT Id,
    TO_TIMESTAMP(
        SPLIT_PART(date, ' ', 1) || ' ' || SPLIT_PART(date, ' ', 2) || ' ' || SPLIT_PART(date, ' ', 3),
        'MM/DD/YYYY HH12:MI:SS AM'
    ) AS SleepMinute,
    value AS SleepStage,
    logId
FROM (SELECT * FROM raw.minutesleep_p1 UNION ALL SELECT * FROM raw.minutesleep_p2) x;

SELECT 'minutecalories'   AS table_name, COUNT(*) AS rows FROM stg.minutecalories
UNION ALL SELECT 'minuteintensities', COUNT(*) FROM stg.minuteintensities
UNION ALL SELECT 'minutesteps',       COUNT(*) FROM stg.minutesteps
UNION ALL SELECT 'minutemets',        COUNT(*) FROM stg.minutemets
UNION ALL SELECT 'minutesleep',       COUNT(*) FROM stg.minutesleep;


-- =============================================================
-- STEP 9: ANALYTICS — daily_activity
-- =============================================================

DROP TABLE IF EXISTS analytics.daily_activity;
CREATE TABLE analytics.daily_activity AS
SELECT
    Id, ActivityDate, TotalSteps, TotalDistance, TrackerDistance, LoggedActivitiesDistance,
    VeryActiveDistance, ModeratelyActiveDistance, LightActiveDistance, SedentaryActiveDistance,
    VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes, Calories,
    (VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes) AS TotalActiveMinutes,
    CASE
        WHEN TotalSteps < 5000 THEN 'Sedentary'
        WHEN TotalSteps BETWEEN 5000 AND 7499 THEN 'Low Active'
        WHEN TotalSteps BETWEEN 7500 AND 9999 THEN 'Moderately Active'
        ELSE 'Highly Active'
    END AS ActivityLevel,
    TRIM(TO_CHAR(ActivityDate, 'Day'))    AS DayName,
    EXTRACT(DOW FROM ActivityDate)::INT   AS DayNumber,
    EXTRACT(MONTH FROM ActivityDate)::INT AS MonthNumber,
    EXTRACT(YEAR FROM ActivityDate)::INT  AS YearNumber
FROM stg.dailyactivity_clean;

SELECT COUNT(*) AS analytics_daily_activity_rows FROM analytics.daily_activity;
SELECT ActivityLevel, COUNT(*) FROM analytics.daily_activity GROUP BY ActivityLevel ORDER BY COUNT(*) DESC;


-- =============================================================
-- STEP 10: ANALYTICS — user_activity_summary
-- =============================================================

DROP TABLE IF EXISTS analytics.user_activity_summary;
CREATE TABLE analytics.user_activity_summary AS
SELECT
    Id,
    COUNT(*)                            AS TrackedDays,
    AVG(TotalSteps::FLOAT)              AS AvgDailySteps,
    AVG(Calories::FLOAT)                AS AvgDailyCalories,
    AVG(TotalDistance::FLOAT)           AS AvgDailyDistance,
    AVG(SedentaryMinutes::FLOAT)        AS AvgSedentaryMinutes,
    AVG(VeryActiveMinutes::FLOAT)       AS AvgVeryActiveMinutes,
    AVG(FairlyActiveMinutes::FLOAT)     AS AvgFairlyActiveMinutes,
    AVG(LightlyActiveMinutes::FLOAT)    AS AvgLightlyActiveMinutes,
    AVG(TotalActiveMinutes::FLOAT)      AS AvgTotalActiveMinutes
FROM analytics.daily_activity
GROUP BY Id;

SELECT COUNT(*) AS total_users FROM analytics.user_activity_summary;


-- =============================================================
-- STEP 11: ANALYTICS — activity_sleep
-- =============================================================

DROP TABLE IF EXISTS analytics.activity_sleep;
CREATE TABLE analytics.activity_sleep AS
SELECT
    a.Id, a.ActivityDate, a.TotalSteps, a.TotalActiveMinutes,
    a.SedentaryMinutes, a.Calories, a.ActivityLevel,
    s.TotalSleepRecords, s.TotalMinutesAsleep, s.TotalTimeInBed, s.SleepEfficiency
FROM analytics.daily_activity a
LEFT JOIN stg.sleep s ON a.Id = s.Id AND a.ActivityDate = s.SleepDate;

SELECT COUNT(*) AS activity_sleep_rows FROM analytics.activity_sleep;
SELECT COUNT(*) AS rows_with_sleep FROM analytics.activity_sleep WHERE TotalMinutesAsleep IS NOT NULL;


-- =============================================================
-- STEP 12: ANALYTICS — hourly_activity
-- =============================================================

DROP TABLE IF EXISTS analytics.hourly_activity;
CREATE TABLE analytics.hourly_activity AS
SELECT
    Id, ActivityDateTime,
    ActivityDateTime::DATE                AS ActivityDate,
    EXTRACT(HOUR FROM ActivityDateTime)::INT AS HourOfDay,
    TRIM(TO_CHAR(ActivityDateTime, 'Day')) AS DayName,
    StepTotal, Calories, TotalIntensity, AverageIntensity
FROM stg.hourly;

SELECT COUNT(*) AS analytics_hourly_activity_rows FROM analytics.hourly_activity;


-- =============================================================
-- STEP 13: REPORT TABLES
-- =============================================================

-- 1. Peak activity times by hour
DROP TABLE IF EXISTS report.hourly_behavior_summary;
CREATE TABLE report.hourly_behavior_summary AS
SELECT
    HourOfDay,
    AVG(StepTotal::FLOAT)      AS AvgSteps,
    AVG(Calories::FLOAT)       AS AvgCalories,
    AVG(TotalIntensity::FLOAT) AS AvgIntensity
FROM analytics.hourly_activity
GROUP BY HourOfDay ORDER BY HourOfDay;

-- 2. User activity segments
DROP TABLE IF EXISTS report.user_activity_segments;
CREATE TABLE report.user_activity_segments AS
SELECT
    Id, AvgDailySteps, AvgDailyCalories, AvgTotalActiveMinutes,
    CASE
        WHEN AvgDailySteps < 5000 THEN 'Sedentary'
        WHEN AvgDailySteps BETWEEN 5000 AND 7499 THEN 'Low Active'
        WHEN AvgDailySteps BETWEEN 7500 AND 9999 THEN 'Moderately Active'
        ELSE 'Highly Active'
    END AS ActivitySegment
FROM analytics.user_activity_summary;

-- 3. Sleep vs activity by segment
DROP TABLE IF EXISTS report.sleep_activity_summary;
CREATE TABLE report.sleep_activity_summary AS
SELECT
    a.ActivityLevel,
    AVG(a.TotalSteps::FLOAT)         AS AvgSteps,
    AVG(a.TotalActiveMinutes::FLOAT) AS AvgActiveMinutes,
    AVG(a.SedentaryMinutes::FLOAT)   AS AvgSedentaryMinutes,
    AVG(s.TotalMinutesAsleep::FLOAT) AS AvgSleepMinutes,
    AVG(s.SleepEfficiency::FLOAT)    AS AvgSleepEfficiency
FROM analytics.daily_activity a
LEFT JOIN stg.sleep s ON a.Id = s.Id AND a.ActivityDate = s.SleepDate
WHERE s.TotalMinutesAsleep IS NOT NULL
GROUP BY a.ActivityLevel;

-- 4. Primary BI table — activity + sleep combined
DROP TABLE IF EXISTS report.activity_sleep_dataset;
CREATE TABLE report.activity_sleep_dataset AS
SELECT
    Id, ActivityDate,
    TRIM(TO_CHAR(ActivityDate, 'Day'))    AS DayName,
    EXTRACT(DOW FROM ActivityDate)::INT   AS DayNumber,
    EXTRACT(MONTH FROM ActivityDate)::INT AS MonthNumber,
    TotalSteps, TotalActiveMinutes, SedentaryMinutes, Calories, ActivityLevel,
    TotalMinutesAsleep, TotalTimeInBed, SleepEfficiency,
    CASE
        WHEN TotalSteps < 5000 THEN 'Sedentary'
        WHEN TotalSteps BETWEEN 5000 AND 7499 THEN 'Low Active'
        WHEN TotalSteps BETWEEN 7500 AND 9999 THEN 'Moderately Active'
        ELSE 'Highly Active'
    END AS ActivitySegment
FROM analytics.activity_sleep;

-- 5. Weight tracking summary
DROP TABLE IF EXISTS report.weight_summary;
CREATE TABLE report.weight_summary AS
SELECT
    Id,
    COUNT(*)               AS LogCount,
    MIN(WeightKg)          AS MinWeightKg,
    MAX(WeightKg)          AS MaxWeightKg,
    AVG(WeightKg)          AS AvgWeightKg,
    AVG(BMI)               AS AvgBMI,
    MIN(LogDateTime::DATE) AS FirstLog,
    MAX(LogDateTime::DATE) AS LastLog
FROM stg.weightlog
GROUP BY Id;


-- =============================================================
-- FINAL SANITY CHECKS
-- =============================================================

SELECT 'daily_activity'         AS table_name, COUNT(*) AS rows FROM analytics.daily_activity
UNION ALL SELECT 'activity_sleep',              COUNT(*) FROM analytics.activity_sleep
UNION ALL SELECT 'hourly_activity',             COUNT(*) FROM analytics.hourly_activity
UNION ALL SELECT 'user_activity_summary',       COUNT(*) FROM analytics.user_activity_summary
UNION ALL SELECT 'activity_sleep_dataset',      COUNT(*) FROM report.activity_sleep_dataset
UNION ALL SELECT 'hourly_behavior_summary',     COUNT(*) FROM report.hourly_behavior_summary
UNION ALL SELECT 'user_activity_segments',      COUNT(*) FROM report.user_activity_segments
UNION ALL SELECT 'sleep_activity_summary',      COUNT(*) FROM report.sleep_activity_summary
UNION ALL SELECT 'weight_summary',              COUNT(*) FROM report.weight_summary;

SELECT COUNT(DISTINCT Id) AS unique_users FROM analytics.daily_activity;
SELECT MIN(ActivityDate), MAX(ActivityDate) FROM analytics.daily_activity;
