#' seeGantt
#'
#' Visualise the Gantt chart you have created for your project.
#'

#' @export
#'
#' @examples
#'
#' seeGantt()
#'
seeGantt <- function(){
  requireNamespace("plan", quietly = TRUE)
  document_dir <- findDocumentDirectory(project)
  file_name <- "gantt.csv"
  gantt_file <- file.path(document_dir, "project_initiation", file_name)
  if(!file.exists(gantt_file)){
    stop("A Gantt chart does not exist for this project.\n
         You can create one with createGantt().")
  }

  gantt <- plan::read.gantt(gantt_file)
  plan::plot.gantt(gantt)
}
