# Phase 2 — Task 1: First EDA on a Real Client Export

**Issued by:** Promise Ekeh, Head of Analytics
**Phase:** 2 — Data Wrangling & SQL
**Duration:** ~Week 1 of the phase · part-time
**Dataset:** NorthStar Goods (`dataset/northstar_goods.csv`)

---

## Context

Marcus, our Head of Client Delivery, has landed a new account: **NorthStar Goods**, a UK retailer. Their systems team has sent over a raw order export and a small internal reference table for their sales regions. Nobody at DataTrove has touched either file yet.

Phase 2 is where you take one messy client export and carry it the whole way — understand it, clean it, interrogate it in pandas and SQL, and finish with a report the client's board could read. Every task in this phase works the **same** NorthStar dataset, so by the end you know it inside out.

Everything here is in **pounds (£)** — NorthStar is a UK business.

## The data

The datasets are available in https://drive.google.com/drive/folders/1CinL84Np-Zsc0K37hvtHXP71UlQP3u6i:

- **`northstar_goods.csv`** (~1,000 orders) — the raw order export, messy on purpose.

  | Column | Description |
  |---|---|
  | `order_id` | Order reference (e.g. `NS-00123`) |
  | `order_date` | Order date as text (`YYYY-MM-DD`) |
  | `customer_id` | Customer reference |
  | `region` | UK sales region |
  | `product_category` | Product category |
  | `quantity` | Units ordered |
  | `unit_price` | Price per unit (£) |
  | `discount_pct` | Discount applied (%) |
  | `payment_method` | How the order was paid |
  | `total_amount` | Final order value (£) |
  | `returned` | Whether the order was later returned (`Y`/`N`) — *leave it for now; it becomes the target in Phase 4* |

- **`northstar_regions.csv`** (8 rows) — a clean reference table (`region`, `regional_manager`, `country`, `launch_date`). You'll use it in later tasks; ignore it here.

## Objective

Produce a first-pass exploratory analysis of the raw export **without changing a single value** — you are diagnosing, not treating. Cleaning comes in Task 2.

## Working structure

Work in a `tasks/phase2/` folder, one notebook per task in the phase:

```
tasks/phase2/
└── 01_eda.ipynb
```

## Requirements
Load `northstar_goods.csv` and **do not modify it**. In `01_eda.ipynb`:

1. **Shape & types** — rows, columns, dtypes, memory. Comment on whether the dtypes are right (is `order_date` a real datetime? is `unit_price` numeric?).
2. **Missingness** — a missing-value count per column plus a bar chart. Say which columns are worst affected.
3. **Univariate** — for each numeric column: summary stats + a histogram + a one-line read. For each categorical: value counts + a horizontal bar chart.
4. **Bivariate** — at least three pairwise relationships you find interesting (e.g. `region` vs `total_amount`, `product_category` vs `discount_pct`), one chart each, each with a one-sentence finding underneath.
5. **Data-quality catalogue** — a markdown cell listing *every* issue you found (duplicates, impossible dates, negative quantities, price outliers, inconsistent casing, missing values). **Catalogue, don't fix** — fixing is Task 2.

**Milestone:** you can describe the dataset's shape and its problems without having changed a single value.

## Deliverables

- `tasks/phase2/01_eda.ipynb` — every cell runs top-to-bottom, every chart titled and labelled, the data-quality catalogue at the end.

## How I'll assess it

Technical correctness, code quality, written communication, professional behaviour. The thing I care about most: **you interpret what you see for a decision, not just describe it.**


## Learning outcomes

- A repeatable first-look routine: shape → types → missingness → univariate → bivariate → issue log.
- The discipline of separating *diagnosis* from *treatment*.

## Resources

- *Python for Data Analysis* (Wes McKinney) — Ch. 7 (EDA).
- pandas docs: `describe`, `info`, `value_counts`, `isna`.
