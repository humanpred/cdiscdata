test_that("build_domain_spec rejects invalid domain", {
  expect_error(build_domain_spec("XX"))
})

test_that("build_domain_spec returns expected columns for PP", {
  pp <- build_domain_spec("PP")
  expect_s3_class(pp, "data.frame")
  expect_equal(names(pp),
               c("variable", "label", "type", "length", "core", "order",
                 "source", "codelist_id"))
  expect_gt(nrow(pp), 0L)
  expect_true(all(pp$source == "SDTMIG"))
})

test_that("build_domain_spec resolves PPTESTCD/PPTEST/PPSTAT codelist ids against CT", {
  pp <- build_domain_spec("PP")
  expect_equal(pp$codelist_id[pp$variable == "PPTESTCD"], "C85839")
  expect_equal(pp$codelist_id[pp$variable == "PPTEST"], "C85493")
  expect_equal(pp$codelist_id[pp$variable == "PPSTAT"], "C66789")
  expect_equal(pp$length[pp$variable == "PPTESTCD"], 8L)
})

test_that("build_domain_spec PP defaults to the newest SDTMIG (3.4) and returns its 26 variables in order", {
  pp <- build_domain_spec("PP")
  expect_equal(pp$variable,
               c("STUDYID", "DOMAIN", "USUBJID", "PPSEQ", "PPGRPID", "PPTESTCD",
                 "PPTEST", "PPCAT", "PPSCAT", "PPORRES", "PPORRESU", "PPSTRESC",
                 "PPSTRESN", "PPSTRESU", "PPSTAT", "PPREASND", "PPSPEC",
                 "PPANMETH", "TAETORD", "EPOCH", "PPDTC", "PPDY", "PPTPTREF",
                 "PPRFTDTC", "PPSTINT", "PPENINT"))
  expect_equal(pp$order, 1:26)
  expect_equal(pp$codelist_id[pp$variable == "EPOCH"], "C99079")
  expect_equal(pp$codelist_id[pp$variable == "PPANMETH"], "C172330")
  expect_equal(pp$core[pp$variable %in% c("PPANMETH", "PPTPTREF")], c("Perm", "Perm"))
  expect_identical(pp, build_domain_spec("PP", ig_version = "3.4"))
})

test_that("build_domain_spec PP at 3.3 returns the 24 published variables, without PPANMETH or PPTPTREF", {
  pp <- build_domain_spec("PP", ig_version = "3.3")
  expect_equal(pp$variable, setdiff(build_domain_spec("PP")$variable, c("PPANMETH", "PPTPTREF")))
  expect_equal(pp$order, 1:24)
})

test_that("build_domain_spec PP at 3.2 equals 3.3 (the tables are unchanged between them)", {
  expect_identical(build_domain_spec("PP", ig_version = "3.2"),
                   build_domain_spec("PP", ig_version = "3.3"))
})

test_that("build_domain_spec SUPPPP returns the 10 standard SUPP-- variables", {
  supp <- build_domain_spec("SUPPPP")
  expect_setequal(
    supp$variable,
    c("STUDYID", "RDOMAIN", "USUBJID", "IDVAR", "IDVARVAL", "QNAM",
      "QLABEL", "QVAL", "QORIG", "QEVAL")
  )
})

test_that("build_domain_spec ADPP defaults to exactly one (the newest) ADaMIG version", {
  adpp <- build_domain_spec("ADPP")
  expect_gt(nrow(adpp), 0L)
  expect_equal(sum(duplicated(adpp$variable)), 0L)
})

test_that("build_domain_spec ADPP with an explicit older version differs from the default", {
  adpp_latest <- build_domain_spec("ADPP", ig_version = "1.0")
  adpp_default <- build_domain_spec("ADPP")
  expect_false(identical(sort(adpp_latest$variable), sort(adpp_default$variable)))
})

