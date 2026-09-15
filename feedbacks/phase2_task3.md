# Feedback — Phase 2, Task 3: Answer the Business with Pandas

**Reviewer:** Promise Ekeh, Head of Analytics  
**Submitted by:** Victory Nnamani

---

## Overall

Excellent work, Victory. Every requirement in the brief is met, idiomatically, with a plain-English finding under each result. The groupby/merge/reshape/time-series toolkit is all there and used correctly, the interpretations connect across tasks into a cumulative story, and the merge section in particular shows exactly the "prove it, don't assume it" discipline this task was built to teach.

**Grade indication:** Pass with distinction. Soften and quantify the one over-confident claim in 1e (below) and it's unqualified.

---

## What you did well

- **The merge proof (2c) is exemplary.** You compared the distinct labels on both sides, checked row counts before/after, counted nulls after the left join, and used `assert`s that fail loudly — then explained that identical inner/left counts are *only* possible because Task 2 normalised region casing. That's the whole point of the task, done properly.
- **Named aggregation done right.** One `.agg()` call computing `unique_customers`, `total_orders`, `mean_basket_size`, and `return_rate` (the last via a clean `lambda s: (s == "Y").mean()`) — four stats in a single pass, no loops.
- **Findings connect across tasks.** You reference the Task 1 order counts and the ~23.8% overall return rate, so each result builds on what came before rather than standing alone. This is how an analyst tells a cumulative story.
- **Idiomatic, modern time series.** `resample("ME")`, a 7-day rolling mean overlaid on daily revenue, `pct_change`, and `idxmin` to name the worst month (March 2024, −38.6%) — each with a sensible read tying the volatility back to order-level noise.
- **Reshape.** Clean pivot/melt with an explicit shape comparison and a correct one-sentence rule for when to use wide vs long.
- **Charts are titled and labelled**, sorted sensibly (biggest bar on top), and every one has a finding underneath.

---

## Things to fix

### 1. Don't declare "signal, not noise" without quantifying it (the one real note)

In 1e you write that the regional return-rate spread (Scotland 32.6% vs West 15.2%) is "a genuine regional pattern, rather than sampling noise." You haven't actually shown that. With roughly 120–160 orders per region and a ~24% base rate, the standard error on each rate is about 4%, so Scotland and West sit only ~2 standard errors from the mean — suggestive, but not conclusive. Two fixes:

- **Show the order counts** behind each rate so the reader can weigh how much data each percentage rests on. A 32.6% rate on 130 orders is a very different claim from one on 13.
- **Soften the language** to "worth investigating" rather than "not sampling noise."

This is exactly what the Task 7 statistics reading is for: a difference worth flagging is not the same as a difference you've shown is real. Flag it, quantify the uncertainty, and recommend the test — don't skip to the conclusion.

---

## Smaller notes

- **Re-run from a clean kernel before sign-off.** None of the cells are executed in the current kernel (saved outputs only). The numbers are internally consistent (999 rows matches Task 2's output), so it clearly ran against the current data — but make the fresh top-to-bottom run a habit so a reviewer's kernel matches yours.
- **1d has no explicit "so what".** The region-by-month grid is correct, but the finding just says the variation "looks like noise." If that's the conclusion, say what it means for the business (e.g. "monthly regional targets should be set on a rolling average, not a single prior month").

---

— Promise  
Head of Analytics, DataTrove
