options(scipen=999)  # turn-off scientific notation like 1e+48
library(dplyr)
source("./read_data.R")

SCC <- read_scc() #read scc data
NEI <- read_nei() #read NEI data

#' Have total emissions from PM2.5 decreased in the
#' Baltimore City, Maryland (fips == "24510") 
#' from 1999 to 2008?

# filter by Baltimore City 
NEI_baltimore_city <- NEI[NEI$fips == "24510",]

# sum emissions by year
df <- NEI_baltimore_city %>% group_by(year) %>% summarise(Emissions = sum(Emissions))

# save as png file
png("answer2.png", 480, 480)

# make a plot
with(df, plot(x= year, y= Emissions, type = "b", col="red", ylab = expression( ~PM[2.5] ~" Emissions"), xlab = "Year")) +
  title(expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions"))

dev.off()


