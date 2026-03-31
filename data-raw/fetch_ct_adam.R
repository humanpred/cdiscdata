# Run this script to update ADaM CT data.
# Either source it directly or call it from fetch_all.R.
# Requires: utils_nci.R and utils_diff.R sourced first.

# ── Load existing data ─────────────────────────────────────────────────────────
existing_path <- "data/ct_adam.rda"
if (file.exists(existing_path)) {
  load(existing_path)  # loads ct_adam
} else {
  message("No existing ct_adam found. Bootstrapping from NCI archive...")
  ct_adam <- data.frame(
    codelist_code  = character(),
    codelist_name  = character(),
    codelist_label = character(),
    extensible     = logical(),
    term_code      = character(),
    term           = character(),
    decoded_value  = character(),
    synonyms       = character(),
    definition     = character(),
    valid_from     = as.Date(character()),
    valid_to       = as.Date(character()),
    stringsAsFactors = FALSE
  )
}

# ── Find versions to add ───────────────────────────────────────────────────────
current_date  <- fetch_current_release_date("adam")
archive_dates <- list_archive_dates("adam")
all_dates     <- sort(unique(c(archive_dates, current_date)))

dates_needed <- all_dates[
  !vapply(all_dates, function(d) {
    already_have_version(ct_adam, d) || file.exists(raw_ct_path("adam", d))
  }, logical(1L))
]

if (length(dates_needed) == 0L) {
  message("ADaM CT is already up to date.")
} else {
  message(sprintf(
    "Adding %d new ADaM CT version(s): %s",
    length(dates_needed),
    paste(format(dates_needed), collapse = ", ")
  ))

  # ── Apply updates in chronological order ───────────────────────────────────
  for (d in sort(dates_needed)) {
    d <- as.Date(d)
    message(sprintf("  Processing %s...", format(d)))

    url <- if (identical(d, current_date)) ADAM_CURRENT else archive_url("adam", d)

    new_release <- tryCatch(
      fetch_raw_ct_tbl(url, "adam", d),
      error = function(e) {
        warning(sprintf("Failed to fetch/parse ADaM CT %s: %s", format(d), e$message))
        NULL
      }
    )

    if (!is.null(new_release)) {
      ct_adam <- apply_ct_update(ct_adam, new_release, d)
      if (nrow(ct_adam) > 0L) assert_no_na_valid_from(ct_adam)
      message(sprintf("    -> ct_adam now has %d rows", nrow(ct_adam)))
    }
  }

  # ── Save ────────────────────────────────────────────────────────────────────
  usethis::use_data(ct_adam, overwrite = TRUE, compress = "xz")
  message("ct_adam saved.")
  adam_updated <- TRUE
}
