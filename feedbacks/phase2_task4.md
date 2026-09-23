# Feedback — Phase 2, Task 4: SQL Fundamentals

**Reviewer:** Promise Ekeh, Head of Analytics  
**Submitted by:** Victory Nnamani

---

## Overall

Strong work, Victory. Your schema is sensible, the required SQL topics are all covered, and the result reads under each query make the script easy to review. The row-count validation on the inner join is especially good: you did not just assume that the casing fix worked, you proved that the join preserved all 999 orders.

**Grade indication:** Pass with distinction. You went beyond the brief by submitting both a SQL script and a Python notebook, which is useful practice because analysts often move between a database client and Python. Both submissions are accepted; the improvement below is about making the SQL workflow easier for another person to reproduce.

## What you did well

- **Schema design is appropriate.** You used `TEXT` for identifiers and categories, `DATE` for dates, `INTEGER` for counts, and `REAL` for monetary values, with clear explanations in the notebook.
- **Complete coverage.** Filtering, ordering, aggregation, `GROUP BY`/`HAVING`, joins, and subqueries are all present and produce sensible results.
- **Join validation is excellent.** You compare the original order count with the inner-join count and confirm that all 999 rows are retained. This directly proves the Task 2 casing fix worked.
- **The destructive join test is safely contained.** Wrapping the temporary region deletion in `BEGIN` and `ROLLBACK` keeps the database usable for Task 5.
- **Your plain-English reads are useful.** Comments such as the highest single order and the range covered by the top 20 turn query output into analysis rather than leaving the reviewer to interpret raw rows.
- **The Python version is reproducible.** It reads both CSVs and inserts the rows after creating the tables, avoiding a manual import step.
- **You explored both workflows.** The brief asked you to choose one environment, but submitting both gives you useful practice in translating the same analysis between SQL and Python. Keep that initiative.

## Things to fix

### 1. Document the SQL load step

The opening comments in `04_sql_fundamentals.sql` say that the CSVs were loaded through DBeaver's Import Data wizard. That is a valid way to build your local database, but it is not part of the SQL script, so a reviewer cannot run that file alone from start to finish. Your Python notebook does solve this: it reads both CSVs and inserts the rows programmatically.

Add a short note to the SQL file describing the DBeaver import step and stating that the script contains the hand-written schema and analysis queries. This lets a reviewer reproduce both accepted approaches without guessing how the tables were populated.

If you want the SQL file to stand alone as well, add the SQLite `.import` commands and state that SQLite is the target environment.


## Smaller notes

- Standardise the spacing and indentation in the DDL. The SQL is readable already, but consistent alignment will make the schema easier to scan.
- Consider adding a stable tie rule to the “single best region” query, or use a tie-preserving approach if two regions ever share the same revenue.
- Re-run the notebook and SQL workflow from a clean database before sign-off so the saved outputs and the declared row counts remain aligned with the current CSVs.

---

— Promise  
Head of Analytics, DataTrove
