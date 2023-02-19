#### DEFRA: PhD ####
## Function: Estimates a basic Mixed Logit with all respondents
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 23/08/2022
## TODO: setup RENV


#------------------------------
# Replication Information: ####
# Selected output of 'sessionInfo()'
#------------------------------

# R version 4.1.3 (2022-03-10)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows 10 x64 (build 19043)
# [1] LC_COLLATE=English_United Kingdom.1252  LC_CTYPE=English_United Kingdom.1252   
# other attached packages:
#   [1] lubridate_1.8.0    tidygeocoder_1.0.5 PostcodesioR_0.3.1 DCchoice_0.1.0    
# [5] here_1.0.1         forcats_0.5.1      stringr_1.4.0      dplyr_1.0.8       
# [9] purrr_0.3.4        readr_2.1.2        tidyr_1.2.0        tibble_3.1.6      
# [13] ggplot2_3.3.5      tidyverse_1.3.1  

## Any issues installing packages try:
# Sys.setenv(RENV_DOWNLOAD_METHOD="libcurl")
# Sys.setenv(RENV_DOWNLOAD_FILE_METHOD=getOption("download.file.method"))

# renv::snapshot()
rm(list=ls())
library(here)
library(DCchoice)
library(lubridate)
library(tidyr)
library(apollo)
library(ggridges)
library(ggplot2)
library(reshape2)
library(dplyr)
library(magrittr)

#------------------------------
# Section 1: Import Data ####
# Selected output of 'sessionInfo()'
#------------------------------


here() ## This is the preferred approach to Setwd()


## Setup Data:
database <- data.frame(read.csv("Long_Weights_Dummy_2022_08_25.csv"))


#------------------------------
# Setup Apollo: ####
#------------------------------

apollo_initialise()

### Set core controls
apollo_control = list(
  modelName       = "PhD_MNL_ModelTwo_2022_08_25",
  modelDescr      = "PhD_MNL_ModelTwo_2022_08_25",
  indivID         = "ID"
)


#------------------------------
# Define Parameters: ####
#------------------------------

### Vector of parameters, including any that are kept fixed in estimation
apollo_beta=c(asc_A      = 0,
              asc_B      = 0,
              b_Performance_10=1,
              b_Performance_50=1,
              b_Emissions_40=1,
              b_Emissions_90=1,
              b_Price=-3,
              
              Experts_Performance_10_Int=1,
              Experts_Performance_50_Int=1,
              Experts_Emissions_40_Int=1,
              Experts_Emissions_90_Int=1,
              
              b_Gender = 0,
              b_Age      = 0,
              b_Distance = 0,
              b_Charity  = 0,
              b_Education  = 0,
              b_Income     = 0,
              b_Cons       = 0,
              b_BP    = 0,
              b_Understanding =0,
              b_Certainty=0)

### Vector with names (in quotes) of parameters to be kept fixed at their starting value in apollo_beta, use apollo_beta_fixed = c() if none
apollo_fixed = c("asc_B")


apollo_inputs = apollo_validateInputs()


#------------------------------
# Establish Likelihood Function: ####
#------------------------------


apollo_probabilities=function(apollo_beta, apollo_inputs, functionality="estimate"){
  
  ### Attach inputs and detach after function exit
  apollo_attach(apollo_beta, apollo_inputs)
  on.exit(apollo_detach(apollo_beta, apollo_inputs))
  
  Interactions = 
    Experts_Performance_10_Int * ((Performance_B==10)*ExpertsDummy)+
    Experts_Performance_50_Int * ((Performance_B==50)*ExpertsDummy)+
    Experts_Emissions_40_Int * ((Emission_B==40)*ExpertsDummy)+
    Experts_Emissions_90_Int * ((Emission_B==90)*ExpertsDummy)
  
  asc_B1 = asc_B + 
    b_Gender*Q1Gender + 
    b_Age*Age +
    b_Distance * Distance + 
    b_Charity * Charity + 
    b_Education * Education +
    b_Income * IncomeDummy +
    b_Cons * Consequentiality +       
    b_BP * BP+
    b_Understanding*Survey +
    b_Certainty*Q12CECertainty
  
  ### Create list of probabilities P
  P = list()
  
  ### List of utilities: these must use the same names as in mnl_settings, order is irrelevant
  V = list()
  V[["A"]]  = asc_A 
  
  
  V[["B"]]  = asc_B1  +  b_Price *((Price_B)+
                                     (b_Performance_10*(Performance_B==10))+
                                     (b_Performance_50*(Performance_B==50))+
                                     (b_Emissions_40*(Emission_B==40))+
                                     (b_Emissions_90*(Emission_B==90)))+
    Interactions
  
  ### Define settings for MNL model component
  mnl_settings = list(
    alternatives  = c(A=1, B=2), 
    avail         = list(A=1, B=1), 
    choiceVar     = Choice,
    utilities     = V
  )
  
  ## Compute probabilities using MNL model
  P[['model']] = apollo_mnl(mnl_settings, functionality)
  
  ## Take product across observation for same individual
  P = apollo_panelProd(P, apollo_inputs, functionality)
  
  ## Prepare and return outputs of function
  P = apollo_prepareProb(P, apollo_inputs, functionality)
  return(P)
}

#------------------------------
# Estimation: ####
#------------------------------

## Actually estimates the model
PhD_MNL_ModelTwo_2022_08_25 = apollo_estimate(apollo_beta, apollo_fixed, apollo_probabilities, apollo_inputs)

## Model output and results here alongside saving information
apollo_modelOutput(PhD_MNL_ModelTwo_2022_08_25,modelOutput_settings = list(printPVal=TRUE))
apollo_saveOutput(PhD_MNL_ModelTwo_2022_08_25,saveOutput_settings = list(printPVal=TRUE))
# saveRDS(PhD_MNL_ModelTwo_2022_08_25, file="PhD_MNL_ModelTwo_2022_08_25.rds")

