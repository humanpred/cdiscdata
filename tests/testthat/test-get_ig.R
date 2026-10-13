test_that("get_ig() defaults to the newest SDTMIG (3.4), all 63 of its domains", {
  x <- get_ig()
  expect_equal(unique(x$standard), "SDTMIG")
  expect_equal(unique(x$version), "3.4")
  expect_equal(nrow(x), 1917L)
  expect_equal(length(unique(x$domain)), 63L)
  expect_s3_class(x, "data.frame")
  expect_equal(names(x), names(get_dataset("ig_sdtm")))
})

test_that("the pre-redesign names 'sdtm' and 'adam' are kept as aliases for SDTMIG and ADaMIG", {
  expect_identical(get_ig("sdtm"), get_ig("SDTMIG"))
  expect_identical(get_ig("adam"), get_ig("ADaMIG"))
  expect_equal(unique(get_ig("adam")$version), "1.3")
  # capital SDTM is the model, not the IG
  expect_equal(unique(get_ig("SDTM")$standard), "SDTM")
  expect_equal(unique(get_ig("SDTM")$version), "2.1")
})

test_that("each standard's default version is its newest, compared numerically", {
  src <- ig_standard_sources()
  for (std in unique(src$standard)) {
    v <- src$version[src$standard == std]
    newest <- v[order(package_version(v))][length(v)]
    expect_equal(unique(get_ig(std)$version), newest, label = paste("default version of", std))
  }
  expect_equal(unique(get_ig("SDTMIG", version = "3.1.3")$version), "3.1.3")
  expect_equal(unique(get_ig("SENDIG")$version), "3.1.1")
})

test_that("get_ig reaches every one of the 15 standards, and only that standard's rows", {
  src <- ig_standard_sources()
  for (i in seq_len(nrow(src))) {
    x <- get_ig(src$standard[i], version = src$version[i])
    expect_equal(nrow(x), src$rows[i], label = paste(src$standard[i], src$version[i]))
    expect_true(all(x$standard == src$standard[i] & x$version == src$version[i]))
  }
})

test_that("get_ig aborts (classed) on an unknown standard, version, or a malformed standard", {
  e <- expect_error(get_ig("FOO"), class = "cdiscdata_error_ig_standard_unavailable")
  expect_equal(
    conditionMessage(e),
    paste0("Standard 'FOO' is not available. Available standards: ",
           "SDTM, SDTMIG, SDTMIG-AP, SDTMIG-MD, SENDIG, SENDIG-AR, SENDIG-DART, ",
           "SENDIG-GeneTox, ADaMIG, ADaMIG-MD, ADaMIG-NCA, ADaM-ADAE, ADaM-BDS-TTE, ",
           "ADaM-OCCDS, ADaM-popPK.")
  )
  expect_error(get_ig(c("SDTMIG", "SENDIG")), class = "cdiscdata_error_ig_standard_unavailable")
  expect_error(get_ig(NA_character_), class = "cdiscdata_error_ig_standard_unavailable")
  expect_error(get_ig(3L), class = "cdiscdata_error_ig_standard_unavailable")

  ev <- expect_error(get_ig("SDTMIG", version = "9.9"),
                     class = "cdiscdata_error_ig_version_unavailable")
  expect_equal(conditionMessage(ev),
               "Version '9.9' is not available for SDTMIG. Available versions: 3.1.2, 3.1.3, 3.2, 3.3, 3.4.")
  expect_error(get_ig("ADaMIG-NCA", version = "2.0"),
               class = "cdiscdata_error_ig_version_unavailable")
})

test_that("SDTMIG PP grows 19, 19, 21, 24, 26 variables across 3.1.2 to 3.4 as the Library publishes it", {
  n <- vapply(c("3.1.2", "3.1.3", "3.2", "3.3", "3.4"),
              function(v) nrow(get_ig("SDTMIG", v, "PP")), integer(1L))
  expect_equal(unname(n), c(19L, 19L, 21L, 24L, 26L))

  v32 <- get_ig("SDTMIG", "3.2", "PP")$variable
  v33 <- get_ig("SDTMIG", "3.3", "PP")$variable
  v34 <- get_ig("SDTMIG", "3.4", "PP")$variable
  expect_equal(setdiff(v33, v32), c("TAETORD", "EPOCH", "PPDY"))
  expect_equal(setdiff(v34, v33), c("PPANMETH", "PPTPTREF"))
  expect_equal(v34,
               c("STUDYID", "DOMAIN", "USUBJID", "PPSEQ", "PPGRPID", "PPTESTCD",
                 "PPTEST", "PPCAT", "PPSCAT", "PPORRES", "PPORRESU", "PPSTRESC",
                 "PPSTRESN", "PPSTRESU", "PPSTAT", "PPREASND", "PPSPEC",
                 "PPANMETH", "TAETORD", "EPOCH", "PPDTC", "PPDY", "PPTPTREF",
                 "PPRFTDTC", "PPSTINT", "PPENINT"))
  for (v in c("3.1.2", "3.1.3", "3.2", "3.3", "3.4")) {
    pp <- get_ig("SDTMIG", v, "PP")$variable
    expect_equal(intersect(c("PPPDTC", "PPPDY", "PTAETORD"), pp), character(0L))
  }
})

