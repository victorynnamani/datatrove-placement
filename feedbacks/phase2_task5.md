# Feedback — Phase 2, Task 5: SQL Advanced (CTEs & Window Functions)

**Reviewer:** Promise Ekeh, Head of Analytics  
**Submitted by:** Victory Nnamani

---

## Overall

This is strong advanced SQL, Victory. Your CTE and subquery solutions are thoughtful, the window frames are mostly handled carefully, and the multi-step customer analysis is easy to follow. The reflection also gives concrete reasons to choose SQL for repeatable customer reporting and pandas for exploratory investigation.

**Grade indication:** Pass with merit. Add the missing `LEAD()` example, make the date edge case explicit, and document your tie-handling choice in the top-three customer result. Those are focused fixes; the underlying SQL reasoning is good.

## What you did well

- **CTE versus subquery comparison is excellent.** You provide both approaches and explain why the named CTE steps are easier to read than repeating the region-total logic.
- **Window framing is deliberate.** The running total uses an explicit `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` frame, and the percentage-of-region-total calculation correctly keeps the full partition by omitting an ordering clause.
- **Ranking is correctly partitioned.** Order rankings reset by region, and customer spend rankings are based on the intended regional groups.
- **The customer quartile logic is sound.** `NTILE(4)` is applied to customer spend in a clear, reproducible way.
- **The multi-step CTE is well structured.** Customer statistics, ranking, and filtering are separated into logical stages, which is exactly when CTEs earn their keep.
- **Month-over-month calculation is correctly shaped.** You aggregate to region-month, use `LAG()` for the previous month, and leave the first month as `NULL` rather than inventing a growth rate.
- **The reflection is practical.** Your SQL-versus-pandas examples are grounded in NorthStar work rather than generic tool descriptions.

## Things to fix

### 1. Add the required `LEAD()` result (must-fix)

The section is labelled “Lag/lead”, but the submission only uses `LAG()`. Add one concrete `LEAD()` output, such as next month's revenue per region, and include a short read explaining what the forward-looking value is useful for.

For example, after your monthly revenue CTE, return `LEAD(revenue) OVER (PARTITION BY region ORDER BY order_month)` as `next_month_revenue`. Keep the existing `LAG()` and month-over-month calculation as well.

### 2. Handle the missing order date explicitly (must-fix)

The current cleaned dataset contains one row with a missing `order_date`. Grouping with `strftime('%Y-%m', order_date)` can place that row in a `NULL` month, which is not a valid calendar period for month-over-month analysis.

Filter `order_date IS NOT NULL` in the monthly revenue CTE, and state in the result read that one row was excluded. Re-run the query against a clean database so the output and explanation match.

### 3. Explain the tie choice in the top-three customer query (must-fix)

Your final customer query uses `RANK()` and filters to ranks 1 through 3. That is a valid tie-preserving choice, but it can return more than three rows for a region when customers tie at the boundary. Say this explicitly in the comment under the query.

If the requirement is exactly three rows per region, use `ROW_NUMBER()` with a stable secondary ordering instead. The important thing is to state whether you are preserving ties or forcing exactly three results.

## Smaller notes

- Add a deterministic secondary sort to the worst region-month query, for example `ORDER BY mom_growth_pct ASC, region, order_month`, so ties do not produce an arbitrary result.
- The running-total query returns a long result. Consider showing a representative limited view while keeping the full query available for verification.
- The Python notebook has saved outputs but no executed-cell state. Re-run it top-to-bottom in a clean kernel before submission so the stored results are demonstrably reproducible.

---

— Promise  
Head of Analytics, DataTrove
