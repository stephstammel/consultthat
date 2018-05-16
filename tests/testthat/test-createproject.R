context("test-createproject")

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

                        # can use a different directory than the default
                        project_path <- file.path(create1, "otherDocs")
                        createProject(consult_path = project_path, documents_directory = "something_odd")
                        expect_true("something_odd" %in% dir(project_path, include.dirs = TRUE))

                        # we get the new .consultthat file present
                        expect_true(".consultthat" %in% dir(project_path, all.files = TRUE))

                        expect_true("DESCRIPTION" %in% dir(project_path, all.files = TRUE))
                        # don't call usethis::create_package
                        project_path <- file.path(create1, "noPkg")
                        createProject(consult_path = project_path, use_package = FALSE)
                        expect_equal(length(dir(project_path)), 1)

                        })
})

