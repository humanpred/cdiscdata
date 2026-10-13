# Ground truth for these tests: the CDISC Library exports in ig_sdtm and
# ig_adam. SDTMIG 3.4 PP has 26 variables, ADaMIG 1.3 has 195 BDS and 141 ADSL
# variables (4 shared), ADaMIG-NCA 1.0 has 59, ADaM-popPK 1.0 has 82, and
# ADaM-BDS-TTE 1.0 has 29.

source_counts <- function(spec) {
  tab <- table(spec$source)
  stats::setNames(as.integer(tab), names(tab))
}

test_that("build_domain_spec rejects invalid domain", {
  expect_error(build_domain_spec("XX"))
})

test_that("build_domain_spec returns the documented columns for PP, with no length (the exports have none)", {
  pp <- build_domain_spec("PP")
  expect_s3_class(pp, "data.frame")
  expect_equal(names(pp),
               c("variable", "label", "type", "length", "core", "order",
                 "source", "codelist_id"))
  expect_equal(nrow(pp), 26L)
  expect_true(all(pp$source == "SDTMIG"))
  expect_type(pp$length, "integer")
  expect_true(all(is.na(pp$length)))
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
  expect_equal(pp$core[pp$variable %in% c("PPANMETH", "PPTPTREF")], c("Perm", "Perm"))
  expect_equal(pp$label[pp$variable == "PPSTRESC"], "Character Result/Finding in Std Format")
  expect_identical(pp, build_domain_spec("PP", ig_version = "3.4"))
})

test_that("build_domain_spec resolves PP codelist ids against the SDTM CT, the first code of a list winning", {
  pp <- build_domain_spec("PP")
  ids <- stats::setNames(pp$codelist_id, pp$variable)
  expect_equal(ids[["PPTESTCD"]], "C85839")
  expect_equal(ids[["PPTEST"]], "C85493")
  expect_equal(ids[["PPSTAT"]], "C66789")
  expect_equal(ids[["PPSPEC"]], "C78734")
  expect_equal(ids[["EPOCH"]], "C99079")
  expect_equal(ids[["PPANMETH"]], "C172330")
  # "C85494; C128684; ..." in the guide
  expect_equal(ids[["PPORRESU"]], "C85494")
  expect_equal(sort(names(ids)[!is.na(ids)]),
               sort(c("PPTESTCD", "PPTEST", "PPORRESU", "PPSTRESU", "PPSTAT",
                      "PPSPEC", "PPANMETH", "EPOCH")))
})

test_that("build_domain_spec PP follows each SDTMIG version's published variables: 21, 24, 26 at 3.2, 3.3, 3.4", {
  pp32 <- build_domain_spec("PP", ig_version = "3.2")
  pp33 <- build_domain_spec("PP", ig_version = "3.3")
  pp34 <- build_domain_spec("PP", ig_version = "3.4")
  expect_equal(c(nrow(pp32), nrow(pp33), nrow(pp34)), c(21L, 24L, 26L))
  expect_equal(pp33$variable, setdiff(pp34$variable, c("PPANMETH", "PPTPTREF")))
  expect_equal(pp32$variable, setdiff(pp33$variable, c("TAETORD", "EPOCH", "PPDY")))
  expect_equal(pp32$order, 1:21)
  expect_equal(nrow(build_domain_spec("PP", ig_version = "3.1.2")), 19L)
  expect_false(identical(pp32, pp33))
})

test_that("build_domain_spec PP can be built from another SDTM-side guide with the standard argument", {
  pp <- build_domain_spec("PP", standard = "SENDIG")
  expect_equal(nrow(pp), 25L)
  expect_true(all(pp$source == "SENDIG"))
  expect_equal(nrow(build_domain_spec("PP", standard = "SENDIG", ig_version = "3.0")), 23L)
  e <- expect_error(build_domain_spec("PP", standard = "FOO"),
                    class = "cdiscdata_error_ig_standard_unavailable")
  expect_match(conditionMessage(e), "Standard 'FOO' is not available.", fixed = TRUE)
})

test_that("build_domain_spec SUPPPP returns the 10 standard SUPP-- variables, from SUPPQUAL", {
  supp <- build_domain_spec("SUPPPP")
  expect_equal(supp$variable,
               c("STUDYID", "RDOMAIN", "USUBJID", "IDVAR", "IDVARVAL", "QNAM",
                 "QLABEL", "QVAL", "QORIG", "QEVAL"))
  expect_equal(supp$order, 1:10)
  expect_true(all(supp$source == "SDTMIG"))
  expect_equal(supp$codelist_id[!is.na(supp$codelist_id)], c("C66734", "C78735"))
  expect_equal(supp$variable[!is.na(supp$codelist_id)], c("RDOMAIN", "QEVAL"))
})

