#' punchOn
#'
#' @param path, string: path on which the projects ar efiled
#' @param client, string: client name
#' @param project, string: project name
#' @param category, string: category of work
#' @param notes, string: any notes you'd like to add
#'
#' @export
#'
#' @examples
#'
#' punchOn("~/practice", "RMiddling", "secondProject", "data analysis", "data was really awful")
#'
punchOn <- function(path, client, project, category, notes){
  time_file <- paste(path, client, "time_sheet.csv", sep = "/")
  if(!file.exists(time_file)){
    time_log <- data.frame("project" = project, "category" = category,
                                 "notes" = notes, "punch_on" = Sys.time(), "state" = "on")
  } else {
    time_log <- read.csv("time_sheet.csv", stringsAsFactors = FALSE)
    if (time_log[nrow(time_log), 5] == "on"){
      stop("You're already punched on for this client.")
    }
    punch <- c(project, category, notes, Sys.time(), "on")
    time_log <- rbind(time_log, punch)
  }
  write.csv(time_log, file = time_file)
}
