#' issues()
#'
#' Return the log of issues for the current project as a data frame. If no
#' log of issues exists, NULL will be returned and also congratulations you're either
#' really early in this project of amazing. Possibly both.
#'
#' @return issues, a data frame.
#' @export
#'
#' @examples
#'
#' issues()
#'
issues <- function(){
  requireNamespace("utils")
  current_project <- getwd()
  issue_file <- paste(current_project, "project_documents", "planning", "issues.csv", sep = "/")
  if(!file.exists(issue_file)){
    issue_log <- NULL
    stop("No issues exist yet. You probably aren't looking hard enough ;)")
  } else {
    issue_log <- read.csv(issue_file, stringsAsFactors = FALSE)
    issue_log <- as.data.frame(issue_log)
  }
  return(issue_log)
}
