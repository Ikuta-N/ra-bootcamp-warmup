library(tidyverse)

#1
semdata_1 <- read.csv("raw/semester_dummy/semester_data_1.csv", header = T)
semdata_2 <- read.csv("raw/semester_dummy/semester_data_2.csv")

semdata_joined <- rbind(semdata_1, semdata_2) %>% 
  select(-x6) 
colnames(semdata_joined) <- semdata_joined[1,]
semdata <- semdata_joined[-1,] %>% 
  mutate(semester = as.numeric(semester)) %>% 
  mutate(quarter = as.numeric(quarter)) %>% 
  group_by(unitid) %>% 
  mutate(onlysemester = prod(semester)) %>% 
  mutate(onlyquarter = prod(quarter)) %>% 
  ungroup() %>% 
  mutate(introsem = ifelse(onlysemester == 0 & onlyquarter == 0 & semester == 1, as.numeric(year), 2500)) %>% 
  group_by(unitid) %>% 
  mutate(introsem = ifelse(min(introsem) == 2500, NA_real_, min(introsem))) %>% 
  mutate(aftersem_dummy = ifelse(!is.na(introsem) & semester == 1, 1, 0)) %>% 
  select(-onlyquarter, -onlysemester) %>% 
  ungroup()
  

#2

  
