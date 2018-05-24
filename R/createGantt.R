#' createGantt
#'
#' Create a Gantt chart, using the plan package. You can manipulate a .csv as required.
#'
#' @param key give each task a name
#' @param description describe the task
#' @param start date task should start
#' @param end date task should finish
#' @param done percentage completion of task
#' @param neededBy date completion required
#'
#' @export
#'
#' @examples
#'
#' task1 <- c("Team Avatar!", "Welcome to Republic City",
#' as.Date("2018/01/01"), as.Date("2018/01/02"), done = 72, neededBy = as.Date("2018/02/01"))
#'
#' task2 <- c("The Equalists = bad", "A Leaf in the Wind",
#' as.Date("2018/01/18"), as.Date("2018/01/24"), done = 65, neededBy = asDate("2018/02/02"))
#'
#' task3 <- c("Bolin gets captured!", "The Revelation",
#' as.Date("2018/01/26"), as.Date("2018/01/30"), done = 50, neededBy = asDate("2018/02/05"))
#'
#' tasks <- rbind(task1, task2, task3)
#'
#' createGantt(tasks[,1], tasks[,2], tasks[,3], tasks[,4], tasks[,5], tasks[,6])
#'
#'
createGantt <- function(key, description, start, end, done, neededBy){
  requireNamespace("plan", quietly = TRUE)
  document_dir <- findDocumentDirectory(project)
  file_name <- "gantt.csv"
  gantt_file <- file.path(document_dir, "project_initiation", file_name)

  if (!dir.exists(file.path(document_dir, "project_initiation"))) {
    stop("The project initiation directory does not exist!\nYou need to run createProject first!")
  }

  if(file.exists(gantt_file)){
    stop("A Gantt chart already exists for this project.\n
         You can view it with plan::plot.gantt()")
  }

  require(plan)

  gantt_df <- plan::as.gantt(key, description, start, end, done, neededBy)
  utils:: write.csv(gantt_file, file = gantt_df, row.names = FALSE)

  plan::plot.gantt()


}
