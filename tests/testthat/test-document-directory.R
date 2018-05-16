context("test-document-directory")

test_dir <- file.path(rprojroot::find_root("DESCRIPTION"), "tests", "testthat")

test_that("get correct returns / errors", {
  expect_equal(basename(findDocumentDirectory(project = file.path(test_dir, "has_consultthat"))), "something_odd")

  expect_equal(basename(findDocumentDirectory(project = file.path(test_dir, "no_consultthat"))), "project_documents")

  expect_error(findDocumentDirectory(test_dir), "Can't find either .consultthat or default directory project_documents, is project really a consultthat project?")
})
