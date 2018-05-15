context("test-timekeeping")

test_that("timekeeping works", {
  withr::with_tempfile("timekeeping",
                       {
                         dir.create(timekeeping, recursive = TRUE)
                         project_path <- file.path(timekeeping, "time1")
                         createProject(consult_path = project_path, project_documents = "time", use_package = FALSE)

                         punchOn("Robert", project = project_path)
                         Sys.sleep(2)
                         punchOff("Robert", project = project_path)

                         punchOn("Robert", project = project_path)
                         Sys.sleep(1)
                         punchOff("Robert", project = project_path)

                         times <- timesheet("Robert", project_path)

                         expect_equal(nrow(times), 2)

                         expect_is(as.POSIXct(times$punch_on), "POSIXct")

                         time_diffs <- as.numeric(difftime(as.POSIXct(times$punch_off), as.POSIXct(times$punch_on)))
                         expect_equal(time_diffs, c(2, 1))
                       })

})
