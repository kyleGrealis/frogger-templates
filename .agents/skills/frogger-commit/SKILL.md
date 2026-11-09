---
name: frogger-commit
description: Draft clean, structured git commit messages with a concise conventional header and 2-space indented bullets explaining what changed and why. Activate whenever committing changes or drafting a commit message in this project.
---

# `{froggeR}` Git Commit Message Skill (`frogger-commit`)

Draft clear, structured git commit messages that explain both *what* changed and *why*.

---

## 1. Reconnaissance Before Drafting

1. Run `git status -s` and `git diff --stat` (plus `git diff` on modified files as needed) to inspect all staged and unstaged changes.
2. Run `git log --oneline -n 5` to review recent commit context.
3. Always include the formatted commit message draft directly in your response when offering to commit.

---

## 2. Commit Message Format

```text
type(scope): concise summary of what it solved
  - indented bullet explaining how or what changed
  - indented bullet explaining why the change was needed
  - reference to issue or source URL if applicable
```

### Allowed Types
* `feat`: New analysis page, data pipeline, model, or table
* `fix`: Bug fix, data filtering correction, or broken path/render fix
* `docs`: Documentation, `README.md`, `DECISIONS.md`, `CHANGELOG.md`, or comments
* `refactor`: Restructuring R scripts or Quarto chunks without changing outputs
* `test`: Adding or updating verification checks
* `chore`: Configuration updates (`_quarto.yml`, `_brand.yml`, `_variables.yml`, `.gitignore`)

---

## 3. Formatting Rules

1. **Header Line (`<= 72` characters)**:
   * Keep the first line strictly at or under **72 characters**.
   * Use lowercase `type(scope): summary` without a trailing period.
2. **Indented Bullet Body**:
   * Use **2-space indented bullets** (`  - `) directly below the header line (2 to 5 bullets).
   * Never write free-form multi-paragraph commit bodies.
   * Focus on **why** the change was made, not just listing filenames.
3. **Zero AI Attribution**:
   * Never add AI/LLM attribution, agent signatures, or `Co-Authored-By:` trailers.

---

## 4. Example

```text
feat(demographics): add baseline participant summary table by trial
  - Join everybody and demographics tables in R/clean_data.R
  - Add 9 human-readable variable labels to R/_data_dictionary.R
  - Render JAMA-styled gtsummary table with sumExtras in analysis/index.qmd
```
