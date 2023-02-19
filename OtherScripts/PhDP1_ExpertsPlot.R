#### PhD Paper 1: Histogram Plot Of Experts ####
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 25/08/2022
## TODO: Format nicely


#------------------------------
# Replication Information: ####
#------------------------------


# R version 4.2.0 (2022-04-22 ucrt)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows 10 x64 (build 19044)
#   [1] LC_COLLATE=English_United Kingdom.utf8  LC_CTYPE=English_United Kingdom.utf8   
#   [1] here_1.0.1     reshape2_1.4.4 ggridges_0.5.3 ggplot2_3.3.6  magrittr_2.0.3 dplyr_1.0.9    apollo_0.2.7  
#   [1] zoo_1.8-10          tidyselect_1.1.2    purrr_0.3.4         splines_4.2.0       lattice_0.20-45    
# [6] colorspace_2.0-3    generics_0.1.2      vctrs_0.4.1         MCMCpack_1.6-3      utf8_1.2.2         
# [11] survival_3.3-1      rlang_1.0.2         pillar_1.7.0        withr_2.5.0         glue_1.6.2         
# [16] plyr_1.8.7          matrixStats_0.62.0  lifecycle_1.0.1     stringr_1.4.0       MatrixModels_0.5-0 
# [21] munsell_0.5.0       gtable_0.3.0        mvtnorm_1.1-3       coda_0.19-4         miscTools_0.6-26   
# [26] SparseM_1.81        RSGHB_1.2.2         quantreg_5.93       parallel_4.2.0      fansi_1.0.3        
# [31] Rcpp_1.0.8.3        scales_1.2.0        tmvnsim_1.0-2       farver_2.1.0        mcmc_0.9-7         
# [36] maxLik_1.5-2        mnormt_2.0.2        digest_0.6.29       stringi_1.7.6       rprojroot_2.0.3    
# [41] numDeriv_2016.8-1.1 grid_4.2.0          cli_3.3.0           tools_4.2.0         sandwich_3.0-1     
# [46] tibble_3.1.7        crayon_1.5.1        pkgconfig_2.0.3     MASS_7.3-56         ellipsis_0.3.2     
# [51] Matrix_1.4-1        randtoolbox_1.31.1  R6_2.5.1            rngWELL_0.10-7      compiler_4.2.0    


#------------------------------
# Setup Environment: ####
#------------------------------


library(magrittr)
library(dplyr)
library(apollo)
library(reshape2)
library(ggplot2)
library(ggridges)
library(distributional)
library(ggdist)
library(gridExtra)
library(here)


#----------------------------------------------------------------------------------------------------------
#### Section 1: Import Data ####
#----------------------------------------------------------------------------------------------------------


## Read in all seasons data
Full_Final <- data.frame(read.csv("FinalData.csv")) ## Imports from the excel file straight from the survey companies website.


#----------------------------------------------------------------------------------------------------------
#### Section 2: Define Histogram Function  ####
#----------------------------------------------------------------------------------------------------------


## I use this function in all these histograms to make the lines:
fun = function(x, mean, sd, n){
  n * dnorm(x = x, mean = mean, sd = sd)
}



#----------------------------------------------------------------------------------------------------------
#### Section 3: Create Plot ####
#----------------------------------------------------------------------------------------------------------


### Q21 Histogram
Q21Hist <- ggplot(Full_Final, aes(x=Q21Experts)) + 
  geom_histogram(aes(y = ..density..),color="black", fill="white",bins = 50)+
  stat_function(fun = fun, 
                args = with(Full_Final, c(mean = mean(Q21Experts), sd = sd(Q21Experts), n
                                          = 6)))+
  scale_x_continuous(breaks=waiver(),
                     name="",
                     labels = c("1: Unconfident\n (N = 16)","2\n (N = 46)","3\n (N = 251)","4\n (N = 237)","5: Confident\n (N = 120)"))+
  ggtitle("How confident are you in the ability of experts to provide reliable information?")+
  theme(legend.position = "bottom", ## Put legend on the bottom not righthandside
        legend.background=element_blank(),
        legend.box.background = element_rect(colour="black"),
        panel.grid.major.x=element_blank(),
        panel.grid.minor.x=element_blank(),
        panel.grid.major.y=element_blank())+theme_bw()



#----------------------------------------------------------------------------------------------------------
#### Section 4: Export Plot ####
#----------------------------------------------------------------------------------------------------------


ggsave(Q21Hist, device = "jpeg",
       filename = "Q21Hist.jpeg",
       width=20,height=15,units = "cm",dpi=1000)


# End Of Script -----------------------------------------------------------