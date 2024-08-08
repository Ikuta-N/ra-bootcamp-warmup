library(tidyverse)
semdata_1 <- read.csv("raw/semester_dummy/semester_data_1.csv", header = T)
semdata_2 <- read.csv("raw/semester_dummy/semester_data_2.csv")

semdata_joined <- rbind(semdata_1, semdata_2) %>% 
  select(-x6) 
#  mutate(rownum = row_number())


test <- c(0)

for (i in (2:nrow(semdata))) {
  if((semdata[i,1] == semdata[i-1,1]) && (semdata[i,3] != semdata[i-1,3]) && (semdata[i,3] == 1)){
    test <- rbind(test, 1)
  } else  {
    test<- rbind(test, 0)
  } 
}
semdata <- data.frame(semdata_joined, test)
rownames(semdata) <- (1:nrow(semdata))
te <- data.frame(test)
