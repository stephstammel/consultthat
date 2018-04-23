#' createBasicDocumentation
#'
#' This function will create a basic documentation for all of the data files
#' in the /data folder for a project.
#'
#' Currently only operational for .csv files as a start point: more formats soon!
#'
#' Note, the file will be read as is: you may need to do some cleaning first.
#' Suggest creating /data/raw and putting raw files there with cleaning script.
#'
#'
#' @examples
#'
#' createBasicDocumentation()
#'
createBasicDocumentation <- function(){
  requireNamespace("pacman")
  requireNamespace("rmarkdown")
  requireNamespace("knitr")
  pacman::p_load(knitr, rmarkdown)


  data_directory <- paste(getwd(), "/data", sep = "")
  utils::download.file("https://raw.githubusercontent.com/stephdesilva/consultthat_scripts/master/basicDocumentation.Rmd",
                       paste(getwd(), "/data/documentation/basicDocumentation.rmd", sep = ""))


  files <- list.files(path = data_directory, recursive = FALSE)
  for (i in 1:length(files)){
      rmarkdown::render(paste(data_directory,"/documentation/basicDocumentation.rmd", sep = ""),
             params = list(nameFile = files[i],
                           fileType = ".csv"),
             output_file = paste("Basic Documentation", files[i], ".html", sep = ""))
  }
}
