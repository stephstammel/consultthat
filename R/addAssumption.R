#' addAssumption
#'
#' When creating a project plan, you often have to make a number of assumptions.
#' Record them so they can be added to your project plan document.
#'
#' @param title, string: name your assumption for easy reference.
#' @param notes, string: notes describing your assumption
#' @param requirements, string: any requirements your assumption entails,
#'  e.g. software access. Defaults to NA.
#' @param logged_by, string: who logged the assumption? Useful for teams.
#' Defaults to NA.
#'
#' @export
#'
#' @examples
#'
#' addAssumption("Avatar state", "Don't die while in it", "Not dying", "Kora")
#'
#'
addAssumption <- function(title, notes, requirements = NA, logged_by = NA){
  document_dir <- findDocumentDirectory(project)

  current_project <- basename(dirname(normalizePath(document_dir)))

  file_name <- "initial_assumptions.csv"
  assumption_file <- file.path(document_dir, "project_initiation", file_name)

  if (!dir.exists(file.path(document_dir, "project_initiation"))) {
    stop("The project_initiation directory does not exist!\nYou need to run createProject first!")
  }

  if(!file.exists(assumption_file)){
    assumptions <- data.frame("Assumption" = title, "Notes" = notes,
                           "Requirements" = requirements, "Logged By" = logged_by,
                           stringsAsFactors = FALSE)
  } else {
    assumptions <- utils::read.csv(time_file, stringsAsFactors = FALSE, sep = ",",
                                   colClasses = rep("character", 4))
  }

  new_assumption <- c(title, notes, requirements, logged_by)
  assumptions <- rbind(assumptions, new_assumption)
  utils::write.csv(assumptions, file = assumption_file, row.names = FALSE)

}
