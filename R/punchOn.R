#' punchOn
#'
#' Record the time you spend on a project.
#'
#' punchOn will record the system time you started in the current working directory.
#' The time sheet will be located in the client directory and will record all
#' work for that client's projects. If the time sheet does not exist, it will create it.
#'
#' Time sheet will be located in /project/project_documents/time_management.
#'
#' Note: this is tidy time sheet management. Each project can generate a timesheet,
#' but you can append them all to analyse your overall time management.
#' Output as a .csv, this is readable for those who may not be using R. You can read
#' it into R and calculate time spent etc. as required.
#'
#' @param category, string: category of work. Divide your work up into 'buckets'
#' so you can track what part of the project you were working on. E.g. 'data analysis',
#' 'modelling', 'write up', 'meeting'.
#' @param notes, string: any notes you'd like to add
#'
#' @export
#'
#' @examples
#'
#' punchOn("~/practice", "RMiddling", "secondProject", "data analysis", "data was really awful")
#'
punchOn <- function(category, notes){
  current_project <- getwd()
  time_file <- paste(current_project, "project_documents", "time_management", "time_sheet.csv", sep = "/")

  if(!file.exists(time_file)){
    time_log <- data.frame("project" = current_project, "category" = category,
                                 "notes" = notes, "punch_on" = Sys.time(),
                                  "punch_off" = NA, "state" = "on")
  } else {
    time_log <- read.csv(time_file, stringsAsFactors = FALSE)
    if (time_log[nrow(time_log), 6] == "on"){
      print("You're already punched on for this project")
      time_log[nrow(time_log), 6] <- "off"
      time_log[nrow(time_log), 5] <- Sys.time()
    }
    punch <- c(current_project, category, notes, Sys.time(), NA, "on")
    time_log <- rbind(time_log, punch)
  }
  write.csv(time_log, file = time_file, row.names = FALSE)
}
