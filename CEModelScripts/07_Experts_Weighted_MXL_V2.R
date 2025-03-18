#### Experts: Weighted MXL ####
## Function: Weighted: Categorical experts and weighted now with more controls
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 18/03/2025
## Change:
# - Correcting ASC


# *****************************
# Replication Information: ####
# Selected output of 'sessionInfo()'
# *****************************


# > session_info()
# ─ Session info ──────────────────────────────────────────────────────────────
# setting  value
# version  R version 4.4.1 (2024-06-14 ucrt)
# os       Windows 11 x64 (build 22631)
# system   x86_64, mingw32
# ui       RStudio
# language (EN)
# collate  English_United Kingdom.utf8
# ctype    English_United Kingdom.utf8
# tz       Europe/London
# date     2025-02-12
# rstudio  2023.06.2+561 Mountain Hydrangea (desktop)
# pandoc   3.1.1 @ C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools/ (via rmarkdown)
#
# ─ Packages ──────────────────────────────────────────────────────────────────
# package        * version    date (UTC) lib source
# apollo         * 0.3.4      2024-10-01 [1] CRAN (R 4.4.1)
# backports        1.5.0      2024-05-23 [1] CRAN (R 4.4.0)
# bgw              0.1.3      2024-03-29 [1] CRAN (R 4.4.0)
# chk              0.9.1      2023-10-06 [1] CRAN (R 4.4.0)
# cli              3.6.3      2024-06-21 [1] CRAN (R 4.4.1)
# cobalt         * 4.5.5      2024-04-02 [1] CRAN (R 4.4.0)
# coda             0.19-4.1   2024-01-31 [1] CRAN (R 4.4.0)
# colorspace       2.1-0      2023-01-23 [1] CRAN (R 4.4.0)
# crayon           1.5.3      2024-06-20 [1] CRAN (R 4.4.1)
# data.table     * 1.15.4     2024-03-30 [1] CRAN (R 4.4.0)
# digest           0.6.35     2024-03-11 [1] CRAN (R 4.4.0)
# distributional * 0.4.0      2024-02-07 [1] CRAN (R 4.4.0)
# dplyr          * 1.1.4      2023-11-17 [1] CRAN (R 4.4.0)
# evaluate         0.24.0     2024-06-10 [1] CRAN (R 4.4.0)
# fansi            1.0.6      2023-12-08 [1] CRAN (R 4.4.0)
# farver           2.1.2      2024-05-13 [1] CRAN (R 4.4.0)
# fastmap          1.2.0      2024-05-15 [1] CRAN (R 4.4.0)
# forcats        * 1.0.0      2023-01-29 [1] CRAN (R 4.4.0)
# generics         0.1.3      2022-07-05 [1] CRAN (R 4.4.0)
# ggdist         * 3.3.2      2024-03-05 [1] CRAN (R 4.4.0)
# ggplot2        * 3.5.1      2024-04-23 [1] CRAN (R 4.4.0)
# ggridges       * 0.5.6      2024-01-23 [1] CRAN (R 4.4.0)
# glue             1.7.0      2024-01-09 [1] CRAN (R 4.4.0)
# gridExtra      * 2.3        2017-09-09 [1] CRAN (R 4.4.0)
# gtable           0.3.5      2024-04-22 [1] CRAN (R 4.4.0)
# here           * 1.0.1      2020-12-13 [1] CRAN (R 4.4.0)
# hms              1.1.3      2023-03-21 [1] CRAN (R 4.4.0)
# htmltools        0.5.8.1    2024-04-04 [1] CRAN (R 4.4.0)
# janitor        * 2.2.0      2023-02-02 [1] CRAN (R 4.4.1)
# knitr            1.47       2024-05-29 [1] CRAN (R 4.4.0)
# labeling         0.4.3      2023-08-29 [1] CRAN (R 4.4.0)
# lattice          0.22-6     2024-03-20 [1] CRAN (R 4.4.1)
# lifecycle        1.0.4      2023-11-07 [1] CRAN (R 4.4.0)
# lubridate      * 1.9.3      2023-09-27 [1] CRAN (R 4.4.0)
# magrittr       * 2.0.3      2022-03-30 [1] CRAN (R 4.4.0)
# MASS             7.3-61     2024-06-13 [1] CRAN (R 4.4.1)
# MatchIt        * 4.5.5      2023-10-13 [1] CRAN (R 4.4.0)
# Matrix           1.7-0      2024-04-26 [1] CRAN (R 4.4.1)
# MatrixModels     0.5-3      2023-11-06 [1] CRAN (R 4.4.0)
# matrixStats      1.3.0      2024-04-11 [1] CRAN (R 4.4.0)
# maxLik           1.5-2.1    2024-03-24 [1] CRAN (R 4.4.0)
# mcmc             0.9-8      2023-11-16 [1] CRAN (R 4.4.0)
# MCMCpack         1.7-0      2024-01-18 [1] CRAN (R 4.4.0)
# mded           * 0.1-2      2015-04-27 [1] CRAN (R 4.4.0)
# miscTools        0.6-28     2023-05-03 [1] CRAN (R 4.4.0)
# mnormt           2.1.1      2022-09-26 [1] CRAN (R 4.4.0)
# munsell          0.5.1      2024-04-01 [1] CRAN (R 4.4.0)
# mvtnorm          1.2-5      2024-05-21 [1] CRAN (R 4.4.0)
# numDeriv         2016.8-1.1 2019-06-06 [1] CRAN (R 4.4.0)
# pillar           1.9.0      2023-03-22 [1] CRAN (R 4.4.0)
# pkgconfig        2.0.3      2019-09-22 [1] CRAN (R 4.4.0)
# plyr             1.8.9      2023-10-02 [1] CRAN (R 4.4.0)
# purrr          * 1.0.2      2023-08-10 [1] CRAN (R 4.4.0)
# quantreg         5.98       2024-05-26 [1] CRAN (R 4.4.0)
# R6               2.5.1      2021-08-19 [1] CRAN (R 4.4.0)
# randtoolbox      2.0.4      2023-01-28 [1] CRAN (R 4.4.0)
# RColorBrewer   * 1.1-3      2022-04-03 [1] CRAN (R 4.4.0)
# Rcpp             1.0.12     2024-01-09 [1] CRAN (R 4.4.0)
# readr          * 2.1.5      2024-01-10 [1] CRAN (R 4.4.0)
# reshape2       * 1.4.4      2020-04-09 [1] CRAN (R 4.4.0)
# rlang            1.1.4      2024-06-04 [1] CRAN (R 4.4.0)
# rmarkdown        2.27       2024-05-17 [1] CRAN (R 4.4.0)
# rngWELL          0.10-9     2023-01-16 [1] CRAN (R 4.4.0)
# rprojroot        2.0.4      2023-11-05 [1] CRAN (R 4.4.0)
# RSGHB            1.2.2      2019-07-03 [1] CRAN (R 4.4.0)
# Rsolnp           1.16       2015-12-28 [1] CRAN (R 4.4.0)
# rstudioapi       0.16.0     2024-03-24 [1] CRAN (R 4.4.0)
# sandwich         3.1-0      2023-12-11 [1] CRAN (R 4.4.0)
# scales           1.3.0      2023-11-28 [1] CRAN (R 4.4.0)
# sessioninfo    * 1.2.2      2021-12-06 [1] CRAN (R 4.4.2)
# snakecase        0.11.1     2023-08-27 [1] CRAN (R 4.4.1)
# SparseM          1.83       2024-05-30 [1] CRAN (R 4.4.0)
# stringi          1.8.4      2024-05-06 [1] CRAN (R 4.4.0)
# stringr        * 1.5.1      2023-11-14 [1] CRAN (R 4.4.0)
# survival         3.7-0      2024-06-05 [1] CRAN (R 4.4.1)
# tibble         * 3.2.1      2023-03-20 [1] CRAN (R 4.4.0)
# tidyr          * 1.3.1      2024-01-24 [1] CRAN (R 4.4.0)
# tidyselect       1.2.1      2024-03-11 [1] CRAN (R 4.4.0)
# tidyverse      * 2.0.0      2023-02-22 [1] CRAN (R 4.4.0)
# timechange       0.3.0      2024-01-18 [1] CRAN (R 4.4.0)
# truncnorm        1.0-9      2023-03-20 [1] CRAN (R 4.4.0)
# tzdb             0.4.0      2023-05-12 [1] CRAN (R 4.4.0)
# utf8             1.2.4      2023-10-22 [1] CRAN (R 4.4.0)
# vctrs            0.6.5      2023-12-01 [1] CRAN (R 4.4.0)
# WeightIt       * 1.1.0      2024-05-04 [1] CRAN (R 4.4.0)
# withr            3.0.0      2024-01-16 [1] CRAN (R 4.4.0)
# xfun             0.45       2024-06-16 [1] CRAN (R 4.4.1)
# zoo              1.8-12     2023-04-13 [1] CRAN (R 4.4.0)
#
# [1] C:/Users/earpkin/AppData/Local/Programs/R/R-4.4.1/library



