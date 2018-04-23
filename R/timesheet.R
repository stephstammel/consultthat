#' timesheet
#'
#' Return the timesheet for the current project as a data frame.
#' If no timesheet exists for this project because you have not punchedIn,
#' NULL will be returned instead.
#'
#' @param name, person you'd like to return a timesheet for
#' @return timesheet, a data frame.
#' @export
#'
#' @examples
#' timesheet("Gary")
#'
timesheet <- function(name){

  current_project <- getwd()
  file_name <- paste(name, "time_sheet.csv", sep = "_")
  time_file <- paste(current_project, "project_documents", "time_management", file_name, sep = "/")

  if(!file.exists(time_file)){
    time_log <- NULL
    stop("No timesheet exists for this project/person. Please punch on.")
  } else {
    time_log <- utils::read.csv(time_file, stringsAsFactors = FALSE)
    time_log <- as.data.frame(time_log)
  }
  return(time_log)
}
