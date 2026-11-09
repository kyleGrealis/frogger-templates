---
name: frogger-brand
description: Interactively audit, configure, and wire author metadata (_variables.yml), Quarto branding (_brand.yml), project titles (_quarto.yml), and logos (logos/), with optional persistence to global froggeR settings. Activate when setting up a new project's identity, author details, colors, fonts, or branding.
---

# `{froggeR}` Branding & Metadata Configuration Skill

Guide the user through configuring their project identity (`_variables.yml`, `_brand.yml`, `_quarto.yml`, `logos/`, and `README.md`), wiring metadata shortcodes into Quarto documents, and optionally persisting their configuration globally via `{froggeR}`.

---

## Step 1: Audit Current Project & Global Configuration

Before asking the user questions, inspect the current state of the project:
1. Read `_variables.yml`, `_brand.yml`, `_quarto.yml`, and `README.md` in the project root.
2. Check what logo files exist in `logos/`.
3. Check whether the user already has saved global `{froggeR}` settings by running:
   ```bash
   Rscript -e 'cfg <- rappdirs::user_config_dir("froggeR"); cat("Config dir:", cfg, "\nExists:", dir.exists(cfg), "\nFiles:", paste(list.files(cfg, recursive = TRUE), collapse = ", "), "\n")'
   ```

---

## Step 2: Interactive Discovery (Prompt for Missing Details)

Identify which fields are blank or still set to template placeholders (such as `title: "Project Title"` in `_quarto.yml`, empty keys in `_variables.yml`, or default `teek.png` / colors in `_brand.yml`).

Ask the user concise, grouped questions for only the missing or default items they want to customize:

1. **Project Identity (`_quarto.yml` & `README.md`)**:
   * Project title (replaces `"Project Title"` in `_quarto.yml` and `# Project` in `README.md`)
   * Brief project description and purpose (for `README.md`)
   * GitHub repository URL (for the navbar GitHub icon `href` in `_quarto.yml`, or remove the navbar icon if none)
2. **Author Metadata (`_variables.yml`)**:
   * `name`: Full name as it should appear on reports
   * `email`: Contact email address
   * `orcid`: ORCID iD (e.g., `0000-0002-9223-8854`, optional)
   * `url`: Personal website or profile URL (optional)
   * `github`: GitHub username (optional)
   * `affiliations`: Institution or department name (optional)
3. **Visual Branding (`_brand.yml` & `logos/`)**:
   * **Colors**: Primary brand color (hex code), optional secondary/accent colors, or keep the default palette (`green: "#005030"`, `orange: "#f47321"`, `gray: "#f9f9f9"`).
   * **Typography**: Base sans-serif font and monospace code font (from Google Fonts or Bunny Fonts), or keep `Google Sans` + `Fira Code`.
   * **Logo**: Path to a custom logo image to copy into `logos/`, or disable/remove the logo if not using one.

---

## Step 3: Apply & Wire Configuration

1. **Update `_variables.yml`**:
   Populate the user's metadata fields cleanly:
   ```yaml
   name: Jane Doe
   email: jane.doe@example.edu
   orcid: 0000-0001-2345-6789
   url: https://example.edu/~jdoe
   github: janedoe
   affiliations: Department of Biostatistics, Example University
   ```
2. **Wire Metadata into Quarto (`_quarto.yml` or `analysis/*.qmd`)**:
   Ask if the user wants author metadata displayed automatically across their Quarto pages. If yes, wire Quarto `{{< var >}}` shortcodes in `_quarto.yml` (project-wide) or inside `analysis/index.qmd` YAML frontmatter (only include fields that are non-empty in `_variables.yml`):
   ```yaml
   author:
     - name: "{{< var name >}}"
       email: "{{< var email >}}"
       orcid: "{{< var orcid >}}"
       url: "{{< var url >}}"
       affiliations:
         - name: "{{< var affiliations >}}"
   ```
   *(Important: Never wire a `{{< var field >}}` shortcode for a field that is left blank in `_variables.yml`, as Quarto will render empty author blocks or broken links).*
3. **Update `_brand.yml` & `logos/`**:
   * Ensure all hex colors in `color.palette` are quoted strings (e.g., `"#005030"`).
   * Verify `color.primary` references a valid key defined under `color.palette`.
   * If the user provided a custom logo, copy it to `logos/` and update `logo.large` (and/or `logo.small`). If they do not want a logo, comment out or remove the `logo:` block so Quarto does not fail on a missing image file.
4. **Update `_quarto.yml` & `README.md`**:
   * Set `project.title` and `website.title` in `_quarto.yml`.
   * Update `Code Author`, `Description`, and `Purpose` in `README.md`.

---

## Step 4: Global Persistence (`~/.config/froggeR/`)

After updating `_variables.yml` and/or `_brand.yml` and confirming `quarto render` succeeds:
1. Ask the user: *"Would you like to save your author metadata (`_variables.yml`) and branding (`_brand.yml` + `logos/`) as your global `{froggeR}` defaults so future `froggeR::init()` projects inherit them automatically?"*
2. If confirmed, persist them to `rappdirs::user_config_dir("froggeR")` in R (or via direct file copy in non-interactive shells since `froggeR::save_variables()` and `froggeR::save_brand()` prompt with `usethis::ui_yeah()` when overwriting existing global configs):
   ```r
   Rscript -e '
     cfg <- rappdirs::user_config_dir("froggeR")
     fs::dir_create(cfg)
     file.copy("_variables.yml", file.path(cfg, "_variables.yml"), overwrite = TRUE)
     file.copy("_brand.yml", file.path(cfg, "_brand.yml"), overwrite = TRUE)
     if (dir.exists("logos")) fs::dir_copy("logos", file.path(cfg, "logos"), overwrite = TRUE)
   '
   ```
