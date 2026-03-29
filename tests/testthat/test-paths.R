test_that("schema_path returns existing file for 2.1", {
  path <- schema_path("2.1")
  expect_true(file.exists(path))
  expect_true(endsWith(path, ".xsd"))
})

test_that("schema_path returns existing file for 2.0", {
  path <- schema_path("2.0")
  expect_true(file.exists(path))
  expect_true(endsWith(path, ".xsd"))
})

test_that("schema files are valid XML", {
  skip_if_not_installed("xml2")
  expect_no_error(xml2::read_xml(schema_path("2.1")))
  expect_no_error(xml2::read_xml(schema_path("2.0")))
})

test_that("stylesheet_path returns existing file for 2.1", {
  path <- stylesheet_path("2.1")
  expect_true(file.exists(path))
  expect_true(endsWith(path, ".xsl"))
})

test_that("stylesheet_path returns existing file for 2.0", {
  path <- stylesheet_path("2.0")
  expect_true(file.exists(path))
  expect_true(endsWith(path, ".xsl"))
})

test_that("schema_path rejects invalid version", {
  expect_error(schema_path("3.0"))
})

test_that("schema_path and stylesheet_path return different files for same version", {
  expect_false(identical(schema_path("2.1"), stylesheet_path("2.1")))
})

test_that("schema_path errors when installed file cannot be found", {
  local_mocked_bindings(.sys_file = function(...) "", .package = "cdiscdata")
  expect_error(schema_path("2.1"), "not found in package")
})

test_that("stylesheet_path errors when installed file cannot be found", {
  local_mocked_bindings(.sys_file = function(...) "", .package = "cdiscdata")
  expect_error(stylesheet_path("2.1"), "not found in package")
})
