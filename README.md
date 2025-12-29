# Zabito – Operations & Revenue Analytics (Portfolio Project)

This repository showcases an end-to-end analytics workflow for a multi-city co-living/hostel portfolio:
occupancy, churn/retention, pricing & discount effectiveness, and monthly forecasting/variance.

## Business Questions Covered
- Which cities/properties/room types drive occupancy gaps and revenue volatility?
- Where is early-stage churn highest and what indicators correlate with churn?
- Do discounts improve net revenue and retention, or only reduce ADR?
- How accurate are monthly forecasts and what explains variance?

## KPIs
- Occupancy % (daily/monthly)
- Vacancy nights
- Average length of stay (ALOS)
- Early-stage churn (e.g., churn within first 30 days)
- Retention (cohort-based)
- ADR / RevPAR-like proxy (depending on data availability)
- Discount rate and net revenue impact
- Forecast vs Actual variance

## Tech Stack
SQL • Python (Pandas) • Power BI • Excel/Google Sheets

## Data
Data in this repo is either:
1) anonymized sample data, or
2) synthetic data shaped to match the business schema.

See `data/README.md` for the dictionary and privacy approach.

## How to Run
1. Create schema and tables: `sql/00_schema.sql`
2. Build KPI views: `sql/01_kpi_views.sql`
3. Run analyses: `sql/02_*` to `sql/05_*`
4. Use Python notebooks for QA, cohorts, and baseline forecasting.
5. Build Power BI visuals using `powerbi/dashboard_spec.md` and measures in `powerbi/dax_measures.md`.

## Deliverables
- SQL KPI views and analysis queries
- Cohort churn notebook + feature exploration
- Forecast baseline notebook + variance reporting tables
- Power BI dashboard specification + screenshots

## Notes
This is a portfolio project inspired by real operational analytics work. No confidential data is included.
