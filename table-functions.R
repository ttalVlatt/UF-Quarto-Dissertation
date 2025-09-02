## -----------------------------------------------------------------------------
##
##' [PROJ: UF Quarto Dissertation]
##' [FILE: Table Functions]
##' [INIT: Feb 21st 2025]
##' [AUTH: Matt Capaldi] @ttalVlatt
##
## -----------------------------------------------------------------------------

## ---------------------------
##' [Libraries]
## ---------------------------

if(!require(pacman)) {install.packages("pacman"); library(pacman)}

p_load(tidyverse, gtsummary)

## ---------------------------
##' [Create Descriptive Stats Tables]
## ---------------------------

create_desc_table <- function(data, variables = everything(), treatment, labels = NULL) {
  
  if(missing(treatment)) {
    
    tbl_summary(data = data,
                include = all_of(variables),
                type = all_continuous() ~ "continuous2",
                statistic = c(all_continuous() ~ c("{mean}",
                                                   "{sd}",
                                                   "{min}",
                                                   "{max}")),
                label = labels,
                missing_text = "NAs (imputed)") |>
      modify_header(label ~ "Variable",
                    all_stat_cols() ~ "{level} \n*N = {n}*") |> # Remove bold formatting
      modify_footnote(c(all_stat_cols()) ~ NA) |>
      modify_column_indent(columns = "label",
                           rows = !row_type %in% 'label',
                           indent = 8)
  } else {
    
    tbl_summary(data = data,
                include = all_of(variables),
                by = all_of(treatment),
                type = all_continuous() ~ "continuous2",
                statistic = c(all_continuous() ~ c("{mean}",
                                                   "{sd}",
                                                   "{min}",
                                                   "{max}")),
                label = labels,
                missing_text = "NAs (imputed)") |>
      add_overall() |>
      modify_header(label ~ "Variable",
                    all_stat_cols() ~ "{level} \n*N = {n}*") |> # Remove bold formatting
      modify_footnote(c(all_stat_cols()) ~ NA) |>
      modify_column_indent(columns = "label",
                           rows = !row_type %in% 'label',
                           indent = 8)
    
  }
}

## ---------------------------
##' [Create Regression LM Tables]
## ---------------------------

create_lm_table <- function(model, 
                             variables = everything(), 
                             labels = NULL) {
  
  tbl_regression(model,
                 include = all_of(variables),
                 label = labels) |>
    add_significance_stars(hide_p = FALSE,
                           hide_ci = FALSE) |>
    add_glance_table(include = c(nobs, r.squared, adj.r.squared)) |>
    modify_header(label ~ "Variable",
                  estimate ~ "Beta",
                  std.error ~ "SE",
                  conf.low ~ "95% CI",
                  p.value ~ "p-value") |> # Remove bold formatting
    modify_footnote(std.error ~ NA,
                    conf.low ~ NA, 
                    conf.high ~ NA,
                    abbreviation = TRUE) |>
    modify_column_indent(columns = "label",
                         rows = !row_type %in% 'label',
                         indent = 8)
  
}

## ---------------------------
##' [Create Regression GLM Tables]
## ---------------------------

create_glm_table <- function(model, 
                             variables = everything(), 
                             labels = NULL,
                             exp = TRUE) {
  
  tbl_regression(model,
                 include = all_of(variables),
                 exponentiate = exp,
                 label = labels) |>
    add_significance_stars(hide_p = FALSE,
                           hide_ci = FALSE) |>
    add_glance_table(include = c(nobs)) |>
    modify_header(label ~ "Variable",
                  estimate ~ if(exp == TRUE) {"O.R."} else {"Beta"},
                  std.error ~ "SE",
                  conf.low ~ "95% CI",
                  p.value ~ "p-value") |> # Remove bold formatting
    modify_footnote(estimate ~ NA,
                    std.error ~ NA,
                    conf.low ~ NA, 
                    conf.high ~ NA,
                    abbreviation = TRUE) |>
    modify_column_indent(columns = "label",
                         rows = !row_type %in% 'label',
                         indent = 8)
  
}

## ---------------------------
##' [Format Descriptive Stats Tables]
## ---------------------------

format_desc_table <- function(tbl_desc,
                              repeating_header = "Table A-1. Continued. (UPDATE THIS)") {
  
  ## Need to add ifelse logic for 2 columns without by treatment.
  
  tbl_desc |>
    as_kable_extra(format = "latex",
                   booktabs = TRUE,
                   linesep = "",
                   align = c("l", "r", "r", "r"),
                   longtable = TRUE) |>
    kable_styling(full_width = FALSE,
                  latex_options = c("repeat_header"),
                  repeat_header_text = repeating_header) |>
    column_spec(1, width = "3.575in") |>  # Adjust width as needed
    column_spec(2, width = "0.75in") |>  # Adjust width as needed
    column_spec(3, width = "0.75in") |>  # Adjust width as needed
    column_spec(4, width = "0.75in") |>
    row_spec(0, align = "l")
  
}

## ---------------------------
##' [Format Regression Tables]
## ---------------------------

format_reg_table <- function(tbl_reg,
                             repeating_header = "Table A-1. Continued. (UPDATE THIS)") {
  
  tbl_reg |>
    as_kable_extra(format = "latex",
                   booktabs = TRUE,
                   escape = TRUE,
                   linesep = "",
                   align = c("l", "r", "r", "r", "r"),
                   longtable = TRUE) |>
    kable_styling(full_width = FALSE,
                  latex_options = c("repeat_header"),
                  repeat_header_text = repeating_header) |>
    column_spec(1, width = "3in") |>  # Adjust width as needed
    column_spec(2, width = "0.65in") |>
    column_spec(3, width = "0.6in") |>
    column_spec(4, width = "0.8in") |>
    column_spec(5, width = "0.6in") |>
    row_spec(0, align = "l") |>
    gsub("\\\\midrule\\\\\\\\", "\\\\midrule", x = _) |>
    gsub("Beta", "Beta$^1$", x = _) |>
    gsub("O\\.R\\.", "O\\.R\\.$^1$", x = _)
  
}

## -----------------------------------------------------------------------------
##' *END SCRIPT*
## -----------------------------------------------------------------------------
