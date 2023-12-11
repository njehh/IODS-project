

#Week 6 data wrangling


#1. Load data

bprs <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep="", header = T)

str(bprs)
#Dataset has 11 columns and 40 rows.Columns include treatment (1 or 2), subject identifier and weeks from 0 to 8.
#There are 20 subject and all of the subjects received two different treatments, therefore 40 rows.

rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt")

str(rats)
# Dataset has 13 columns and 16 rows. 
# There is data for 16 rats (rows).
# Columns include rat identifier, group (1, 2 or 3) and weight at different time points.

#2. Convert categorical variables to factors

bprs$treatment <- as.factor(bprs$treatment)
is.factor(bprs$treatment) # is factor
bprs$subject <- as.factor(bprs$subject)
is.factor(bprs$subject) # is factor


rats$Group <- as.factor(rats$Group)
is.factor(rats$Group)
rats$ID <- as.factor(rats$ID)
is.factor(rats$ID)


#3. convert dataset to long form

library(dplyr)
library(tidyr)

BPRS  <-  pivot_longer(bprs, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
                      arrange(weeks)

BPRS  <-  BPRS  %>% 
  mutate(week = as.integer(substr(BPRS $weeks,start=5,stop=5)))


RATS <- pivot_longer(rats, cols = -c(ID, Group),
                     names_to = "WD", values_to = "Weight")

RATS <-  RATS %>% 
  mutate(Time = as.integer(substr(RATS$WD,start=3, stop = 4))) %>% 
  arrange(Time)


#4. Look at data

glimpse(bprs)
#In the wide form one row contains data for each week 
#Each subject has two rows because there are two different treatments

glimpse(BPRS)
#In the tall form each row contains data for only one observation
#Now each subject has 18 rows for observations (weeks from 0 to 9 for two different treatments)

#write dataset
setwd("C:/Users/pinta/Documents/IODS-project/Data")
write_csv(BPRS, "bprs.csv")

glimpse(rats)
#In the wide form each row (16 in total) contains data for rat weight at 11 time points

glimpse(RATS)
#In the tall form each row contains only data for single time point.
#Now there are 11 rows for each rat, 176 rows in total.

write_csv(RATS, "rats.csv")
