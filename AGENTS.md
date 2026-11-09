# Project Guidelines for AI Coding Assistants (`AGENTS.md`)

This project follows the `{froggeR}` research compendium architecture for R and Quarto. Follow these directory routing, path resolution, and coding conventions on every task.

---

## 1. Directory & File Routing ("Every File in Its Place")

* **`R/_libraries.R` (Centralized Package Loading)**:
  * Place all `library()` calls inside `suppressPackageStartupMessages({...})` in `R/_libraries.R`.
  * Never scatter `library()` or `require()` calls inside `.qmd` files or individual analysis scripts.
* **`R/_data_dictionary.R` (Variable Labels)**:
  * Define human-readable variable labels in the `dictionary` `dplyr::tribble(~Variable, ~Description)` object.
  * Because `R/_load.R` enables `options(sumExtras.auto_labels = TRUE)` and `options(sumExtras.prefer_dictionary = TRUE)`, `gtsummary` tables automatically pull labels from `dictionary`. Update `R/_data_dictionary.R` whenever new analysis variables are introduced.
* **`R/_load.R` (Single Entry Point)**:
  * Every Quarto document in `analysis/` begins by sourcing `source(here::here("R", "_load.R"))`.
  * Keep data wrangling, helper functions, and modeling scripts modular in `R/` (e.g., `R/clean_data.R`, `R/models.R`) and source them inside `R/_load.R` in dependency order.
* **`analysis/` (Quarto Narrative Documents)**:
  * All `.qmd` files live in `analysis/` (`analysis/index.qmd` is the website home page).
  * Keep `.qmd` code chunks focused on displaying tables, plots, and inline results rather than heavy data cleaning.
  * When adding a new `.qmd` file in `analysis/`, register it under `website.sidebar.contents` in `_quarto.yml`.
* **`www/` (Web Assets & Styling)**:
  * Place custom SCSS files (`www/custom.scss`), JavaScript (`www/tables.js`), and static web assets in `www/`.
* **`logos/` & Branding**:
  * Place project and institutional logos in `logos/` and reference them in `_brand.yml`.
* **`data/` (Local Data Directory)**:
  * Store raw and processed datasets in `data/` (gitignored by default). Never commit sensitive or raw participant data to version control.

---

## 2. R & Quarto Coding Standards

* **Path Discipline (`here::here()`)**:
  * Always construct file paths using `here::here()` (e.g., `readr::read_csv(here::here("data", "dataset.csv"))`, `source(here::here("R", "_load.R"))`).
  * Never use `setwd()` or fragile relative paths (`"../data/..."`) inside R scripts or code chunks.
  * Note: `_quarto.yml` sets `execute-dir: project`, and HTML header/footer asset links in `_quarto.yml` (such as `../www/tables.js`) resolve relative to `analysis/*.qmd`.
* **Modern R Idioms**:
  * Use the native R pipe `|>` (never `%>%`).
  * Use `snake_case` naming and double quotes (`"`).
  * Keep R code and comments wrapped at or below 80 characters per line.
  * Prefer modern `dplyr` 1.1+ idioms (inline `.by =` in `summarise()`, `mutate()`, and `filter()`, plus `join_by()`).
* **Quarto (`.qmd`) Chunk Formatting**:
  * Always use YAML hashpipe chunk options inside the chunk body (`#| label:`, `#| echo: false`, `#| warning: false`), never inside the `{r ...}` header.

---

## 3. Built-In Project Skills (`.agents/skills/`)

Activate the specialized skills in `.agents/skills/` when performing these workflows:

1. **`frogger-workflow`** (`.agents/skills/frogger-workflow/SKILL.md`):
   Use when creating new Quarto pages in `analysis/`, adding new R scripts or packages to `R/`, updating `R/_data_dictionary.R`, or adding custom SCSS rules in `www/`.
2. **`frogger-brand`** (`.agents/skills/frogger-brand/SKILL.md`):
   Use when setting up or updating author metadata (`_variables.yml`), visual branding (`_brand.yml`), logos (`logos/`), or saving settings globally via `froggeR::save_variables()` and `froggeR::save_brand()`.
3. **`frogger-devlog`** (`.agents/skills/frogger-devlog/SKILL.md`):
   Use when auditing code comments, logging analytical or technical decisions in `DECISIONS.md`, or updating `CHANGELOG.md`.
