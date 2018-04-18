#' punchOff
#'
#' Record when you finished working on a project, with notes.
#' To be used in conjunction with punchOn().
#' Time sheet will be located in /project/project_documents/time_management.
#'
#' @param category, string: category of work. Divide your work up into 'buckets'
#' so you can track what part of the project you were working on. E.g. 'data analysis',
#' 'modelling', 'write up', 'meeting'. Need to match category assigned at punchOn().
#' @param notes, string: any notes you'd like to add
#'
#' @return
#' @export
#'
#' @examples
punchOff <- function(category, notes){
  current_project <- getwd()
  time_file <- paste(current_project, "project_documents", "time_management", "time_sheet.csv", sep = "/")

  if(!file.exists(time_file)){
    stop("No timesheet exists for this project. You can't punch off when you never punched on :)")
  } else {
    time_log <- read.csv(time_file, stringsAsFactors = FALSE)
    if (time_log[nrow(time_log), 6] == "off"){
      stop("You're already punched off for this client.")
    }
    time_log[nrow(time_log), 5] <- Sys.time()
    time_log[nrow(time_log), 6] <- "off"
  }
  write.csv(time_log, file = time_file, row.names = FALSE)
}
