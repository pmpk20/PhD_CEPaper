#### PhDP1: Model Summaries ####
## Function: Compares MXL results
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 13/12/2022
## Change: Just compares Model 5 and 7



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
library(mded)
library(here)
library(data.table)
library(tidyverse)
library(ggdist)


#------------------------------------------
# Import Results And Models: ####
#------------------------------------------


database <- data.frame(fread(here("Data","Long_Weights_Category_2022_12_12.csv")))
ModelFive_WTP <- data.frame(fread(here("Output","PhD_MXL_ModelFive_2022_08_25_WTP.csv")))
ModelSeven_WTP <- data.frame(fread(here("Output","PhD_MXL_ModelSeven_2022_08_25_WTP.csv")))

Combined <-  cbind("b_Price.post.mean"=ModelSeven_WTP$b_Price.post.mean,
                   "b_Performance_10.post.mean"=ModelSeven_WTP$b_Performance_10.post.mean,
                   "b_Performance_50.post.mean"=ModelSeven_WTP$b_Performance_50.post.mean,
                   "b_Emissions_40.post.mean"=ModelSeven_WTP$b_Emissions_40.post.mean,
                   "b_Emissions_90.post.mean"=ModelSeven_WTP$b_Emissions_90.post.mean,
                   "Experts"=database$Experts[seq.int(1,nrow(database),4)]
) %>% data.frame()


#------------------------------------------
# Define Summary Function ####
#------------------------------------------


SummariseWTP <- function(WTP) {
  (rbind(
    paste0(round(median(WTP$b_Price.post.mean),  2), " (", round(quantile(WTP$b_Price.post.mean,  c(0.025)),  2),  ") - (",  round(quantile(WTP$b_Price.post.mean,  c(0.975)), 2), ")"), 
    paste0(round(median(WTP$b_Performance_10.post.mean),  2), " (", round(quantile(WTP$b_Performance_10.post.mean,  c(0.025)),  2),  ") - (",  round(quantile(WTP$b_Performance_10.post.mean,  c(0.975)), 2), ")"), 
    paste0(round(median(WTP$b_Performance_50.post.mean),  2), " (", round(quantile(WTP$b_Performance_50.post.mean,  c(0.025)),  2),  ") - (",  round(quantile(WTP$b_Performance_50.post.mean,  c(0.975)), 2), ")"), 
    paste0(round(median(WTP$b_Emissions_40.post.mean),  2), " (", round(quantile(WTP$b_Emissions_40.post.mean,  c(0.025)),  2),  ") - (",  round(quantile(WTP$b_Emissions_40.post.mean,  c(0.975)), 2), ")"), 
    paste0(round(median(WTP$b_Emissions_90.post.mean),  2), " (", round(quantile(WTP$b_Emissions_90.post.mean,  c(0.025)),  2),  ") - (",  round(quantile(WTP$b_Emissions_90.post.mean,  c(0.975)), 2), ")")))
}

#------------------------------------------
# Construct Table ####
#------------------------------------------

## Export Table
TableOutput <- cbind(
  data.frame("Level1"=SummariseWTP(-1*ModelSeven_WTP %>% filter(b_Price.ID %in% (database$ID[database$Experts==1] )))),
  data.frame("Level2"=SummariseWTP(-1*ModelSeven_WTP %>% filter(b_Price.ID %in% (database$ID[database$Experts==2] )))),
  data.frame("Level3"=SummariseWTP(-1*ModelSeven_WTP %>% filter(b_Price.ID %in% (database$ID[database$Experts==3] )))),
  data.frame("Level4"=SummariseWTP(-1*ModelSeven_WTP %>% filter(b_Price.ID %in% (database$ID[database$Experts==4] )))),
  data.frame("Level5"=SummariseWTP(-1*ModelSeven_WTP %>% filter(b_Price.ID %in% (database$ID[database$Experts==5] ))))) 

TableOutput %>% write.csv(quote=F,row.names=F)


#------------------------------------------
# Poe Test Part of the table ####
#------------------------------------------


## Initialise lists here:
Lists_Poes = matrix(0,5,5)
Table_Poes = matrix(0,5,5)
Variables <- Combined[,1:5] %>% colnames()


