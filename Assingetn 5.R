##Assingment 5
library(tidyverse)
library(readr)
library(dplyr)
data <- read_csv("most-recent-cohorts-all-data-elements-1.csv")
library(maps)


us_states <- map_data("state")
view(data$C150_4)

p <- ggplot(data = us_states,
            mapping = aes(x = long, y = lat,
                          group =group))
p + geom_polygon(color = "gray90", size = 0.1)

schools <-select(data, STABBR, C150_4, INSTNM)
schools <- mutate(schools, state.name[match(schools$STABBR, state.abb)])
schools <- rename(schools, region = state)  

schools <- subset(schools, C150_4 != 0)  
schools <- schools[!schools$C150_4== "NULL", ] 
schools <- select(schools, C150_4, state)


dt <- schools %>%                             
  group_by(state) %>%                         # i could not figure out how to get the average
  summarize(retention_mean= mean[C150_4))
dt <- rename(dt, region = state)  
us_states <- left_join(us_states, dt, by = 'region')
p <- ggplot(data = us_states,
            mapping = aes(x = long, y = lat,
                          group =group, fill = retention_mean))
p + geom_polygon() + coord_map(projection = "albers", lat0 =39, lat1 = 45)
p <-p + geom_polygon() + coord_map(projection = "albers", lat0 =39, lat1 = 45)
p <-


