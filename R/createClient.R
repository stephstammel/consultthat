#' createClient
#'
#' One way to organise your projects is by client. Consultthat works this way.
#' This function creates a new client.
#'
#' @param name, string: name of client.
#' @param path, string: path where you want to put the client directory
#' @export
#'
#' @examples
#' createClient("RStars", "~/practice")
#'
createClient <- function(name, path){

  path_client <- paste(path, name, sep = "/")
  if (dir.exists(path_client)){
    stop("this client already exists! Go you!")
  }
  dir.create(path_client)
}
