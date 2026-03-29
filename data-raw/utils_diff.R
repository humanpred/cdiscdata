# Validity-date differential update logic for CT tables.
# Sourced by fetch_ct_sdtm.R, fetch_ct_adam.R, and fetch_all.R

# Apply a new CT release to the validity-date table.
# existing_tbl : current ct_sdtm or ct_adam data frame
# new_release_tbl : data frame parsed from the new NCI release
# release_date : Date object for the new release
apply_ct_update <- function(existing_tbl, new_release_tbl, release_date) {
  stopifnot(inherits(release_date, "Date"))

  key_cols   <- c("codelist_code", "term_code")
  value_cols <- c("codelist_name", "codelist_label", "extensible",
                  "term", "decoded_value", "synonyms", "definition")
  all_data_cols <- c(key_cols, value_cols)

  # Current (still-active) rows
  current <- existing_tbl[is.na(existing_tbl$valid_to), ]

  new_clean     <- new_release_tbl[, all_data_cols]
  current_clean <- current[, all_data_cols]

  # Helper: paste key columns into a single string for set operations.
  # Separator "||" is safe: CDISC codes are alphanumeric and never contain it.
  key_str <- function(df) {
    paste(df$codelist_code,
          ifelse(is.na(df$term_code), "<NA>", df$term_code),
          sep = "||")
  }

  new_keys     <- key_str(new_clean)
  current_keys <- key_str(current_clean)

  # 1. Genuinely new terms (key not in current)
  new_terms_idx <- which(!new_keys %in% current_keys)

  # 2. Retired terms (key in current but not in new release)
  retired_idx <- which(!current_keys %in% new_keys)

  # 3. Changed terms (key in both but at least one value column differs)
  matched_new_idx     <- which(new_keys %in% current_keys)
  matched_current_idx <- match(new_keys[matched_new_idx], current_keys)

  changed_new_idx <- matched_new_idx[vapply(
    seq_along(matched_new_idx),
    function(i) {
      ni <- matched_new_idx[i]
      ci <- matched_current_idx[i]
      any(vapply(value_cols, function(col) {
        nv <- new_clean[[col]][ni]
        cv <- current_clean[[col]][ci]
        # NA-safe comparison
        if (is.na(nv) && is.na(cv)) return(FALSE)
        if (is.na(nv) || is.na(cv)) return(TRUE)
        nv != cv
      }, logical(1L)))
    },
    logical(1L)
  )]

  changed_current_idx <- match(
    key_str(new_clean[changed_new_idx, ]),
    current_keys
  )

  # Close out retired and changed rows: set valid_to = release_date - 1
  keys_to_close <- unique(c(
    current_keys[retired_idx],
    current_keys[changed_current_idx]
  ))

  if (length(keys_to_close) > 0L) {
    close_mask <- key_str(existing_tbl) %in% keys_to_close &
      is.na(existing_tbl$valid_to)
    existing_tbl$valid_to[close_mask] <- release_date - 1L
  }

  # Build new rows for new and changed terms (may be empty if release is identical)
  new_idx  <- c(new_terms_idx, changed_new_idx)
  new_rows <- new_release_tbl[new_idx, ]
  if (nrow(new_rows) > 0L) {
    new_rows$valid_from <- release_date
    new_rows$valid_to   <- as.Date(NA_character_)
  }

  result <- rbind(existing_tbl, new_rows)
  result <- result[order(result$codelist_code,
                         ifelse(is.na(result$term_code), "", result$term_code),
                         result$valid_from), ]
  rownames(result) <- NULL
  result
}

# Check whether a release date is already fully represented in the table
already_have_version <- function(tbl, release_date) {
  as.character(release_date) %in% as.character(unique(tbl$valid_from))
}

# Assert that valid_from contains no NA values — call after every update.
assert_no_na_valid_from <- function(tbl, tbl_name = deparse(substitute(tbl))) {
  if (anyNA(tbl$valid_from)) {
    stop(paste0(
      "valid_from must never be NA after update, but NAs found in ", tbl_name, "."
    ))
  }
  invisible(tbl)
}
