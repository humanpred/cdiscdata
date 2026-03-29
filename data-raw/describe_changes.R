# Generates human-readable text describing new CT versions added in a data
# refresh. Intended for use in GitHub Actions PR body generation.
#
# Usage (from fetch_all.R or CI):
#   source("data-raw/describe_changes.R")
#   describe_ct_changes(ct_sdtm, prev_versions = old_sdtm_versions, label = "SDTM CT")
#   describe_ct_changes(ct_adam, prev_versions = old_adam_versions, label = "ADaM CT")

# Describe rows added for CT versions not in prev_versions.
# tbl           : updated ct_sdtm or ct_adam data frame
# prev_versions : character vector of version date strings before the update
# label         : human-readable label for messages
describe_ct_changes <- function(tbl, prev_versions, label = "CT") {
  all_versions <- as.character(unique(tbl$valid_from))
  new_versions <- sort(setdiff(all_versions, prev_versions))

  if (length(new_versions) == 0L) {
    cat(sprintf("- %s: no new versions\n", label))
    return(invisible(NULL))
  }

  for (v in new_versions) {
    v_rows   <- tbl[as.character(tbl$valid_from) == v, ]
    n_lists  <- sum(is.na(v_rows$term_code))
    n_terms  <- sum(!is.na(v_rows$term_code))
    cat(sprintf(
      "- %s version %s: %d new/changed codelists, %d new/changed terms\n",
      label, v, n_lists, n_terms
    ))
  }

  invisible(new_versions)
}
