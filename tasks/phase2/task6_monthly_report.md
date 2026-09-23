# Phase 2 — Task 6: The NorthStar Monthly Report

**Issued by:** Promise Ekeh, Head of Analytics
**Phase:** 2 — Data Wrangling & SQL
**Duration:** ~Week 4 of the phase · part-time
**Prerequisite:** Tasks 1–5 of this phase.

---

## Context

This is your first **deliverable for the business**, not a learning exercise. Using everything from Tasks 1–5, write a report the NorthStar board could read on its own. The analysis behind it must be reproducible — every number traces back to a notebook cell.

Everything is in **pounds (£)**.

## The data

All of your Phase 2 work: `dataset/northstar_clean.csv`, the merged regions, your pandas and SQL analyses.

## Objective

Write a 3–5 page report (`northstar_monthly_report.pdf` or `.docx`) covering **December 2024**, compared with **November 2024**, that a NorthStar director who never opens a notebook can read and act on.

## Working structure

```
tasks/phase2/
└── northstar_monthly_report.pdf   (or .docx)
```

## Requirements

1. **Analysis is reproducible** — every number in the report traces back to a notebook cell. No hand-typed figures from a different run.
2. **The report must contain**
   - **Cover page** — client, period covered, your name, date.
   - **Executive summary** — ≤ 200 words, no jargon.
   - **3–5 charts**, each with a title, axis labels, a one-sentence *"what"* caption and a one-sentence *"so what"* caption. Choose ruthlessly — kill your darlings.
   - **Findings** in prose (not bullets), answering: December revenue vs November; which categories drove or dragged revenue; which regions over-/under-performed vs a target of November revenue × 1.05; any day-of-week or seasonal pattern; and what the **return rate** looks like by region or category (a first look at the `returned` column — it becomes the target in Phase 4).
   - **Recommendations** — at least three specific actions, each tied to a finding.
   - **Appendix** — one paragraph on data sources and caveats (what you cleaned, what you assumed).
3. **Style** — calm, professional, British English, no emojis. Aim for the tone of a concise Deloitte or McKinsey consumer-goods executive report.

**Milestone:** a NorthStar director who never opens the notebook understands the month, and knows what to do next.

## Deliverables

- `tasks/phase2/northstar_monthly_report.pdf` (or `.docx`).

## How I'll assess it

The usual four dimensions. The single thing I care about most: **you interpret the numbers for a decision, not just describe them.** Every chart paired with a *what* and a *so what*; every recommendation tied to a finding.

## Working rhythm

- Branch `phase2-task6-report`, small commits, imperative messages ≤ 72 chars.
- Friday stand-up: Done / Learning / Blockers / Next.
- Show me a draft before you polish — cheaper to fix the argument than the formatting.

## Learning outcomes

- Turning analysis into a business-readable narrative.
- The discipline of pairing every chart with a *what* and a *so what*, and tying findings to recommendations.

## Resources

- *Storytelling with Data* (Cole Nussbaumer Knaflic) — Ch. 1–4.
