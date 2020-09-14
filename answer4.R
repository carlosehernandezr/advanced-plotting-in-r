options(scipen=999)  # turn-off scientific notation like 1e+48
library(dplyr)
library(ggplot2)
source("./read_data.R")

SCC <- read_scc()
NEI <- read_nei()

#' Question:
#' Across the United States, how have emissions from coal combustion-related 
#' sources changed from 1999–2008?

# get only SCC with SCC.Level.One that contains 'comb' or 'coal'
SCCcoal <- SCC[SCC$SCC.Level.Three %in% grep("[Cc]oal", SCC$SCC.Level.Three, value = TRUE),]
# get data with SCC codes in SCCcoal_combustion
NEIcoal <- NEI[NEI$SCC %in% SCCcoal$SCC,] 
# sum emissions by year
NEIcoal_by_year <- NEIcoal %>% group_by(year,type) %>% summarise(Emissions = sum(Emissions))

png("answer4.png", 600, 480)

# make a plot
ggplot(NEIcoal_by_year, aes(year, Emissions, col=type))  + 
  geom_line() + 
  geom_point() +
  ggtitle(expression(~ PM[2.5] ~ "Emissions from coal combustion-related by Source and Year")) +
  scale_colour_discrete(name = "Type of sources") +
  xlab("Year") +
  ylab(expression(~PM[2.5]~ "Emissions"))

dev.off()

