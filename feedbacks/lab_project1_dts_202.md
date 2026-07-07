# Feedback — Lab Project 1 (DTS 202): Student Performance Analysis

**Reviewer:** Promise Ekeh, Head of Analytics
**Submitted by:** Victory Nnamani
**Notebook:** `tasks/lab_project1_ANSWERS.ipynb`

---

## Overall

This is a sophisticated submission, you covered every stage the brief asked for (exploration → cleaning → feature engineering → transformation → modelling → comparison), the code is clean and well-commented, and the visuals are professional. Most impressively, you spotted and prevented **data leakage** on your own — that's a concept many people don't meet until well into a data science course, and you handled it correctly and explained why.

**Grade indication:** Strong pass — the engineering is distinction-level. What holds it back from a clean distinction is that the *write-up* doesn't yet meet the brief: the model comparison only covers accuracy (the brief also wants interpretability and computational complexity), the results aren't interpreted against a baseline, and the formal report sections are missing. There are also two reproducibility issues. All are quick to address — details below.

---

## What you did well

- **Leakage prevention (Section 4) — the standout.** Dropping `G1`, `G2`, and `grade_category` before modelling, with a clear written justification, is exactly right. Keeping G1/G2 would have let the models "cheat" to near-perfect accuracy without learning anything about the social/behavioural factors that actually matter. Excellent judgement.
- **Proper encoding strategy.** Label-encoding binary columns, one-hot encoding nominal columns with `drop_first=True` (avoiding the dummy-variable trap), and scaling only the numeric columns — a clean, correct transformation pipeline.
- **Reproducible, stratified split.** `train_test_split(..., random_state=42, stratify=y)` keeps the Pass/Fail ratio balanced across train and test, and the seed makes it repeatable. Good practice.
- **Thorough, honest cleaning.** You ran every required check (missing values, duplicates, IQR outliers) and *documented that the data was already clean* rather than pretending you fixed things. That transparency is the right instinct.
- **Complete evaluation metrics.** Accuracy, confusion matrix, classification report, a comparison table, a bar chart, and a Random Forest feature-importance plot. You've computed everything needed to *support* a strong comparison — you just need to write that comparison up (see fix #5).

---

## Things to fix

### 1. The notebook loads a file that isn't in the repo (must-fix — reproducibility)
Your first load cell reads:

```python
df = pd.read_excel("DTS_202_Dataset.xlsx")
```

But the file committed alongside the notebook is `DTS_202_Dataset.csv`, not an `.xlsx`. As submitted, **the notebook won't run for anyone who clones it** — it points at a file that doesn't exist here. Load the CSV that actually ships with the project:

```python
df = pd.read_csv("DTS_202_Dataset.csv")
```

Always make sure the notebook loads the exact file you deliver. A grader running it top-to-bottom will hit an error on cell 3.

### 2. Don't push the dataset to Git (must-fix — same lesson as Task 3B)
`DTS_202_Dataset.csv` has been **committed to the repo** under `tasks/`. This is the exact habit the Task 3B `.gitignore` work was about: **datasets don't belong in version control.** They bloat the repo, may carry licensing/privacy constraints, and aren't code.

