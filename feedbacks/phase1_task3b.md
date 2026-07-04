# Feedback — Phase 1, Task 3B: Project Tooling (Environments, requirements.txt & .gitignore)

**Reviewer:** Promise Ekeh, Head of Analytics  
**Submitted by:** Victory Nnamani

---

## Overall

Good, clear work, Victory. Your written answers show you actually understand *why* we use these tools, not just the commands to type. The virtual environment explanation, the `requirements.txt` purpose, and the `.gitignore` reasoning are all correct and in your own words. The concepts have landed — which matters, because everything in Phase 2 depends on a clean, reproducible environment.

**Grade indication:** Pass. Two important habits to fix before we move on (see below) — both are about *discipline*, not understanding.

---

## What you did well

- **Virtual environment explanation is spot on.** "An isolated Python environment that allows a project to have its own libraries separate from the global system" — that's exactly right, and you correctly linked it to avoiding version conflicts and reproducibility.
- **Correct create/activate commands for your OS.** `python -m venv .venv` and `.venv\Scripts\activate.bat` are right for Windows. Good that you specified the OS rather than copying a generic answer.
- **`requirements.txt` answer is accurate.** You correctly identified its purpose and gave the right teammate command: `pip install -r requirements.txt`.
- **`.gitignore` reasoning is strong.** You explained *why* `.venv/` (recreatable from `requirements.txt`) and dataset CSVs (large, possibly private) shouldn't be committed, and your two chosen entries (`.venv/`, `__pycache__/`) were explained correctly.

---

## Things to fix

### 1. The Python installer (`python-3.11.9-amd64.exe`) was committed to the repo (must-fix)
This is the most important note on this task — and it's the perfect real-world example of *exactly* what Task 3B is about.

The 100MB+ `python-3.11.9-amd64.exe` installer is sitting in your repo and is **tracked by Git**. A few things to understand here:

- **It is already listed in your `.gitignore`** — but it is *still* tracked. That's the key lesson: **`.gitignore` only stops Git from tracking files it isn't *already* tracking.** Because the installer was committed *before* you added it to `.gitignore`, Git keeps tracking it. Ignoring is not retroactive.
- **Installers, binaries, and large files should never be in a repo.** They bloat the history forever (even if you delete the file later, it stays in the Git history), they're slow to clone, and they're not source code.

**Your job:** untrack it (without deleting it from your computer), commit, and push:

```bash
git rm --cached python-3.11.9-amd64.exe
git commit -m "Stop tracking Python installer (already in .gitignore)"
git push
```

`git rm --cached` removes it from Git's tracking but **keeps the file on your disk**. After this, the `.gitignore` entry will finally do its job. Do this yourself — it's a habit you'll use constantly.


 ### 2. Pin your versions in `requirements.txt`.
 Right now it lists:

  ```text
  numpy
  pandas
  matplotlib
  seaborn
  ```

  That installs *whatever* the latest version is on each machine — which defeats the reproducibility you correctly described in your answer. Pin them so everyone gets the same versions:

  ```text
  numpy==1.26.4
  pandas==2.2.2
  matplotlib==3.8.4
  seaborn==0.13.2
  ```

  (`pip freeze > requirements.txt` generates these for you from your venv.)

### 3. Add the notebook kernel dependencies.
To actually *run* the Task 3C notebook from a clean clone, a teammate also needs `jupyter` and `ipykernel`. They're missing from `requirements.txt`, so as written, the notebook won't run for someone setting up fresh.

### 4. Note the dataset in the README. Since `dataset/datatrove_sales_2024.csv` is correctly git-ignored, anyone cloning the repo won't have it. A one-line note in the README ("place the dataset in `dataset/` before running") saves confusion later.

### 5. Ignore the whole `dataset/` folder, not one file by name (follow-up)
Coming back to this after Task 4: ignoring the **whole** `dataset/` folder with a single entry — rather than naming one file — is exactly the point I was trying to get across in Task 3B (*Part 3 — Understand the `.gitignore`*), but it didn't quite land the first time. Naming the exact file means every new dataset has to be added to `.gitignore` by hand — easy to forget, and not good practice.

So I've gone in and shown you what I meant: I added a `dataset/` entry (which ignores the entire folder) and tagged your old file-specific line with `#remove`. Compare the two and you'll see the difference:

```diff
- ../dataset/datatrove_sales_2024.csv   #remove   ← my old file-by-name entry: delete this whole line
+ dataset/                                        ← ignores the whole folder in one go
```

(That old `../` pattern never worked anyway — `.gitignore` patterns are relative to the file's own folder and can't point to a parent directory.)

**Your only job now:** delete the line I tagged `#remove`. 

---


---

## Suggestions for next time (not blockers)

### Answers were written into the task sheet, not a separate answers file
The brief asked you to write your answers in a **new** file: `tasks/phase1_task3b_answers.md`. Instead, you wrote them directly inside the task instructions file (`phase1_task3b_environment_and_tooling.md`).

It still reads fine, but keep *task prompts* and *your work* in separate files. Mixing them means the original brief is now altered, and if I reissue the task or you revisit it, your answers and the question are tangled together. Small thing, but following the deliverable spec exactly is part of the job.



— Promise
