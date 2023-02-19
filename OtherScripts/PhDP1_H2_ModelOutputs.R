#### PhDP1: Model Summaries ####
## Function: Compares MXL results
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 18/02/2023
## Change: Just compares Model 5 and 7



# ****************************************
# Replication Information: ####
# ****************************************


# R version 4.2.0 (2022-04-22 ucrt)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows 10 x64 (build 19044)
#   [1] LC_COLLATE=English_United Kingdom.utf8  LC_CTYPE=English_United Kingdom.utf8
# [3] LC_MONETARY=English_United Kingdom.utf8 LC_NUMERIC=C
# [5] LC_TIME=English_United Kingdom.utf8
#   [1] ggplot2_3.3.6  reshape2_1.4.4 apollo_0.2.7



# ****************************************
# Setup Environment: ####
# ****************************************


rm(list = ls())


library(dplyr)
library(magrittr)
library(here)
library(data.table)



# ****************************************
# Import Results And Models: ####
# ****************************************


#--------- Estimates:
ModelFive_Estimates <- here("Output/ModelFiveB",
       "PhD_MXL_ModelFiveB_2023_02_18_estimates.csv") %>%
    fread() %>%
    data.frame()


ModelSeven_Estimates <- here("Output/ModelSevenB",
                             "PhD_MXL_ModelSevenB_2023_02_18_estimates.csv") %>%
  fread() %>%
  data.frame()


#--------- Outputs:
ModelFive_Models <- readRDS(here("Output/ModelFiveB","PhD_MXL_ModelFiveB_2023_02_18_model.rds"))
ModelSeven_Models <- readRDS(here("Output/ModelSevenB","PhD_MXL_ModelSevenB_2023_02_18_model.rds"))


# ***************************************
# First Table: Summary Of MNLs ####
# ***************************************



ModelOutput <- function(Estimates) {
  data.frame("Variable" =  Estimates$V1,
             "Estimate" =  paste(
               ifelse(
                 Estimates$Rob.p.val.0. < 0.01,
                 paste0(round(Estimates$Estimate,  3),  "***"),
                 ifelse(
                   Estimates$Rob.p.val.0. < 0.05,
                   paste0(round(Estimates$Estimate,  3),  "**"),
                   ifelse(
                     Estimates$Rob.p.val.0. < 0.1,
                     paste0(round(Estimates$Estimate,  3),  "*"),
                     round(Estimates$Estimate,  3)
                   )
                 )
               ),
               paste0("(", round(abs(Estimates$Rob.std.err.),  3), ")")))
}



# ****************************************
# Second Table: Summary Of Mixed Logits ####
# ****************************************


## Export Categorical MXL Models:
cbind(ModelOutput(ModelFive_Estimates),
      ModelOutput(ModelSeven_Estimates)[,2])  %>%
  fwrite(sep=",",
         here("Output/Tables","Table5_ModelComparisons.txt"),
         row.names = TRUE,
         quote = FALSE)



# End Of Script ----------------------------------------------------
