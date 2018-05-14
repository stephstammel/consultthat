context("test-createproject")

test_project_loc <- file.path(rprojroot::find_root("DESCRIPTION"), "tests", "testthat")

test_that("can create projects properly", {
  withr::with_tempfile("create1",
                       {
                        dir.create(create1, recursive = TRUE)
                        project_path <- file.path(create1, "fullProject")
                        createProject(consult_path = project_path)
                        expect_equal_to_reference(dir(project_path, recursive = TRUE, include.dirs = TRUE), "full_files")

                        project_path <- file.path(create1, "timeOnly")
                        createProject(consult_path = project_path)
                        expect_equal_to_reference(dir(project_path, recursive = TRUE, include.dirs = TRUE), "time_files")
                        })
})

