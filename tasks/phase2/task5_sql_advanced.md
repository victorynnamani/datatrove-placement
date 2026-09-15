# Phase 2 — Task 5: SQL Advanced (CTEs & Window Functions)

**Issued by:** Promise Ekeh, Head of Analytics
**Phase:** 2 — Data Wrangling & SQL
**Duration:** ~Week 3 of the phase · part-time
**Prerequisite:** [Task 4 — SQL Fundamentals](task4_sql_fundamentals.md) (reuse the database you built there).

---

## Context

Fundamentals answer "how much" and "which". Analyst-grade SQL answers "compared to what" and "in what order" — running totals, rankings, month-over-month growth. That is what CTEs and window functions unlock, and it's what separates a junior from a mid analyst in an interview.

Everything is in **pounds (£)**.

## The data

Reuse the database you built in Task 4 (the `orders` and `regions` tables) — SQLite, MySQL, or the notebook, whichever you chose. Window functions need **SQLite 3.25+** or **MySQL 8+** (both current versions have them).

## Objective

Answer harder, comparative questions using CTEs and all three window-function families.

## Working structure

```
tasks/phase2/
└── 05_sql_advanced.sql   (your query answers; or a .ipynb if you use Python)
```

## Requirements

Working against your Task 4 database, answer the following with **SQL only** (one query per answer):

1. **CTE vs subquery** — answer *"for each region, what fraction of total revenue does its top customer contribute?"* both ways, then say which reads better.
2. **Ranking windows** — `ROW_NUMBER()` over orders within each region by date; `RANK()`/`DENSE_RANK()` on customers within region by total spend (explain the difference); `NTILE(4)` for customer spend quartiles.
3. **Aggregating windows** — running total of revenue per region ordered by date; each order's `total_amount` as a % of its region's total.
4. **Lag/lead** — monthly revenue per region with a `prev_month_revenue` via `LAG()`, then month-over-month growth; find the worst region-month.
5. **Multi-step CTE** — one query, a CTE per logical step, returning the **top 3 customers per region by spend** with their rank, total spend, and order count.
6. **Reflection (≤ 150 words)** — one concrete NorthStar scenario where you'd reach for SQL over pandas, and one for the reverse.

**Milestone:** you're comfortable with CTEs and all three window-function families.

## Deliverables

- **A runnable `.sql` script** (`05_sql_advanced.sql`) — one query per answer under a comment header with a one-line read, and the reflection at the end. *(An `.ipynb` is fine if you used Python.)*

## How I'll assess it

The usual four dimensions. Correct window framing (`PARTITION BY` / `ORDER BY`), readable multi-step CTEs, and a thoughtful pandas-vs-SQL reflection.

## Working rhythm

- Branch `phase2-task5-sql-advanced`, small commits, imperative messages ≤ 72 chars.
- Friday stand-up: Done / Learning / Blockers / Next.

## Learning outcomes

- CTEs for readable multi-step logic.
- Ranking, aggregating, and lag/lead windows for comparative analysis.

## Resources

- Mode Analytics SQL tutorial — the advanced track (free).
- *SQL for Data Analysis* (Cathy Tanimura) — Ch. 4–5.
- SQLite window-function docs.
