library(tidyverse)
library(summarytools)
library(ggplot2)

master_data <- read.csv("02_analysis/intermid/master_data.csv")

na_count <- c()
for (i in (1:ncol(master_data))) {
  na_count <- cbind(na_count, sum(is.na(master_data[,i])))
}

master_data %>% 
  select(-unitid, -instnm, -semester, -quarter, -year, -introsem, -aftersem_dummy) %>%   
  descr()

master_data %>% 
  group_by(year) %>% 
  summarise(gradrate_mean = mean(tot_gradrate_4yr)) %>% 
  ggplot(aes(x = year, y = gradrate_mean)) +
  geom_line()

master_data %>% 
  group_by(year) %>% 
  summarise(semester_rate = sum(semester) / n()) %>% 
  ggplot(aes(x = year, y = semester_rate)) +
  geom_line()

master_data %>% 
  ggplot(aes(x = w_cohortsize / totcohortsize, y = tot_gradrate_4yr))+
  geom_point()

master_data %>% 
  ggplot(aes(x = white_cohortsize / totcohortsize, y = tot_gradrate_4yr))+
  geom_point()

master_data %>% 
  ggplot(aes(x = instatetuition, y = tot_gradrate_4yr))+
  geom_point()

lm(tot_gradrate_4yr ~ aftersem_dummy, data = master_data) %>% 
  summary()
