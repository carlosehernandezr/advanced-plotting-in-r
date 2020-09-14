options(scipen=999)  # turn-off scientific notation like 1e+48

library(dplyr)
library(ggplot2)
source("./read_data.R")

SCC <- read_scc()
NEI <- read_nei()

#' Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#' variable, which of these four sources have seen decreases in emissions
#' from 1999–2008 for Baltimore City? Which have seen increases in
#' emissions from 1999–2008?

# filter by Baltimore City 
NEI_baltimore_city <- NEI[NEI$fips == "24510",] #get only Baltimore City data

# sum emissions by year
NEI_baltimore_city <- NEI_baltimore_city %>% group_by(type, year) %>% summarise(Emissions = sum(Emissions))

png("answer3.png", 600, 480)

# make a plot
ggplot(NEI_baltimore_city, aes(year, Emissions, col = type)) + 
  geom_line() +
  geom_point() +
  ggtitle(expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions by Type and Year")) +
  scale_colour_discrete(name = "Type of sources") +
  xlab("Year") +
  ylab(expression(~PM[2.5]~ "Emissions"))

dev.off()




