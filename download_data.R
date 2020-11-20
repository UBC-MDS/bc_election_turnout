# author: Chad Neald
# date: 2020-11-19

"This script downloads data from two url links and saves it to a given file path.
Usage: download_data.R --url1=<url1> --url2=<url2> --path=<path>

Options:
--url1=<url1>     Takes a url to a downloadable csv file (this is a required argument)
--url2=<url2>     Takes a secondary url to a downloadable csv file (this is a required argument)
--path=<path>     Takes a path to where the data should be saved (this is a required argument)
" -> doc

library(tidyverse)
library(here)
library(docopt)

opt <- docopt(doc)

main <- function(url1, url2, path){
  
  election_results <- read_csv(url1)
  participation_data <- read_csv(url2)
  
  # If the directory do not exist it will be created
  # If the directory does exist, a message will be output and the script will continue
  dir.create(path, recursive = TRUE)
  
  # Append the actual name of the .csv to each path
  file_name1 = "bc_provincial_election_results.csv"
  file_name2 = "bc_election_participation_data.csv"
  
  # Check whether the user entered a path that ended in '/' or not
  # Create the paths to the final files accordingly
  if(str_sub(path, str_length(path)) == '/'){
    path1 <- paste(path, file_name1, sep = "")
    path2 <- paste(path, file_name2, sep = "")
  } else{
    path1 <- paste(path, file_name1, sep = "/")
    path2 <- paste(path, file_name2, sep = "/")
  }
  
  write_csv(election_results, path1)
  write_csv(participation_data, path2)
 
}


main(opt$url1, opt$url2, opt$path)