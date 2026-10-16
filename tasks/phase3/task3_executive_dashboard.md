# Phase 3 — Task 3: The Executive Dashboard

**Issued by:** Promise Ekeh, Head of Analytics
**Phase:** 3 — Visualisation & Dashboards
**Duration:** ~Week 2–3 of the phase · part-time
**Prerequisite:** [Task 2 — BI Fundamentals](task2_bi_fundamentals.md).

---

## Context

Eleanor's words to Marcus: *"I have ten minutes between meetings. Show me how the business is doing."* A report is read once; a dashboard is glanced at weekly. It has to answer "how are we doing?" in a five-second look and reward a thirty-second one. Same tool as Task 2, dramatically higher bar — and what you **leave out** now matters more than what you put in.

Everything is in **pounds (£)**.

## The data

Reuse your Task 2 model (`northstar_clean.csv` + `northstar_regions.csv`). The `returned` column is fair game — return rate is a KPI Eleanor cares about, and it sets up Phase 4.

## Objective

Design and build a single-page, CEO-grade dashboard that passes the 30-second test.

## Working structure

```
tasks/phase3/
├── northstar_dashboard.pbix      (updated)
└── phase3_dashboard.md           (sketch, screenshots, checklist)
```

## Requirements

1. **Sketch first.** Before building, sketch the layout on paper (headline number, supporting KPIs, trend chart, bottom detail). Photograph it into `phase3_dashboard.md`. **Show me the sketch before you build.**
2. **KPI strip (top).** Four cards, each with an **arrow + % change vs prior month**: revenue, orders, average basket size, and return rate (or new customers).
3. **Headline chart.** One large chart telling the most important story — usually revenue trend with a target line (target = prior month × 1.05). Title it as a sentence.
4. **Supporting visuals (3–4):** revenue by region vs target; top categories this month with last-month rank in grey; return rate by category or region; optional payment-method mix.
5. **Filters:** date range, region, category — top-right. **No** customer-level slicers; this is an executive page.
6. **Polish checklist** (tick each in `phase3_dashboard.md`): one brand colour + grey; cards aligned to a grid; one font, two sizes; no needless gridlines; a footer caveat ("Data as of [date]").
7. **30-second test.** Show it to a non-technical person for 30 seconds and write down what they thought the business was doing. If they didn't get it, iterate.
8. **Publish** the updated link.

**Milestone:** a director who never opens a notebook understands the month in one glance.

## Deliverables

- `tasks/phase3/northstar_dashboard.pbix` (updated) or public link.
- `tasks/phase3/phase3_dashboard.md` — sketch, screenshots, published link, polish checklist, 30-second-test feedback.

## How I'll assess it

The usual four dimensions, with **communication** weighted highest. A beautiful chart that doesn't drive a decision scores lower than a plain one that does.

## Working rhythm

- Branch `phase3-task3-dashboard`, small commits, imperative messages ≤ 72 chars.
- Friday stand-up: Done / Learning / Blockers / Next.
- Show me the sketch *before* you build — it's cheaper to fix a layout on paper.

## Learning outcomes

- Top-down dashboard design (sketch first) and the 30-second test as a quality bar.
- Ruthless editing: deciding what to leave out.

## Resources

- *Storytelling with Data* (Cole Nussbaumer Knaflic) — Ch. 6–7.
- Stephen Few, *Information Dashboard Design*, Ch. 4.
