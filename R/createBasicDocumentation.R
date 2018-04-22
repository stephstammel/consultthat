createBasicDocumentation <- function(){
  requireNamespace("knitr")
  requireNamespace("rmarkdown")
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
