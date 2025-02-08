#### PhDP1: EB ####
## Function: Model Seven B: Categorical experts and weighted now with more controls
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 18/02/2023
## TODO: setup RENV


# *****************************
# Replication Information: ####
# Selected output of 'sessionInfo()'
# *****************************


# R version 4.2.2 (2022-10-31 ucrt)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows 10 x64 (build 19045)
# Matrix products: default
#
# locale:
#   [1] LC_COLLATE=English_United Kingdom.utf8
# LC_CTYPE=English_United Kingdom.utf8
# [3] LC_MONETARY=English_United Kingdom.utf8
# LC_NUMERIC=C
# [5] LC_TIME=English_United Kingdom.utf8
#
# attached base packages:
#   [1] stats     graphics  grDevices utils
# datasets  methods   base
#
# other attached packages:
#   [1] lintr_3.0.2       cobalt_4.4.1
# WeightIt_0.13.1   MatchIt_4.5.0
# [5] ggalluvial_0.12.4 ggdist_3.2.1
# forcats_0.5.2     stringr_1.5.0
# [9] purrr_1.0.1       readr_2.1.3
# tidyr_1.2.1       tibble_3.1.8
# [13] tidyverse_1.3.2   data.table_1.14.6
# here_1.0.1        mded_0.1-2
# [17] reshape2_1.4.4    ggridges_0.5.4
# ggplot2_3.4.0     magrittr_2.0.3
# [21] dplyr_1.1.0       apollo_0.2.8
#
# loaded via a namespace (and not attached):
#   [1] googledrive_2.0.0    colorspace_2.0-3
# ellipsis_0.3.2       rprojroot_2.0.3
# [5] fs_1.6.0             rstudioapi_0.14
# farver_2.1.1         MatrixModels_0.5-1
# [9] remotes_2.4.2        fansi_1.0.3
# mvtnorm_1.1-3        lubridate_1.9.1
# [13] RSGHB_1.2.2          xml2_1.3.3
# splines_4.2.2        mnormt_2.1.1
# [17] jsonlite_1.8.4       mcmc_0.9-7
# broom_1.0.3          dbplyr_2.3.0
# [21] compiler_4.2.2       httr_1.4.4
# MLEcens_0.1-7        backports_1.4.1
# [25] lazyeval_0.2.2       assertthat_0.2.1
# Matrix_1.5-1         gargle_1.2.1
# [29] cli_3.6.0            quantreg_5.94
# prettyunits_1.1.1    tools_4.2.2
# [33] perm_1.0-0.2         coda_0.19-4
# gtable_0.3.1         glue_1.6.2
# [37] Rcpp_1.0.9           cellranger_1.1.0
# vctrs_0.5.2          randtoolbox_2.0.3
# [41] ps_1.7.2             rvest_1.0.3
# timechange_0.2.0     lifecycle_1.0.3
# [45] rngWELL_0.10-9       googlesheets4_1.0.1
# MASS_7.3-58.1        zoo_1.8-11
# [49] scales_1.2.1         miscTools_0.6-26
# hms_1.1.2            rex_1.2.1
# [53] parallel_4.2.2       sandwich_3.0-2
# xmlparsedata_1.0.5   SparseM_1.81
# [57] RColorBrewer_1.1-3   stringi_1.7.12
# desc_1.4.2           cyclocomp_1.1.0
# [61] pkgbuild_1.4.0       rlang_1.0.6
# pkgconfig_2.0.3      matrixStats_0.63.0
# [65] distributional_0.3.1 lattice_0.20-45
# tidyselect_1.2.0     processx_3.8.0
# [69] plyr_1.8.8           R6_2.5.1
# generics_0.1.3       DBI_1.1.3
# [73] pillar_1.8.1         haven_2.5.1
# withr_2.5.0          survival_3.4-0
# [77] modelr_0.1.10        crayon_1.5.2
# utf8_1.2.2           tzdb_0.3.0
# [81] maxLik_1.5-2         grid_4.2.2
# readxl_1.4.1         callr_3.7.3
# [85] reprex_2.0.2         digest_0.6.31
# numDeriv_2016.8-1.1  MCMCpack_1.6-3
# [89] munsell_0.5.0


