#' timesheet
#'
#' Return the timesheet for the current project as a data frame.
#' If no timesheet exists for this project because you have not punchedIn,
#' NULL will be returned instead.
#'
#' @return timesheet, a data frame.
#' @export
#'
#' @examples
#' timesheet()
#'
timesheet <- function(){
  requireNamespace("utils")
  current_project <- getwd()
  time_file <- paste(current_project, "project_documents", "time_management", "time_sheet.csv", sep = "/")
  if(!file.exists(time_file)){
    time_log <- NULL
    stop("No timesheet exists for this project. Please punch on.")
  } else {
    time_log <- read.csv(time_file, stringsAsFactors = FALSE)
    time_log <- as.data.frame(time_log)
  }
  return(time_log)
}
