#### PhDP1: WTP Summary ####
## Function: Hypothesis One Tests
## Author: Dr Peter King (p.king@leeds.ac.uk)
## Last change: 24/04/2024
## Change: Calculating how many only chose the SQ# *****************************
# Replication Information: ####
# *****************************


# R version 4.2.0 (2022-04-22 ucrt)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows 10 x64 (build 19044)
#   [1] LC_COLLATE=English_United Kingdom.utf8  LC_CTYPE=English_United Kingdom.utf8
# [3] LC_MONETARY=English_United Kingdom.utf8 LC_NUMERIC=C
# [5] LC_TIME=English_United Kingdom.utf8
#   [1] ggplot2_3.3.6  reshape2_1.4.4 apollo_0.2.7



# *****************************
# Setup Environment: ####
# *****************************


rm(list = ls())


library(dplyr)
library(magrittr)
library(here)
library(data.table)


# *****************************
# Import Results And Models: ####
# *****************************



## Read in the completed data
Data <-
  here("Data", "SurveyData_2022_06_02.csv") %>% fread() %>% data.frame()




# *****************************
# Data cleaning: ####
# *****************************


Data$AlwaysSQ <-
ifelse(
  Data$Q9Choice == 0 &
    Data$Q10Choice == 0 &
    Data$Q11Choice == 0 &
    Data$Q12Choice == 0, 1, 0)



## Code dummy here for ease of inference:
Data$ExpertsDummy <- ifelse(Data$Q21Experts <= 3, 0, 1)


## Like a dummy but groups
Data$ExpertsGroup <- ifelse(Data$Q21Experts < 3, 0,
                            ifelse(Data$Q21Experts == 3, 1, 2))