test_that("build_domain_spec ADPP defaults to adsl = TRUE and unions ADSL variables", {
  adpp <- build_domain_spec("ADPP")
  expect_true(all(c("BDS", "ADSL") %in% adpp$source))
  # ADSL-only variables (not also defined by BDS) are present...
  expect_true("ARM" %in% adpp$variable[adpp$source == "ADSL"])
  # ...marked Perm regardless of their Core designation in ADSL itself
  # (ARM is "Req" in ADSL_Treatment_Variables.csv)
  expect_equal(adpp$core[adpp$variable == "ARM"], "Perm")
  # no duplicates even though BDS and ADSL share base identifier variables
  expect_equal(sum(duplicated(adpp$variable)), 0L)
})

test_that("build_domain_spec ADPP with adsl = FALSE returns BDS variables only", {
  adpp <- build_domain_spec("ADPP", adsl = FALSE)
  expect_true(all(adpp$source == "BDS"))
  expect_false("ARM" %in% adpp$variable)
})

test_that("shared BDS/ADSL variables keep the BDS version, not duplicated", {
  adpp <- build_domain_spec("ADPP")
  expect_equal(adpp$source[adpp$variable == "STUDYID"], "BDS")
  expect_equal(sum(adpp$variable == "STUDYID"), 1L)
})

test_that("build_domain_spec warns (classed) when adsl is passed for a non-ADPP domain", {
  w <- expect_warning(
    build_domain_spec("PP", adsl = FALSE),
    class = "cdiscdata_warning_adsl_ignored"
  )
  expect_match(conditionMessage(w), "ignored", fixed = TRUE)
})

test_that("build_domain_spec aborts (classed) on unknown ig_version", {
  e_pp <- expect_error(
    build_domain_spec("PP", ig_version = "9.9"),
    class = "cdiscdata_error_ig_version_unavailable"
  )
  expect_match(conditionMessage(e_pp), "not available", fixed = TRUE)

  e_adpp <- expect_error(
    build_domain_spec("ADPP", ig_version = "9.9"),
    class = "cdiscdata_error_ig_version_unavailable"
  )
  expect_match(conditionMessage(e_adpp), "not available", fixed = TRUE)
})

test_that("build_domain_spec aborts informatively on unknown ct_version", {
  expect_error(build_domain_spec("PP", ct_version = "1900-01-01"), regexp = "not available")
})

test_that("build_domain_spec aborts (classed) when an SDTMIG version has no PP/SUPPQUAL rows", {
  # Not reachable via the public API with the currently bundled ig_sdtm
  # (SDTMIG's one version, 3.2, always has both PP and SUPPQUAL rows); this
  # exercises the defensive check directly by mocking get_ig() to return a
  # version that validates but has no rows for either domain.
  fake_sdtm <- data.frame(
    source = "SDTMIG", version = "9.9", class = NA_character_,
    domain = "OTHER", order = 1L, variable = "X", label = "X", type = "Char",
    role = NA_character_, core = "Req", codelist = NA_character_,
    length = NA_integer_, notes = NA_character_, stringsAsFactors = FALSE
  )
  testthat::local_mocked_bindings(
    get_ig = function(standard, version = NULL) {
      if (standard == "sdtm") fake_sdtm else get_ig(standard, version)
    },
    .package = "cdiscdata"
  )
  e <- expect_error(
    build_domain_spec("PP"),
    class = "cdiscdata_error_no_ig_variables"
  )
  expect_match(conditionMessage(e), "No SDTMIG 'PP' variables found", fixed = TRUE)
})

