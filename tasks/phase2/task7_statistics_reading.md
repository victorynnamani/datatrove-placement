# Phase 2 — Task 7: Statistics & Experimentation (Reading)

**Issued by:** Promise Ekeh, Head of Analytics
**Phase:** 2 — Data Wrangling & SQL
**Duration:** ~2–3 hours · reading + a short written submission
**Format:** **Reading-only.** No notebook to submit — add a short written submission to the repository.

---

## Context

In the original six-month programme, inferential statistics and experimentation were a whole phase of their own. On the compressed timeline we are folding them into Phase 2 as **background reading**, not a build. You already covered descriptive statistics and probability in Phase 1 (Task 1.4); this task makes sure you know *what exists* and *when you'd reach for it*, so it's not a blank spot in an interview — even though we won't drill it hands-on now.

## Objective

Read enough to explain, in plain English, the core ideas of inferential statistics and controlled experiments — and to recognise when a NorthStar question needs one.

## What to read

Skim for understanding, not mastery:

1. **Sampling & confidence intervals** — why a sample estimate has uncertainty, and what a 95% CI does and does not mean.
2. **Hypothesis testing** — null vs alternative, p-values, significance, and the two error types. Focus on the *intuition* and the common misreadings of a p-value.
3. **A/B testing** — how an online experiment is set up: randomisation, control vs treatment, a primary metric, and why you fix the metric before you look.
4. **Resampling (bootstrap)** — the one-paragraph idea: simulate uncertainty by resampling your data.
5. **Bayesian thinking (awareness)** — prior → data → posterior, in one paragraph. Just know the vocabulary.

## Deliverable

Create `tasks/phase2/07_statistics_reading_submission.md` in the repository. Keep it to no more than one page and cover:

- **Three things you learned**, in your own words.
- **One NorthStar question** that would genuinely need an A/B test or a significance test (e.g. *"does a 10% discount actually reduce returns, or is it noise?"*), and one sentence on how you'd set it up.
- **One thing you want to revisit** properly after the placement.

## How I'll assess it

Lightly — this is awareness, not a graded build. I'm looking for evidence you understood the ideas and can spot when they apply. Written communication is the dimension that matters here.

## Resources

- *Practical Statistics for Data Scientists* (Bruce & Bruce) — Ch. 2–3 (skim).
- StatQuest (YouTube): p-values, confidence intervals, and hypothesis testing explainers.
- Any good "How to run an A/B test" article from a product-analytics blog.

> **Note.** Web scraping and API data acquisition are also awareness-only on this timeline. If you have spare time, read one primer on `requests` + a public JSON API and one on `BeautifulSoup`, and add a line to your stand-up — but there's nothing to submit.
