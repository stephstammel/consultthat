#' addPersonnel
#'
#' Keeping track of who's working on your project with you can be really hard.
#' Take notes! Make a personnel log.
#' If the log has not been initialised, this function will create one.
#' You can add new people to the log as you meet them.
#' Currently, any edits to the file need to be manually made.
#' The file is held as a csv so non-R users on your project can access it without
#' R.
#'
#' @param consult_path , string: path the consulting files are found on
#' @param client , string: name of the client
#' @param name , string: name of personnel to be added to the log
#' @param contact_details , string: contact details of the person
#' @param projects,  string: project(s) the person works on
#' @param notes , string: notes about the person, e.g. concerns they may
#' have about the project, something they need.
#'
#' @export
#'
#' @examples
#'
#' addPersonnel("~/practice", "RStars", "Jenny Bryan", "123 Fantastic Lane",
#'               "usethis", "is really awesome")
#'
#'
addPersonnel <- function(consult_path, client, name, contact_details,
                         projects, notes){

  client_file <- paste(consult_path, client, "personnel_log.csv", sep = "/")
  if(!file.exists(client_file)){
    personnel_log <- data.frame("name" = name, "contact_details" = contact_details,
                                "projects" = projects, "notes" = notes)
  } else {

    personnel_log <- utils::read.csv(client_file, stringsAsFactors = FALSE)
    person <- c(name, contact_details, projects, notes)
    if(person[1] %in% personnel_log[,1]){
      stop("this person is already in the file. Do you need to change an entry? :)")
    }
    personnel_log <- rbind(personnel_log, person)
  }

  utils::write.csv(personnel_log, file = client_file, row.names = FALSE)

}
