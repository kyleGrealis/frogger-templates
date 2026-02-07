# R/_data_dictionary.R

# Purpose:
# Create a dictionary object of Variable and Description columns. 
# This file is used by sumExtras::add_auto_labels() to conveniently add
# variable labeling to gtsummary tables. Can be used with other packages
# as well.
# Use quoted variable names and descriptions, one entry per line.

dictionary <- dplyr::tribble(
  ~Variable, ~Description,
  # "var1", "Label of var1",
)