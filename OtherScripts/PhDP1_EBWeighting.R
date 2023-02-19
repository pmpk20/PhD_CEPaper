#### PhDP1: Entropy Balancing Weights For Experts ####
## Function: Weights the sample and estimates treatment effects
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 12/12/2022
## TODO: add density plots



#------------------------------
# Replication Information: ####
#------------------------------


# R version 4.2.0 (2022-04-22 ucrt)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows 10 x64 (build 19044)
#   [1] LC_COLLATE=English_United Kingdom.utf8  LC_CTYPE=English_United Kingdom.utf8   
# [3] LC_MONETARY=English_United Kingdom.utf8 LC_NUMERIC=C                           
# [5] LC_TIME=English_United Kingdom.utf8    
#   [1] ggplot2_3.3.6  reshape2_1.4.4 apollo_0.2.7  



#------------------------------
# Setup Environment: ####
#------------------------------

rm(list = ls())


library(apollo)
library(dplyr)
library(magrittr)
library(ggplot2)
library(ggridges)
library(reshape2)
library(ggalluvial)
library(MatchIt)
library(WeightIt)
library(cobalt)
library(data.table)


#------------------------------------------
# Import Data: ####
#------------------------------------------


## Read in latest version of data in wide format
Wide <- data.frame(fread("SurveyData_2022_06_02.csv"))
Long <- data.frame(fread("Test_Apollo.csv"))
Long$Performance_B <-Long$Performance_B*-1
Long$ExpertsDummy <- ifelse(Long$Experts<=3,0,1)
Wide$ExpertsDummy <- ifelse(Wide$Q21Experts<=3,0,1)

Wide$ExpertsGroup <- ifelse(Wide$Q21Experts<3,0,
                            ifelse(Wide$Q21Experts==3,1,2))
Long$ExpertsGroup <- ifelse(Long$Experts<3,0,
                            ifelse(Long$Experts==3,1,2))



#------------------------------------------
# Trim Data: ####
#------------------------------------------


Wide$GenderDummy <- ifelse(Wide$Q1Gender<1,0,1)
Wide$EducationDummy <- ifelse(Wide$Q22Education<3,0,1)
Wide$AgeDummy <- ifelse(Wide$Q2Age<median(Wide$Q2Age),0,1)


#------------------------------------------
# Estimate Weights For Dummy: ####
#------------------------------------------


## Fit here:
## NOTE: Entropy Balancing for consistency with Hynes et al 2020, 2021
EB_Weights_Dummy <- weightit(as.factor(ExpertsGroup)  ~ IncomeDummy +
                               AgeDummy +
                               EducationDummy +
                               GenderDummy, focal = 1,
                       data = Wide, method = "ebal", 
                       estimand = "ATT")

summary(EB_Weights_Dummy)

EB_Weights_Dummy_Summary <- bal.tab(x = EB_Weights_Dummy$covs,
                                    treat = EB_Weights_Dummy$treat,
                                    stats = c("mean.diffs"),
                                    thresholds = c(m=0.01),
                                    weights = EB_Weights_Dummy$weights)

## Export summary table to word:
cbind(
  rownames(EB_Weights_Dummy_Summary$Balance),
  EB_Weights_Dummy_Summary$Balance$Type,
  round(EB_Weights_Dummy_Summary$Balance$M.0.Un,3),
  round(EB_Weights_Dummy_Summary$Balance$M.1.Un,3),
  round(EB_Weights_Dummy_Summary$Balance$Diff.Un,3),
  round(EB_Weights_Dummy_Summary$Balance$Diff.Adj,3),
  EB_Weights_Dummy_Summary$Balance$M.Threshold
) %>% write.csv(quote=F,row.names=F)

## Individual Weights here:
# EB_Weights$weights
Long_Weights_Dummy <-  cbind(Long,"Weights"=rep(EB_Weights_Dummy$weights,each=4))

## Export weighted:
write.csv(Long_Weights_Dummy,"Long_Weights_Dummy_2022_12_12.csv")



#------------------------------------------
# Estimate Weights For Category: ####
#------------------------------------------


## Fit here:
## NOTE: Entropy Balancing for consistency with Hynes et al 2020, 2021
EB_Weights_Category <- weightit(as.factor(Q21Experts)  ~ IncomeDummy +
                                  AgeDummy +
                                 EducationDummy +
                                  GenderDummy, 
                             data = Wide, method = "ebal", 
                             estimand = "ATE")

summary(EB_Weights_Category)

EB_Weights_Category_Summary <- bal.tab(EB_Weights_Category,
        stats=c("mean.diffs"),
        thresholds=c(m=0.01),
        disp=c("means"),un=TRUE)

## Export summary table to word:
EB_Weights_Category_Summary$Balance.Across.Pairs %>% 
  mutate(across(where(is.numeric), round, digits = 3)) %>% 
  write.csv(quote=F)



## Individual Weights here:
# EB_Weights$weights
Long_Weights_Category <-  cbind(Long,"Weights"=rep(EB_Weights_Category$weights,each=4))

## Export weighted:
write.csv(Long_Weights_Category,"Long_Weights_Category_2022_08_25.csv")



# End Of Script -----------------------------------------------------------