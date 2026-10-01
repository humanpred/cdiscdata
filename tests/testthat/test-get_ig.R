test_that("get_ig returns a data frame for sdtm and adam", {
  expect_s3_class(get_ig("sdtm"), "data.frame")
  expect_s3_class(get_ig("adam"), "data.frame")
})

test_that("get_ig rejects invalid standard", {
  expect_error(get_ig("other"))
})

test_that("get_ig(version = NULL) returns every source/version", {
  sdtm <- get_ig("sdtm")
  expect_setequal(unique(sdtm$source), c("SDTM_MODEL", "SDTMIG"))
  expect_setequal(sdtm$version[sdtm$source == "SDTM_MODEL"], c("1.4", "1.5", "1.6", "1.7"))
  expect_setequal(sdtm$version[sdtm$source == "SDTMIG"], c("3.2", "3.3"))

  adam <- get_ig("adam")
  expect_setequal(unique(adam$version), c("1.0", "1.1", "1.2"))
  expect_setequal(unique(adam$dataset), c("ADSL", "BDS"))
})

test_that("get_ig filters to one version when given", {
  sdtm_32 <- get_ig("sdtm", version = "3.2")
  expect_true(all(sdtm_32$version == "3.2"))
  expect_true(all(sdtm_32$source == "SDTMIG"))

  adam_10 <- get_ig("adam", version = "1.0")
  expect_true(all(adam_10$version == "1.0"))
})

test_that("get_ig aborts (classed) on unknown version", {
  e_sdtm <- expect_error(
    get_ig("sdtm", version = "9.9"),
    class = "cdiscdata_error_ig_version_unavailable"
  )
  expect_match(conditionMessage(e_sdtm), "not available", fixed = TRUE)

  e_adam <- expect_error(
    get_ig("adam", version = "9.9"),
    class = "cdiscdata_error_ig_version_unavailable"
  )
  expect_match(conditionMessage(e_adam), "not available", fixed = TRUE)
})

test_that("ig_sdtm has expected columns and no NA variable/version", {
  ig <- get_ig("sdtm")
  expect_true(all(c("source", "version", "class", "domain", "order",
                    "variable", "label", "type", "role", "core", "codelist",
                    "length", "notes") %in% names(ig)))
  expect_false(anyNA(ig$variable))
  expect_false(anyNA(ig$version))
})

test_that("ig_adam has expected columns and no NA variable/version", {
  ig <- get_ig("adam")
  expect_true(all(c("dataset", "version", "category", "order", "variable",
                    "label", "type", "core", "codelist", "length", "notes") %in%
                    names(ig)))
  expect_false(anyNA(ig$variable))
  expect_false(anyNA(ig$version))
})

test_that("SDTMIG PP domain contains PPTESTCD with the PKPARMCD codelist token", {
  pp <- get_ig("sdtm", version = "3.2")
  pp <- pp[pp$domain == "PP", ]
  expect_true("PPTESTCD" %in% pp$variable)
  expect_equal(pp$codelist[pp$variable == "PPTESTCD"], "PKPARMCD")
  expect_equal(pp$length[pp$variable == "PPTESTCD"], 8L)
})

test_that("SUPPQUAL structure has the 10 standard SUPP-- variables", {
  supp <- get_ig("sdtm", version = "3.2")
  supp <- supp[supp$domain == "SUPPQUAL", ]
  expect_setequal(
    supp$variable,
    c("STUDYID", "RDOMAIN", "USUBJID", "IDVAR", "IDVARVAL", "QNAM",
      "QLABEL", "QVAL", "QORIG", "QEVAL")
  )
})

# Published PP table (SDTMIG v3.3 section 6.3.11.2), in published order. The
# 3.3 guide stamps the table "Version 3.2", so 3.2 and 3.3 carry the same rows.
pp_variables_published <- c(
  "STUDYID", "DOMAIN", "USUBJID", "PPSEQ", "PPGRPID", "PPTESTCD", "PPTEST",
  "PPCAT", "PPSCAT", "PPORRES", "PPORRESU", "PPSTRESC", "PPSTRESN",
  "PPSTRESU", "PPSTAT", "PPREASND", "PPSPEC", "TAETORD", "EPOCH", "PPDTC",
  "PPDY", "PPRFTDTC", "PPSTINT", "PPENINT"
)

