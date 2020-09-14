options(scipen=999)  # turn-off scientific notation like 1e+48
library(dplyr)
library(ggplot2)
source("./read_data.R")

SCC <- read_scc() #read SCC data
NEI <- read_nei() #read NEI data

#' How have emissions from motor vehicle sources 
#' changed from 1999–2008 in Baltimore City?

# filter by Baltimore City and ON-ROAD
NEI_baltimore_ONROAD <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD",]

# sum emissions by year
df <- NEI_baltimore_ONROAD %>% group_by(year) %>% summarise(Emissions = sum(Emissions))

png("answer5.png", 480, 480)

# make a plot
ggplot(df, aes(year, Emissions))  + 
  geom_line(color = "darkblue") +
  geom_point(color = "darkblue") +
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
  xlab("Year") +
  ylab(expression(~PM[2.5]~ "Motor Vehicle Emissions"))

dev.off()
