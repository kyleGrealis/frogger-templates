# R/_load.R

# Use this file as a project entry point to initialize library() calls
# and to load the data dictionary.

# ADD: other files to keep your scripts and Quarto files cleaner.

# Don't use relative paths!
source(here::here("R", "_libraries.R"))
source(here::here("R", "_data_dictionary.R"))


# Use JAMA table theme from sumExtras
use_jama_theme()