test_that("get_ig(domain = 'PP') returns the 24 published PP variables in order at 3.2 and 3.3", {
  for (v in c("3.2", "3.3")) {
    pp <- get_ig("sdtm", version = v, domain = "PP")
    expect_equal(pp$variable, pp_variables_published, label = paste("PP variables at", v))
    expect_equal(pp$order, seq_len(24L))
    expect_true(all(pp$source == "SDTMIG" & pp$domain == "PP" & pp$version == v))
  }
})

test_that("PP rows added from the SDTMIG v3.3 table have the published label, type, codelist, role and core", {
  pp <- get_ig("sdtm", version = "3.3", domain = "PP")
  row <- function(v) pp[pp$variable == v, ]
  expect_equal(row("TAETORD")$label, "Planned Order of Element within Arm")
  expect_equal(row("TAETORD")$type, "Num")
  expect_equal(row("TAETORD")$role, "Timing")
  expect_equal(row("TAETORD")$core, "Perm")
  expect_equal(row("EPOCH")$label, "Epoch")
  expect_equal(row("EPOCH")$type, "Char")
  expect_equal(row("EPOCH")$codelist, "EPOCH")
  expect_equal(row("PPDY")$label, "Study Day of Parameter Calculations")
  expect_equal(row("PPDY")$type, "Num")
  expect_equal(row("PPDTC")$label, "Date/Time of Parameter Calculations")
})

test_that("PP does not carry the aNCA-style names PPPDTC, PPPDY, or PTAETORD, nor 3.4-only PPANMETH/PPTPTREF", {
  pp <- get_ig("sdtm", domain = "PP")
  expect_equal(intersect(c("PPPDTC", "PPPDY", "PTAETORD", "PPANMETH", "PPTPTREF"), pp$variable),
               character(0L))
})

test_that("SDTMIG 3.2 and 3.3 PP and SUPPQUAL tables are identical apart from the version", {
  for (d in c("PP", "SUPPQUAL")) {
    a <- get_ig("sdtm", version = "3.2", domain = d)
    b <- get_ig("sdtm", version = "3.3", domain = d)
    rownames(a) <- rownames(b) <- NULL
    a$version <- b$version <- NULL
    expect_identical(a, b, label = paste(d, "3.2 vs 3.3"))
  }
})

test_that("SUPPQUAL at 3.3 has the 10 published SUPP-- variables in order", {
  supp <- get_ig("sdtm", version = "3.3", domain = "SUPPQUAL")
  expect_equal(supp$variable,
               c("STUDYID", "RDOMAIN", "USUBJID", "IDVAR", "IDVARVAL", "QNAM",
                 "QLABEL", "QVAL", "QORIG", "QEVAL"))
})

test_that("get_ig(domain =) filters ADaM by dataset and works without a version", {
  bds <- get_ig("adam", domain = "BDS")
  expect_equal(unique(bds$dataset), "BDS")
  expect_equal(sort(unique(bds$version)), c("1.0", "1.1", "1.2"))
  adsl <- get_ig("adam", version = "1.2", domain = "ADSL")
  expect_equal(unique(adsl$dataset), "ADSL")
  expect_equal(unique(adsl$version), "1.2")
})

test_that("get_ig aborts (classed) on an unknown domain, listing what is available", {
  e <- expect_error(get_ig("sdtm", domain = "ZZ"),
                    class = "cdiscdata_error_ig_domain_unavailable")
  expect_equal(conditionMessage(e),
               "Domain 'ZZ' is not available for standard 'sdtm'. Available: PP, SUPPQUAL.")
  e_v <- expect_error(get_ig("adam", version = "1.0", domain = "ZZ"),
                      class = "cdiscdata_error_ig_domain_unavailable")
  expect_equal(conditionMessage(e_v),
               "Domain 'ZZ' is not available for standard 'adam' at version '1.0'. Available: ADSL, BDS.")
})

test_that("get_ig reports 'none' when the version has no domain-bearing rows", {
  # SDTM Model rows have no domain, so a model version has no domains to list.
  e <- expect_error(get_ig("sdtm", version = "1.7", domain = "PP"),
                    class = "cdiscdata_error_ig_domain_unavailable")
  expect_equal(conditionMessage(e),
               "Domain 'PP' is not available for standard 'sdtm' at version '1.7'. Available: none.")
})
