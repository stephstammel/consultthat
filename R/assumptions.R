#' assumptions
#'
#' Find out which assumptions you and your team have logged about this project
#'
#' @return assumptions, a dataframe listing, well, assumptions.
#' @export
#'
#' @examples
#'
#' assumptions()
#'
assumptions <- function(){
  document_dir <- findDocumentDirectory(project)

  file_name <- "initial_assumptions.csv"
  assumption_file <- file.path(document_dir, "project_initiation", file_name)

  returned_assumptions <- utils::read.csv(time_file, stringsAsFactors = FALSE,
                                          sep = ",", colClasses = rep("character", 4))
  return(returned_assumptions)
}
