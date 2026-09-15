# Phase 2 — Task 4: SQL Fundamentals

**Issued by:** Promise Ekeh, Head of Analytics

**Phase:** 2 — Data Wrangling & SQL

**Duration:** ~Week 3 of the phase · part-time

**Prerequisite:** [Task 2 — Cleaning](task2_cleaning.md) (you need `dataset/northstar_clean.csv`).

---

## Context

SQL is the second most-asked skill in data interviews after pandas — and in most companies the data lives in a database, not a CSV. In this task you build a small database from the clean NorthStar tables — **defining the schema yourself with `CREATE TABLE`** — and answer the same kinds of questions as Task 3, but in **SQL only**.

You do **not** have to work in Python or a notebook. Pick whichever environment you prefer (see *Choose your environment* below); the SQL is identical.

Everything is in **pounds (£)**.

## The data

- `dataset/northstar_clean.csv` → an `orders` table.
- `dataset/northstar_regions.csv` → a `regions` table.

## Choose your environment

Work in whichever of these you like — the SQL you write is the same:

- **SQLite via a desktop app (recommended).** Install **DB Browser for SQLite** or **DBeaver** — both free, no server to set up, and the whole database is a single `northstar.db` file. Write your SQL in the app's editor and save it as a `.sql` script.
- **MySQL** (MySQL Workbench or DBeaver) — allowed if you'd rather. It's a client-server database, so you'll need a local MySQL server running; hand in your `.sql` script plus exported result CSVs/screenshots, since a server isn't portable.
- **Python / notebook** (the original route) — nothing to install; `sqlite3` is built into Python and `pd.read_sql_query(sql, conn)` runs each query.

Either way, you build the tables by hand with `CREATE TABLE` — see *Setup* under Requirements.

## Objective

Build a small database — **schema and all** — and answer business questions with the core SQL toolkit: the six clauses, aggregation, `GROUP BY`/`HAVING`, joins, and subqueries.

## Working structure

```
tasks/phase2/
├── 04_sql_fundamentals.sql   (your DDL + data load + every query answer; or a .ipynb if you use Python)
└── northstar.db              (the SQLite database you built; MySQL users hand in exported results instead)
```

## Requirements

**Setup — build the schema yourself (do this first).** Write `CREATE TABLE` statements for both tables — `orders` (from `northstar_clean.csv`) and `regions` (from `northstar_regions.csv`) — choosing a sensible type for every column (dates as `DATE`, money as `REAL`/`DECIMAL`, counts as `INTEGER`, the rest as `TEXT`). **Do not let the CSV-import wizard invent the schema for you:** write the DDL, create the empty tables, then load the CSV rows into them. You should be able to explain why each column has the type it does.

Then answer the following with **SQL only** (if you're in a notebook, no pandas in the answer cells — just the SQL string):

1. `SELECT / WHERE / ORDER BY / LIMIT` — top 20 orders by `total_amount`; all London orders after `2024-06-01` with `discount_pct > 10`.
2. **Aggregation** — total revenue; unique customers; min/max/avg basket size.
3. `GROUP BY / HAVING` — revenue per region (desc); categories with revenue > £10,000; regions with more than 100 orders.
4. `JOIN` — inner-join `orders` to `regions` to add `regional_manager` (confirm row count unchanged); left-join after deleting one `regions` row to observe the NULLs.
5. **Subqueries** — the single best region by revenue; all orders above the overall average `total_amount`.

**Milestone:** you can reproduce your Task 3 headline numbers in SQL.

## Deliverables

- **A runnable `.sql` script** (`04_sql_fundamentals.sql`) containing your `CREATE TABLE` DDL, the data load, and every query answer — each under a comment header with a one-line read of the result. *(If you use Python instead, an `.ipynb` with one SQL string per answer is fine.)*
- **The database or its results:** `northstar.db` if you used SQLite; exported result CSVs/screenshots if you used MySQL.
- The script must rebuild everything **from the two CSVs** — a reviewer should be able to run it start to finish.

## How I'll assess it

The usual four dimensions. Sensible column types in your `CREATE TABLE` DDL, clean readable SQL (good aliases, correct `GROUP BY`), and a plain-English read under each query.

## Working rhythm

- Branch `phase2-task4-sql-fundamentals`, small commits, imperative messages ≤ 72 chars.
- Friday stand-up: Done / Learning / Blockers / Next.

## Learning outcomes

- Defining a schema with `CREATE TABLE` and choosing correct column types.
- The six clauses, aggregation, `GROUP BY`/`HAVING`, joins, and subqueries against a real schema.
- Working in a real SQL client (SQLite/MySQL), not just through pandas.

## Resources

- Mode Analytics SQL tutorial — the basic track (free).
- *SQL for Data Analysis* (Cathy Tanimura) — Ch. 1–3.
