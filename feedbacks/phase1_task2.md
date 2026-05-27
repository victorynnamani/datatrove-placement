# Feedback — Phase 1, Task 2: Python Foundations

**Reviewer:** Promise Ekeh, Head of Analytics  
**Submitted by:** Victory Nnamani

---

## Overall

Strong submission, Victory. Every cell runs end-to-end without errors, your written explanations are clear and in your own words, and your code is consistently readable. You are clearly thinking about *what the code does* rather than just copying patterns, that is exactly what we want to see at this stage.

**Grade indication:** Pass with merit. You are ready to move on to Task 3A.

---

## What you did well

- **Clean, idiomatic Python.** Good use of `f-strings`, `.strip()`, `.title()`, `round()`, and `format(..., ".2f")` for presenting values.
- **Written answers are concise and accurate.** Q1.5 (`print(name)` vs `name`), Q4.1 (`if/elif/else`), and Q5.1 (`for` vs `while`) all show real understanding, not just memorisation.
- **Sensible variable names.** `units_sold`, `unit_price`, `clean_regions`, `total_before_discount` — all self-documenting.
- **Data cleaning loop in Q5.4** is exactly the pattern you will reuse hundreds of times in pandas later. Good instinct to build the cleaned list rather than mutating the original.
- **Q6.3 `classify_price`** is well-structured — using `return` early in each branch is cleaner than setting a variable and returning at the end.

---

## Things to fix

### 1. Q6.5 — `validate_order` uses the wrong region list (must-fix)
Your `valid_regions` is:

```python
valid_regions = ["North", "South", "East", "West"]
```

But Task 4.4 already defined DataTrove's 10 active regions (Scotland, North East, North West, Yorkshire, Midlands, East Anglia, London, South East, South West, Wales). Your validator should use that same list, otherwise a legitimate order from `"Lagos"` (per the task example) is flagged as invalid for the wrong reason. Reuse the canonical list across the notebook.

### 2. Q5.5 — Loop condition is slightly off
You used `while balance >= 0:` which means the deduction happens after the balance is already at or above zero, and the final printed balance is negative (e.g. `-53`). The task says *"Stops when the balance drops below £0"*, which is what you achieved — but it's worth noticing that the printed log shows a negative balance as the last "valid" entry. A cleaner pattern is to check after deducting and `break` when the balance drops below zero, so the message and the final state line up.

---

## Suggestions for next time (not blockers)

- **Use `:.2f` inside f-strings** instead of `format(x, ".2f")` — it reads more naturally:

  ```python
  print(f"Total: £{total_amount:.2f}")
  ```

- **Add short docstrings to your functions.** Even one line, e.g.:

  ```python
  def calculate_total(unit_price, quantity, discount_pct):
      """Return the total cost after applying a percentage discount."""
  ```

  This is what your future self (and teammates) will thank you for.

- **Prefer constants for repeated lists.** The 10 DataTrove regions and the 8 approved categories appear in multiple cells — defining them once at the top of the notebook avoids the bug you hit in Q6.5.

- **Q3.3 (`j.morrison` → `J.Morrison`): Document your assumptions.** 

    Your code perfectly solves the task! However, notice that it assumes the username will always split into exactly two parts. In the real world, messy data like `mary-jane.o.connor` would cause this to drop part of the name. A great habit is to add a quick comment (e.g., `# Assumes only one '.' in the name`) so if the code ever breaks on weird data, people know exactly why.

- **Q7.3 (Replacing an item): Flag "destructive" actions.** 

    You correctly replaced index 1 with `"Laptop Stand"` exactly as the task asked. But in a real data pipeline, silently overwriting data can be risky because you lose the original record forever. A pro tip is to leave a comment like `# Warning: this overwrites the existing entry` whenever you permanently replace or delete data. It tells future readers that the data loss was intentional, not a bug.

---
