# Feedback — Phase 2, Task 1: First EDA on NorthStar Goods

**Reviewer:** Promise Ekeh, Head of Analytics  
**Submitted by:** Victory Nnamani

---

## Overall

This is genuinely strong work, Victory — distinction-level in structure, thoroughness, and interpretation. Every requirement in the brief is covered properly, the milestone (describe the data and its problems without changing a single value) is respected throughout, and the "interpret, don't define" habit from Task 4 has clearly carried over: your findings tie specific numbers to what they mean for the business.

There's one real problem, and it's a process one rather than a skill one: **the notebook was run against an older export that predated the `returned` column**, so a prominent finding is now wrong. Re-run against the current data, correct the affected cells, and this is a clean distinction.

**Grade indication:** Pass with merit — distinction-level analysis. Fix the stale-data issue (must-fix #1) and it's a distinction.

---

## What you did well

- **Complete and well-structured.** Shape/types, missingness, univariate (numeric *and* categorical), three bivariate relationships, and a data-quality catalogue — all present, all in a logical order with clear markdown signposting.
- **Sharp dtype critique.** You flagged `order_date` stored as a string and `quantity` as a float that should logically be an integer count — exactly the right instinct for a raw export.
- **Interpretation is decision-level.** "Median £401 well below mean £515 → long tail of higher-value orders", discounts as a five-value order-level rule, no region trading at a materially different scale. These are findings, not definitions.
- **The casing analysis is the standout.** Quantifying that 8 true regions inflate to 22 raw labels (`east`:5, `EAST`:4, `East`:113), folding `card`/`Card` into a true total of 537, and then noticing that the region boxplot is distorted by those split labels — that is professional-grade diagnosis.
- **Exemplary data-quality catalogue.** Duplicates with the specific order IDs, the `2024-13-40` impossible date, the IQR-based price outlier (£9,999.99), the `quantity = 500` outlier, and the casing issues — all catalogued without fixing, exactly as the brief asked.

---

## Things to fix

### 1. Re-run against the current export (must-fix — the important one)

Your outputs were generated against an export that **did not include `returned`**. The current `dataset/northstar_goods_v2.csv` has **11 columns including `returned`**.

- Shape becomes **(1002, 11)**, not (1002, 10) — update the shape/type section and the conclusion.
- `returned` will appear in your column list and in `select_dtypes("object")`, so your categorical section needs a line acknowledging it. Leave the *analysis* of it for Phase 4 per the brief — just note its presence.
- The catalogue item **"the `returned` column is not present in this export" is now incorrect** and must be removed or reframed.

To be clear: cross-checking the export against the data dictionary and flagging a mismatch was *exactly* the right instinct — that is real analyst behaviour, and I want to see more of it. But the data moved on and the notebook didn't. The lesson is the same one from your Task 4 resubmission: **re-run in a fresh kernel against the current file before you submit**, and ideally record which data snapshot you used so a reviewer can reproduce your numbers.

---

## Suggestions for next time (not blockers)

- **Remove the empty code cell** under *3.8 Return Status*. After re-running, replace the "Left for now" stub with a single line confirming `returned` is present and deferred to Phase 4 — a tidy notebook has no empty cells.
- **Give the outliers a second view.** The `quantity = 500` and `unit_price = £9,999.99` values compress the quantity histogram and stretch the quantity-vs-total scatter. You correctly *noted* this — go one step further and add a filtered or log-scaled view so the real distribution of the other ~1,000 orders is visible. Diagnosing *and* working around a distortion is what separates a good EDA from a great one.
- **Consider a shared plotting style.** You repeat `figsize`/title/label boilerplate on every chart. Not required, but a small helper (or a consistent `figsize`) keeps a long notebook uniform.

---

— Promise  
Head of Analytics, DataTrove