test_that("build_domain_spec ADPP defaults to ADaMIG 1.3: 195 BDS variables plus 137 more from ADSL", {
  adpp <- build_domain_spec("ADPP")
  expect_equal(nrow(adpp), 332L)
  expect_equal(source_counts(adpp)[c("ADSL", "BDS")], c(ADSL = 137L, BDS = 195L))
  expect_equal(sum(duplicated(adpp$variable)), 0L)
  expect_equal(adpp$order, 1:332)
  expect_identical(adpp, build_domain_spec("ADPP", ig_version = "1.3"))
})

test_that("build_domain_spec ADPP with an explicit older version differs from the default", {
  adpp_old <- build_domain_spec("ADPP", ig_version = "1.0")
  expect_false(identical(sort(adpp_old$variable), sort(build_domain_spec("ADPP")$variable)))
  expect_equal(sum(duplicated(adpp_old$variable)), 0L)
})

test_that("build_domain_spec ADPP unions ADSL with Perm core, keeping the BDS version of shared variables", {
  adpp <- build_domain_spec("ADPP")
  expect_equal(adpp$source[adpp$variable == "ARM"], "ADSL")
  expect_equal(adpp$core[adpp$variable == "ARM"], "Perm")
  expect_true(all(adpp$core[adpp$source == "ADSL"] == "Perm"))
  expect_equal(adpp$source[adpp$variable == "STUDYID"], "BDS")
  expect_equal(sum(adpp$variable == "STUDYID"), 1L)
})

test_that("build_domain_spec ADPP resolves codelist ids against the ADaM CT, then the SDTM CT", {
  adpp <- build_domain_spec("ADPP")
  ids <- stats::setNames(adpp$codelist_id, adpp$variable)
  expect_equal(ids[["DTYPE"]], "C81224")
  expect_equal(ids[["SEX"]], "C66731")
  expect_equal(ids[["AGEU"]], "C66781")
  expect_true(is.na(ids[["RACE"]]))
  expect_equal(sum(!is.na(adpp$codelist_id)), 54L)
  expect_equal(sort(unique(adpp$codelist_id)),
               c("C124296", "C66731", "C66781", "C81223", "C81224", "C81226"))
})

test_that("build_domain_spec ADPP with adsl = FALSE returns the 195 BDS variables only", {
  adpp <- build_domain_spec("ADPP", adsl = FALSE)
  expect_equal(nrow(adpp), 195L)
  expect_true(all(adpp$source == "BDS"))
  expect_false("ARM" %in% adpp$variable)
})

test_that("build_domain_spec warns (classed) when adsl is passed for a non-ADPP domain", {
  w <- expect_warning(
    build_domain_spec("PP", adsl = FALSE),
    class = "cdiscdata_warning_adsl_ignored"
  )
  expect_equal(conditionMessage(w), '`adsl` is ignored for domain != "ADPP".')
})

test_that("build_domain_spec aborts (classed) on an unknown ig_version, naming the standard", {
  e_pp <- expect_error(
    build_domain_spec("PP", ig_version = "9.9"),
    class = "cdiscdata_error_ig_version_unavailable"
  )
  expect_equal(conditionMessage(e_pp),
               "Version '9.9' is not available for SDTMIG. Available versions: 3.1.2, 3.1.3, 3.2, 3.3, 3.4.")
  e_adpp <- expect_error(
    build_domain_spec("ADPP", ig_version = "9.9"),
    class = "cdiscdata_error_ig_version_unavailable"
  )
  expect_match(conditionMessage(e_adpp), "Version '9.9' is not available for ADaMIG.", fixed = TRUE)
})

test_that("build_domain_spec aborts informatively on unknown ct_version", {
  expect_error(build_domain_spec("PP", ct_version = "1900-01-01"), regexp = "not available")
})

# ---- codelist id resolution, in isolation -----------------------------------

