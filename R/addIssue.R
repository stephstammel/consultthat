#' addIssue
#'
#' A simple way to keep track of issues you want to follow up. Add an issue,
#' it will be added to a .csv which is accessible to non-R users. If no issue
#' tracker for this project exists, one will be created.
#'
#' @param ID string: choose an ID that you will use to close the issue or make changes to it.
#' Can be numeric if you wish, or text based. E.g. "00001" or "that damn bug".
#' @param category string: you can choose a category to file it under for later reference
#' and analysis.
#' @param notes string: it's often worthwile to add some notes to help you when you
#' pick up the project again. This might be a brief run down of what the problem is,
#' or it could be a helpful way to store and file useful links, tips etc.
#' @param user string: who added this issue?
#' @param project string: which project to add the issue to?
#'
#' @export
#'
#'
#'
addIssue <- function(ID, user, category = NA, notes = NA, project = "."){

  document_directory <- findDocumentDirectory(project)

  current_project <- basename(dirname(normalizePath(document_directory)))

  issue_file <- file.path(document_directory, "planning", "issues.csv")
  if(!file.exists(issue_file)){
    issue_log <- data.frame("ID" = ID, "project" = current_project, "added_by" = user, "category" = category,
                           "opening notes" = notes, "state" = "open", "closing notes" = NA, "closed_by" = NA)
  } else {
    issue_log <- utils::read.csv(issue_file, stringsAsFactors = FALSE)

    issue <- c(ID, current_project, user, category, notes, "open", NA, NA)
    issue_log <- rbind(issue_log, issue)
  }
  utils::write.csv(issue_log, file = issue_file, row.names = FALSE)

}
