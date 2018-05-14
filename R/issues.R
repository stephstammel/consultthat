#' issues()
#'
#' Return the log of issues for the current project as a data frame. If no
#' log of issues exists, NULL will be returned and also congratulations you're either
#' really early in this project of amazing. Possibly both.
#'
#' @param project string: the project to return issues for
#' @return issues, a data frame.
#' @export
#'
#' @examples
#'
#' issues()
#'
issues <- function(project = "."){

  document_directory <- findDocumentDirectory(project)

  current_project <- basename(dirname(normalizePath(document_dir)))

  issue_file <- file.path(document_directory, "planning", "issues.csv")
  if(!file.exists(issue_file)){
    issue_log <- NULL
    stop("No issues exist yet. You probably aren't looking hard enough ;)")
  } else {
    issue_log <- utils::read.csv(issue_file, stringsAsFactors = FALSE)
  }
  return(issue_log)
}
