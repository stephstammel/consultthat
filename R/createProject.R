#' createProject
#'
#' Create a package structure for a new consulting project. This builds on the
#' normal package structure and provides subdirectories for data, outputs (client
#' facing and internal), meetings etc.
#'
#' @param consult_path string: path that consulting projects lie on, OR full path to directory
#' @param client string: name of client
#' @param project_name string: name of project
#' @param overwrite logical: should existing project_documents directories be overwritten?
#' @param project_documents string: the consulting project documents you want in this project, see Details
#' @param documents_directory string: what sub-directory should the project documents be in? Default is `project_documents`
#' @param use_package logical: should a package structure be used, or just create the directory? default is `FALSE`
#'
#' @details By default, the project directory is created, and then by default a set of sub-directories
#' to help manage consulting projects under **project_documents** (can be changed by `documents_directory`).
#' The directories are:
#'
#' * meetings: `meetings``
#' * documents: `client_side`, `company_side`
#' * initiation: `initiation`
#' * financials: `financials/invoices_payable`, `financials/invoices_receivable`
#' * time: `time_management`
#' * planning: `planning`
#' * milestones: `planning/milestone_summaries`
#' * outputs: `outputs/internal`, `outputs/client_facing`
#' * data: `data`
#' * documentation: `data/documentation`
#'
#' Controlling which are created uses the `project_documents` variable, giving
#' a string denoting which group will be created. See the `examples`.
#'
#' @importFrom usethis create_package
#' @importFrom purrr walk
#' @export
#'
#' @examples
#' # set a temp loc to create projects in
#' tmp_loc <- tempfile()
#'
#' # giving all three pieces
#' createProject(tmp_loc, "RStars", "firstProject")
#' # see all the directories that get created
#' dir(file.path(tmp_loc, "RStars", "firstProject"), recursive = TRUE, include.dirs = TRUE)
#'
#' # giving a single path
#' createProject(file.path(tmp_loc, "RStars", "secondProject"))
#'
#' # using only a subset of documents
#' createProject(tmp_loc, "RStars", "thirdProject", project_documents = c("time", "issues"))
#' # see only some sub-directories
#' dir(file.path(tmp_loc, "RStars", "thirdProject"), recursive = TRUE, include.dirs = TRUE)
#'
#' # change the documents_directory
#' createProject(tmp_loc, "RStars", "fourthProject", documents_directory = "consulting_documents")
#' dir(file.path(tmp_loc, "RStars", "fourthProject"), recursive = TRUE, include.dirs = TRUE)
#'
#' \dontrun{
#' # not run, create an R package
#' createProject(tmp_loc, "RStars", "packageProject", use_package = TRUE)
#' dir(file.path(tmp_loc, "RStars", "packageProject"), recursive = TRUE, include.dirs = TRUE)
#' }
#'
#'
#'
createProject <- function(consult_path = ".", client = NULL, project_name = NULL,
                          overwrite = FALSE,
                          project_documents = c("meetings", "documents", "initiation",
                                               "financials", "time", "planning",
                                               "milestones", "outputs", "data", "documentation"),
                          documents_directory = "project_documents",
                          use_package = FALSE){

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

  if (is.null(documents_directory)) {
    stop("The documents sub-directory cannot be NULL!")
  }

  if (nchar(documents_directory) < 2) {
    stop("Please provide a longer name for the documents_directory sub-directory!")
  }

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

  if (dir.exists(project_path) && (length(dir(project_path)) > 0)) {
    message("this project package already exists!")
  } else if (use_package) {
    usethis::create_package(project_path)
  } else if (!dir.exists(project_path)) {
    dir.create(project_path, recursive = TRUE)
  }

  # put the used directory in the file so it can be queried later
  cat(documents_directory, file = file.path(project_path, ".consultthat"))

  docs_path <- file.path(project_path, documents_directory)

  if (dir.exists(docs_path) && !overwrite) {
    message("project_documents subdirectory already exists, checking others ...")
  }

  for (ipath in names(project_directories)) {
    output_path <- file.path(docs_path, project_directories[[ipath]])

    if (dir.exists(output_path[1]) && !overwrite) {
      warning(paste0(ipath, " sub-directory already exists, use 'overwrite_project_documents = TRUE' to overwrite it!"))
    }  else {
      purrr::walk(output_path, dir.create, recursive = TRUE)
    }
  }
}
