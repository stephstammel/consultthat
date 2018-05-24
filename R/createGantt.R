createGantt <- function(dates, people, first_task){
  document_dir <- findDocumentDirectory(project)
  file_name <- "gantt.csv"
  gantt_file <- file.path(document_dir, "project_initiation", file_name)

  if (!dir.exists(file.path(document_dir, "project_initiation"))) {
    stop("The project initiation directory does not exist!\nYou need to run createProject first!")
  }

  if(file.exists(gantt_file)){
    stop("A Gantt chart already exists for this project.\n
         You can view it with viewGantt()")
  }


}
