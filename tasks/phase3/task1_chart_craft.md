# Phase 3 — Task 1: Chart Craft

**Issued by:** Promise Ekeh, Head of Analytics
**Phase:** 3 — Visualisation & Dashboards
**Duration:** ~Week 1 of the phase (short) · part-time
**Prerequisite:** Phase 2 (you need `dataset/northstar_clean.csv`).

---

## Context

Your Phase 2 report landed well. Now **Eleanor Grant**, CEO of NorthStar Goods, wants something she can look at herself, on any given Tuesday, without asking an analyst. That's a different craft from a written report — and it starts with knowing which chart answers which question, and how to make it say something.

Before touching a BI tool, sharpen your judgement in Python on the clean NorthStar data. Everything is in **pounds (£)**.

## The data

- `dataset/northstar_clean.csv` — your cleaned order table from Phase 2.
- `dataset/northstar_regions.csv` — the regions reference table.

## Objective

Build the single best chart for each of a set of business questions, and be able to defend every choice in one sentence.

## Working structure

```
tasks/phase3/
└── 01_chart_craft.ipynb
```

## Requirements

In `01_chart_craft.ipynb`:

1. **Choose-the-right-chart drill.** For each question, build the single chart you think answers it best, with a one-sentence justification:
   - "How is monthly revenue trending?"
   - "Which regions are pulling their weight?"
   - "How does basket size differ by payment method?"
   - "Are discount depth and return rate related?"
   - "What does our order-value distribution look like?"
2. **Design polish** on every chart: a **sentence** title ("London is up 12% on last quarter", not "Revenue by region"), clean axis labels with units, one accent colour + grey for the rest, direct labelling over legends, a small source/caveat footer.
3. **Annotation challenge.** Pick one chart and add an arrow + text callout on the most interesting point ("Discount campaign launched here").
4. **Two anti-examples.** Recreate two *bad* charts (a 3-D pie, a rainbow palette, a truncated axis) and write one paragraph each on why they mislead.

**Milestone:** you can defend every chart choice in one sentence.

## Deliverables

- `tasks/phase3/01_chart_craft.ipynb` — every chart titled as a sentence, each with a one-line justification.


## Working rhythm

- Branch `phase3-task1-chart-craft`, small commits, imperative messages ≤ 72 chars.
- Friday stand-up: Done / Learning / Blockers / Next.

## Learning outcomes

- Chart-type judgement and the discipline of deleting non-informative ink.
- Titling a chart as a claim, not a label.

## Resources

- *Storytelling with Data* (Cole Nussbaumer Knaflic) — Ch. 3–6.
- The Economist's "Off the Charts"; the Datawrapper Academy blog.
