# Project

**Code Author**: 

**Description**: 

**Purpose**: 

## Project Structure

```text
.
├── .agents/              # AI agent skills for project scaffolding and maintenance
│   └── skills/
│       ├── frogger-brand/
│       ├── frogger-commit/
│       ├── frogger-devlog/
│       └── frogger-workflow/
├── R/                    # R scripts only
│   ├── _load.R
│   ├── _libraries.R
│   └── _data_dictionary.R
├── analysis/             # Quarto documents (.qmd)
│   ├── index.qmd
│   └── references.bib
├── www/                  # Static web assets (SCSS, JS)
│   ├── custom.scss
│   └── tables.js
├── logos/                # Project logos and branding images
├── data/                 # Local data files (gitignored)
├── AGENTS.md             # Project rules and conventions for AI coding assistants
├── CLAUDE.md             # Pointer to AGENTS.md and .agents/skills/
├── GEMINI.md             # Pointer to AGENTS.md and .agents/skills/
├── _brand.yml            # Quarto color palette and typography
├── _quarto.yml           # Site structure and format options
└── _variables.yml        # Author metadata
```

## R Files

- **`R/_load.R`**: Single entry point sourced by every `.qmd` file. Bootstraps the R environment by loading libraries and the data dictionary. Add new `source()` calls here to keep `*.qmd` files clean.
- **`R/_libraries.R`**: Defines the default package stack (`froggeR`, `gtsummary`, `rUM`, `sumExtras`, `tidyverse`). All `library()` calls go here, not in `.qmd` files.
- **`R/_data_dictionary.R`**: A `tribble` of variable names and labels used by `sumExtras::add_auto_labels()` for `gtsummary` tables. Add new variable labels as rows.

## AI Agent Support

This project includes built-in instructions (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`) and skills (`.agents/skills/`) so AI coding assistants automatically follow `{froggeR}` conventions:

- **`frogger-workflow`**: Scaffolds new Quarto documents in `analysis/`, routes packages to `R/_libraries.R`, maintains `R/_data_dictionary.R`, and manages styles in `www/`.
- **`frogger-brand`**: Configures `_variables.yml` and `_brand.yml`, wires metadata/logo shortcodes into documents, and saves global defaults via `froggeR::save_variables()` and `froggeR::save_brand()`.
- **`frogger-devlog`**: Audits code comments, records methodology and analytical choices in `DECISIONS.md`, and maintains `CHANGELOG.md`.
- **`frogger-commit`**: Drafts structured `type(scope): summary` git commit messages with 2-space indented bullets.

## References

This project structure is informed by research on reproducible data analysis workflows in R. Marwick et al. make the case that standardized directory layouts, explicit dependency management, and separation of code from narrative are not just nice-to-haves but prerequisites for reproducibility. This template puts that into practice.

Marwick, B., Boettiger, C., & Mullen, L. (2018). Packaging data analytical work reproducibly using R (and friends). *The American Statistician*, 72(1), 80-88. https://doi.org/10.1080/00031305.2017.1375986
