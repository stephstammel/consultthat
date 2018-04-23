#' people()
#'
#' Return the log of personnel for the current client as a data frame. If no
#' log of personnel exists, NULL will be returned and also congratulations you're either
#' really early in this project or have a great memory. Possibly both.
#' @param path, path where client directory is located.
#' @param client, client you wish to return personnel log for.
#' @return people, a data frame.
#' @export
#'
#' @examples
#'
#' people()
#'
people <- function(path, client){
  requireNamespace("utils")

  people_file <- paste(path, client, "personnel_log.csv", sep = "/")
  if(!file.exists(people_file)){
    people_log <- NULL
    stop("No people exist in this project yet. That's a surprise ;)")
  } else {
    people_log <- utils::read.csv(people_file, stringsAsFactors = FALSE)
    people_log <- as.data.frame(people_log)
  }

  return(people_log)
}
