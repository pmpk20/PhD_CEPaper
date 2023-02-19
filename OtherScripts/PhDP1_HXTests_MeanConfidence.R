#### PhDP1: WTP Summary ####
## Function: Hypothesis Two Tests Confidence vs confidence
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 18/02/2023
## Change: Changing to the categorical models instead



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


# ****************************************
# Import Results And Models: ####
# ****************************************

database <- data.frame(fread(here("Data","Long_Weights_Category_2022_12_12.csv")))


# ****************************************
# MAKE EACH COLUMN OF THE TABLE: ####
# ****************************************


## Test frequency of A and B choices per level with the reference level being `low`:
TestTable_PartA <- bind_cols(
  database$Q12CECertainty[database$Experts==1] %>% mean(),
  database$Q12CECertainty[database$Experts==1] %>% mean(),
  database$Q12CECertainty[database$Experts==1] %>% mean(),
  database$Q12CECertainty[database$Experts==1] %>% mean()) %>%
  t() %>% data.frame()



## Test frequency of A and B choices per level with the reference level being `low`:
TestTable_PartB <- bind_cols(
  database$Q12CECertainty[database$Experts==2] %>% mean(),
  database$Q12CECertainty[database$Experts==3] %>% mean(),
  database$Q12CECertainty[database$Experts==4] %>% mean(),
  database$Q12CECertainty[database$Experts==5] %>% mean()) %>%
  t() %>% data.frame()



## Test frequency of A and B choices per level with the reference level being `low`:
TestTable_PartC <- bind_cols(
  wilcox.test(x =   database$Q12CECertainty[database$Experts==1],  database$Q12CECertainty[database$Experts==2])$p.value,
  wilcox.test(x =   database$Q12CECertainty[database$Experts==1],  database$Q12CECertainty[database$Experts==3])$p.value,
  wilcox.test(x =   database$Q12CECertainty[database$Experts==1],  database$Q12CECertainty[database$Experts==4])$p.value,
  wilcox.test(x =   database$Q12CECertainty[database$Experts==1],  database$Q12CECertainty[database$Experts==5])$p.value) %>%
  t() %>% data.frame()



# ****************************************
# COMBINES COLUMNS OF THE TABLE: ####
# ****************************************


TestTable <- bind_cols(TestTable_PartA %>% round(3),
          TestTable_PartB %>% round(3),
          TestTable_PartC %>% round(3))

rownames(TestTable)<- c("1","2",
                        "3","4")
colnames(TestTable)<- c("Group1Mean","Group1Mean","PValues")




# ****************************************
# EXPORTS ####
# ****************************************



## Export:
TestTable %>%
  fwrite(sep=",",
         here("Output/Tables","TableX_MeanConfidence.txt"),
         row.names = TRUE,
         quote = FALSE)


# End of script ************************************
