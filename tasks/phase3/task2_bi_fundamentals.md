# Phase 3 — Task 2: BI Tool Fundamentals (Power BI / Tableau)

**Issued by:** Promise Ekeh, Head of Analytics
**Phase:** 3 — Visualisation & Dashboards
**Duration:** ~Week 1–2 of the phase · part-time
**Prerequisite:** [Task 1 — Chart Craft](task1_chart_craft.md).

---

## Context

Most clients live in **Power BI** or **Tableau**, not Jupyter. This task is about *mechanics* — loading, modelling, building, and publishing — not beauty. Pick **one** tool and stick with it for the rest of the phase; I recommend **Power BI Desktop** (free, Windows, what most UK retailers use).

Everything is in **pounds (£)**.

## The data

- `dataset/northstar_clean.csv` — your cleaned order table.
- `dataset/northstar_regions.csv` — the regions reference table (`region`, `regional_manager`, `country`, `launch_date`).

## Objective

Load and model the two NorthStar tables in a BI tool, build five visuals with slicers and your first measures, and publish.

## Working structure

```
tasks/phase3/
├── northstar_dashboard.pbix      (or Tableau .twbx / public link)
└── phase3_dashboard.md           (screenshots, links, checklists)
```

## Requirements

1. **Install** the tool; confirm it opens (screenshot in `phase3_dashboard.md`).
2. **Load & model.** Connect to `northstar_clean.csv` and `northstar_regions.csv`. Define the relationship between them on `region`. Check data types (date, decimal, text). Screenshot the model view.
3. **Five visuals on one page:** KPI cards (total revenue, total orders, average basket size); a line chart of revenue by month; a bar chart of revenue by region (sorted); a donut/stacked bar of revenue by `product_category`; and a geographic visual by `country` (or a region bar if your regions don't geocode).
4. **Slicers:** a date-range slicer and a region slicer. Confirm clicking a region cross-filters the other visuals.
5. **First measures (DAX / calculated field):** `Average Basket Size = DIVIDE(SUM(orders[total_amount]), DISTINCTCOUNT(orders[order_id]))`, and a `Return Rate` measure. Put both on cards.
6. **Publish** to Power BI Service (or Tableau Public) and capture the public link + 4–6 screenshots in `phase3_dashboard.md`, with a short note on what was easy, hard, and surprising.

**Milestone:** you can load, model, build, and publish — and you know a column from a measure.

## Deliverables

- `tasks/phase3/northstar_dashboard.pbix` (or `.twbx` / public link).
- `tasks/phase3/phase3_dashboard.md` — model screenshot, visuals, published link, and your easy/hard/surprising note.

## How I'll assess it

The usual four dimensions. Correct data model (relationship on `region`, right types), working slicers, and a measure that isn't just a dragged column.

## Working rhythm

- Branch `phase3-task2-bi-fundamentals`, small commits, imperative messages ≤ 72 chars.
- Friday stand-up: Done / Learning / Blockers / Next.

## Learning outcomes

- Power BI / Tableau mechanics: load, model, measure, slice, publish.
- The difference between a column and a measure.

## Resources

- Microsoft Learn: "Power BI Desktop in a Day" (free); DAX Guide (`dax.guide`).
- Tableau Public free training videos (if you choose Tableau).
