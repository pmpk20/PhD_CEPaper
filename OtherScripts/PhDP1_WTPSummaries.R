#### PhDP1: WTP Summary ####
## Function: Poe tests WTP
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 26/08/2022
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
library(mded)


#------------------------------------------
# Import Results And Models: ####
#------------------------------------------


#--------- Estimates:
database <- data.frame(read.csv("Long_Weights_Dummy_2022_08_25.csv"))
ModelFive_WTP <- data.frame(read.csv("PhD_MXL_ModelFive_2022_08_25_WTP.csv"))
ModelSix_WTP <- data.frame(read.csv("PhD_MXL_ModelSix_2022_08_25_WTP.csv"))
ModelSeven_WTP <- data.frame(read.csv("PhD_MXL_ModelSeven_2022_08_25_WTP.csv"))
ModelEight_WTP <- data.frame(read.csv("PhD_MXL_ModelEight_2022_08_25_WTP.csv"))


#------------------------------------------
# Summary function: ####
#------------------------------------------


SummariseWTP <- function(WTP) {
  data.frame("Title"=rbind(
    paste0(round(median(WTP$b_Price.post.mean),  2), " (", round(quantile(WTP$b_Price.post.mean,  c(0.025)),  2),  ") - (",  round(quantile(WTP$b_Price.post.mean,  c(0.975)), 2), ")"), 
    paste0(round(median(WTP$b_Performance_10.post.mean),  2), " (", round(quantile(WTP$b_Performance_10.post.mean,  c(0.025)),  2),  ") - (",  round(quantile(WTP$b_Performance_10.post.mean,  c(0.975)), 2), ")"), 
    paste0(round(median(WTP$b_Performance_50.post.mean),  2), " (", round(quantile(WTP$b_Performance_50.post.mean,  c(0.025)),  2),  ") - (",  round(quantile(WTP$b_Performance_50.post.mean,  c(0.975)), 2), ")"), 
    paste0(round(median(WTP$b_Emissions_40.post.mean),  2), " (", round(quantile(WTP$b_Emissions_40.post.mean,  c(0.025)),  2),  ") - (",  round(quantile(WTP$b_Emissions_40.post.mean,  c(0.975)), 2), ")"), 
    paste0(round(median(WTP$b_Emissions_90.post.mean),  2), " (", round(quantile(WTP$b_Emissions_90.post.mean,  c(0.025)),  2),  ") - (",  round(quantile(WTP$b_Emissions_90.post.mean,  c(0.975)), 2), ")")))
}

#------------------------------------------
# Manipulate data: ####
#------------------------------------------

## Export Table
cbind(
  SummariseWTP(-1*ModelEight_WTP %>% filter(b_Price.ID %in% (database$ID[database$ExpertsDummy==0] ))),
  SummariseWTP(-1*ModelEight_WTP %>% filter(b_Price.ID %in% (database$ID[database$ExpertsDummy==1] )))) %>% write.csv(quote=F,row.names=F)


## This helps to trim and truncate WTP:
TransformWTP <- function(WTP) {
  
  WTP$Dummy <- ifelse(WTP$b_Price.ID %in% 
                        (database$ID[database$ExpertsDummy==0]),0,1)
  WTP_Trimmed <- WTP[WTP$b_Price.post.mean>-25,]
  WTP_Trimmed <- data.frame(cbind(
    "b_Price.post.mean"=WTP_Trimmed$b_Price.post.mean,
    "b_Performance_10.post.mean"=WTP_Trimmed$b_Performance_10.post.mean*-1,
    "b_Performance_50.post.mean"=WTP_Trimmed$b_Performance_50.post.mean*-1,
    "b_Emissions_40.post.mean"=WTP_Trimmed$b_Emissions_40.post.mean*-1,
    "b_Emissions_90.post.mean"=WTP_Trimmed$b_Emissions_90.post.mean*-1,
    "Dummy"=WTP_Trimmed$Dummy))
  return(WTP_Trimmed)
}


#------------------------------------------
# Poe tests: ####
#------------------------------------------


## Handily calculates and stores P Value of Poe tests per attribute
PoeResults <- function(WTP) {
  PoeResultsTable <- c(
    mded(WTP$b_Performance_10.post.mean[WTP$Dummy==0],
         WTP$b_Performance_10.post.mean[WTP$Dummy==1])$stat,
    
    mded(WTP$b_Performance_50.post.mean[WTP$Dummy==0],
         WTP$b_Performance_50.post.mean[WTP$Dummy==1])$stat,
    
    mded(WTP$b_Emissions_40.post.mean[WTP$Dummy==0],
         WTP$b_Emissions_40.post.mean[WTP$Dummy==1])$stat,
    
    mded(WTP$b_Emissions_90.post.mean[WTP$Dummy==0],
         WTP$b_Emissions_90.post.mean[WTP$Dummy==1])$stat
  )
  return(PoeResultsTable)
  
}


PoeResults(TransformWTP(ModelSeven_WTP))


#------------------------------------------
# Mann-Whitney tests: ####
#------------------------------------------

c(
  wilcox.test(EightWTP$b_Performance_10.post.mean[EightWTP$Dummy==0],
              EightWTP$b_Performance_10.post.mean[EightWTP$Dummy==1])$p.value,
  
  wilcox.test(EightWTP$b_Performance_50.post.mean[EightWTP$Dummy==0],
              EightWTP$b_Performance_50.post.mean[EightWTP$Dummy==1])$p.value,
  
  wilcox.test(EightWTP$b_Emissions_40.post.mean[EightWTP$Dummy==0],
              EightWTP$b_Emissions_40.post.mean[EightWTP$Dummy==1])$p.value,
  
  wilcox.test(EightWTP$b_Emissions_90.post.mean[EightWTP$Dummy==0],
              EightWTP$b_Emissions_90.post.mean[EightWTP$Dummy==1])$p.value
)



