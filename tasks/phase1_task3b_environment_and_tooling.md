# DataTrove Graduate Placement Programme
## Task 3B — Project Tooling: Environments, requirements.txt & .gitignore

**Issued by:** Promise Ekeh, Head of Analytics
**Phase:** 1 — Onboarding & Foundations

---

Nice progress 🎉 Before you start working with real libraries in Task 3C, let's set up the small-but-important habits that keep a data project clean, shareable, and reproducible. Doing this *first* means your libraries install into a clean, isolated environment — exactly how professional data teams work. It takes less than an hour to learn.

Write your answers in a new markdown file called `tasks/phase1_task3b_answers.md` (or in markdown cells in a notebook — your choice).

---

### 1 — Create your virtual environment

The `.venv` folder is **not** stored in the repo (it's in the `.gitignore` — see Part 3), so when you pull the project you won't have one. Your next job is to create your own.

- Create a virtual environment in the project (a folder called `.venv`).
- Activate it.
- **Written:**
  - In your own words, what is a virtual environment, and why do we use one instead of installing libraries globally? (2–3 sentences)
  - What commands did you run to *create* and *activate* it on your machine? (give the commands for your operating system)

## ANSWER:
A virtual environment is an isolated Python environment that allows a project to have its own libraries separate from the global system. This helps to prevent conflicts when different projects require different versions of the same package.

We use virtual environments instead of installing libraries globally to ensure consistency, avoid version conflicts, and make it easier for others to reproduce the project.

COMMANDS I USED TO CREATE AND ACTIVATE 
(Windows - Command Prompt):
python -m venv .venv
.venv\Scripts\activate.bat
---

### 2 — Create a `requirements.txt`

This project does **not** have a `requirements.txt` yet — that part is your job.

- Create a file named `requirements.txt` in the **root** of the repo.
- List every library this project depends on. *Hint: open the Task 3C notebook and look at the `import` lines in its setup cell.*
- Install everything from it into your virtual environment.
- **Written:** What is a `requirements.txt` for, and what single command would a teammate run to install everything listed in it?

## ANSWER
A requirements.txt file is used to list all the libraries a project needs so that someone else can install the same ones and run the project without issues.

To install everything in the file, a teammate would run:
pip install -r requirements.txt

---

### 3 — Understand the `.gitignore`

I have added a `.gitignore` file to the repo. Open it and read through it.

**Written:**
- Explain in your own words what a `.gitignore` file does and why it is useful.
- Why is it a bad idea to commit things like the `.venv/` folder or the dataset CSV to GitHub?
- Pick **two** entries from the file and, for each, say what it ignores and why we don't want it in version control.

## ANSWER
a. A .gitignore file tells Git which files and folders it should ignore and not upload to GitHub. This helps keep the project clean and avoids sharing files that are not needed.

b. It is not a good idea to upload the .venv folder because it contains files that are specific to your computer and can be recreated by others. Dataset CSV files should also not be uploaded because they can be very large, may contain private information, and are not always necessary for the project.

Two examples from the .gitignore file:

1. .venv/ — This ignores the virtual environment folder. We don’t include it because anyone can recreate it using the requirements.txt file.

2. **pycache**/ — This ignores Python cache files. These files are created automatically and are not important for the project since they don’t affect the actual code.

---

## Deliverable

Push your answers (and your new `requirements.txt`) to the `datatrove-placement` repo.

---
*DataTrove Graduate Academy — Phase 1, Task 3B*
*Issued by: Promise Ekeh, Head of Analytics*
*Simulated Training Material — For Educational Use Only*
