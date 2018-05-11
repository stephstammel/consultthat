#' createProject
#'
#' Create a package structure for a new consulting project. This builds on the
#' normal package structure and provides subdirectories for data, outputs (client
#' facing and internal), meetings etc.
#'
#' @param consult_path, string: path that consulting projects lie on, OR full path to directory
#' @param client, string: name of client
#' @param project_name, string: name of project
#' @param overwrite_project_documents logical: should existing project_documents directories be overwritten?
#' @param project_documents string: the consulting project documents you want in this project, see Details
#'
#' @importFrom usethis create_package
#' @export
#'
#' @examples
#' createProject("~/practice", "RStars", "firstProject")
#'
#'
#'
#'
createProject <- function(consult_path = ".", client = NULL, project_name = NULL,
                          overwrite_project_documents = FALSE,
                          project_documents = c("meetings", "documents", "initiation",
                                               "financials", "time", "planning",
                                               "milestones", "outputs", "data", "documentation")){

  project_directories <- list(meetings = "meetings",
                              documents = c("client_side", "company_side"),
                              initiation = "initiation",
                              financials = file.path("financials", c("invoices_payable", "invoices_receivable")),
                              time = "time_management",
                              planning = "planning",
                              milestones = file.path("planning", "milestone_summaries"),
                              outputs = file.path("outputs", c("internal", "client_facing")),
                              data = "data",
                              documentation = file.path("data", "documentation")
  )

  valid_documents <- intersect(project_documents, names(project_directories))
  project_directories <- project_directories[valid_documents]
  project_docs <- "project_documents"

  project_path <- consult_path

  if (!dir.exists(project_path)) {
    dir.create(project_path, recursive = TRUE)
  }

  if (!is.null(client)) {
    project_path <- file.path(project_path, client)
    if (!dir.exists(project_path)) {
      dir.create(project_path, recursive = TRUE)
    }
  }
  if (!is.null(project_name)) {
    project_path <- file.path(project_path, project_name)
  }

  if (dir.exists(file.path(project_path))) {
    message("this project package already exists!")
  } else {
    usethis::create_package(project_path)
  }

  docs_path <- file.path(project_path, project_docs)

  if (dir.exists(docs_path) && !overwrite_project_documents) {
    message("project_documents subdirectory already exists, checking others ...")
  }

  for (ipath in names(project_directories)) {
    output_path <- file.path(docs_path, project_directories[[ipath]])

    if (dir.exists(output_path[1]) && !overwrite_project_documents) {
      warning(paste0(ipath, " sub-directory already exists, use 'overwrite_project_documents = TRUE' to overwrite it!"))
    }  else {
      purrr::walk(output_path, dir.create, recursive = TRUE)
    }
  }
}
