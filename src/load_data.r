"Script for downloading a CSV from the web.
Usage: src/download_csv.R <url> <write_path>
Options:
--url=<url>                 The url address of csv file.
--write_path=<write_path>   The path destination to write the csv file.
" -> doc

library(docopt)

pt <- docopt(doc)

main <- function(url, write_path) {
        download_csv(url, write_path) 
}
#' Download CSV From the url.
#'
#' It is a script for downloading the csv file.
#'
#' @param url The url address of the csv.
#' @param write_path The destination path for saving the data.
#'
#' @return
#' @examples
#' 
#' url <- "https://catalogue.data.gov.bc.ca/dataset/44914a35-de9a-4830-ac48-870001ef8935/resource/fb40239e-b718-4a79-b18f-7a62139d9792/download/provincial_voting_results.csv"
#' write_path = 'C:\Users\smoravejjahr\MDS_2020\dsci_522\project\data\raw\provincial_voting_results.csv'
#' download_csv(url, write_path)
download_csv <- function(url, write_path) {
    download.file(url = url, destfile = write_path)
}

main(opt$url, opt$write_path)