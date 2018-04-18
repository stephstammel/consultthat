punchOff <- function(path, client, project, category, notes){
  time_file <- paste(path, client, "time_sheet.csv", sep = "/")
  if(!file.exists(time_file)){
    stop("No timesheet exists for this client. You can't punch off when you never punched on :)")
  } else {
    time_log <- read.csv("time_sheet.csv", stringsAsFactors = FALSE)
    if (time_log[nrow(time_log), 5] == "off"){
      stop("You're already punched off for this client.")
    }
    punch <- c(project, category, notes, Sys.time(), "off")
    time_log <- rbind(time_log, punch)
  }
  write.csv(time_log, file = time_file)
}
