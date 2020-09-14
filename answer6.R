options(scipen=999)  # turn-off scientific notation like 1e+48
library(dplyr)
library(ggplot2)
source("./read_data.R")

SCC <- read_scc() #read SCC data
NEI <- read_nei() #read NEI data

#' Question:
#' Compare emissions from motor vehicle sources in Baltimore City
#' with emissions from motor vehicle sources in Los Angeles County, 
#' California (fips == "06037").
#' Which city has seen greater changes over time in motor vehicle emissions?

# filter by Baltimore City and ON-ROAD
NEI_baltimore_ONROAD <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD",]
# filter by Los Angeles City and ON-ROAD
NEI_Los_Angeles_ONROAD <- NEI[NEI$fips == "06037" & NEI$type == "ON-ROAD",]

NEI_B_LA <- rbind(NEI_baltimore_ONROAD, NEI_Los_Angeles_ONROAD)

# sum emissions by year
df <- NEI_B_LA %>% group_by(NEI_B_LA$fips, year) %>% summarise(Emissions = sum(Emissions))

#' this function convert a fib code to respectively city name
#' @param fib a fib number, can be "24510" for Baltimore or "06037" for Los Angeles
renameFib <- function(fib){
  if(fib == "24510"){
    return("Baltimore")
  }else if(fib == "06037"){
    return("Los Angeles")
  }
}

# apply renameFib function
df$`NEI_B_LA$fips` <- sapply(df$`NEI_B_LA$fips`, renameFib)

# save as png file
png("answer6.png", 600, 480)

# make a plot
ggplot(df, aes(year, Emissions, col=`NEI_B_LA$fips`))  + 
  geom_line() +
  geom_point() +
  ggtitle(expression("Los Angeles VS. Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
  xlab("Year") +
  scale_colour_discrete(name = "City") +
  ylab(expression(~PM[2.5]~ "Motor Vehicle Emissions"))

dev.off()