# renv::snapshot()
rm(list = ls())
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
database <- here("Data", "Long_Weights_Category_Clean.csv") %>%
  fread() %>% data.frame()

Data <-
  here("Data", "SurveyData_Clean.csv") %>% fread() %>% data.frame()


# *****************************
# Setup Apollo: ####
# *****************************

apollo_initialise()

### Set core controls
apollo_control = list(
  modelName       = "Experts_Weighted_V2",
  modelDescr      = "Experts_Weighted_V2",
  indivID         = "ID",
  mixing = TRUE,
  nCores = 10,
  weights = "Weights",
  outputDirectory = "Output/Model_Weighted"
)


# *****************************
# Define Parameters: ####
# *****************************

### Vector of parameters, including any that are kept fixed in estimation
apollo_beta = c(
  asc_A      = 0,
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
  b_Q15 = 0
)

### Vector with names (in quotes) of parameters to be kept fixed at their starting value in apollo_beta, use apollo_beta_fixed = c() if none
## Fix to zero to permit identification of ASC_SQ i.e., A
apollo_fixed = c("asc_B")



### Set parameters for generating draws
apollo_draws = list(
  interDrawsType = "sobol",
  interNDraws    = 2000,
  interUnifDraws = c(),
  interNormDraws = c(
    "Draws_Performance_10" ,
    "Draws_Performance_50",
    "Draws_Emissions_40",
    "Draws_Emissions_90",
    "draws_Price"
  ),
  intraDrawsType = "halton",
  intraNDraws    = 0,
  intraUnifDraws = c(),
  intraNormDraws = c()
)
### Create random parameters
apollo_randCoeff = function(apollo_beta, apollo_inputs) {
  randcoeff = list()
  ## Lognormal
  randcoeff[["b_Price"]] = -exp(mu_Price + sig_Price * draws_Price)

  ## Normals
  randcoeff[["b_Performance_10"]] =  (mu_Performance_10 +    sig_Performance_10 *
                                        Draws_Performance_10)
  randcoeff[["b_Performance_50"]] =  (mu_Performance_50 +    sig_Performance_50 *
                                        Draws_Performance_50)
  randcoeff[["b_Emissions_40"]] =  (mu_Emissions_40 +    sig_Emissions_40 *
                                      Draws_Emissions_40)
  randcoeff[["b_Emissions_90"]] =  (mu_Emissions_90 +    sig_Emissions_90 *
                                      Draws_Emissions_90)
  return(randcoeff)
}



