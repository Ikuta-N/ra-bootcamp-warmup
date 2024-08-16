library(tidyverse)

#1
semdata_1 <- read.csv("raw/semester_dummy/semester_data_1.csv", header = T)
semdata_2 <- read.csv("raw/semester_dummy/semester_data_2.csv")

semdata_joined <- rbind(semdata_1, semdata_2) %>% 
  select(-x6) %>% 
  



# semester_dummy_temp <- c("temp")
# 
# for (i in (2:nrow(semdata))) {
#   if((semdata[i,1] == semdata[i-1,1]) && (semdata[i,3] != semdata[i-1,3]) && (semdata[i,3] == 1)){
#     semester_dummy_temp <- rbind(semester_dummy_temp, 1)
#   } else  {
#     semester_dummy_temp<- rbind(semester_dummy_temp, 0)
#   } 
# }
# rownames(semester_dummy_temp) <- (1:nrow(semester_dummy_temp))
# semdata <- data.frame(semdata_joined, semester_dummy_temp)
# semdata <- semdata %>% 
#   mutate(intro_semester = ifelse(semester_dummy_temp == 1, as.numeric(x5), 0)) %>% 
#   select(-semester_dummy_temp) %>% 
#   mutate(after_semester_dummy = ifelse(intro_semester >= 2001, 1,0))

#2

  
