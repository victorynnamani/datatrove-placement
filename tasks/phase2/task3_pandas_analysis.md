# Phase 2 — Task 3: Answer the Business with Pandas

**Issued by:** Promise Ekeh, Head of Analytics
**Phase:** 2 — Data Wrangling & SQL
**Duration:** ~Week 2 of the phase · part-time
**Prerequisite:** [Task 2 — Cleaning](task2_cleaning.md) (you need `dataset/northstar_clean.csv`).

---

## Context

You have a clean table. Now use it to answer the questions a client actually asks — which regions, how much revenue, when it moved. No manual loops; pandas is built for this.

Everything is in **pounds (£)**.

## The data

- `dataset/northstar_clean.csv` — your cleaned order table.
- `dataset/northstar_regions.csv` — the regions reference table (`region`, `regional_manager`, `country`, `launch_date`). This is your merge target.

## Objective

Answer real "which / how much / when" questions with idiomatic pandas, and prove your Task 2 casing fix makes the region merge match every row.

## Working structure

```
tasks/phase2/
└── 03_pandas_analysis.ipynb
```

## Requirements

In `03_pandas_analysis.ipynb`, load `northstar_clean.csv`:

1. **Groupby**
   - Total revenue per region.
   - Average order value per `product_category`.
   - Top 5 customers by total spend, with rank.
   - Revenue per region per month (multi-key groupby).
   - Per region, in one `.agg()` with named aggregations: unique customers, total orders, mean basket size, and return rate.
2. **Merge** — join the orders to `northstar_regions.csv` to enrich each order with `regional_manager` and `country`. Show one `inner` and one `left` join, and confirm the join matched every row (it won't unless Task 2 normalised the casing — prove it did).
3. **Reshape** — pivot to `region` (rows) × `product_category` (columns) = total revenue; then melt it back to long format. One sentence on when you'd use each shape.
4. **Time series** — set `order_date` as the index, resample to monthly revenue and plot it, overlay a 7-day rolling mean of daily revenue, compute month-over-month % change, and name the worst month.

**Milestone:** you can answer any "which / how much / when" question about NorthStar in a few lines of pandas.

## Deliverables

- `tasks/phase2/03_pandas_analysis.ipynb` — every cell runs, every chart titled and labelled, each finding stated in a sentence.

## How I'll assess it

The usual four dimensions. Idiomatic pandas (use `groupby`/`agg`/`merge`, not loops), and a plain-English finding under each result.

## Working rhythm

- Branch `phase2-task3-pandas`, small commits, imperative messages ≤ 72 chars.
- Friday stand-up: Done / Learning / Blockers / Next.

## Learning outcomes

- Fluency in `groupby().agg(named=...)`, `merge`, pivot/melt, and time-series resampling.
- Proving a join is complete rather than assuming it.

## Resources

- *Python for Data Analysis* (Wes McKinney) — Ch. 10–11 (groupby / merge / time series).
