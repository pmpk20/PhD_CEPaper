#### PhDP1: Entropy Balancing Weights For Experts ####
## Function: Weights the sample using dummy coding: for the appendix
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 12/12/2022



#------------------------------
# Replication Information: ####
#------------------------------


# R version 4.1.3 (2022-03-10)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows 10 x64 (build 19045)
# Matrix products: default
# locale:
#   [1] LC_COLLATE=English_United Kingdom.1252  LC_CTYPE=English_United Kingdom.1252   
# [3] LC_MONETARY=English_United Kingdom.1252 LC_NUMERIC=C                           
# [5] LC_TIME=English_United Kingdom.1252    
# 
# attached base packages:
#   [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
#   [1] here_1.0.1        data.table_1.14.2 cobalt_4.4.0      WeightIt_0.13.1  
# [5] MatchIt_4.4.0     ggalluvial_0.12.3 reshape2_1.4.4    ggridges_0.5.4   
# [9] ggplot2_3.3.6     magrittr_2.0.3    dplyr_1.0.10      apollo_0.2.8     
# 
# loaded via a namespace (and not attached):
#   [1] Rcpp_1.0.8.3        mvtnorm_1.1-3       lattice_0.20-45     zoo_1.8-11         
# [5] rprojroot_2.0.3     rngWELL_0.10-7      assertthat_0.2.1    digest_0.6.29      
# [9] utf8_1.2.2          R6_2.5.1            plyr_1.8.7          backports_1.4.1    
# [13] MatrixModels_0.5-1  coda_0.19-4         pillar_1.7.0        miscTools_0.6-26   
# [17] rlang_1.0.6         rstudioapi_0.13     SparseM_1.81        Matrix_1.5-1       
# [21] splines_4.1.3       randtoolbox_1.31.1  stringr_1.4.1       munsell_0.5.0      
# [25] compiler_4.1.3      numDeriv_2016.8-1.1 pkgconfig_2.0.3     mnormt_2.1.1       
# [29] RSGHB_1.2.2         maxLik_1.5-2        mcmc_0.9-7          tidyselect_1.1.2   
# [33] tibble_3.1.8        matrixStats_0.62.0  fansi_1.0.3         crayon_1.5.1       
# [37] withr_2.5.0         MASS_7.3-56         grid_4.1.3          gtable_0.3.0       
# [41] lifecycle_1.0.3     DBI_1.1.3           scales_1.2.1        cli_3.4.1          
# [45] stringi_1.7.8       ellipsis_0.3.2      vctrs_0.5.0         generics_0.1.2     
# [49] sandwich_3.0-2      RColorBrewer_1.1-3  tools_4.1.3         glue_1.6.2         
# [53] purrr_0.3.4         parallel_4.1.3      survival_3.3-1      colorspace_2.0-3   
# [57] quantreg_5.94       MCMCpack_1.6-3   



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
library(here)


#------------------------------------------
# Import Data: ####
#------------------------------------------


## Read in latest version of data in wide format
Wide <- data.frame(fread(here("Data","SurveyData_2022_06_02.csv")))
Long <- data.frame(fread(here("Data","Test_Apollo.csv")))

#------------------------------------------
# Data Manipulation: ####
#------------------------------------------



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
# APPENDIX: Estimate Weights For Dummy: ####
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


# End Of Script -----------------------------------------------------------