test_that("build_domain_spec aborts (classed) when an ADaMIG version has no BDS rows", {
  # Same rationale as the SDTMIG test above: not reachable with the
  # currently bundled ig_adam (every version has BDS rows), so mocked.
  fake_adam <- data.frame(
    dataset = "OTHER", version = "9.9", category = "X", order = 1L,
    variable = "X", label = "X", type = "Char", core = "Req",
    codelist = NA_character_, length = NA_integer_, notes = NA_character_,
    stringsAsFactors = FALSE
  )
  testthat::local_mocked_bindings(
    get_ig = function(standard, version = NULL) {
      if (standard == "adam") fake_adam else get_ig(standard, version)
    },
    .package = "cdiscdata"
  )
  e <- expect_error(
    build_domain_spec("ADPP"),
    class = "cdiscdata_error_no_ig_variables"
  )
  expect_match(conditionMessage(e), "No ADaMIG BDS variables found", fixed = TRUE)
})

# ---- sdtm_domain: union the SDTMIG PP variables into an ADPP spec ----------

# SDTMIG 3.4's 26 PP variables less STUDYID and USUBJID, which BDS already
# defines (the BDS version is kept); at 3.3 PPANMETH and PPTPTREF are absent.
pp_added_to_adpp <- c(
  "DOMAIN", "PPSEQ", "PPGRPID", "PPTESTCD", "PPTEST", "PPCAT", "PPSCAT",
  "PPORRES", "PPORRESU", "PPSTRESC", "PPSTRESN", "PPSTRESU", "PPSTAT",
  "PPREASND", "PPSPEC", "PPANMETH", "TAETORD", "EPOCH", "PPDTC", "PPDY",
  "PPTPTREF", "PPRFTDTC", "PPSTINT", "PPENINT"
)
pp_added_to_adpp_33 <- setdiff(pp_added_to_adpp, c("PPANMETH", "PPTPTREF"))

test_that("build_domain_spec ADPP leaves the PP variables out by default, and sdtm_domain = NULL is the default", {
  base <- build_domain_spec("ADPP")
  expect_equal(sum(base$variable %in% pp_added_to_adpp[-1L]), 0L)
  expect_identical(base, build_domain_spec("ADPP", sdtm_domain = NULL))
})

test_that("build_domain_spec ADPP sdtm_domain = 'PP' appends exactly the 24 PP variables not already defined", {
  base <- build_domain_spec("ADPP")
  withpp <- build_domain_spec("ADPP", sdtm_domain = "PP")
  added <- withpp[withpp$source == "SDTMIG", ]

  expect_equal(nrow(withpp), nrow(base) + 24L)
  # the BDS + ADSL rows are untouched and come first
  expect_identical(withpp[seq_len(nrow(base)), ], base)
  expect_equal(added$variable, pp_added_to_adpp)
  expect_true(all(added$core == "Perm"))
  # ordered after everything already there, continuing the sequence
  expect_equal(added$order, max(base$order) + seq_len(24L))
  # shared base variables keep their BDS version and appear once
  expect_equal(withpp$source[withpp$variable == "STUDYID"], "BDS")
  expect_equal(sum(withpp$variable %in% c("STUDYID", "USUBJID")), 2L)
  expect_equal(sum(duplicated(withpp$variable)), 0L)
})

test_that("build_domain_spec ADPP sdtm_domain = 'PP' takes labels and types from the SDTMIG PP table", {
  withpp <- build_domain_spec("ADPP", sdtm_domain = "PP")
  row <- function(v) withpp[withpp$variable == v, ]
  expect_equal(row("PPSTRESC")$label, "Character Result/Finding in Std Format")
  expect_equal(row("PPSTRESC")$type, "Char")
  expect_equal(row("PPSTRESN")$type, "Num")
  expect_equal(row("PPTESTCD")$length, 8L)
  expect_equal(row("EPOCH")$label, "Epoch")
})

test_that("build_domain_spec ADPP resolves the PP codelist ids against the SDTM CT (ADaM CT has none of them)", {
  withpp <- build_domain_spec("ADPP", sdtm_domain = "PP")
  expect_equal(withpp$codelist_id[withpp$variable == "PPTESTCD"], "C85839")
  expect_equal(withpp$codelist_id[withpp$variable == "PPTEST"], "C85493")
  expect_equal(withpp$codelist_id[withpp$variable == "PPORRESU"], "C85494")
  expect_equal(withpp$codelist_id[withpp$variable == "PPSTAT"], "C66789")
  expect_equal(withpp$codelist_id[withpp$variable == "PPSPEC"], "C78734")
  expect_equal(withpp$codelist_id[withpp$variable == "EPOCH"], "C99079")
  expect_equal(withpp$codelist_id[withpp$variable == "PPANMETH"], "C172330")
})

