---
name: frogger-workflow
description: Add new Quarto analysis documents, R scripts, package dependencies, data dictionary labels, and custom SCSS styling following froggeR project architecture. Activate whenever adding or organizing files, scripts, tables, or Quarto pages in this project.
---

# `{froggeR}` Project Workflow Skill

Maintain the `{froggeR}` research compendium layout (`R/`, `analysis/`, `www/`, `data/`, `logos/`) whenever extending the project.

---

## 1. Adding a New Quarto Page (`analysis/*.qmd`)

1. **Create the File in `analysis/`**:
   * Name the file using `snake_case` or `kebab-case` (letters, numbers, hyphens, and underscores only): `analysis/<page_name>.qmd`.
   * Or run in R: `froggeR::write_quarto(filename = "<page_name>")`.
2. **Required Starter Structure**:
   Every `.qmd` file in `analysis/` must source `R/_load.R` in its `setup` chunk and use YAML hashpipe chunk options (`#|`):
   ````markdown
   ---
   title: "<Page Title>"
   date: last-modified
   ---

   ```{r}
   #| label: setup
   #| echo: false
   source(here::here("R", "_load.R"))
   ```
   ````
3. **Wire Author Metadata (If Configured)**:
   If `_variables.yml` has populated values (`name`, `email`, `orcid`, `affiliations`), wire them via Quarto `{{< var ... >}}` shortcodes when the user wants author attribution on the page or in `_quarto.yml`.
4. **Register in `_quarto.yml` Navigation**:
   Add the new page under `website.sidebar.contents` in `_quarto.yml` so it appears in the docked sidebar:
   ```yaml
   website:
     sidebar:
       style: docked
       search: true
       contents:
         - text: Home
           href: analysis/index.qmd
         - text: <Page Title>
           href: analysis/<page_name>.qmd
   ```

---

## 2. Adding Packages & R Scripts (`R/`)

1. **Adding R Packages (`R/_libraries.R`)**:
   * Never place `library()` calls inside `.qmd` files or individual analysis scripts.
   * Add all required packages inside `suppressPackageStartupMessages({...})` in `R/_libraries.R`, sorted alphabetically.
2. **Adding Modular R Scripts (`R/<script>.R` -> `R/_load.R`)**:
   * Place data cleaning, feature engineering, helper functions, and model fitting in dedicated scripts inside `R/` (e.g., `R/clean_data.R`, `R/models.R`).
   * Use `here::here()` for all file paths (e.g., `here::here("data", "raw_data.csv")`).
   * Register new scripts in `R/_load.R` after `R/_libraries.R` and `R/_data_dictionary.R`:
     ```r
     source(here::here("R", "_libraries.R"))
     source(here::here("R", "_data_dictionary.R"))
     source(here::here("R", "clean_data.R"))
     ```

---

## 3. Labeling Variables for Tables (`R/_data_dictionary.R`)

`R/_load.R` enables `sumExtras` automatic dictionary labeling:
```r
use_jama_theme()
options(sumExtras.auto_labels = TRUE)
options(sumExtras.prefer_dictionary = TRUE)
```

Whenever new variables are created or summarized in `gtsummary::tbl_summary()` / `tbl_regression()`:
1. Add each variable and its human-readable label as a row in the `dictionary` tribble inside `R/_data_dictionary.R`:
   ```r
   dictionary <- dplyr::tribble(
     ~Variable, ~Description,
     "bill_length_mm", "Bill length (mm)",
     "body_mass_g", "Body mass (g)",
     "species", "Penguin species"
   )
   ```
2. Keep one entry per line (`<= 80` characters) using double quotes (`"`).

---

## 4. Custom Styling & Web Assets (`www/`)

1. **Modifying Existing Styles (`www/custom.scss`)**:
   * Place SCSS variables under `/*-- scss:defaults --*/`, mixins under `/*-- scss:mixins --*/`, and CSS/SCSS selectors under `/*-- scss:rules --*/`.
2. **Adding a New Stylesheet**:
   * Create `www/<name>.scss` (or call `froggeR::write_scss("<name>")`) with the three standard Quarto SCSS section headers (`defaults`, `mixins`, `rules`).
   * Register the new stylesheet in `_quarto.yml` under `format.html.theme`:
     ```yaml
     format:
       html:
         theme:
           - default
           - brand
           - www/custom.scss
           - www/<name>.scss
     ```

---

## 5. Verification

After adding or modifying `.qmd` pages, `R/` scripts, or `_quarto.yml`:
1. Verify all `source()` and data paths use `here::here()`.
2. Run `quarto render` from the project root to confirm all pages in `analysis/` render cleanly to `docs/` with zero errors.
