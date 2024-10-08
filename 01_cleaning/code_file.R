library(tidyverse)
library(readxl)

#1
#データの読み込み
semdata_1 <- read.csv("raw/semester_dummy/semester_data_1.csv", header = T)
semdata_2 <- read.csv("raw/semester_dummy/semester_data_2.csv")
#データ結合と不要な行の削除
semdata_joined <- rbind(semdata_1, semdata_2) %>% 
  select(-x6) 
#データ型を揃えるために列名を先頭列に変更
colnames(semdata_joined) <- semdata_joined[1,]

semdata <- semdata_joined[-1,] %>%
  mutate(semester = as.numeric(semester)) %>% 
  mutate(quarter = as.numeric(quarter)) %>%
  mutate(unitid = as.numeric(unitid)) %>% 
  mutate(year = as.numeric(year)) %>% 
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
#データ読み込み
graduate_data <- read_xlsx("raw/outcome/1991.xlsx")
for (i in (1992:2016)) {
  dataname <- paste0("raw/outcome/", i, ".xlsx")
  graduate_data <- rbind(graduate_data, tryCatch({read_xlsx(dataname)}, error = function(e){}))
}

graduate_data <- graduate_data %>% 
  mutate(women_gradrate_4yr = women_gradrate_4yr * 0.01) %>% 
  mutate(totcohortsize = as.numeric(totcohortsize)) %>% 
  mutate(tot_gradrate_4yr = tot4yrgrads / totcohortsize * 0.01) %>% 
  mutate(m_4yrgrads = as.numeric(m_4yrgrads)) %>% 
  mutate(men_gradrate_4yr = m_cohortsize / m_4yrgrads * 0.01) %>% 
  mutate(tot_gradrate_4yr = format(tot_gradrate_4yr, digits = 3)) %>% 
  mutate(men_gradrate_4yr = format(men_gradrate_4yr, digits = 3)) %>% 
  filter(year %in% (1991:2010))

#3

Covariates_Data <- read_xlsx("raw/covariates/covariates.xlsx") %>% 
  rename(unitid = university_id) %>% 
  mutate(unitid = as.numeric(str_remove(unitid,"aaaa"))) %>% 
  group_by(unitid, year) %>% 
  pivot_wider(names_from = category, values_from = value) %>% 
  ungroup() %>% 
  filter(year %in% graduate_data$year | year %in% semdata$year) %>% 
  filter(unitid %in% graduate_data$unitid) %>% 
  mutate(year = as.numeric(year))

#4

master_data <- left_join(semdata, graduate_data, by = c("unitid","year")) %>% 
  left_join(Covariates_Data, by = c("unitid","year"))
write_csv(master_data, file = "02_analysis/intermid/master_data.csv")





  
