#' punchOn
#'
#' Record the time you spend on a project.
#'
#' punchOn will record the system time you started in the current working directory.
#' The time sheet will be located in the client directory and will record all
#' work for that client's projects. If the time sheet does not exist, it will create it.
#'
#' If you are *already* punched on, then you will be punched off and punched back on. This makes
#' it easy to switch *categories* without punching off first.
#'
#' Time sheet will be located in /project/project_documents/time_management.
#'
#' Note: this is tidy time sheet management. Each project can generate a timesheet,
#' but you can append them all to analyse your overall time management.
#' Output as a .csv, this is readable for those who may not be using R. You can read
#' it into R and calculate time spent etc. as required.
#'
#' @param name, string: person who is punching on for this project
#' @param category, string: category of work. Divide your work up into 'buckets'
#' so you can track what part of the project you were working on. E.g. 'data analysis',
#' 'modelling', 'write up', 'meeting'.
#' @param notes, string: any notes you'd like to add
#' @param project string: where is the project you are punching into
#'
#' @importFrom rprojroot find_root
#' @export
#'
#' @examples
#'
#' punchOn("Steph", "clean data", "it's a mess")
#'
punchOn <- function(name = NULL, category = NA, notes = NA, project = "."){

  document_dir <- findDocumentDirectory(project)

  current_project <- basename(dirname(normalizePath(document_dir)))

  file_name <- paste(name, "time_sheet.csv", sep = "_")
  time_file <- file.path(document_dir, "time_management", file_name)

  if (!dir.exists(file.path(document_dir, "time_management"))) {
    stop("The time management directory does not exist!\nYou need to run createProject first!")
  }

  if(!file.exists(time_file)){
    time_log <- data.frame("project" = current_project, "category" = category,
                                 "notes" = notes, "punch_on" = as.character(Sys.time(), usetz = FALSE),
                                  "punch_off" = NA, "state" = "on", stringsAsFactors = FALSE)
  } else {
    time_log <- utils::read.csv(time_file, stringsAsFactors = FALSE, sep = ",",
                                colClasses = rep("character", 6))
    if (time_log[nrow(time_log), "state"] == "on"){
      print("You're already punched on for this project")
      time_log[nrow(time_log), "state"] <- "off"
      time_log[nrow(time_log), "punch_off"] <- as.character(Sys.time(), usetz = FALSE)

    }
    punch <- c(current_project, category, notes, as.character(Sys.time(), usetz = FALSE), NA, "on")
    time_log <- rbind(time_log, punch)
  }
  utils::write.csv(time_log, file = time_file, row.names = FALSE)
}
