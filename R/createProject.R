#' createProject
#'
#' Create a package structure for a new consulting project. This builds on the
#' normal package structure and provides subdirectories for data, outputs (client
#' facing and internal), meetings etc.
#'
#' @param consult_path, string: path that consulting projects lie on
#' @param client, string: name of client
#' @param project_name, string: name of project
#'

#' @export
#'
#' @examples
#'
#'
#'
#'
createProject <- function(consult_path, client, project_name){
  project_path <- paste(consult_path, client, project_name, sep = "/")
  if (!dir.exists(project_path)){
    stop("this project already exists! Go you!")
  }
  create_package(project_path)
  # create subdirectory for meetings
  meeting_path <- paste(project_path, "meeting", sep = "/")
  dir.create(meeting_path)
  # create subdirectory for outputs
  output_path <- paste(project_path, "outputs", sep = "/")
  dir.create(output_path)
  # create subdirectory for data
  data_path <- paste(project_path, "data", sep = "/")
  dir.create(data_path)
  # create sub-subdirectory internal documents
  internal_path <- paste(project_path, "outputs", "internal", sep = "/")
  dir.create(internal_path)
  # create sub-subdirectory client-facing documents
  client_facing_path <- paste(project_path, "outputs", "client_facing", sep = "/")
  dir.create(client_facing_path)
  # create sub-subdirectory for data documentation
  data_doc_path <- paste(project_path, "data", "documentation", sep = "/")
  dir.create(data_doc_path)
}
