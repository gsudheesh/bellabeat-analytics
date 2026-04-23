-- Per-user weight tracking summary
SELECT
    id,
    COUNT(*)               AS log_count,
    MIN(weightkg)          AS min_weight_kg,
    MAX(weightkg)          AS max_weight_kg,
    AVG(weightkg)          AS avg_weight_kg,
    AVG(bmi)               AS avg_bmi,
    MIN(log_datetime::DATE) AS first_log,
    MAX(log_datetime::DATE) AS last_log
FROM {{ ref('stg_weightlog') }}
GROUP BY id
