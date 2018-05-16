#' punchOff
#'
#' Record when you finished working on a project, with notes.
#' To be used in conjunction with punchOn().
#' Time sheet will be located in /project/project_documents/time_management.
#'
#' @param name string: person punching off
#' @param category string: category of work. Divide your work up into 'buckets'
#' so you can track what part of the project you were working on. E.g. 'data analysis',
#' 'modelling', 'write up', 'meeting'. Need to match category assigned at punchOn().
#' @param notes string: any notes you'd like to add
#' @param project string: the path to the project to punch off, default is "."
#'
#' @return NULL, writes to the time-log csv file
#' @export
#'
#' @examples
#' punchOff("Steph", "factorisation", "Completed.")
#'
punchOff <- function(name, category = NA, notes = NA, project = "."){

  document_dir <- findDocumentDirectory(project)

  file_name <- paste(name, "time_sheet.csv", sep = "_")
  time_file <- paste(document_dir, "time_management", file_name, sep = "/")

  if(!file.exists(time_file)){
    stop("No timesheet exists for this project/person.
         You can't punch off when you never punched on :)")
  } else {
    time_log <- utils::read.csv(time_file, stringsAsFactors = FALSE, sep = ",",
                                colClasses = rep("character", 6))

    if (time_log[nrow(time_log), 6] == "off"){
      stop("You're already punched off for this client.")
    }
    time_log[nrow(time_log), 5] <- as.character(Sys.time(), usetz = FALSE)
    time_log[nrow(time_log), 6] <- "off"

  }
  utils::write.csv(time_log, file = time_file, row.names = FALSE)
}
