

#2. Read in the “Human development” and “Gender inequality” data sets


library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")


#3. Explore the datasets: see the structure and dimensions of the data
#sturcture
str(hd) #dimensions 195 × 8
str(gii) #dimensions 195 × 10

summary(hd)
summary(gii)


#4. Look at the meta files and rename the variables with (shorter) descriptive names

library(tidyverse)
names(hd)
colnames(hd) <- c("HDI Rank","Country", "HDI", "Life.Exp", "Edu.Exp", "Mean.Edu", "GNI","GNI-HDI")

names()
