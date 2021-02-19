getwd
Temp <- getwd()
setwd("C:/Users/William/OneDrive/Core Business Classes/BIS 244/GitHub/BIS 244/Covid-19_Project/covid-19-data/")
STATES<- read.csv("us-states.csv")
data.frame(STATES)
setwd("C:/Users/William/OneDrive/Core Business Classes/BIS 244/GitHub/BIS 244/BIS-244-Fall-2020")
library(tidyverse)
Temp <- getwd()
Pennsylvania<- filter(STATES, state =="Pennsylvania")
view(Pennsylvania)
Pennsylvania_adjusted_data <- mutate(Pennsylvania, adjust_deaths = deaths)
Pennsylvania_adjusted_data$adjust_deaths[47] <- 1338
Pennsylvania_adjusted_data$adjust_deaths[48] <- 1423
sum(Pennsylvania_adjusted_data$adjust_deaths)
Total <- sum(Pennsylvania_adjusted_data$adjust_deaths)
cat("Total average death", Total )

      