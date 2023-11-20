
library(tidyverse)


math <- read_delim("https://raw.githubusercontent.com/njehh/IODS-project/master/Data/student-mat.csv",delim = ";")

str(math)
names(math)

por <- read_delim("https://raw.githubusercontent.com/njehh/IODS-project/master/Data/student-por.csv", delim = ";")


str(por)
names(por)



free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")

join_cols <- setdiff(colnames(por), free_cols)

math_por <- inner_join(math, por, by = join_cols)

str(math_por)
names(math_por)