# renv::snapshot()
rm(list=ls())
library(here)
library(tidyr)
library(apollo)
library(ggridges)
library(ggplot2)
library(reshape2)
library(dplyr)
library(magrittr)
library(data.table)


# *****************************
# Section 1: Import Data ####
# Selected output of 'sessionInfo()'
# *****************************


here() ## This is the preferred approach to Setwd()

## Setup Data:
database <- here("Data","Long_Weights_Category_Clean.csv") %>%
  fread() %>% data.frame()


# *****************************
# Setup Apollo: ####
# *****************************

apollo_initialise()

### Set core controls
apollo_control = list(
  modelName       = "PhD_MXL_ModelSevenB_2023_02_18",
  modelDescr      = "PhD_MXL_ModelSevenB_2023_02_18",
  indivID         = "ID",
  mixing=TRUE,
  nCores=10,
  weights="Weights",
  outputDirectory="Output/ModelSevenB"
)


# *****************************
# Define Parameters: ####
# *****************************

### Vector of parameters, including any that are kept fixed in estimation
apollo_beta=c(asc_A      = 0,
              asc_B      = 0,
              mu_Performance_10 = 1,
              mu_Performance_50 = 1,
              mu_Emissions_40 = 1,
              mu_Emissions_90 = 1,
              mu_Price = -3,
              sig_Performance_10 = 0,
              sig_Performance_50 = 0,
              sig_Emissions_40 = 0,
              sig_Emissions_90 = 0,
              sig_Price = 0.1,

              Experts_Performance_10_Int = 1,
              Experts_Performance_50_Int = 1,
              Experts_Emissions_40_Int = 1,
              Experts_Emissions_90_Int = 1,

              b_Order = 0,
              b_Gender = 0,
              b_Age      = 0,
              b_Distance = 0,
              b_Knowledge = 0,
              b_Charity  = 0,
              b_Education  = 0,
              b_Income     = 0,
              b_Cons       = 0,
              b_BP    = 0,
              b_Understanding = 0,
              b_Certainty = 0,
              b_Q13 = 0,
              b_Q14 = 0,
              b_Q15 = 0)

### Vector with names (in quotes) of parameters to be kept fixed at their starting value in apollo_beta, use apollo_beta_fixed = c() if none
apollo_fixed = c("asc_B")



### Set parameters for generating draws
apollo_draws = list(
  interDrawsType = "pmc",
  interNDraws    = 1000,
  interUnifDraws = c(),
  interNormDraws = c("Draws_Performance_10" , "Draws_Performance_50",
                     "Draws_Emissions_40","Draws_Emissions_90",
                     "draws_Price" ),
  intraDrawsType = "halton",
  intraNDraws    = 0,
  intraUnifDraws = c(),
  intraNormDraws = c()
)
### Create random parameters
apollo_randCoeff = function(apollo_beta, apollo_inputs){
  randcoeff = list()
  randcoeff[["b_Price"]] = -exp(mu_Price + sig_Price * draws_Price )
  randcoeff[["b_Performance_10"]] =  (mu_Performance_10+    sig_Performance_10*Draws_Performance_10)
  randcoeff[["b_Performance_50"]] =  (mu_Performance_50+    sig_Performance_50*Draws_Performance_50)
  randcoeff[["b_Emissions_40"]] =  ( mu_Emissions_40+    sig_Emissions_40*Draws_Emissions_40)
  randcoeff[["b_Emissions_90"]] =  (mu_Emissions_90+    sig_Emissions_90*Draws_Emissions_90)
  return(randcoeff)
}

apollo_inputs = apollo_validateInputs()


