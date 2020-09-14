#' this function read the data set, and return a vector 
#' with SCC and NEI data respectively
read_scc<- function(){
  
  SCC <- readRDS("Source_Classification_Code.rds")
   return(SCC)
}

read_nei <- function(){
  NEI <- readRDS("summarySCC_PM25.rds")
  return(NEI)
}