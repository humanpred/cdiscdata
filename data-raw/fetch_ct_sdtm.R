# Run this script to update SDTM CT data.
# Either source it directly or call it from fetch_all.R.
# Requires: utils_nci.R and utils_diff.R sourced first.

# ── Load existing data ─────────────────────────────────────────────────────────
existing_path <- "data/ct_sdtm.rda"
if (file.exists(existing_path)) {
  load(existing_path)  # loads ct_sdtm
} else {
  message("No existing ct_sdtm found. Bootstrapping from NCI archive...")
  ct_sdtm <- data.frame(
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
current_date <- tryCatch(
  fetch_current_release_date("sdtm"),
  error = function(e) {
    message(sprintf(
      "Could not fetch SDTM CT release date stamp: %s\nFalling back to archive listing only.",
      e$message
    ))
    as.Date(NA_character_)
  }
)
archive_dates <- list_archive_dates("sdtm")
all_dates     <- sort(unique(c(archive_dates, if (!is.na(current_date)) current_date)))

if (length(all_dates) == 0L) {
  message("Could not reach NCI server. Skipping SDTM CT update.")
} else {
  dates_needed <- all_dates[
    !vapply(all_dates, function(d) {
      # A date is "done" if it already has rows in the table OR if its raw
      # cache file exists (meaning it was processed but produced no new rows,
      # i.e. the release was identical to the prior one).
      already_have_version(ct_sdtm, d) || file.exists(raw_ct_path("sdtm", d))
    }, logical(1L))
  ]

  if (length(dates_needed) == 0L) {
    message("SDTM CT is already up to date.")
  } else {
    message(sprintf(
      "Adding %d new SDTM CT version(s): %s",
      length(dates_needed),
      paste(format(dates_needed), collapse = ", ")
    ))

    # ── Apply updates in chronological order ───────────────────────────────────
    for (d in sort(dates_needed)) {
      d <- as.Date(d)
      message(sprintf("  Processing %s...", format(d)))

      url <- if (identical(d, current_date)) SDTM_CURRENT else archive_url("sdtm", d)

      new_release <- tryCatch(
        fetch_raw_ct_tbl(url, "sdtm", d),
        error = function(e) {
          warning(sprintf("Failed to fetch/parse SDTM CT %s: %s", format(d), e$message))
          NULL
        }
      )

      if (!is.null(new_release)) {
        ct_sdtm <- apply_ct_update(ct_sdtm, new_release, d)
        if (nrow(ct_sdtm) > 0L) assert_no_na_valid_from(ct_sdtm)
        message(sprintf("    -> ct_sdtm now has %d rows", nrow(ct_sdtm)))
      }
    }

    # ── Save ────────────────────────────────────────────────────────────────────
    usethis::use_data(ct_sdtm, overwrite = TRUE, compress = "xz")
    message("ct_sdtm saved.")
    sdtm_updated <- TRUE
  }
}
