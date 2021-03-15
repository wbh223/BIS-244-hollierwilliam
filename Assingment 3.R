
library(here)
library(tidyverse)


library(readr)
PRESIDENT <- read_csv("PRESIDENT_precinct_primary.csv")
View(PRESIDENT)

PRESIDENT$candidate <- as.factor(PRESIDENT$candidate)
PRESIDENT$state <- as.factor(PRESIDENT$state)
n_candidates <- length(levels(PRESIDENT$candidate))
n_states <- length(levels(PRESIDENT$state))    

PRESIDENT <- group_by(PRESIDENT, state, candidate)
TOTAL <- summarise(PRESIDENT, votes = sum(votes))

STATES <- levels(PRESIDENT$state)
CANDIDATES <- levels(TOTAL$candidate)
TOTAL <- mutate(TOTAL,cand_cons=case_when(candidate =="JOSEPH R BIDEN" ~ "BIDEN",
                                              candidate == "DONALD J TRUMP" ~ "TRUMP",
                                              candidate == "JOSEPH R BIDEN/KAMALA HARRIS" ~ "BIDEN",
                                              candidate == "JOSEPH R BIDEN JR" ~ "BIDEN",
                                              candidate == "BIDEN / HARRIS" ~ "BIDEN",
                                              candidate == "BIDEN AND HARRIS" ~ "BIDEN",
                                              candidate == "JOE BIDEN" ~ "BIDEN",
                                              candidate == "JOSEPH ROBINETTE BIDEN" ~ "BIDEN",
                                              candidate == "DONALD J TRUMP/MICHAEL R PENCE" ~ "TRUMP",
                                              candidate == "TRUMP / PENCE" ~ "TRUMP",
                                              candidate == "TRUMP AND PENCE" ~ "TRUMP",
                                              TRUE ~ "OTHER"))
TOTAL

CAND_CONS <- levels(as.factor(TOTAL$cand_cons))

CAND_CONS
PRESIDENT <- group_by(TOTAL, state, cand_cons)
TOTAL2 <- summarise(PRESIDENT, votes = sum(votes))
TOTAL2
n_TOTAL2 <- length(TOTAL2$state)
TOTAL3 <- data.frame(STATES)
TOTAL3$votes <- 0
TOTAL3$winner <- NA
for (i in 1:n_states) {
  BIDEN <- 0
  TRUMP <- 0
  VOTES <- 0
  for (j in 1:n_TOTAL2){
    if (TOTAL2$state[j]==TOTAL3$STATES[i]){
      VOTES <- VOTES + TOTAL2$votes[j]
      if (TOTAL2$cand_cons[j]=="BIDEN") {
        BIDEN <- BIDEN + TOTAL2$votes[j]
     }
      else if (TOTAL2$cand_cons[j]=="TRUMP") {
        TRUMP <- TRUMP + TOTAL2$votes[j]
  }
      else {}
   }
  }
  TOTAL3$votes[i] <- VOTES
  if (BIDEN > TRUMP) {
    TOTAL3$winner[i] <- "BIDEN" }
  else TOTAL3$winner[i] <- "TRUMP"
}

p <-  ggplot(data = TOTAL3,
            mapping = aes(x = votes,
                          y = STATES,
                          color = winner))
p + geom_point()+
  labs(x = "Vot Total", y = "State",
       title = "Mapping Election Totals and Presedential Outcomes",
       subtitle = "Data points are total votes per state")
      

p_out <-  p + geom_point()+
  labs(x = "Vot Total", y = "State",
       title = "Mapping Election Totals and Presedential Outcomes",
       subtitle = "Data points are total votes per state")
       p_out
       ggsave("Assingment3.pdf",plot = p_out)
       
       