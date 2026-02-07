# Project

**Code Author**: 

**Description**: 

**Purpose**: 

## Project Structure

```
.
├── R/                    # R scripts only
│   ├── _load.R
│   ├── _libraries.R
│   └── _data_dictionary.R
├── pages/                # Quarto documents (.qmd)
│   ├── index.qmd
│   └── references.bib
├── www/                  # Static web assets (SCSS, JS)
│   ├── custom.scss
│   └── index.js
├── logos/                # Project logos and branding images
├── data/                 # Local data files (gitignored)
├── _brand.yml            # Quarto color palette and typography
├── _quarto.yml           # Site structure and format options
└── _variables.yml        # Author metadata
```

## R Files

- **`R/_load.R`** — Single entry point sourced by every `.qmd` file. Bootstraps the R environment by loading libraries and the data dictionary. Add new `source()` calls here to keep `*.qmd` files clean.
- **`R/_libraries.R`** — Defines the default package stack (`froggeR`, `gtsummary`, `sumExtras`, `tidyverse`). All `library()` calls go here, not in `.qmd` files.
- **`R/_data_dictionary.R`** — A `tribble` of variable names and labels used by `sumExtras::add_auto_labels()` for gtsummary tables. Add new variable labels as rows.
