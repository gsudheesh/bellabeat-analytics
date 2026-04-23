# Bellabeat Fitness Analytics

End-to-end analytics engineering project on public Fitbit data — built to demonstrate a production-style data pipeline using the tools used by Sydney data teams.

![Architecture](assets/bellabeat_architecture.svg)

---

## Project Goal

Build a raw-to-report data pipeline on the publicly available [Fitbit dataset (Kaggle)](https://www.kaggle.com/datasets/arashnic/fitbit) and surface actionable fitness behaviour insights relevant to Bellabeat, a health-focused smart device company.

The project was originally built on Windows using SQL Server and Power BI, then fully migrated to macOS using an open-source, cloud-compatible stack — demonstrating the ability to work across platforms without losing data fidelity or pipeline structure.

---

## Tech Stack

| Component | Tool |
|---|---|
| Database | PostgreSQL 16 |
| SQL IDE | DBeaver 26 |
| Transformation & Modelling | dbt Core 1.11 |
| BI & Visualisation | Looker Studio |
| Version Control | Git / GitHub |
| Language | SQL (PostgreSQL dialect) |
| Environment | macOS (Apple M5) |

---

## Architecture

The pipeline follows a four-layer ELT architecture, identical to how production data warehouses are structured at companies using Snowflake, BigQuery, or Redshift.

```
Raw CSVs → PostgreSQL (raw) → dbt staging → dbt analytics → dbt report → Looker Studio
```

| Schema | Purpose | Tables |
|---|---|---|
| raw | Exact CSV copies, append-only | 28 |
| stg | Type casting, deduplication, cleaning | 15 |
| analytics | Business logic, derived metrics, joins | 4 |
| report | Pre-aggregated BI-ready output | 5 |

---

## Dataset

- Source: [Fitbit Dataset — Kaggle](https://www.kaggle.com/datasets/arashnic/fitbit)
- 35 Fitbit users across two export periods: 12 March 2016 to 12 May 2016
- 29 CSV files covering daily, hourly, and minute-level activity, sleep, and weight data

| Layer | Key Counts |
|---|---|
| Raw | 1,397 daily · 46,183 hourly · 2.77M minute records |
| Staging | 1,373 clean daily records (24 duplicates removed) |
| Analytics | 35 user summaries · 46,008 hourly records |
| Report | 1,376 BI dataset rows · 24 hourly summary rows |

---

## dbt Project

15 models across 3 layers, with 23 automated data tests.

```
dbt_bellabeat/
  models/
    staging/
      stg_daily_activity.sql
      stg_sleep.sql
      stg_weightlog.sql
      stg_hourly_activity.sql
      stg_minute_activity.sql
      stg_minute_sleep.sql
      sources.yml
      schema.yml
    analytics/
      daily_activity.sql
      user_activity_summary.sql
      activity_sleep.sql
      hourly_activity.sql
      schema.yml
    report/
      rpt_activity_sleep_dataset.sql
      rpt_hourly_behavior_summary.sql
      rpt_user_activity_segments.sql
      rpt_sleep_activity_summary.sql
      rpt_weight_summary.sql
      schema.yml
```

**dbt run results:**

```
dbt run   → PASS=15  WARN=0  ERROR=0  SKIP=0
dbt test  → PASS=23  WARN=0  ERROR=0  SKIP=0
```

---

## Key Findings

**Activity Segmentation**
35.7% of user-days fall in the Sedentary category (under 5,000 steps) — the single largest segment. The majority of tracked users are not meeting recommended daily step targets, representing a clear engagement opportunity for Bellabeat.

**Peak Activity Hours**
Users are most active between hours 12–19 (midday to early evening), with a secondary morning spike around 8–9AM. This is directly actionable for Bellabeat's notification and engagement timing features.

**Sleep and Activity**
Sleep efficiency is consistently high (0.88–0.90) across all activity segments with only marginal differences. Highly Active users tend to sleep slightly fewer minutes (~400 mins) than Sedentary users (~450 mins), suggesting more active users may be trading sleep for activity time.

**Weight Tracking**
Only 13 of 35 users logged weight data, with some logging as few as once across the full period. Low adoption suggests the weight tracking feature may need redesign or improved in-app prompting.

---

## Dashboard

**[View Live Looker Studio Dashboard →](YOUR_LOOKER_STUDIO_LINK_HERE)**

Four pages covering:
- Overview — user count, activity segment distribution
- Activity Analysis — daily steps trend, day-of-week patterns
- Sleep Analysis — sleep efficiency and duration by activity level
- Hourly Behaviour — peak activity hour analysis across 24 hours

---

## SQL Migration Reference

The original pipeline was written in T-SQL (SQL Server) and fully migrated to PostgreSQL. Key syntax changes:

| T-SQL | PostgreSQL |
|---|---|
| `SELECT * INTO table FROM ...` | `CREATE TABLE AS SELECT * FROM ...` |
| `TRY_CONVERT(date, col, 101)` | `TO_DATE(col, 'MM/DD/YYYY')` |
| `DATENAME(WEEKDAY, col)` | `TRIM(TO_CHAR(col, 'Day'))` |
| `TOP 10` | `LIMIT 10` |
| `DATEPART(WEEKDAY, col)` | `EXTRACT(DOW FROM col)` |

---

## How to Run Locally

1. Install PostgreSQL 16 via Homebrew: `brew install postgresql@16`
2. Download the [Fitbit dataset from Kaggle](https://www.kaggle.com/datasets/arashnic/fitbit)
3. Create the `bellabeat` database and load CSVs using the script in `bellabeat_pipeline_postgres.sql`
4. Install dbt: `pip install dbt-postgres`
5. Configure `~/.dbt/profiles.yml` for your local PostgreSQL instance
6. Run the pipeline:

```bash
cd dbt_bellabeat
dbt run
dbt test
```

---

## Project Summary

| Metric | Value |
|---|---|
| Total tables built | 47 (28 raw + 15 staging + 4 analytics + 5 report) |
| dbt models | 15 |
| dbt tests | 23 · 100% pass rate |
| Source files ingested | 29 CSV files |
| Unique users | 35 |
| Date range | 12 March 2016 to 12 May 2016 |
| Daily records (clean) | 1,373 |
| Minute-level records | 2,770,620 |

---

*Sudheesh Gangishetty · April 2026 · Sydney, Australia*
