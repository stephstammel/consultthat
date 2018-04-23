#' closeIssue
#'
#' Close an issue you've previously logged.
#' Add notes on how you closed it for future reference.
#'
#' @param user, string: the person who closed the issue.
#' @param ID, string: the ID of the issue you want to close.
#' @param notes, string: any closing notes you want to add to the issue.
#'
#' @export
#'
#' @examples
#'
#' closeIssue("Steph", "stupid bug 3", "Used bug tracker. It was awesome.")
#'
closeIssue <- function(user, ID, notes = NA){
  current_project <- getwd()
  issue_file <- paste(current_project, "project_documents", "planning",
                      "issues.csv", sep = "/")
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
