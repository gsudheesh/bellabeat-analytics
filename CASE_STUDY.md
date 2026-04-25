# Bellabeat Fitness Analytics — Case Study

**Role:** Analytics Engineer (solo project)
**Tools:** PostgreSQL 16 · dbt Core 1.11 · Looker Studio · Git
**Duration:** April 2026
**Location:** Sydney, Australia

---

## Background

Bellabeat is a health-focused smart device company that makes fitness trackers and wellness products targeted at women. This project treats a publicly available Fitbit dataset as a proxy for Bellabeat device data, with the goal of identifying user behaviour patterns that could inform product and marketing decisions.

The business question driving the analysis:

> *How do people actually use fitness trackers day-to-day, and what does that tell us about where Bellabeat should focus its product and engagement strategy?*

---

## What I Built

A production-style analytics pipeline — not a notebook, not a one-off query, but a repeatable, tested, layered data model that could be handed to another engineer and run immediately.

```
Raw CSVs (Kaggle)
    ↓
PostgreSQL 16 — raw schema (28 tables, exact CSV copies)
    ↓
dbt staging — type casting, deduplication, cleaning
    ↓
dbt analytics — business logic, joins, derived metrics
    ↓
dbt report — 5 pre-aggregated BI-ready tables
    ↓
Looker Studio — 4-page interactive dashboard
```

**Scale:**
- 29 source CSV files ingested
- 2.77 million minute-level records processed
- 1,373 clean daily user records after deduplication
- 15 dbt models with 23 automated data tests, 100% pass rate

---

## Technical Decisions Worth Noting

**Why dbt over plain SQL scripts?**
dbt enforces modularity — each model does one thing, transformations are version-controlled, and the test framework catches data quality issues automatically. When I discovered 24 duplicate rows across the two Fitbit export periods, the `not_null` and `unique` tests flagged them immediately. Without dbt tests, those duplicates would have silently inflated user-day counts in every downstream metric.

**Why PostgreSQL over SQLite or DuckDB?**
PostgreSQL mirrors what production analytics environments actually use — it has schemas, proper data types, window functions, and a permission model. Using SQLite for a portfolio project signals you haven't worked with real infrastructure. PostgreSQL signals you have.

**Why a layered schema architecture?**
Separating raw → staging → analytics → report means each layer has a single responsibility. If a source changes its column names, only the staging model needs updating — not every downstream report. This is how Snowflake and BigQuery projects are structured at scale.

**Platform migration:**
The original pipeline was built in T-SQL (SQL Server). I fully migrated it to PostgreSQL on macOS, rewriting syntax for date handling, string functions, and table creation. This wasn't just a copy-paste job — PostgreSQL's stricter type system required explicit casting throughout the staging layer.

---

## What the Data Showed

### Finding 1 — Most users are sedentary most of the time

Classifying each user-day by step count into four segments:

| Segment | Steps | Share of user-days |
|---|---|---|
| Sedentary | < 5,000 | 37.1% |
| Low Active | 5,000–7,499 | 22.9% |
| Moderately Active | 7,500–9,999 | 20.0% |
| Highly Active | ≥ 10,000 | 20.0% |

Over a third of tracked days fall below 5,000 steps — well under the commonly cited 10,000-step target. This is the most important commercial insight in the dataset: **the majority of Fitbit users are not meeting their own implied fitness goals**, which means there is a significant engagement gap that a product like Bellabeat's Leaf or Time could address with smarter nudging.

**Recommendation:** Bellabeat should design its notification system around the sedentary segment specifically — small achievable goals rather than generic reminders.

---

### Finding 2 — Peak activity windows are consistent and predictable

Aggregating average steps by hour across all users and all days reveals two clear activity peaks:

- **8–9AM** — morning commute and workout window
- **12–7PM** — sustained midday to early evening activity, peaking around 6–7PM

Activity drops sharply after 8PM and is near-zero from midnight to 6AM.

**Recommendation:** Bellabeat's in-app notifications and coaching prompts should be timed to these windows — not generic daily reminders, but contextually timed prompts that appear just before the natural activity window opens. A prompt at 7:45AM saying "morning walk?" will outperform a generic "time to move!" at 2PM.

---

### Finding 3 — Sleep efficiency is high but sleep duration varies by activity level

Across all four activity segments, average sleep efficiency (time asleep / time in bed) sits between 0.88 and 0.90 — consistently high regardless of how active a user is on a given day.

However, sleep duration tells a different story: Sedentary users average ~450 minutes (7.5 hours) while Highly Active users average ~400 minutes (6.7 hours).

**The honest finding:** There is no strong correlation between daily step count and sleep efficiency in this dataset. More active users sleep slightly less, but not worse. This is a nuanced result — it would be easy to force a "more steps = better sleep" narrative, but the data doesn't support it.

**Recommendation:** Rather than making sleep quality claims tied to activity level, Bellabeat's marketing should focus on sleep consistency — the data suggests users who engage with the app regularly maintain stable sleep patterns, which is a more defensible product differentiator.

---

### Finding 4 — Weight tracking has an adoption problem

Only 13 of 35 users logged any weight data during the two-month period, and several of those logged only once or twice. This is a product signal, not a data quality issue.

**Recommendation:** The weight tracking feature either needs to be made significantly easier to use (automated scale integration, photo logging) or deprioritised in favour of features users actually engage with — like step tracking and sleep monitoring.

---

## What I Would Do Differently at Scale

This pipeline was built locally against a 35-user sample. At production scale, several things would change:

**Infrastructure:** Move PostgreSQL to a managed cloud database (Cloud SQL or RDS). The dbt project is already structured to support this — only the `profiles.yml` connection string would need updating.

**Orchestration:** Add Apache Airflow or dbt Cloud to schedule daily runs rather than running `dbt run` manually.

**Scale of data:** With millions of users instead of 35, the staging layer would need partitioning strategies and incremental models (`materialized='incremental'`) rather than full table refreshes.

**Testing:** Expand dbt tests to include range checks (steps shouldn't exceed 100,000/day), freshness checks on source data, and referential integrity between user IDs across tables.

**Dashboard:** Migrate from Google Sheets as the Looker Studio connector to BigQuery — removing the manual CSV export step and making the pipeline fully automated end-to-end.

---

## Results

| Deliverable | Status |
|---|---|
| 4-layer dbt pipeline (raw → report) | ✅ Complete |
| 15 dbt models, 23 tests, 100% pass | ✅ Complete |
| 5 BI-ready report tables | ✅ Complete |
| 4-page Looker Studio dashboard | ✅ Complete |
| Architecture diagram | ✅ Complete |
| PostgreSQL migration from T-SQL | ✅ Complete |

---

## Links

- [Live Dashboard (Looker Studio)](https://datastudio.google.com/u/0/reporting/cc39169a-814f-42aa-8b67-754e7ed2d566/page/De5vF)
- [GitHub Repository](https://github.com/gsudheesh/bellabeat-analytics)
- [Source Data (Kaggle)](https://www.kaggle.com/datasets/arashnic/fitbit)

---

*Sudheesh Gangishetty · April 2026 · Sydney, Australia*
