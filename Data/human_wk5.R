#IODS2023 Week 5 exercises
#Author: Mykkänen Anssi


#1.Explore structure
library(readr)
library(tidyverse)
human <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.csv")

str(human)
#Dataset has 195 rows and 19 columns
names(human)
#It includes human developement index (HDI) data for different countries (each row is one country)
#Data include such variables as life expectancy, birth rate, maternal mortality and adolescent birth rate.

#2. Exclude unneeded variables

#vector of columns to be included
include <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F") 

#select columns with the "include" vector
human_selected <- human %>% 
  select(include)

names(human_selected) #confirms that only the correct columns are included

#3. Remove all rows with missing values
human_na.rm <- na.omit(human_selected)

#4. Remove the observations which relate to regions instead of countries.

#let's create vector of the areas
areas <- c("Arab States", "East Asia and the Pacific", "Europe and Central Asia", "Latin America and the Caribbean", "South Asia", "Sub-Saharan Africa", "World")

human_final <- subset(human_na.rm, !Country %in% areas) #remove rows where Country is included in the 'areas' vector

#5. Export data

str(human_final) #includes 155 rows and 9 columns
names(human_final) #includes correct columns

setwd("~/IODS-project/Data")
write_csv(human_final, "human.csv")



