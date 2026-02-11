# R/_load.R

# Use this file as a project entry point to initialize library() calls
# and to load the data dictionary.

# ADD: other files to keep your scripts and Quarto files cleaner.

# Don't use relative paths!
source(here::here("R", "_libraries.R"))
source(here::here("R", "_data_dictionary.R"))


# sumExtras configuration
use_jama_theme()
options(sumExtras.auto_labels = TRUE)
options(sumExtras.prefer_dictionary = TRUE)
