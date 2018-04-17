createBasicDataDoc <- function(consult_path, client, project){
  data_path <- paste(consult_path, client, project_name, "data", sep = "/")
  # find all the .csvs
  csv_files <- list.files(data_path, pattern = "\\w+.csv")
  for (i in 1:length(csv_files)){
    basicDoc(data_path, csv_files[i], "csv")
  }

}

## TODO need to work out how and what format to render this file in.
## May need to create it as a data frame object, return back to working directory
## then render it as human readable later.
## perhaps download the relevant file from GH to use as a template.

basicDoc <- function(data_path, file, type){
  require(RCurl)
  if (type == "csv"){
    file_name <- paste(data_path, file, sep = "/")
    f_name <- strsplit(file, ".")
    f_name <- f_name[1]
    lib_location <- .libPaths()
    mkdown_location <-getURL("https://raw.githubusercontent.com/stephdesilva/consultthat/master/R/basicDoc.Rmd",
                             ssl.verifypeer = FALSE)
    rmarkdown::render(mkdown_location, params = list(filename = file_name,
                                                     type = "csv"),
           output_file = paste(data_path, "documentation/",
                                "Basic Documentation_", f_name, ".pdf"))
  } else {
    stop("Sorry, haven't implemented that file type yet.")
  }
}