apollo_inputs = apollo_validateInputs()


# *****************************
# Establish Likelihood Function: ####
# *****************************


apollo_probabilities = function(apollo_beta,
                                apollo_inputs,
                                functionality = "estimate") {
  ### Attach inputs and detach after function exit
  apollo_attach(apollo_beta, apollo_inputs)
  on.exit(apollo_detach(apollo_beta, apollo_inputs))

  Interactions =
    Experts_Performance_10_Int * ((Performance_B == 10) * Experts) +
    Experts_Performance_50_Int * ((Performance_B == 50) * Experts) +
    Experts_Emissions_40_Int * ((Emission_B == 40) * Experts) +
    Experts_Emissions_90_Int * ((Emission_B == 90) * Experts)


  ## Previous version was ASC_B but a reviewer kindly corrected this
  asc_A1 = asc_A +
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
  V[["A"]]  = asc_A1


  V[["B"]]  = asc_B  +  b_Price * ((Price_B) +
                                      (b_Performance_10 * (Performance_B == 10)) +
                                      (b_Performance_50 * (Performance_B == 50)) +
                                      (b_Emissions_40 * (Emission_B == 40)) +
                                      (b_Emissions_90 * (Emission_B == 90))
  ) +
    Interactions

  ### Define settings for MNL model component
  mnl_settings = list(
    alternatives  = c(A = 1,  B = 2),
    avail         = list(A = 1,  B = 1),
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
  P = apollo_weighting(P, apollo_inputs, functionality)

  ## Prepare and return outputs of function
  P = apollo_prepareProb(P, apollo_inputs, functionality)
  return(P)
}

# *****************************
# Estimation: ####
# *****************************

## Actually estimates the model
Experts_Weighted_V2 = apollo_estimate(apollo_beta,
                                            apollo_fixed,
                                            apollo_probabilities,
                                            apollo_inputs)

## Model output and results here alongside saving information
apollo_modelOutput(Experts_Weighted_V2,
                   modelOutput_settings = list(printPVal = TRUE))
apollo_saveOutput(Experts_Weighted_V2,
                  saveOutput_settings = list(printPVal = TRUE))
# saveRDS(Experts_Weighted_V2, file="Experts_Weighted_V2.rds")


# *****************************
# Summarise WTP: ####
# *****************************


Model <- readRDS(here("Output/Model_Weighted",
                      "Experts_Weighted_V2_model.rds")) ## Enter model of interest RDS here


# Conditionals: *****************************
Experts_Weighted_V2_WTP <-
  apollo_conditionals(Model, apollo_probabilities, apollo_inputs)
Experts_Weighted_V2_WTP %>%
  data.frame() %>%
  fwrite(sep = ",",
         here("Output/Model_Weighted",
              "Experts_Weighted_V2_WTP.csv"))


# Unconditionals: *****************************
# Experts_Weighted_V2_UCWTP <-
#   apollo_unconditionals(Model, apollo_probabilities, apollo_inputs)
# Experts_Weighted_V2_UCWTP %>%
#   data.frame() %>%
#   fwrite(sep = ",",
#          here("Output/ModelSevenB",
#               "Experts_Weighted_V2_UCWTP.csv"))


# End of script ******************************************************
