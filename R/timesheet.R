#' timesheet
#'
#' Return the timesheet for the current project as a data frame.
#' If no timesheet exists for this project because you have not punchedIn,
#' NULL will be returned instead.
#'
#' @param name, person you'd like to return a timesheet for
#' @param project the project you want the timesheet for
#'
#' @return timesheet, a data frame.
#' @export
#'
#' @examples
#' timesheet("Gary")
#'
timesheet <- function(name, project = "."){

  document_directory <- findDocumentDirectory(project)
  file_name <- paste(name, "time_sheet.csv", sep = "_")
  time_file <- file.path(document_directory, "time_management", file_name)

  if(!file.exists(time_file)){
    time_log <- NULL
    stop("No timesheet exists for this project/person. Please punch on.")
  } else {
    time_log <- utils::read.table(time_file, header = TRUE, stringsAsFactors = FALSE, sep = ",")
  }
  return(time_log)
}
