---
name: frogger-devlog
description: Audit and synchronize R and Quarto code comments, project decision records (DECISIONS.md), and changelog entries (CHANGELOG.md) before committing or completing an analytical milestone.
---

# Project Developer Log & Documentation Gate (`frogger-devlog`)

Audit modified R scripts and Quarto documents, enforce high-signal code commenting, record analytical and technical decisions in `DECISIONS.md`, and maintain `CHANGELOG.md`.

When invoked without arguments, execute Steps 0 through 4 in order. If the user requests only a specific part (`comments`, `decisions`, or `changelog`), run Step 0 followed by that targeted step.

---

## Step 0: Reconnaissance

1. Inspect `git status -s` and `git diff` (or `git show HEAD` if the working tree is clean) to identify modified files in `R/`, `analysis/`, and `www/`.
2. Check if `DECISIONS.md` and `CHANGELOG.md` exist in the project root.

---

## Step 1: Code Commenting Audit (`comments`)

Audit modified `.R` and `.qmd` files against these standards:

1. **The "Why", Never the "What"**:
   * Never narrate self-evident syntax (e.g., `# filter where age >= 18` above `filter(age >= 18)`).
   * Explain non-obvious domain logic, cohort inclusion/exclusion criteria, statistical modeling assumptions, magic numbers, or data anomalies directly above the code block:
     ```r
     # Exclude pilot Phase 1 observations (status == 3) that lacked calibrated
     # baseline measurements to preserve cohort consistency.
     df_clean <- df_raw |>
       filter(age >= 18 & status != 3)
     ```
2. **Traceability on Cutoff / Parameter Changes**:
   * When changing a filtering threshold, model covariate, or filename, preserve the previous value and date in an adjacent comment explaining why it changed.
3. **Strict Formatting**:
   * Wrap all comment lines at or before **80 characters**.
   * Place comments on preceding lines above the code block rather than trailing inline comments.
   * For reusable helper functions in `R/`, include clear parameter and return value comments (or `roxygen2` headers).

---

## Step 2: Project Decision Record (`decisions`)

Maintain `DECISIONS.md` in the project root to log analytical, statistical, and architectural choices:

1. **When to Log**:
   * Cohort inclusion/exclusion rules, missing-data imputation strategies, or outlier handling.
   * Model family selection, covariate adjustments, or package/tool choices.
   * Skip routine bug fixes, typos, or minor styling tweaks.
2. **Scaffold `DECISIONS.md` (If Missing)**:
   If a decision warrants logging and `DECISIONS.md` does not exist, create it at the project root:
   ```markdown
   # Project Decision Log

   This document records analytical, statistical, and technical decisions made throughout the lifecycle of this project.

   Entries are ordered chronologically with newest entries at the top.

   ---

   ## YYYY-MM-DD: <Short Decision Title>

   - **Context / Problem**: What data anomaly, analytical question, or technical constraint required a decision?
   - **Decision Taken**: What specific method, filter, model, or tool was chosen?
   - **Rationale & Trade-offs**: Why was this chosen over alternatives? What are the known limitations?
   - **Related Files**: `R/clean_data.R`, `analysis/index.qmd`
   ```
3. **Prepend New Entries**:
   Add new entries at the top (directly below the `---` divider) in 5 to 15 concise lines.

---

## Step 3: Project Changelog (`changelog`)

Maintain `CHANGELOG.md` in the project root following [Keep a Changelog](https://keepachangelog.com/en/1.1.0/):

1. **Scaffold `CHANGELOG.md` (If Missing)**:
   If `CHANGELOG.md` does not exist, inspect `git log --oneline -n 30` to summarize initial milestones and create `CHANGELOG.md`:
   ```markdown
   # Changelog

   All notable changes to this project will be documented in this file.

   ## [Unreleased]

   ### Added
   - Initial `{froggeR}` project structure and baseline analysis setup.
   ```
2. **Update `## [Unreleased]`**:
   Group recent changes into concise, human-readable bullets under `### Added`, `### Changed`, `### Removed`, or `### Fixed`.

---

## Step 4: Summary

Report a brief summary of:
* **Code Comments**: Files audited and comments added/refined.
* **Decisions**: `DECISIONS.md` entry logged (or noted as not needed for routine edits).
* **Changelog**: `CHANGELOG.md` bullets updated under `[Unreleased]`.
