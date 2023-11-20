
library(tidyverse)

#3. read data

#read student-mat
math <- read_delim("https://raw.githubusercontent.com/njehh/IODS-project/master/Data/student-mat.csv",delim = ";")

#explore math data
str(math) #data has 395 rows and 33 columns
names(math)

#read student-por
por <- read_delim("https://raw.githubusercontent.com/njehh/IODS-project/master/Data/student-por.csv", delim = ";")

#explore por data
str(por) #649 rows and 33 columns
names(por)


#4. Join datasets
free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3") #columns NOT used for joining

join_cols <- setdiff(colnames(por), free_cols) #select columns for joining
#setdiff selects columns which are not in "free_cols"

math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por")) #join dataset by "join_cols
#innerjoin selects only observations which are in both data sets.

str(math_por) #now there is 370 rows and 39 columns
names(math_por)


#5. Remove duplicates from the joined data


# create a new data frame with only the joined columns
alc <- select(math_por, all_of(join_cols))

# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- col_name
  }
}

#6. Create alc_use

alc <- alc %>% 
  mutate(alc_use = rowMeans(cbind(Dalc, Walc)), #takes mean of Dalc and Walc for each row
         high_use = alc_use >2) # Is TRUE when alc_use is greater than 2, otherwise FALSE

#7. Export data
glimpse(alc)

setwd("C:/Users/pinta/Documents/IODS-project/Data")
write_csv(alc, "alc.csv")