test_that("the SDTMIG 3.4 PP rows carry the published label, type, role, core, and codelist", {
  pp <- get_ig("SDTMIG", "3.4", "PP")
  row <- function(v) pp[pp$variable == v, ]
  expect_equal(row("PPANMETH")$label, "Analysis Method")
  expect_equal(row("PPANMETH")$codelist_code, "C172330")
  expect_equal(row("PPANMETH")$core, "Perm")
  expect_equal(row("PPTPTREF")$label, "Time Point Reference")
  expect_equal(row("PPTESTCD")$codelist_code, "C85839")
  expect_equal(row("PPTESTCD")$role, "Topic")
  expect_equal(row("PPTESTCD")$core, "Req")
  expect_equal(row("PPORRESU")$codelist_code, "C85494; C128684; C128683; C128685; C128686")
  expect_equal(row("PPSTRESC")$label, "Character Result/Finding in Std Format")
  expect_equal(pp$order, 1:26)
  expect_true(all(pp$class == "Findings"))
})

test_that("SUPP-- is the same ten variables in every SDTMIG version", {
  for (v in c("3.1.2", "3.1.3", "3.2", "3.3", "3.4")) {
    expect_equal(get_ig("SDTMIG", v, "SUPPQUAL")$variable,
                 c("STUDYID", "RDOMAIN", "USUBJID", "IDVAR", "IDVARVAL", "QNAM",
                   "QLABEL", "QVAL", "QORIG", "QEVAL"),
                 label = paste("SUPPQUAL at", v))
  }
})

test_that("SENDIG defines PP too, at 23, 25, and 25 variables", {
  expect_equal(c(nrow(get_ig("SENDIG", "3.0", "PP")), nrow(get_ig("SENDIG", "3.1", "PP")),
                 nrow(get_ig("SENDIG", "3.1.1", "PP"))), c(23L, 25L, 25L))
  expect_true(all(get_ig("SENDIG", domain = "PP")$standard == "SENDIG"))
})

test_that("get_ig(domain =) filters, and an unknown domain is a classed error listing what exists", {
  e <- expect_error(get_ig("SDTMIG", domain = "ZZ"),
                    class = "cdiscdata_error_ig_domain_unavailable")
  avail <- sort(unique(get_ig("SDTMIG")$domain))
  expect_equal(length(avail), 63L)
  expect_equal(conditionMessage(e),
               paste0("Domain 'ZZ' is not available for standard 'SDTMIG' at version '3.4'. Available: ",
                      paste(avail, collapse = ", "), "."))
  e2 <- expect_error(get_ig("SDTMIG", "3.2", domain = c("PP", "AE", "ZZ", "YY")),
                     class = "cdiscdata_error_ig_domain_unavailable")
  expect_match(conditionMessage(e2), "Domain 'ZZ', 'YY' is not available", fixed = TRUE)
  both <- get_ig("SDTMIG", "3.4", domain = c("PP", "PC"))
  expect_setequal(unique(both$domain), c("PP", "PC"))
})

test_that("ADaM structures are reachable by name and by the BDS and ADSL aliases", {
  expect_equal(nrow(get_ig("ADaMIG", "1.3", "BDS")), 195L)
  expect_equal(nrow(get_ig("ADaMIG", "1.3", "ADSL")), 141L)
  expect_identical(get_ig("ADaMIG", "1.3", "BDS"),
                   get_ig("ADaMIG", "1.3", "Basic Data Structure"))
  expect_identical(get_ig("ADaMIG", "1.3", "ADSL"),
                   get_ig("ADaMIG", "1.3", "Subject-Level Analysis Dataset"))
  expect_equal(nrow(get_ig("ADaMIG", "1.3", c("BDS", "ADSL"))), 336L)
  expect_equal(nrow(get_ig("ADaMIG-NCA")), 59L)
  expect_equal(unique(get_ig("ADaMIG-NCA")$structure),
               "Basic Data Structure Non-Compartmental Analysis")
  e <- expect_error(get_ig("ADaMIG", "1.0", "OCCDS"),
                    class = "cdiscdata_error_ig_domain_unavailable")
  expect_equal(conditionMessage(e),
               paste0("Domain 'OCCDS' is not available for standard 'ADaMIG' at version '1.0'. ",
                      "Available: Basic Data Structure, Subject-Level Analysis Dataset."))
})

test_that("ADaM-OCCDS keeps both DECDORGw definitions, one per dictionary variable set", {
  occ <- get_ig("ADaM-OCCDS", "1.1")
  d <- occ[occ$variable == "DECDORGw", ]
  expect_equal(nrow(d), 4L)
  expect_equal(sort(unique(d$label)),
               c("PT in Original Dictionary w", "Standardized Med Name in Orig Dict w"))
})

test_that("the SDTM model is reachable by class or dataset, with the 2.0 and later fields only from 2.0", {
  expect_equal(nrow(get_ig("SDTM", "1.2", "Findings")), 37L)
  expect_equal(nrow(get_ig("SDTM", "2.1", "DM")), 38L)
  expect_true(all(is.na(get_ig("SDTM", "1.7")$variable_code)))
  expect_true(any(!is.na(get_ig("SDTM", "2.1")$variable_code)))
  expect_true(all(is.na(get_ig("SDTM", "1.7")$usage_restrictions)))
  expect_true(any(!is.na(get_ig("SDTM", "2.1")$usage_restrictions)))
  e <- expect_error(get_ig("SDTM", domain = "ZZ"), class = "cdiscdata_error_ig_domain_unavailable")
  expect_match(conditionMessage(e),
               "Domain 'ZZ' is not available for standard 'SDTM' at version '2.1'. Available: AC, ",
               fixed = TRUE)
})