Two things to do:
- Add the dataset to `.gitignore` (e.g. move it into the ignored `dataset/` folder, or add a `*.csv`/`tasks/DTS_202_Dataset.csv` rule).
- Because it's *already tracked*, ignoring it isn't enough on its own — untrack it (remember, `.gitignore` isn't retroactive):

  ```bash
  git rm --cached tasks/DTS_202_Dataset.csv
  git commit -m "Stop tracking dataset (data does not belong in Git)"
  ```

  This keeps the file on your machine but removes it from the repo going forward.

### 3. Interpret the results — the models barely beat "guess everyone passes" (must-fix — analysis)
This is the same theme as your Task 4 feedback: don't just report the numbers, tell me what they *mean for a decision*. Two things you state as positives are actually warnings when you look closer:

- **Compare against a baseline.** About two-thirds of students pass, so a model that blindly predicts "Pass" for everyone already scores ~67%. Your best model (Random Forest, 71.4%) beats that by only ~4 points. That's a modest, honest result — and you should *say so*, not present 71% as a clear win.
- **Look at the Fail class, not just overall accuracy.** You highlight 92.5% recall on the *Pass* class, but the real purpose of a model like this is to **catch the students at risk of failing** so they can be helped. High Pass-recall with low Fail-recall means the model is good at the thing that doesn't matter and weak at the thing that does. Read the Fail row of your classification report and discuss it — that's the finding a school (or DataTrove client) would actually care about.

One or two sentences addressing both points would turn a good engineering exercise into a genuinely useful analysis.

### 4. Be able to explain every metric and diagnostic you produced (must-fix — understanding)
Interpretation (fix #3) only works if you can explain what each output *means*. You generated several diagnostics but didn't use them — make sure you understand each one and connect it to a decision:

- **Precision, recall, F1 and the confusion matrix.** Be able to state these in plain English *and* say why they matter here:
  - **Precision (Fail)** — of the students the model flags as failing, how many actually fail (controls false alarms).
  - **Recall (Fail)** — of the students who actually fail, how many the model catches. **This is the most important metric for an early-warning use-case** — a missed at-risk student gets no support.
  - **F1** — the balance of precision and recall; the metric to lead with when classes are imbalanced.
  - **Confusion matrix** — the raw source of all of the above. Read each cell as a real consequence: a *false negative* is a struggling student the school never flags. Accuracy alone hides all of this, which is exactly why fix #3 matters.

- **Check the class balance of the target.** Add `df_clean["pass_fail"].value_counts(normalize=True)` and state whether this is a balanced or imbalanced problem. It's roughly 2:1 (Pass:Fail) — a mild imbalance — which (a) explains why accuracy is misleading, and (b) explains your *model's behaviour*: classifiers naturally favour the majority class, which is why your Pass-recall is high and Fail-recall is low. Naming the imbalance turns that result from a surprise into an expected, explainable outcome.

- **Correlation matrix — say what it told you.** You produced a correlation heatmap but never referenced it in the write-up. State the finding and the decision it drove: `G1`, `G2` and `G3` are very strongly correlated, which is *precisely why you dropped `G1`/`G2`* to prevent leakage. That's a textbook example of a diagnostic directly shaping methodology — make the link explicit instead of leaving the reader to infer it.

- **Feature importance — feed it back into the story.** You plotted the top-10 Random Forest importances but didn't interpret them. Use them: `failures`, `study_load` and `absences` come out strongest, which both **validates your feature-engineering choices** (the engineered `study_load` earns its place) and **gives the school an actionable list** of factors to monitor. A chart with no interpretation is decoration; a chart tied to a recommendation is analysis.

### 5. The model comparison is incomplete — discuss interpretability and computational complexity (must-fix)
The brief doesn't just ask *which model is most accurate* — it asks you to compare the three on **predictive performance, interpretability, and computational complexity**, then justify your choice against all three. Right now your write-up only covers accuracy/F1. You have the raw material already (the feature-importance plot is a great start), you just need to say it explicitly, e.g.:

- **Interpretability.** Logistic Regression gives you signed coefficients (you can say *how* each factor pushes a student toward pass/fail); a shallow Decision Tree can be read as plain if/then rules; Random Forest is the most accurate here but the least transparent (an ensemble of 200 trees — you can rank feature importance but not trace a single decision).
- **Computational complexity.** Logistic Regression and a single tree train almost instantly; the Random Forest trains 200 trees, so it's the most expensive to fit and to run at prediction time. On a dataset this small it doesn't matter, but you should note the trade-off.
- **Justify against all three.** Your conclusion should weigh: is the ~4-point accuracy gain of Random Forest worth losing the interpretability that a school would want when explaining *why* a student is flagged at-risk? There's a defensible case for either — what matters is that you argue it.

### 6. Add the structured report sections the brief asks for
The submission guidelines require a structured lab **report**: Title Page (course, assessment title, your name + registration number, date), Introduction (dataset overview + objectives), Methodology (cleaning, feature engineering, the three models), Results & Discussion, and Conclusion. Your notebook has the analysis and a short summary cell, but not these named sections. If your course marks the report structure explicitly, add markdown cells for each — you already have the content, it just needs to be organised under those headings.

### 7. Course code in the title is wrong
The notebook header says **"DTS 204 - Data Engineering"**, but the brief, dataset, and filename are all **DTS 202**. Small thing, but on a graded assessment the course code needs to be right.

---

## Suggestions for next time (not blockers)

- **`study_load` — document the rationale and soften the claim.** You defined `study_load = studytime - failures`. Subtracting two differently-scaled ordinals (studytime is 1–4, failures 0–4) is a bit arbitrary — a quick note on *why* subtraction (vs a ratio or weighting) would help. Also, your summary says the feature "captures signal beyond its two source columns," but since it's a direct linear combination of them, it can't contain information they don't already hold; its importance mostly reflects `failures`. Reword to something like "combines two of the strongest predictors into one convenient feature."

- **Order of operations: derive the target before capping.** You cap `G3` outliers in Section 2.4 and *then* derive `pass_fail` from the capped `G3` in Section 3.4. It happens not to matter here (no G3 values were capped across the 10-mark boundary), but as a habit, derive the label from the raw grade first so capping can never accidentally flip a Pass/Fail.

- **Consider a quick cross-validation.** A single 70/30 split gives one number; `cross_val_score` (even 5-fold) would tell you how stable that ~71% really is. The brief only required one split, so this is a "next level" note.

- **Hyperparameter tuning could squeeze out a little more.** Your models use fixed settings (`DecisionTree(max_depth=5)`, `RandomForest(n_estimators=200, max_depth=8)`) that were chosen by hand, not tuned. A `GridSearchCV` or `RandomizedSearchCV` over a small grid (tree depth, number of estimators, `min_samples_leaf`, and `C` for Logistic Regression) might lift the scores a bit and is exactly the kind of rigour graders like to see. Be realistic, though: without `G1`/`G2` the predictive signal is genuinely weak, so tuning will refine the result at the margins — it won't turn a ~71% model into a 90% one. Worth mentioning as a next step in your conclusion.

- **Use a path that doesn't depend on the working directory.** `pd.read_csv("DTS_202_Dataset.csv")` only works if the notebook is run from `tasks/`. Referencing the file relative to the notebook makes it more robust.

---

— Promise
