---
name: frogger-brand
description: Audit, configure, and wire author metadata (_variables.yml), Quarto branding (_brand.yml), project titles (_quarto.yml), and logos (logos/), with optional persistence to global froggeR settings. Activate when setting up or updating a project's identity, author details, colors, fonts, or branding.
---

# `{froggeR}` Branding & Metadata Configuration Skill

Configure the project's identity (`_variables.yml`, `_brand.yml`, `_quarto.yml`, `logos/`, and `README.md`), wire metadata shortcodes into Quarto documents, and optionally persist settings globally via `{froggeR}`.

---

## Step 1: Audit Current Project & Global Configuration

1. Read `_variables.yml`, `_brand.yml`, `_quarto.yml`, `analysis/index.qmd`, and `README.md` in the project root, and list `logos/`.
2. Check whether global `{froggeR}` settings exist:
   ```bash
   Rscript -e 'cfg <- rappdirs::user_config_dir("froggeR"); cat("Config dir:", cfg, "\nExists:", dir.exists(cfg), "\nFiles:", paste(list.files(cfg, recursive = TRUE), collapse = ", "), "\n")'
   ```

---

## Step 2: Zero-Friction Interaction (Act First, Ask Concisely in Plain Text)

* **Never use multiple-choice UI popups (`ask_question`)** in this skill. Always communicate directly in concise plain text.
* **If the user already specified what they want to change** (e.g., title, subtitle, colors, font, or logo), apply those changes immediately in Step 3 without asking preliminary questions.
* **Auto-wire populated `_variables.yml` immediately**:
  If `_variables.yml` already has populated values (for example, restored from global `{froggeR}` settings) and `_quarto.yml` does not yet have an `author:` block, wire the `author:` `{{< var >}}` shortcodes into `_quarto.yml` and populate `Code Author` in `README.md` right away.
* **If the user asks generally for help with branding**, output a brief 4-line summary of the current state (`Title`, `Author`, `Colors/Fonts`, `Logo`) and ask **one concise plain-text question**:
  *"What would you like to customize (e.g., project title/subtitle, color palette, fonts, or logo)?"*

---

## Step 3: Apply, Optimize & Render

1. **Update `_variables.yml` & Wire Shortcodes**:
   Populate any new author metadata fields in `_variables.yml` and wire non-empty fields into `_quarto.yml` so every document in `analysis/*.qmd` inherits them:
   ```yaml
   author:
     - name: "{{< var name >}}"
       email: "{{< var email >}}"
       orcid: "{{< var orcid >}}"
       url: "{{< var url >}}"
       affiliations:
         - name: "{{< var affiliations >}}"
   ```
   *(Only include `{{< var field >}}` keys that are non-empty in `_variables.yml`).*
2. **Update `_brand.yml` & Use Quarto `{{< brand >}}` Shortcodes for Logos**:
   * Ensure all hex colors in `color.palette` are quoted strings (e.g., `"#005030"`), `color.primary` references a valid key in `color.palette`, and fonts default to `source: bunny`.
   * **Register & Embed Logos the Quarto Way (`{{< brand logo ... >}}`)**:
     * Define logos in `_brand.yml` under `logo:` (`small`, `medium`, `large`, or named keys under `logo.images:`).
     * Whenever embedding a logo or brand asset inside a `.qmd` document (or YAML frontmatter), **always use Quarto's native `{{< brand logo small >}}` (or `medium`, `large`, or `{{< brand logo <name> >}}`) shortcode**—never hardcode raw relative Markdown image paths like `![](../logos/...)`.
     * Similarly, use `{{< brand color primary >}}` (or palette key names) and `{{< var <field> >}}` shortcodes when referencing brand colors or `_variables.yml` metadata in `.qmd` files.
   * **Keep Logo File Sizes Small (`<= 400px`)**: Because `_quarto.yml` sets `embed-resources: true` to produce self-contained `.html` files, large camera photos in `logos/` will bloat rendered HTML files. Whenever adding or downloading an image into `logos/`, check its dimensions/size and resize it if larger than `400px` wide (e.g., `sips -Z 400 logos/<file>` on macOS).
3. **Update `_quarto.yml`, `analysis/index.qmd`, & `README.md`**:
   * Set `project.title` in `_quarto.yml` and `title` (plus optional `subtitle`) in `analysis/index.qmd`.
   * Populate `Code Author`, `Description`, and `Purpose` in `README.md`.
4. **Render to Verify**:
   ```bash
   $(command -v quarto || ls /Applications/Positron.app/Contents/Resources/app/quarto/bin/quarto /Applications/RStudio.app/Contents/Resources/app/quarto/bin/quarto 2>/dev/null | head -n 1) render
   ```
   *(Do not `grep`, `sed`, or `read_file` on rendered `docs/analysis/*.html` files, as `embed-resources: true` URL/base64-encodes styles and images into multi-megabyte lines. Trust the `0` exit code of `quarto render`.)*

---

## Step 4: Global Persistence (`~/.config/froggeR/`)

After applying changes and confirming the Quarto render succeeds, ask in plain text:
*"Would you like to save this configuration to your global `{froggeR}` defaults for future projects, or keep it local to this project?"*

If the user confirms global persistence, copy the updated files to `rappdirs::user_config_dir("froggeR")`:
```bash
Rscript -e '
  cfg <- rappdirs::user_config_dir("froggeR")
  fs::dir_create(cfg)
  file.copy("_variables.yml", file.path(cfg, "_variables.yml"), overwrite = TRUE)
  file.copy("_brand.yml", file.path(cfg, "_brand.yml"), overwrite = TRUE)
  if (dir.exists("logos")) fs::dir_copy("logos", file.path(cfg, "logos"), overwrite = TRUE)
'
```
