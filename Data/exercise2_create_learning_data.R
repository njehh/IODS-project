#Author: Anssi Mykkänen
#Date: 12 Nov 2023

library("tidyverse")

# 2. 
learning_data <- read_tsv("JYTOPKYS3-data.txt")

learning_data %>% dim()
#dataset has 183 rows and 60 columns

learning_data %>% str()
learning_data %>% names()
# Column names are:  
#"Aa"       "Ab"       "Ac"       "Ad"       "Ae"       "Af"       "ST01"     "SU02"     "D03"      "ST04"    
#"SU05"     "D06"      "D07"      "SU08"     "ST09"     "SU10"     "D11"      "ST12"     "SU13"     "D14"     
#"D15"      "SU16"     "ST17"     "SU18"     "D19"      "ST20"     "SU21"     "D22"      "D23"      "SU24"    
#"ST25"     "SU26"     "D27"      "ST28"     "SU29"     "D30"      "D31"      "SU32"     "Ca"       "Cb"      
#"Cc"       "Cd"       "Ce"       "Cf"       "Cg"       "Ch"       "Da"       "Db"       "Dc"       "Dd"      
#"De"       "Df"       "Dg"       "Dh"       "Di"       "Dj"       "Age"      "Attitude" "Points"   "gender"  

# 3.
#Pick variables for the exercise dataset: gender, age, attitude, deep, stra, surf and points

#Attitude Global attitude toward statistics ~Da+Db+Dc+Dd+De+Df+Dg+Dh+Di+Dj
learning_data <- learning_data %>%  
  mutate(attitude = Da+Db+Dc+Dd+De+Df+Dg+Dh+Di+Dj)


#Deep     Deep approach             ~d_sm+d_ri+d_ue
#   d_sm     Seeking Meaning           ~D03+D11+D19+D27
#   d_ri     Relating Ideas            ~D07+D14+D22+D30
#   d_ue     Use of Evidence           ~D06+D15+D23+D31
learning_data <- learning_data %>% 
  mutate(deep = D03+D11+D19+D27+D07+D14+D22+D30+D06+D15+D23+D31)

#Stra     Strategic approach        ~st_os+st_tm
#   st_os    Organized Studying        ~ST01+ST09+ST17+ST25
#   st_tm    Time Management           ~ST04+ST12+ST20+ST28
learning_data <- learning_data %>% 
  mutate(stra = ST01+ST09+ST17+ST25+ST04+ST12+ST20+ST28)

#Surf     Surface approach          ~su_lp+su_um+su_sb
    #su_lp    Lack of Purpose           ~SU02+SU10+SU18+SU26
    #su_um    Unrelated Memorising      ~SU05+SU13+SU21+SU29
    #su_sb    Syllabus-boundness        ~SU08+SU16+SU24+SU32
learning_data <- learning_data %>%
  mutate(surf = SU02+SU10+SU18+SU26+SU05+SU13+SU21+SU29+SU08+SU16+SU24+SU32)

#Scale variables
learning_data_scaled <- learning_data %>% 
  mutate(
    attitude = attitude/10,
    deep = deep/12,
    stra = stra/8,
    surf = surf/12,
    age = Age, #rename variable
    points = Points) #rename variable

#Points   Exam points
# Exclude those with 0 exam points
learning_data_excluded <- learning_data_scaled %>% filter(Points != 0)

#Select columns
learning_data_final <- learning_data_excluded %>% 
  select(gender, age, attitude, deep, stra, surf, points)

#Export data
learning_data_final %>% 
  write_csv(file = "learning2023.csv")
