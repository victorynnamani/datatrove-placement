# Feedback — Phase 2, Task 2: Clean It, Log Every Decision

**Reviewer:** Promise Ekeh, Head of Analytics  
**Submitted by:** Victory Nnamani

---

## Overall

Good work, Victory. The notebook runs end-to-end successfully and shows a thoughtful, auditable cleaning workflow. You have handled the main data-quality issues carefully, explained the reasoning behind your decisions, and produced the required cleaned CSV.

**Grade indication:** Pass with merit, pending one minor correction to the invalid-date check.

---

## What you did well

- **Successful end-to-end execution.** All code cells run in order without errors, and the final cleaned file is produced.
- **Duplicate handling.** You identified and removed the two exact duplicate rows, keeping the first occurrence and recording the decision.
- **Per-column missing-value decisions.** You treated each missing field separately rather than applying one blanket rule. Filling missing `payment_method` values with `"Unknown"` is transparent and defensible.
- **Data-driven recovery of missing values.** You recovered missing `unit_price` and `quantity` values from the `total_amount` relationship instead of inventing median values. The reasoning is clearly documented.
- **Outlier investigation.** You did not automatically drop or cap `quantity = 500` and `unit_price = 9999.99`. You checked the reconciliation formula and used it to recover plausible values.
- **Categorical normalisation.** Region casing was standardised so that future joins to the reference table will work. The explicit payment-method mapping correctly preserves `PayPal` rather than changing it to `Paypal`.
- **Reconciliation.** You checked that `total_amount` agrees with `quantity × unit_price × (1 − discount_pct / 100)` after the corrections.
- **Cleaning log.** The `log_step` helper and the resulting log table capture the issue, action, affected rows, and justification for each decision.
- **Post-cleaning checks.** You checked duplicates, negative values, missing numeric fields, allowed regions, outlier bounds, and the raw-versus-clean row count.

---

## Thing to fix

### Invalid date is still present as `NaT` (must-fix)

The brief requires **zero invalid dates** after cleaning. Your notebook correctly identifies `2024-13-40` as impossible and converts it to `NaT`, but it then treats that unresolved `NaT` as an intentional passing state:

```python
checks["Zero invalid (NaT) dates remain unresolved as expected"] = True
```

This does not actually validate the requirement. Either:

- remove the row after logging the decision and explain the effect on the row count, or
- replace the date only if there is reliable evidence for the correct value.

Do not invent a date. The safest correction is likely to drop the affected row because a date-based analysis cannot use it, then make the check test the data directly:

```python
checks["Zero invalid dates"] = df["order_date"].isna().sum() == 0
```

Update the cleaning log, summary, row-count difference, and saved CSV to reflect the final decision. Re-run the notebook from a clean kernel after making the change.

---

## Smaller notes

- The notebook uses `dataset/northstar_goods_v2.csv`, which is consistent with the current Task 2 brief. Keep the filename consistent in later tasks.
- The dynamic `log_df` is useful because it reflects the actual run. The manually written markdown table duplicates that information, so keep both only if the markdown version is deliberately being used as a readable summary.
- The recovery of missing quantities involves rounding to whole units. That is reasonable, but the log should make clear that the recovered value is an inferred value rather than directly observed data.

---

## To complete the task

1. Decide how to handle the one invalid date without inventing a value.
2. Replace the hardcoded date check with a real validation expression.
3. Re-run the notebook from a clean kernel.
4. Confirm that the cleaning log, row-count difference, summary, and `northstar_clean.csv` all reflect the final decision.

The core cleaning work is strong. Once the invalid-date requirement is genuinely satisfied and validated, this will be ready for sign-off.
