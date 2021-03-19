library(tidyverse)
library(readr)
setwd('C:/Users/William/OneDrive/Core Business Classes/BIS 244/GitHub/BIS 244/BIS-244-hollierwilliam')

AAPL <- read_csv("AAPL.csv")
 
AAPL$ADj.change <-0
View(AAPL)
 AAPL$ADj.change[] <- (AAPL$'Adj Close' - AAPL$Open)

n <- nrow(AAPL)
AAPL$Updown <- 3
for (i in 1:n) {
if (AAPL$ADj.change[i] > 0) {
  AAPL$Updown[i] <- 0}

 else if (AAPL$ADj.change[i] < 0) {
  AAPL$Updown[i] <- 1}

}
p <- ggplot(data = AAPL,
            mapping = aes(x = Date,
                          y = ADj.change,
                           color = Updown))
p + geom_point(aes( color = Updown))

p_out = p + geom_point(aes( color = Updown )) +labs(x = "0/3/19 through 03/18/21", y = "Average Daily Change",
    title = "Daily Average Price Change in AAPL Stock",
    subtitle = "WIlliam Hollier"
    )
ggsave("Midterm.pdf", plot = p_out)