## Loop through each attribute
for (V in Variables){
  Lists_Poes[match(V,Variables),] <- c(
mded(distr1=Combined %>% filter(Experts==1) %>% dplyr::select(matches(V,ignore.case = FALSE))%>% unlist() %>% as.double(),
     distr2=Combined %>% filter(Experts==2) %>% dplyr::select(matches(V,ignore.case = FALSE))%>% unlist() %>% as.double())$stat,

mded(distr1=Combined %>% filter(Experts==2) %>% dplyr::select(matches(V,ignore.case = FALSE))%>% unlist() %>% as.double(),
     distr2=Combined %>% filter(Experts==3) %>% dplyr::select(matches(V,ignore.case = FALSE))%>% unlist() %>% as.double())$stat,

mded(distr1=Combined %>% filter(Experts==3) %>% dplyr::select(matches(V,ignore.case = FALSE))%>% unlist() %>% as.double(),
     distr2=Combined %>% filter(Experts==4) %>% dplyr::select(matches(V,ignore.case = FALSE))%>% unlist() %>% as.double())$stat,

mded(distr1=Combined %>% filter(Experts==4) %>% dplyr::select(matches(V,ignore.case = FALSE))%>% unlist() %>% as.double(),
     distr2=Combined %>% filter(Experts==5) %>% dplyr::select(matches(V,ignore.case = FALSE))%>% unlist() %>% as.double())$stat,

mded(distr1=Combined %>% filter(Experts==5) %>% dplyr::select(matches(V,ignore.case = FALSE))%>% unlist() %>% as.double(),
     distr2=Combined %>% filter(Experts==1) %>% dplyr::select(matches(V,ignore.case = FALSE))%>% unlist() %>% as.double())$stat
)
}
Table_Poes = Lists_Poes %>% data.frame()


## Using gsub twice to remove unneccesary characters from the attribute names
Variables_Clean <- gsub(gsub(".post.mean","",Variables),pattern = "b_",replacement = "")
rownames(Table_Poes) <- Variables_Clean
colnames(Table_Poes) <- c("1:2","2:3","3:4","4:5","5:1")

## Round numbers and export to word
Table_Poes %>% mutate(across(everything(),as.numeric)) %>% 
  round(3) %>% write.csv(quote=F)



#------------------------------------------
# Misc old stuff no longer used ####
#------------------------------------------

Tests <- bind_cols(
  mded(distr1=TableOutput$Level1,distr2=TableOutput$Level5)$stat,
  mded(distr1=TableOutput$Level2,distr2=TableOutput$Level1)$stat,
  mded(distr1=TableOutput$Level3,distr2=TableOutput$Level2)$stat,
  mded(distr1=TableOutput$Level4,distr2=TableOutput$Level3)$stat,
  mded(distr1=TableOutput$Level5,distr2=TableOutput$Level4)$stat
) %>% t() %>% data.frame()


mded(distr1=Combined$b_Price.post.mean[Combined$Experts==1],distr2=Combined$b_Price.post.mean[Combined$Experts==2])$stat
mded(distr1=Combined$b_Price.post.mean[Combined$Experts==2],distr2=Combined$b_Price.post.mean[Combined$Experts==3])$stat
mded(distr1=Combined$b_Price.post.mean[Combined$Experts==3],distr2=Combined$b_Price.post.mean[Combined$Experts==4])$stat
mded(distr1=Combined$b_Price.post.mean[Combined$Experts==4],distr2=Combined$b_Price.post.mean[Combined$Experts==5])$stat
mded(distr1=Combined$b_Price.post.mean[Combined$Experts==5],distr2=Combined$b_Price.post.mean[Combined$Experts==1])$stat


List_Ps = vector("list", length = 5)

V = "b_Price"
for (i in 1:5){
  List_Ps[[i]] = mded(distr1=Combined %>% filter(Experts==i) %>% dplyr::select(matches(V,ignore.case = FALSE))%>% unlist() %>% as.double(),
                      distr2=Combined %>% filter(Experts==3) %>% dplyr::select(matches(V,ignore.case = FALSE))%>% unlist() %>% as.double())$stat
}



# End Of Script ----------------------------------------------------