test_that(".codelist_ids takes the first code of a list, from the first CT release that has the codelist", {
  ids <- cdiscdata:::.codelist_ids
  ct1 <- data.frame(codelist_code = c("C1", "C1"), term_code = c(NA, "T1"),
                    stringsAsFactors = FALSE)
  ct2 <- data.frame(codelist_code = c("C2", "C3"), term_code = c(NA_character_, NA_character_),
                    stringsAsFactors = FALSE)
  expect_equal(ids(c("C1; C2", "C2", NA, "C9", "C3; C1", " C1"), list(ct1, ct2)),
               c("C1", "C2", NA, NA, "C3", "C1"))
  # a term code alone does not make a codelist known
  expect_equal(ids("T1", list(ct1)), NA_character_)
  expect_equal(ids(c("C1", "C2"), list(ct1)), c("C1", NA))
  expect_equal(ids(character(0L), list(ct1)), character(0L))
})

test_that("the NULL-coalescing helper returns its left side unless that is NULL", {
  or <- cdiscdata:::.if_null
  expect_equal(or(NULL, 1), 1)
  expect_equal(or(2, 1), 2)
  expect_equal(or(NA, 1), NA)
})

# ---- defensive checks, via mocked guides ------------------------------------

test_that("build_domain_spec aborts (classed) when an SDTM-side guide has no PP/SUPPQUAL rows", {
  # Not reachable with the bundled ig_sdtm for SDTMIG; the check is exercised
  # by mocking get_ig() to return a version that validates but has no rows
  # for the domain.
  fake_sdtm <- data.frame(
    standard = "SDTMIG", version = "9.9", class = NA_character_,
    domain = "OTHER", order = 1L, variable = "X", label = "X", type = "Char",
    role = NA_character_, core = "Req", codelist_code = NA_character_,
    stringsAsFactors = FALSE
  )
  testthat::local_mocked_bindings(
    get_ig = function(standard = "SDTMIG", version = NULL, domain = NULL) fake_sdtm,
    .package = "cdiscdata"
  )
  e <- expect_error(
    build_domain_spec("PP"),
    class = "cdiscdata_error_no_ig_variables"
  )
  expect_equal(conditionMessage(e), "No SDTMIG 'PP' variables found for version '9.9'.")
  e2 <- expect_error(build_domain_spec("SUPPPP"), class = "cdiscdata_error_no_ig_variables")
  expect_match(conditionMessage(e2), "No SDTMIG 'SUPPQUAL' variables found", fixed = TRUE)
})

test_that("build_domain_spec aborts (classed) when an ADaM guide has no BDS rows", {
  fake_adam <- data.frame(
    standard = "ADaMIG", version = "9.9", structure = "OTHER",
    variable_set = "X", order = 1L, variable = "X", label = "X", type = "Char",
    core = "Req", codelist_code = NA_character_, stringsAsFactors = FALSE
  )
  testthat::local_mocked_bindings(
    get_ig = function(standard = "ADaMIG", version = NULL, domain = NULL) fake_adam,
    .package = "cdiscdata"
  )
  e <- expect_error(
    build_domain_spec("ADPP"),
    class = "cdiscdata_error_no_ig_variables"
  )
  expect_equal(conditionMessage(e), "No ADaMIG BDS variables found for version '9.9'.")
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
  expect_equal(sum(base$variable %in% pp_added_to_adpp), 0L)
  expect_identical(base, build_domain_spec("ADPP", sdtm_domain = NULL))
})

test_that("build_domain_spec ADPP sdtm_domain = 'PP' appends exactly the 24 PP variables not already defined", {
  base <- build_domain_spec("ADPP")
  withpp <- build_domain_spec("ADPP", sdtm_domain = "PP")
  added <- withpp[withpp$source == "SDTMIG", ]

  expect_equal(nrow(withpp), 356L)
  expect_equal(nrow(withpp), nrow(base) + 24L)
  expect_identical(withpp[seq_len(nrow(base)), ], base)
  expect_equal(added$variable, pp_added_to_adpp)
  expect_true(all(added$core == "Perm"))
  expect_equal(added$order, max(base$order) + seq_len(24L))
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
  expect_true(is.na(row("PPTESTCD")$length))
  expect_equal(row("EPOCH")$label, "Epoch")
})

test_that("build_domain_spec ADPP resolves the PP codelist ids against the SDTM CT (ADaM CT has none of them)", {
  withpp <- build_domain_spec("ADPP", sdtm_domain = "PP")
  ids <- stats::setNames(withpp$codelist_id, withpp$variable)
  expect_equal(ids[["PPTESTCD"]], "C85839")
  expect_equal(ids[["PPTEST"]], "C85493")
  expect_equal(ids[["PPORRESU"]], "C85494")
  expect_equal(ids[["PPSTAT"]], "C66789")
  expect_equal(ids[["PPSPEC"]], "C78734")
  expect_equal(ids[["EPOCH"]], "C99079")
  expect_equal(ids[["PPANMETH"]], "C172330")
})

