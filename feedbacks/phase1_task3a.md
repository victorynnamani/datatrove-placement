# Feedback — Phase 1, Task 3A: Advanced Python Fundamentals

**Reviewer:** Promise Ekeh, Head of Analytics  
**Submitted by:** Victory Nnamani

---

## Overall

Excellent work, Victory. This is a real step up from Task 2. Every cell runs cleanly, all five challenge questions (1.4, 2.4, 3.3, 5.4, 6.4) are attempted and correct, and your written answers show genuine understanding rather than memorisation. More importantly, you are starting to write *idiomatic* Python — the kind of code an experienced analyst writes — not just code that works.

**Grade indication:** Pass with distinction. You are ready to move on to Task 3B (NumPy, pandas, matplotlib, seaborn).

**General Note:** Some of this looks AI-assisted, which is completely fine — it's a real tool you'll use on the job. What matters is that you can explain why each line works and could rewrite it yourself if asked. In our next 1:1 I may pick a couple of cells (e.g. the max(..., key=...) in Q2.3 or the map()/lambda in Q5.4) and ask you to walk me through them.

---

## What you did well

- **Idiomatic set operators (Q3.2).** You used the symbolic operators (`&`, `-`, `|`, `^`) instead of the longer method names (`.intersection()`, `.difference()`). Concise and readable — exactly right.
- **`max()` / `min()` with a `key` (Q2.3).** Using `max(city_sales, key=city_sales.get)` instead of a manual loop is a clean, advanced technique. It shows you're looking for the best tool, not just the first one that works.
- **Clever sort key (Q5.3).** `key=lambda o: (o["city"], -o["total"])` — using the negative sign to reverse-sort one field inside a multi-key tuple is a genuinely professional trick. Very nicely done.
- **Business-logic validation (Q6.4).** You went beyond catching type errors and added a real rule: `if discount < 0 or discount > 100: raise ValueError`. That's thinking like a data professional — validating the *meaning* of the data, not just its type.
- **Clean grouping pattern (Q1.4).** Building a `city → list of totals` dictionary and then deriving totals/averages from it is exactly the pattern you'll soon recognise as a `groupby` in pandas. Great foundation.
- **Comments throughout.** Your header comments explaining what each block does make the notebook easy to follow.

---

## Things to fix

### 1. Q6.2 & Q6.4 — Avoid bare `except:` (must-fix habit)
In a few places you wrote:

```python
try:
    price = float(value)
except:
    print("Warning...")
```

A bare `except:` catches *everything*, including things you never want to swallow — like `KeyboardInterrupt` (when someone presses `Ctrl+C`) or `MemoryError`. Always name the errors you actually expect:

```python
except (ValueError, TypeError):
    print("Warning...")
```

This is one of the most common notes in real code reviews, so it's a great habit to build now.

### 2. Q6.4 — Round currency values
The clean row produced `total_amount: 134.973`. Since this represents money, round it to 2 decimal places:

```python
cleaned["total_amount"] = round(total_after_discount, 2)
```

---

## Suggestions for next time (not blockers)

- **Floating-point totals (Q1.3 / Q5.4).** You'll have noticed outputs like `872.8100000000002` and `174.95000000000002`. That's normal floating-point behaviour, not a bug — but when *displaying* money, format it: `f"₦{total:.2f}"`. (You already do this well in most cells.)

- **`raw_orders` is overwritten in Q2.3 and Q3.3.** You pasted the data block a second time inside the answer cell, so the variable is defined twice. It still runs fine, but in a real notebook you'd rely on the single definition the task already gave you — duplicating it risks the two copies drifting out of sync.

- **`get_city_summary` return type (Q2.4).** The function returns a *list* on success but a *string* when nothing is found. That works for printing, but mixing return types makes a function harder to use later (you can't safely loop over the result without checking its type first). Returning an empty list `[]` and letting the caller decide what message to show is usually cleaner.



---



— Promise
