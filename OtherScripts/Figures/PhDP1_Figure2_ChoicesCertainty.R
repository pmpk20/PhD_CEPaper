#### PhD Paper 1: Histogram Plot Of Experts ####
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 08/02/2025
## TODO: Format nicely
# - Now using FigureX_2

# ******************************************************************
# Replication Information: ####
# ******************************************************************


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


# ******************************************************************
# Setup Environment: ####
# ******************************************************************


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
library(data.table)
library(tidyverse)


# ******************************************************************
#### Section 1: Import Data ####
# ******************************************************************


## Read in the completed data
Data <-
  here("Data", "SurveyData_Clean.csv") %>% fread() %>% data.frame()



# *****************************
# Data cleaning: ####
# *****************************


Data$AlwaysSQ <-
  ifelse(
    Data$Q9Choice == 0 &
      Data$Q10Choice == 0 &
      Data$Q11Choice == 0 &
      Data$Q12Choice == 0, 1, 0)



## Code dummy here for ease of inference:
Data$ExpertsDummy <- ifelse(Data$Q21Experts <= 3, 0, 1)


## Like a dummy but groups
Data$ExpertsGroup <- ifelse(Data$Q21Experts < 3, 0,
                            ifelse(Data$Q21Experts == 3, 1, 2))


Data$Certainty_Unsure <- ifelse(Data$Q12CECertainty == 0, 1, 0)
Data$Certainty_QuiteSure <- ifelse(Data$Q12CECertainty == 1, 1, 0)
Data$Certainty_VerySure <- ifelse(Data$Q12CECertainty == 2, 1, 0)




TextSize <- 16


TextSetup <- element_text(size = TextSize,
                          colour = "black",
                          family = "serif")


# *****************************
# Plot by facet: ####
# *****************************


FigureX2 <- Data %>%
  group_by(Q12CECertainty,
           Q21Experts) %>%
  summarise(n = n()) %>%
  mutate("Variable" = Q21Experts) %>%
  select(-c(Q21Experts)) %>%
  pivot_wider(names_from = Q12CECertainty,
              values_from = n) %>%
  pivot_longer(cols = 2:4,
               names_to = "Q12CECertainty") %>%
  ggplot(aes(y = value %>% as.numeric(),
             x = Variable %>% as.factor(), group = Q12CECertainty %>% as.factor(), fill = Q12CECertainty %>% as.factor())) +
  geom_bar(stat = "identity", colour = "black", alpha = 0.75) +
  facet_wrap(~Q12CECertainty %>% as.factor(),
             ncol = 1, scales = "free_y", labeller = as_labeller(c('0' = "Unsure (N = 40)", '1' = "Quite Sure (N = 328)", '2' = "Very Sure (N = 302)"
             ))) +
  theme_bw() +
  scale_y_continuous(name = "Frequency") +
  scale_x_discrete(name = "Self-reported confidence in experts (/5)",
                   label = c("1/5", "2/5", "3/5", "4/5", "5/5")) +
  geom_vline(xintercept = 1.5, alpha = 0.25) +
  geom_vline(xintercept = 2.5, alpha = 0.25) +
  geom_vline(xintercept = 3.5, alpha = 0.25) +
  geom_vline(xintercept = 4.5, alpha = 0.25) +
  scale_fill_manual(
    name = "Certainty:",
    labels = c("Unsure", "Quite Sure", "Very Sure"),
    values = c("lightblue", "dodgerblue", "darkblue")
  ) +
  theme(
    legend.position = "none",
    legend.background = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor.y = element_blank(),
    strip.background = element_rect(fill = "white"),
    strip.text.x = TextSetup,
    legend.text = TextSetup,
    legend.title = TextSetup,
    axis.text.x = TextSetup,
    axis.text.y = TextSetup,
    axis.title.y = TextSetup,
    axis.title.x = TextSetup
  )



ggsave(
  FigureX2,
  device = "png",
  filename = here("Output/Plots",
                  "FigureX_ChoiceCertaintyByExperts_Facet.png"),
  width = 25,
  height = 15,
  units = "cm",
  dpi = 500
)



# End Of Script -----------------------------------------------------------





