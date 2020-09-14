options(scipen=999)  # turn-off scientific notation like 1e+48
library(dplyr)
source("./read_data.R")

SCC <- read_scc()
NEI <- read_nei()

#' Question:
#' Have total emissions from PM2.5 decreased in the 
#' United States from 1999 to 2008? 

# sum emissions by year
df <- NEI %>% group_by(year) %>% summarise(Emissions = sum(Emissions))

# save as png file
png("answer1.png", 480, 480)

# make a plot
with(df, plot(x= year, y= Emissions, type = "b", col="red", ylab = expression( ~PM[2.5] ~" Emissions"), xlab = "Year")) +
  title(expression("Total Emissions from" ~PM[2.5]~ "in the United States"))

dev.off()

