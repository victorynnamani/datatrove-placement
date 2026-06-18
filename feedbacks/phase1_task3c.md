# Feedback — Phase 1, Task 3C: Data Science Libraries (NumPy, pandas, matplotlib & seaborn)

**Reviewer:** Promise Ekeh, Head of Analytics  
**Submitted by:** Victory Nnamani

---

## Overall

Really strong submission, Victory — this is the biggest task so far and you handled it well. Every cell runs end-to-end, all four library parts are complete, both challenge questions are attempted, and your charts are properly titled and labelled. Most importantly, your seaborn EDA interpretations read like an analyst talking to the business, not a student ticking a box. This is genuine progress.

**Grade indication:** Pass with merit. A couple of code-quality fixes (see "Things to fix"), none of which are conceptual gaps. You are ready for Phase 2.

---

## What you did well

- **NumPy fundamentals are solid.** Boolean indexing (`city_sales[city_sales > city_sales.mean()]`), vectorised arithmetic for gross/discount/net, and `np.argmax()` to find the top order — all used correctly and without falling back on loops.
- **2D array work (Q1.4) is clean.** `sum(axis=1)` for per-city totals and `sum(axis=0)` for per-quarter totals, plus the quarter-on-quarter growth using array slicing `(lagos[1:] - lagos[:-1]) / lagos[:-1] * 100` — that's exactly the right NumPy idiom.
- **GroupBy business analysis (Q2.5) is excellent.** `groupby("sales_channel")["total_amount"].agg(["count", "sum", "mean"])` is precisely how a working analyst builds a summary table. Using `.idxmax()` to name the top city/product is clean too.
- **pandas exploration (Q2.3) is thorough.** Good use of `.isnull().sum()`, `.nunique()`, `.value_counts().idxmax()`, and `(df["return_flag"] == "Y").sum()`. All pandas-native, no manual counting.
- **Charts are properly labelled.** Titles, axis labels, rotated ticks, and `tight_layout()` throughout. The 2×2 dashboard saved to PNG works and looks professional.
- **The seaborn EDA report (Q4.3) is the highlight.** Five varied chart types, each followed by a 2–3 sentence business interpretation. Your commentary on sales channels, regional revenue, and seasonality is genuinely useful — that's the skill that makes a data analyst valuable.

---

## Things to fix

### 1. Q3.3 — the dashboard figure is created twice (must-fix)
In the 2×2 dashboard cell you call `plt.subplots(2, 2, ...)` once with empty scaffolding comments, and then **immediately call it again** and do the real plotting:

```python
fig, axes = plt.subplots(2, 2, figsize=(14, 10))   # <-- first one, left empty
fig.suptitle("DataTrove 2024 — Sales Overview", ...)

# axes[0, 0] — Revenue by category:
# ... (just comments)

fig, axes = plt.subplots(2, 2, figsize=(14, 10))   # <-- second one, actually used
```

The first figure is created, left blank, and orphaned (it may even render as an empty extra plot). Delete the first block and the placeholder comment lines so the cell creates the figure **once**.

### 2. `total_amount` is recomputed inconsistently with the CSV
In Q2.3 you analyse the CSV's own `total_amount` column. But from Part 3 onwards you overwrite it:

```python
df["total_amount"] = df["quantity"] * df["unit_price"] * (1 - df["discount_pct"] / 100)
```

If the CSV's `total_amount` ever differs from your formula (rounding, returns, a data-quality quirk — which is the whole point of this messy dataset), your charts will silently disagree with your earlier pandas answers. Pick **one** source of truth: either trust the column the dataset gives you, or recompute it **once** in the setup cell and use that everywhere.

---

## Suggestions for next time (not blockers)

- **Q2.4 #7 — `df.groupby("category").count()`** counts *every* column, giving a wide, messy table. If you just want orders per category, `df.groupby("category").size()` (or `df["category"].value_counts()`) gives the single clean count you're after.

- **Load the data once.** Several cells re-`import pandas as pd` and re-run `pd.read_csv(DATA_PATH)`. The notebook runs top-to-bottom, so loading `df` once in the setup cell and relying on it afterwards keeps things DRY and avoids the inconsistency in point 2 above.

- **Saved filename vs the brief.** The task said save as `task3b_sales_overview.png`; you saved `task3c_sales_overview.png`. Your name is arguably more correct (this *is* Task 3C), but when you spot a mismatch with the brief, flag it in a comment rather than silently changing it — that way I know it was deliberate.

- **Keep comments professional.** A line like `# ✅ CORRECT PATH (go up one folder...)` is fine while you're working things out, but tidy these informal/emoji notes before submitting. Aim for comments a teammate would read in a code review.

- **Carry-over habit — format currency on display.** You do this well in most cells, but where you print raw figures (e.g. group sums), wrap them: `f"₦{value:,.2f}"`. Consistent money formatting makes a report instantly more credible.

---

— Promise