test_that("build_domain_spec ADPP sdtm_domain = 'PP' works with adsl = FALSE (BDS + PP only)", {
  nb <- build_domain_spec("ADPP", adsl = FALSE, sdtm_domain = "PP")
  bds <- build_domain_spec("ADPP", adsl = FALSE)
  expect_equal(sort(unique(nb$source)), c("BDS", "SDTMIG"))
  expect_identical(nb[seq_len(nrow(bds)), ], bds)
  expect_equal(nb$variable[nb$source == "SDTMIG"], pp_added_to_adpp)
  expect_equal(nb$codelist_id[nb$variable == "PPTESTCD"], "C85839")
})

test_that("build_domain_spec ADPP sdtmig_version picks the SDTMIG version (3.2 and 3.3 PP tables are identical; 3.4 adds two)", {
  expect_identical(
    build_domain_spec("ADPP", sdtm_domain = "PP", sdtmig_version = "3.2"),
    build_domain_spec("ADPP", sdtm_domain = "PP", sdtmig_version = "3.3")
  )
  at33 <- build_domain_spec("ADPP", sdtm_domain = "PP", sdtmig_version = "3.3")
  expect_equal(at33$variable[at33$source == "SDTMIG"], pp_added_to_adpp_33)
  at34 <- build_domain_spec("ADPP", sdtm_domain = "PP", sdtmig_version = "3.4")
  expect_equal(nrow(at34) - nrow(at33), 2L)
  expect_equal(setdiff(at34$variable, at33$variable), c("PPANMETH", "PPTPTREF"))
  e <- expect_error(
    build_domain_spec("ADPP", sdtm_domain = "PP", sdtmig_version = "9.9"),
    class = "cdiscdata_error_ig_version_unavailable"
  )
  expect_match(conditionMessage(e), "Version '9.9' is not available for SDTMIG.", fixed = TRUE)
})

test_that("build_domain_spec ADPP aborts (classed) on an sdtm_domain other than PP", {
  e <- expect_error(
    build_domain_spec("ADPP", sdtm_domain = "LB"),
    class = "cdiscdata_error_sdtm_domain_unavailable"
  )
  expect_equal(
    conditionMessage(e),
    "`sdtm_domain` must be NULL or \"PP\" (the SDTMIG domain an ADPP is built from), not 'LB'."
  )
  e2 <- expect_error(
    build_domain_spec("ADPP", sdtm_domain = c("PP", "LB")),
    class = "cdiscdata_error_sdtm_domain_unavailable"
  )
  expect_match(conditionMessage(e2), "not 'PP', 'LB'.", fixed = TRUE)
})

test_that("build_domain_spec warns (classed) when sdtm_domain or sdtmig_version is passed where it has no effect", {
  w1 <- expect_warning(
    build_domain_spec("PP", sdtm_domain = "PP"),
    class = "cdiscdata_warning_sdtm_domain_ignored"
  )
  expect_equal(conditionMessage(w1),
               "`sdtm_domain` and `sdtmig_version` are ignored for domain != \"ADPP\".")
  expect_warning(build_domain_spec("SUPPPP", sdtmig_version = "3.3"),
                 class = "cdiscdata_warning_sdtm_domain_ignored")

  w2 <- expect_warning(
    build_domain_spec("ADPP", sdtmig_version = "3.3"),
    class = "cdiscdata_warning_sdtm_domain_ignored"
  )
  expect_equal(conditionMessage(w2), "`sdtmig_version` is ignored when `sdtm_domain` is NULL.")
})
