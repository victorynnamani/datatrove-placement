# Phase 2 — Task 2: Clean It, Log Every Decision

**Issued by:** Promise Ekeh, Head of Analytics
**Phase:** 2 — Data Wrangling & SQL
**Duration:** ~Week 1–2 of the phase · part-time
**Prerequisite:** [Task 1 — First EDA](task1_eda.md) (you need your data-quality catalogue).

---

## Context

Your EDA catalogued what's wrong with the NorthStar export. Now you fix it — carefully, and with a paper trail. In real work, a cleaning step you can't explain is a cleaning step nobody can trust. Every decision here gets a reason.

Everything is in **pounds (£)**.

## The data

- Input: `dataset/northstar_goods.csv` (raw).
- Output: `dataset/northstar_clean.csv` (you produce it here; later tasks depend on it).

> **Deliberate trap you'll meet in Task 3.** The `region` values in the order export are inconsistently cased (`london`, `LONDON`, `London`); the regions reference table uses proper case. A JOIN or merge will silently drop rows until you normalise the casing here. Cleaning is not busywork — it is what makes the join work.

## Objective

Turn the raw export into an analysis-ready table, with a cleaning log that lets a colleague reproduce and understand every decision.

## Working structure

```
tasks/phase2/
└── 02_cleaning.ipynb
```

## Requirements

In `02_cleaning.ipynb`, each cleaning step gets its own cell with a markdown header explaining **what** and **why**. At minimum:

1. **Duplicates** — remove the exact duplicate rows.
2. **Missing values** — decide *per column* (drop / median-fill / `"Unknown"`) and justify each choice.
3. **Dates** — parse `order_date` to a real datetime; handle the impossible date (`2024-13-40`).
4. **Numerics** — coerce `unit_price` and `quantity` to numbers; deal with negatives and the obvious outliers (`9999.99`, `quantity = 500`).
5. **Categoricals** — normalise `region` casing (so it matches the reference table) and `payment_method`.
6. **Recompute `total_amount`** — validate it equals `quantity × unit_price × (1 − discount_pct/100)`; flag and correct rows where it doesn't.
7. **Cleaning log** — a markdown table at the bottom: `Step | Issue | Action taken | Rows affected | Justification`, one row per decision.
8. **Post-cleaning checks** — zero duplicates, zero invalid dates, no negative quantities, every `region` in the known list, and a raw-vs-clean row-count diff.

Save the result as `dataset/northstar_clean.csv`.

**Milestone:** a colleague could reproduce your clean file *and* understand every decision from the log alone.

## Deliverables

- `tasks/phase2/02_cleaning.ipynb` — one cell per decision, cleaning log, post-cleaning checks.
- `dataset/northstar_clean.csv` — rebuilt by the notebook (don't hand-edit it).

## How I'll assess it

The usual four dimensions. Here I care most about **justification**: every change traceable to a reason in the log.

## Working rhythm

- Branch `phase2-task2-cleaning`, small commits, imperative messages ≤ 72 chars.
- Friday stand-up: Done / Learning / Blockers / Next.

## Learning outcomes

- A defensible cleaning workflow with an auditable log.
- Type coercion, missing-value strategy, outlier handling, categorical normalisation.

## Resources

- *Python for Data Analysis* (Wes McKinney) — Ch. 8 (cleaning).
- pandas docs: `drop_duplicates`, `to_datetime`, `to_numeric`, `str` accessors, `fillna`.
