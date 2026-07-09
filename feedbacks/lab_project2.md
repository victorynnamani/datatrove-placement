# Feedback — Lab Project 2: Palmer Penguins Analysis (DTS 204)

**Reviewer:** Promise Ekeh, Head of Analytics  
**Submitted by:** Victory Nnamani

---

## Overall

Strong work, Victory. This is a confident, well-structured submission: the script runs task by task, the comments explain *why* you did each step rather than just *what*, and — crucially — you interpret your results instead of only printing them. Your Task 3 observation, that bill depth's negative correlation is a species-mixing (Simpson's-paradox) effect and not a within-bird trade-off, is genuinely sharp and the highlight of the whole piece.

Two things keep this from a clean distinction: a regression conclusion in Task 4 that needs reconciling, and the missing assumptions/diagnostics + PDF report that the brief explicitly asks for. Fix those and this is distinction-level.

**Grade indication:** Pass with merit. Address must-fix #1 (Task 4 significance), #2 (assumptions/diagnostics) and #3 (the PDF report) and it moves to distinction.

---

## What you did well

- **Task 1 is complete and well-reasoned.** `colSums(is.na())` for the missing-value audit, and you justify dropping incomplete cases with `na.omit()` rather than silently imputing. Summary stats cover mean/median/range/sd exactly as asked.
- **Right tests, and you say why.** Welch's `t.test()` (with an explicit note that it doesn't assume equal variances) and `prop.test(n_male, n_total, p = 0.5)` are both the correct tools, with correct H0/H1 and sound conclusions.
- **Task 3 interpretation is excellent.** Spotting that the bill-depth correlations are driven by species differences — not a real relationship within a single bird — is exactly the critical thinking I want to see.
- **Clean, idiomatic visualisation.** The density-scaled histogram correctly matched to the `dnorm` overlay is a nice touch, and your read of the bimodality (three species pooled into one column) is spot on.
- **Documentation.** Every block is annotated clearly without being noisy. Easy to follow end-to-end.

---

## Things to fix

### 1. Task 4 — reconcile the "not significant" claim (must-fix — the important one)

You conclude that the two bill variables are "not statistically significant." I think this conflates two different questions:

- **R² barely improving (0.762 → 0.764)** — true, and a perfectly fair reason to prefer the simpler model.
- **Statistical significance** — a separate question, and not answered by the R² change.

In the standard penguins data, once you hold flipper length constant, **bill_depth typically flips to a significant *positive* coefficient** — which is precisely the species-confounding you identified in Task 3. Please:

- Print and read the full **coefficient table** from `summary(multi_model)` — check the p-value and sign on `bill_depth_mm`.
- Quote the **`anova()` F-test p-value** directly; it answers whether the two extra predictors *jointly* improve the fit. If that p-value is below 0.05, the multiple model *is* a statistically significant improvement even though R² moves little — which reframes your conclusion as a **parsimony-vs-significance trade-off**, not "the extra variables do nothing."

If bill_depth does turn significant and positive, say so explicitly and link it back to Task 3 — your two tasks will then tell one coherent story.

### 2. Task 6 — add assumptions and diagnostics (must-fix)

The brief asks for a discussion of assumptions and limitations. You handled the t-test assumption well (Welch), but the regression has none. Add:

- `plot(simple_model)` (or at least residuals-vs-fitted and a QQ plot), and
- a short paragraph on linearity, normality of residuals, and homoscedasticity — plus the obvious limitation that pooling three species into one regression violates the "single population" idea (again, ties straight back to Task 3).

### 3. Produce the PDF report (must-fix — it's a graded deliverable)

Submission requires **both** the `.R` script **and** a well-documented PDF report (tables, charts, interpretations) — that's the "Report Quality" 10%. Your in-script summary is a good skeleton, but the formal report needs to exist, with explicit hypotheses, methods, results, and the assumptions/limitations section from #2.

---

## Smaller notes

- **`na.omit()` scope.** Dropping every row with any NA also removes the 11 sex-missing rows from the numeric-only tasks (correlation, regression), costing a little data. Defensible for consistency — just be aware that per-analysis complete cases would retain more.
- **Reproducibility.** Confirm the script runs top-to-bottom in a clean session with all four packages (`palmerpenguins`, `dplyr`, `ggplot2`, `corrplot`) installed, so a marker hits no surprises.

---

## To reach distinction

1. Re-run Task 4, report the coefficient table + `anova()` p-value, and reconcile bill_depth's significance with your Task 3 insight.
2. Add regression diagnostics and a short assumptions/limitations paragraph.
3. Deliver the PDF report.

Genuinely good analysis, Victory — the statistical instincts are there. Tighten these three and it's a distinction.
