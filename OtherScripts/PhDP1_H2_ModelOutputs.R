#### PhDP1: Model Summaries ####
## Function: Compares MXL results
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 08/02/2025
## Change: Just compares Model 5 and 7
# - Fixing column names and output
# - TODO: change model names



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


# Estimates:
ModelFive_Estimates <- here("Output/ModelFiveB",
       "PhD_MXL_ModelFiveB_2023_02_18_estimates.csv") %>%
    fread() %>%
    data.frame()


ModelSeven_Estimates <- here("Output/ModelSevenB",
                             "PhD_MXL_ModelSevenB_2023_02_18_estimates.csv") %>%
  fread() %>%
  data.frame()


# Outputs:

ModelFive_Models <-
  readRDS(here(
    "Output/ModelFiveB",
    "PhD_MXL_ModelFiveB_2023_02_18_model.rds"
  ))
ModelSeven_Models <-
  readRDS(here(
    "Output/ModelSevenB",
    "PhD_MXL_ModelSevenB_2023_02_18_model.rds"
  ))

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


## This function outputs some model diagnostics
Diagnostics <- function(Model) {
  rbind(
    "N" = Model$nIndivs,
    "AIC" = Model$AIC %>% round(3) %>% sprintf("%.3f", .),
    "Adj.R2" = Model$adjRho2_0 %>% round(3) %>% sprintf("%.3f", .),
    "LogLik" = Model$LLout %>% as.numeric() %>% round(3) %>% sprintf("%.3f", .)
  )
}


# ****************************************
# Second Table: Summary Of Mixed Logits ####
# ****************************************



## Stitch model outputs
TopPart <- data.frame(ModelOutput(ModelFive_Estimates)[, 1],
                 ModelOutput(ModelFive_Estimates)[, 2],
                 ModelOutput(ModelSeven_Estimates)[, 2])

## and diagnostic measures
BottomPart <- cbind(
  Diagnostics(ModelFive_Models) %>% rownames(),
  Diagnostics(ModelFive_Models),
  Diagnostics(ModelSeven_Models))


## Correct column names to allow binding
colnames(TopPart) <- c("Variable", "Unweighted", "Weighted")
colnames(BottomPart) <- colnames(TopPart)


## Mush together
Completed <- rbind(TopPart, BottomPart)
colnames(Completed) <- c("Variable", "Unweighted", "Weighted")


## Export Categorical MXL Models:
Completed %>%
  data.frame() %>%
  fwrite(sep=",",
         here("Output/Tables","Table5_ModelComparisons.txt"),
         row.names = FALSE,
         quote = FALSE)



# End Of Script ----------------------------------------------------