# *****************************
# Establish Likelihood Function: ####
# *****************************


apollo_probabilities=function(apollo_beta, apollo_inputs, functionality="estimate"){

  ### Attach inputs and detach after function exit
  apollo_attach(apollo_beta, apollo_inputs)
  on.exit(apollo_detach(apollo_beta, apollo_inputs))

  Interactions =
    Experts_Performance_10_Int * ((Performance_B == 10) * Experts)+
    Experts_Performance_50_Int * ((Performance_B == 50) * Experts)+
    Experts_Emissions_40_Int * ((Emission_B == 40) * Experts)+
    Experts_Emissions_90_Int * ((Emission_B == 90) * Experts)

  asc_B1 = asc_B +
    b_Order * Order +
    b_Gender * Q1Gender +
    b_Age      * Age +
    b_Distance * Distance +
    b_Knowledge *  Q5Knowledge +
    b_Charity  * Charity +
    b_Education  * Education +
    b_Income     * IncomeDummy +
    b_Cons       * Consequentiality +
    b_BP    * BP +
    b_Understanding * Survey +
    b_Certainty * Q12CECertainty +
    b_Q13 * Q13CurrentThreatToSelf +
    b_Q14 * Q14FutureThreatToSelf +
    b_Q15 * Q15ThreatToEnvironment

  ### Create list of probabilities P
  P = list()

  ### List of utilities: these must use the same names as in mnl_settings, order is irrelevant
  V = list()
  V[["A"]]  = asc_A


  V[["B"]]  = asc_B1  +  b_Price *((Price_B)+
                                     (b_Performance_10 * (Performance_B == 10))+
                                     (b_Performance_50 * (Performance_B == 50))+
                                     (b_Emissions_40 * (Emission_B == 40))+
                                     (b_Emissions_90 * (Emission_B == 90)))+
    Interactions

  ### Define settings for MNL model component
  mnl_settings = list(
    alternatives  = c(A = 1,  B=2),
    avail         = list(A = 1,  B=1),
    choiceVar     = Choice,
    utilities     = V
  )

  ## Compute probabilities using MNL model
  P[['model']] = apollo_mnl(mnl_settings, functionality)

  ## Take product across observation for same individual
  P = apollo_panelProd(P, apollo_inputs, functionality)

  ## Average across inter-individual draws
  P = apollo_avgInterDraws(P, apollo_inputs, functionality)

  ## Include EB weights into log-likelihood
  P = apollo_weighting(P,apollo_inputs,functionality)

  ## Prepare and return outputs of function
  P = apollo_prepareProb(P, apollo_inputs, functionality)
  return(P)
}

# *****************************
# Estimation: ####
# *****************************

## Actually estimates the model
PhD_MXL_ModelSevenB_2023_02_18 = apollo_estimate(apollo_beta, apollo_fixed, apollo_probabilities, apollo_inputs)

## Model output and results here alongside saving information
apollo_modelOutput(PhD_MXL_ModelSevenB_2023_02_18,modelOutput_settings = list(printPVal=TRUE))
apollo_saveOutput(PhD_MXL_ModelSevenB_2023_02_18,saveOutput_settings = list(printPVal=TRUE))
# saveRDS(PhD_MXL_ModelSevenB_2023_02_18, file="PhD_MXL_ModelSevenB_2023_02_18.rds")


# *****************************
# Summarise WTP: ####
# *****************************


Model <- readRDS(
  here("Output/ModelSevenB",
       "PhD_MXL_ModelSevenB_2023_02_18_model.rds")) ## Enter model of interest RDS here


# Conditionals: *****************************
PhD_MXL_ModelSevenB_2023_02_18_WTP <- apollo_conditionals(Model,apollo_probabilities,apollo_inputs )
PhD_MXL_ModelSevenB_2023_02_18_WTP %>%
  data.frame() %>%
  fwrite(sep=",",
         here("Output/ModelSevenB",
              "PhD_MXL_ModelSevenB_2023_02_18_WTP.csv"))


