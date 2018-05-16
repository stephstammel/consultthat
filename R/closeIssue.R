#' closeIssue
#'
#' Close an issue you've previously logged.
#' Add notes on how you closed it for future reference.
#'
#' @param user string: the person who closed the issue.
#' @param ID string: the ID of the issue you want to close.
#' @param notes string: any closing notes you want to add to the issue.
#' @param project string: the project location
#'
#' @export
#'
#'
closeIssue <- function(user, ID, notes = NA, project = "."){

  document_directory <- findDocumentDirectory(project)
  current_project <- basename(dirname(normalizePath(document_directory)))
  issue_file <- file.path(document_directory, "planning",
                      "issues.csv")
  if(!file.exists(issue_file)){
    stop("You don't have any issues logged for this project.")
  } else {

    issue_log <- utils::read.csv(issue_file, stringsAsFactors = FALSE)
    issue_log[which(issue_log[,1] == ID),6] = "closed"
    issue_log[which(issue_log[,1] == ID),7] = notes
    issue_log[which(issue_log[,1] == ID),8] = user

    utils::write.csv(issue_log, file = issue_file, row.names = FALSE)
  }
}
