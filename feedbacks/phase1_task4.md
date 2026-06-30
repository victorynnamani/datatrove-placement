# Feedback — Phase 1, Task 4: Statistics & Probability Foundations

**Reviewer:** Promise Ekeh, Head of Analytics  
**Submitted by:** Victory Nnamani

---

## Overall

Really pleasing work, Victory. This notebook is well-organised, runs cleanly end-to-end, and follows the brief section by section. You picked up the specific guidance from the task — computing the mode on a discrete column, sampling with `replace=True` and a `random_state`, and comparing the sample-means distribution against the raw data — and applied it correctly.

The one thing that separates this from a distinction-level submission is **interpretation**. Right now your explanations tell me what each statistic *means in general* ("a positive skew means a long right tail"). What I need from an analyst is what *this* data is telling us, and what we should *do* about it. That's the headline fix below — read it carefully, because it's the habit that turns a notebook into a business deliverable.

**Grade indication:** Pass with merit. Lift the interpretation to decision-level (must-fix #1), finish the probability working (must-fix #2), and this becomes a distinction.

---

> **Follow-up on Task 3B:** I've added a correction to your Task 3B feedback about the `.gitignore` — ignore the whole `dataset/` folder rather than naming one file. Please action it there. See `feedbacks/phase1_task3b.md`, *Things to fix → item 5 (Ignore the whole `dataset/` folder)*.

## What you did well

- **Mode handled correctly.** You computed the mode on `quantity` rather than the continuous `total_amount`, and explained *why* — exactly the right instinct for discrete vs continuous data.
- **Spread statistics are complete and correct.** Range, variance, std, and a properly derived IQR (`Q3 - Q1` from `.quantile()`), with a clear note that the IQR is robust to outliers.
- **Sampling / CLT (Section 4) is the strongest part.** 50 samples of size 30, `replace=True`, reproducible `random_state=i`, and a side-by-side histogram comparison. Your explanation — that averaging shrinks the spread and pulls the shape toward normal even though the raw data is skewed — is spot on.
- **Reflection (Section 7) is excellent.** You chose the median, justified it through the right-skew and outlier argument, and kept it tight. This is genuinely how you'd answer a stakeholder.
- **Comments throughout.** Every code cell is annotated clearly without being noisy. Easy to follow.

---

## Things to fix

### 1. Interpret the *data*, don't define the *statistic* (must-fix — the big one)
This is the most important note on the whole task. Almost every explanation cell tells me what a statistic means in a textbook sense, but not what our numbers are actually saying or what we'd *do* with them. A stakeholder doesn't want a definition of skewness — they want to know what's happening in the business and what decision it points to.

The pattern to adopt: **State the number → say what it tells us about DataTrove → suggest the action or implication.** A few examples from your own cells:

- **Skewness.** Instead of "a positive skew means a long right tail", write: *"Skew of +X.X confirms most orders are modest, but a small group of high-value orders pulls revenue up. We should plan staffing/forecasts around the typical (median) order and treat that top tail as a distinct high-value segment worth protecting."*
- **Mean vs median.** Don't just say the median is robust to outliers — say: *"Mean order is ₦A but median is ₦B; quoting the mean would overstate what a typical customer spends by ~Z%, so we report the median in customer-facing figures."*
- **Correlation (Section 5).** "Quantity and total_amount are correlated" isn't a finding. *"Correlation of 0.XX means basket size is a strong driver of order value — so to grow revenue we should push larger baskets (bundles, volume discounts) rather than relying on price alone."*
- **Distributions (Section 3).** *"`unit_price` clusters at the low end, so most revenue comes from volume of cheaper items — a pricing or upsell opportunity on premium lines."*
- **Probability (Section 6).** *"P(Lagos) = X means ~N% of all orders come from one city — that's both our strongest market and a concentration risk if Lagos demand dips."*

You don't need an essay — one or two decision-oriented sentences per cell. But every statistic should answer "so what?".

### 2. Section 6 — Probability: only one method shown (must-fix)
The brief asked you to show your working **two ways**: as a *count-based fraction* **and** using *pandas boolean indexing*. You did the boolean-indexing version (`len(df[df["city"] == "Lagos"])`), but:

- The **count-based fraction is never shown explicitly** — you print the final probability, but not the numerator and denominator that make it a fraction. Print the actual counts so the working is visible, e.g.:

  ```python
  print(f"Lagos orders: {lagos_orders} out of {total_orders}")
  print(f"P(Lagos) = {lagos_orders}/{total_orders} = {prob_lagos:.3f}")
  ```

- For the **second method**, use a pandas aggregation rather than `len()` so the two approaches are genuinely different, e.g.:

  ```python
  # Method 2 — value_counts (normalised gives the probability directly)
  df["city"].value_counts(normalize=True)["Lagos"]
  ```

  And for the conditional probability, `df[df["city"] == "Lagos"]["category"].value_counts(normalize=True)["Electronics"]` is a clean one-liner that mirrors the maths.

Right now both of your answers use the same technique, so the "show it two ways" requirement isn't fully met.

---

## Suggestions for next time (not blockers)

- **Format currency for readability.** Printed figures like `mean_val` come out as long raw floats. Since these are Naira, wrap them: `print(f"Mean: ₦{mean_val:,.2f}")`. (Same habit flagged in earlier tasks — worth making automatic.)

- **Consistent figure sizing.** Most charts use `figsize=(6, 4)` but the first `total_amount` histogram uses a bare `plt.figure()`. Small thing, but consistent sizing makes a notebook look polished.

- **Correlation scatter.** With a clear positive correlation, consider adding `sns.regplot` (or a trend line) so the relationship is visible at a glance — and note any outliers the scatter reveals.

---

— Promise
