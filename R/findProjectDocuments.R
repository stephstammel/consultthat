#' findDocumentDirectory
#'
#' Given a `consultthat` project path, attempts to find the location of the
#' project documents sub-directory.
#'
#' @param project string: the project directory, default is "."
#'
#' @importFrom rprojroot find_root
#' @export
#'
#' @return the sub-directory as a string
#'
findDocumentDirectory <- function(project = "."){
  root_dir <- try(rprojroot::find_root(".consultthat", path = project), silent = TRUE)

  if (inherits(root_dir, "try-error")) {
    root_dir <- try(rprojroot::find_root("project_documents", path = project), silent = TRUE)

    if (inherits(root_dir, "try-error")) {
      stop("Can't find either .consultthat or default directory project_documents, is project really a consultthat project?")
    } else {
      document_directory <- file.path(root_dir, "project_documents")
    }
  } else {
    document_directory <- file.path(root_dir, scan(file.path(root_dir, ".consultthat"), what = "character", sep = "\n", quiet = TRUE))
  }

  document_directory

}