test_that("build_domain_spec ADPP sdtm_domain = 'PP' works with adsl = FALSE (BDS + PP only)", {
  nb <- build_domain_spec("ADPP", adsl = FALSE, sdtm_domain = "PP")
  bds <- build_domain_spec("ADPP", adsl = FALSE)
  expect_equal(nrow(nb), 195L + 24L)
  expect_equal(sort(unique(nb$source)), c("BDS", "SDTMIG"))
  expect_identical(nb[seq_len(nrow(bds)), ], bds)
  expect_equal(nb$variable[nb$source == "SDTMIG"], pp_added_to_adpp)
  expect_equal(nb$codelist_id[nb$variable == "PPTESTCD"], "C85839")
})

test_that("build_domain_spec ADPP sdtmig_version picks the SDTMIG version (3.3 adds 22, 3.4 adds 24)", {
  at33 <- build_domain_spec("ADPP", sdtm_domain = "PP", sdtmig_version = "3.3")
  at34 <- build_domain_spec("ADPP", sdtm_domain = "PP", sdtmig_version = "3.4")
  at32 <- build_domain_spec("ADPP", sdtm_domain = "PP", sdtmig_version = "3.2")
  expect_equal(at33$variable[at33$source == "SDTMIG"], pp_added_to_adpp_33)
  expect_equal(c(nrow(at32), nrow(at33), nrow(at34)) - 332L, c(19L, 22L, 24L))
  expect_equal(setdiff(at34$variable, at33$variable), c("PPANMETH", "PPTPTREF"))
  expect_identical(at34, build_domain_spec("ADPP", sdtm_domain = "PP"))
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
    '`sdtm_domain` must be NULL or "PP" (the SDTMIG domain an ADPP is built from), not \'LB\'.'
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
               '`sdtm_domain` and `sdtmig_version` are ignored for domain != "ADPP".')
  expect_warning(build_domain_spec("SUPPPP", sdtmig_version = "3.3"),
                 class = "cdiscdata_warning_sdtm_domain_ignored")

  w2 <- expect_warning(
    build_domain_spec("ADPP", sdtmig_version = "3.3"),
    class = "cdiscdata_warning_sdtm_domain_ignored"
  )
  expect_equal(conditionMessage(w2), "`sdtmig_version` is ignored when `sdtm_domain` is NULL.")
})

# ---- extension: union a BDS extension (ADaMIG-NCA, popPK, TTE) --------------

test_that("extension = 'NCA' unions ADaMIG-NCA onto BDS + ADSL: 56 new rows, 3 touched, 388 in all", {
  base <- build_domain_spec("ADPP")
  nca <- build_domain_spec("ADPP", extension = "NCA")
  ext <- get_ig("ADaMIG-NCA")
  expect_equal(nrow(nca), 388L)
  expect_equal(source_counts(nca)[c("ADaMIG-NCA", "ADSL", "BDS")], c("ADaMIG-NCA" = 59L, ADSL = 137L, BDS = 192L))
  expect_equal(sum(duplicated(nca$variable)), 0L)
  expect_equal(nca$order, 1:388)
  # the BDS and ADSL rows keep their position; the extension's new ones follow
  expect_equal(nca$variable[seq_len(nrow(base))], base$variable)
  expect_equal(nca$variable[-seq_len(nrow(base))],
               ext$variable[!ext$variable %in% base$variable])
  expect_equal(nca$order[-seq_len(nrow(base))], nrow(base) + 1:56)
})