# Unconditionals: *****************************
PhD_MXL_ModelSevenB_2023_02_18_UCWTP <- apollo_unconditionals(Model,apollo_probabilities,apollo_inputs )
PhD_MXL_ModelSevenB_2023_02_18_UCWTP %>%
  data.frame() %>%
  fwrite(sep=",",
         here("Output/ModelSevenB",
              "PhD_MXL_ModelSevenB_2023_02_18_UCWTP.csv"))




# *****************************
# OLD CODE: ####
# *****************************




#
# PhD_MXL_ModelSevenB_2023_02_18_Unconditionals <- apollo_unconditionals(Model,apollo_probabilities,apollo_inputs )
# write.csv(PhD_MXL_ModelSevenB_2023_02_18_Unconditionals,"PhD_MXL_ModelSevenB_2023_02_18_Unconditionals.csv")


#
# PhD_MXL_ModelSevenB_2023_02_18_WTPSummary <-data.frame(cbind("b_Performance_10"=PhD_MXL_ModelSevenB_2023_02_18_WTP$b_Performance_10$post.mean,
#                                                                                 "b_Performance_50"=PhD_MXL_ModelSevenB_2023_02_18_WTP$b_Performance_50$post.mean,
#                                                                                 "b_Emissions_40"=PhD_MXL_ModelSevenB_2023_02_18_WTP$b_Emissions_40$post.mean,
#                                                                                 "b_Emissions_90"=PhD_MXL_ModelSevenB_2023_02_18_WTP$b_Emissions_90$post.mean,
#                                                                                 "b_ManagementDeterrent"=PhD_MXL_ModelSevenB_2023_02_18_WTP$b_ManagementDeterrent$post.mean,
#                                                                                 "b_ManagementNothing"=PhD_MXL_ModelSevenB_2023_02_18_WTP$b_ManagementNothing$post.mean))
# apollo_sink()
# PhD_MXL_ModelSevenB_2023_02_18_WTP %>% select(ends_with(".post.mean")) %>% summarise(across(everything(),list(mean)))
# apollo_sink()
# PhD_MXL_ModelSevenB_2023_02_18_WTP <- data.frame(read.csv("PhD_MXL_ModelSevenB_2023_02_18_WTP.csv"))


# Trim the stupidly large price estimates
# PhD_MXL_ModelSevenB_2023_02_18_WTP <- PhD_MXL_ModelSevenB_2023_02_18_WTP[PhD_MXL_ModelSevenB_2023_02_18_WTP$b_Price.post.mean> -5,]
# WTP <- PhD_MXL_ModelSevenB_2023_02_18_WTP %>% select(ends_with(".post.mean")) %>% select(!starts_with("b_Price"))
# WTP <- WTP*-1

# ggsave(PhD_MXL_ModelSevenB_2023_02_18_WTP %>% select(ends_with(".post.mean")) %>% reshape2::melt() %>% ggplot(aes(x=value,y=variable,group=variable,fill=variable))+
#          geom_density_ridges()+geom_vline(xintercept=0,linetype='dashed')+
#          scale_x_continuous(name="mWTP in pounds."),
#        device = "jpeg",
#        filename = "PhD_MXL_ModelSevenB_2023_02_18_WTP_DensityPlot.jpeg",
#        width=20,height=15,units = "cm",dpi=1000)

## Plot Without Costs:
# ggsave(WTP %>% reshape2::melt() %>% ggplot(aes(x=value,y=variable,group=variable,fill=variable))+
#          geom_density_ridges()+geom_vline(xintercept=0,linetype='dashed')+
#          scale_x_continuous(name="mWTP in pounds."),
#        device = "jpeg",
#        filename = "PhD_MXL_ModelSevenB_2023_02_18_WTP_NoCost_DensityPlot.jpeg",
#        width=20,height=15,units = "cm",dpi=1000)


# End of script ******************************************************
