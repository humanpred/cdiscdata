parse_ig <- cdiscdata:::.parse_ig_version

test_that("the parser turns each of the 34 export Version strings into one standard and version", {
  got <- parse_ig(ig_version_strings)
  expect_equal(
    got$standard,
    c(rep("SDTM", 9L), rep("SDTMIG", 5L), "SDTMIG-AP", "SDTMIG-MD", "SDTMIG-MD",
      rep("SENDIG", 3L), "SENDIG-AR", "SENDIG-DART", "SENDIG-GeneTox",
      rep("ADaMIG", 4L), "ADaMIG-MD", "ADaMIG-NCA", "ADaM-ADAE", "ADaM-BDS-TTE",
      "ADaM-OCCDS", "ADaM-OCCDS", "ADaM-popPK")
  )
  expect_equal(
    got$version,
    c("1.2", "1.3", "1.4", "1.5", "1.6", "1.7", "1.8", "2.0", "2.1",
      "3.1.2", "3.1.3", "3.2", "3.3", "3.4", "1.0", "1.0", "1.1",
      "3.0", "3.1", "3.1.1", "1.0", "1.1", "1.0",
      "1.0", "1.1", "1.2", "1.3", "1.0", "1.0", "1.0", "1.0", "1.0", "1.1", "1.0")
  )
  expect_equal(nrow(got), 34L)
  expect_false(anyDuplicated(paste(got$standard, got$version)) > 0L)
})

test_that("the parser handles the spaced names the exports use, mapping them to hyphenated standards", {
  expect_equal(parse_ig("ADaMIG MD v1.0"), data.frame(standard = "ADaMIG-MD", version = "1.0"))
  expect_equal(parse_ig("ADaM BDS for TTE v1.0"),
               data.frame(standard = "ADaM-BDS-TTE", version = "1.0"))
  expect_equal(parse_ig("SDTMIG-MD v1.1"), data.frame(standard = "SDTMIG-MD", version = "1.1"))
  expect_equal(parse_ig("SDTMIG v3.1.2"), data.frame(standard = "SDTMIG", version = "3.1.2"))
})

test_that("every raw standard name maps to a distinct canonical name, and to one table", {
  std <- cdiscdata:::.ig_standards
  expect_equal(nrow(std), 15L)
  expect_false(anyDuplicated(std$raw) > 0L)
  expect_false(anyDuplicated(std$standard) > 0L)
  expect_equal(std$table[std$standard == "SDTM"], "model_sdtm")
  expect_equal(sum(std$table == "ig_sdtm"), 7L)
  expect_equal(sum(std$table == "ig_adam"), 7L)
})

test_that("an unparseable Version string is a classed error naming it, never a guess", {
  e <- expect_error(parse_ig("SDTMIG 3.4"), class = "cdiscdata_error_ig_version_unparsable")
  expect_match(conditionMessage(e), "Cannot parse IG version string(s): 'SDTMIG 3.4'.", fixed = TRUE)
  expect_error(parse_ig("FOO v1.0"), class = "cdiscdata_error_ig_version_unparsable")
  expect_error(parse_ig("SDTMIG v3."), class = "cdiscdata_error_ig_version_unparsable")
  expect_error(parse_ig(NA_character_), class = "cdiscdata_error_ig_version_unparsable")
  # only the bad ones are listed
  e2 <- expect_error(parse_ig(c("SDTMIG v3.4", "BAD", "ADaMIG v1.3", "WORSE v2")),
                     class = "cdiscdata_error_ig_version_unparsable")
  expect_match(conditionMessage(e2), "'BAD', 'WORSE v2'", fixed = TRUE)
  expect_false(grepl("'SDTMIG v3.4'", conditionMessage(e2), fixed = TRUE))
})

test_that("version resolution picks the newest numerically and lists versions in numeric order", {
  resolve <- cdiscdata:::.resolve_ig_version
  expect_equal(resolve(NULL, c("3.1.3", "3.2", "3.1.2"), "SDTMIG"), "3.2")
  expect_equal(resolve(NULL, c("1.9", "1.10", "1.2"), "X"), "1.10")
  expect_equal(resolve("3.1.2", c("3.1.3", "3.2", "3.1.2"), "SDTMIG"), "3.1.2")
  e <- expect_error(resolve("9.9", c("3.2", "3.1.3", "3.1.2"), "SDTMIG"),
                    class = "cdiscdata_error_ig_version_unavailable")
  expect_equal(conditionMessage(e),
               "Version '9.9' is not available for SDTMIG. Available versions: 3.1.2, 3.1.3, 3.2.")
})