test_that("extension = 'NCA' equals 'ADaMIG-NCA' and keeps the extension's Core, unlike ADSL and PP", {
  expect_identical(build_domain_spec("ADPP", extension = "NCA"),
                   build_domain_spec("ADPP", extension = "ADaMIG-NCA"))
  expect_identical(build_domain_spec("ADPP", extension = "NCA"),
                   build_domain_spec("ADPP", extension = "ADaMIG-NCA", extension_version = "1.0"))
  base <- build_domain_spec("ADPP")
  nca <- build_domain_spec("ADPP", extension = "NCA")
  # variables the BDS already had take NCA's Core, and are marked as NCA's
  touched <- c("DOSEA", "DOSEU", "AVISIT")
  expect_equal(nca$core[match(touched, nca$variable)], rep("Req", 3L))
  expect_equal(nca$source[match(touched, nca$variable)], rep("ADaMIG-NCA", 3L))
  expect_equal(nca$order[match(touched, nca$variable)], c(11L, 13L, 32L))
  expect_equal(nca$order[match(touched, nca$variable)], base$order[match(touched, base$variable)])
  # newly added variables keep their published Core, with the NCA source
  row <- function(v) nca[nca$variable == v, ]
  expect_equal(row("PKSUMXF")$core, "Perm")
  expect_equal(row("METABFL")$core, "Cond")
  expect_equal(row("PCRFTDT")$core, "Req")
  expect_equal(row("ROUTE")$core, "Perm")
  expect_equal(row("ROUTE")$source, "ADaMIG-NCA")
  expect_equal(row("ROUTE")$codelist_id, "C66729")
  expect_gt(sum(nca$source == "ADaMIG-NCA" & nca$core == "Req"), 3L)
})

test_that("extension = 'NCA' with adsl = FALSE adds the extension to BDS alone", {
  nb <- build_domain_spec("ADPP", adsl = FALSE, extension = "NCA")
  expect_equal(nrow(nb), 195L + 56L)
  expect_false("ARM" %in% nb$variable)
  expect_equal(sort(unique(nb$source)), c("ADaMIG-NCA", "BDS"))
})

test_that("extension = 'ADaM-popPK' touches 11 existing variables and adds 71", {
  p <- build_domain_spec("ADPP", extension = "ADaM-popPK")
  expect_equal(nrow(p), 403L)
  expect_equal(sum(p$source == "ADaM-popPK"), 82L)
  expect_equal(sum(p$source == "BDS"), 189L)
  expect_equal(sum(p$source == "ADSL"), 132L)
  expect_equal(sum(duplicated(p$variable)), 0L)
  expect_equal(p$order, seq_len(403L))
})

test_that("extension = 'ADaM-BDS-TTE' only restates 29 variables the BDS and ADSL already define", {
  tte <- build_domain_spec("ADPP", extension = "ADaM-BDS-TTE")
  expect_equal(nrow(tte), 332L)
  expect_equal(sum(tte$source == "ADaM-BDS-TTE"), 29L)
  expect_equal(sum(tte$source == "BDS"), 170L)
  expect_equal(sum(tte$source == "ADSL"), 133L)
  expect_equal(tte$variable, build_domain_spec("ADPP")$variable)
})

test_that("extension aborts (classed) on an unknown extension or version, and warns where it has no effect", {
  e <- expect_error(build_domain_spec("ADPP", extension = "FOO"),
                    class = "cdiscdata_error_extension_unavailable")
  expect_equal(
    conditionMessage(e),
    paste0('`extension` must be NULL or one of "ADaMIG-NCA", "ADaM-popPK", ',
           '"ADaM-BDS-TTE", "NCA", not \'FOO\'.')
  )
  expect_error(build_domain_spec("ADPP", extension = "SDTMIG"),
               class = "cdiscdata_error_extension_unavailable")
  ev <- expect_error(build_domain_spec("ADPP", extension = "NCA", extension_version = "9.9"),
                     class = "cdiscdata_error_ig_version_unavailable")
  expect_equal(conditionMessage(ev),
               "Version '9.9' is not available for ADaMIG-NCA. Available versions: 1.0.")

  w1 <- expect_warning(build_domain_spec("PP", extension = "NCA"),
                       class = "cdiscdata_warning_extension_ignored")
  expect_equal(conditionMessage(w1),
               '`extension` and `extension_version` are ignored for domain != "ADPP".')
  expect_warning(build_domain_spec("SUPPPP", extension_version = "1.0"),
                 class = "cdiscdata_warning_extension_ignored")
  w2 <- expect_warning(build_domain_spec("ADPP", extension_version = "1.0"),
                       class = "cdiscdata_warning_extension_ignored")
  expect_equal(conditionMessage(w2), "`extension_version` is ignored when `extension` is NULL.")
})

test_that("extension and sdtm_domain compose: BDS, ADSL, NCA, then the PP variables", {
  both <- build_domain_spec("ADPP", extension = "NCA", sdtm_domain = "PP")
  nca <- build_domain_spec("ADPP", extension = "NCA")
  expect_identical(both[seq_len(nrow(nca)), ], nca)
  expect_equal(nrow(both), 388L + sum(!pp_added_to_adpp %in% nca$variable))
  expect_equal(sum(duplicated(both$variable)), 0L)
})
