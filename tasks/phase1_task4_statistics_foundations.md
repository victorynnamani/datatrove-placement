# Phase 1 — Task 4: Statistics & Probability Foundations

**Issued by:** Promise Ekeh, Head of Analytics

**Phase:** 1 — Onboarding & Foundations

**Task:** 4 — Statistics & Probability Foundations

**Estimated effort:** 3 days

---

## Context

Welcome back, Victory. Now that you can move data around with NumPy and pandas, you need the *vocabulary* to describe it. Every report you ever write at DataTrove will lean on the same handful of statistical ideas: averages, spread, distributions, correlation, and the difference between what you *observe* in your data and what you can *infer* about the world.

This task is deliberately maths-light. We are not training mathematicians, we are training analysts who can spot when a number is misleading. Where there is a formula, I want you to be able to explain it in plain English first, then write the Python.

## Objective

Build a single notebook that demonstrates and explains the core descriptive statistics, common probability distributions, and the bridge between samples and populations, using the DataTrove sales data.

## Requirements

1. **Setup.** Create a notebook `phase1_task4_statistics_foundations.ipynb` in `tasks/`. Reuse the `datatrove_sales_2024.csv` dataset from Task 3C.
2. **Descriptive statistics.** For the `total_amount` column, compute and explain:
   - Mean, median, mode. *(Note: `total_amount` is continuous, so `mode()` will usually return one-off values and be uninformative. Either bin the values first, or compute the mode on a discrete column such as `quantity` or `discount_pct` and explain why mode suits discrete data better.)*
   - Range, variance, standard deviation, IQR.
   - Skewness and kurtosis (use `pandas.Series.skew()` and `.kurt()`). **State the sign and what it means** — e.g. positive skew = a long right tail of high-value orders pulling the mean above the median.
   - Why the median can be more useful than the mean for revenue data.
3. **Distributions.** Plot histograms of `total_amount`, `unit_price`, and `quantity`. For each, write one sentence describing the shape (skew left/right, roughly normal, bimodal, etc.).
4. **Sampling.** Take 50 random samples of size 30 from `total_amount` (use `Series.sample(30, replace=True, random_state=...)` so the work is reproducible), compute the mean of each sample, and plot the distribution of those 50 means. Then **compare it to a histogram of the raw `total_amount`** and explain what the **Central Limit Theorem** tells us: why the distribution of sample means is tighter (smaller spread) and looks more bell-shaped than the original data, even though the raw data is skewed.
5. **Correlation.** Compute the Pearson correlation between `quantity` and `total_amount`. Plot a scatter. Explain in your own words the difference between *correlation* and *causation*.
6. **Probability.** Using the dataset, answer:
   - What is the probability a random order is from Lagos?
   - Given an order is from Lagos, what is the probability it is in the Electronics category? (Conditional probability.)
   - Show your working both as a count-based fraction and using `pandas` boolean indexing.
7. **Written reflection (markdown).** In ≤ 200 words: which statistic in this notebook would you most trust if a stakeholder asked "how big is a typical DataTrove order?", and why?

## Deliverables

- `tasks/phase1_task4_statistics_foundations.ipynb` — completed notebook, all cells run, outputs visible.
- Every chart must have a title and labelled axes.
- A short markdown summary at the top of the notebook explaining what's inside.

## Learning outcomes

- Confident vocabulary for describing a numeric variable.
- Recognition of common distribution shapes from a histogram.
- Intuition for sampling, the CLT, and why "n = 30" is a folk rule.
- First exposure to conditional probability written in pandas.

## Resources

- *Think Stats* (Allen Downey), Chapters 1–3 — free online.
- pandas docs: `Series.describe`, `Series.skew`, `Series.kurt`.
- Khan Academy — Statistics & Probability, "Random variables" unit.
