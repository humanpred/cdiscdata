# Minimal fixture CT table for unit tests — does not load package data
make_ct_fixture <- function(n_terms = 5L,
                            valid_from = as.Date("2024-03-29"),
                            valid_to   = as.Date(NA)) {
  data.frame(
    codelist_code  = "C66731",
    codelist_name  = "SEX",
    codelist_label = "Sex",
    extensible     = FALSE,
    term_code      = paste0("C1657", seq_len(n_terms)),
    term           = paste0("TERM", seq_len(n_terms)),
    decoded_value  = paste0("Decoded ", seq_len(n_terms)),
    synonyms       = NA_character_,
    definition     = paste0("Definition ", seq_len(n_terms)),
    valid_from     = valid_from,
    valid_to       = valid_to,
    stringsAsFactors = FALSE
  )
}

# Fixture with two CT versions: an old row closed out and a new replacement
make_versioned_ct_fixture <- function() {
  old_row <- make_ct_fixture(n_terms = 2L, valid_from = as.Date("2023-09-29"),
                             valid_to = as.Date("2024-03-28"))
  new_row <- make_ct_fixture(n_terms = 3L, valid_from = as.Date("2024-03-29"),
                             valid_to = as.Date(NA))
  rbind(old_row, new_row)
}
