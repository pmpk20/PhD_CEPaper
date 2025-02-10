#### PhD Paper 1: Histogram Plot Of Experts ####
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 10/02/2025
## TODO: Format nicely
# - R1 requested changes from error bar to column


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
library(RColorBrewer)


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


# *****************************
# Plot setup: ####
# *****************************


## New approach here:
PlotData <-
  Data[, c("Q9Choice",
           "Q10Choice",
           "Q11Choice",
           "Q12Choice",
           "Q21Experts")] %>%
  tidyr::pivot_longer(cols = c(Q9Choice, Q10Choice, Q11Choice, Q12Choice)) %>%
  group_by(Q21Experts, value) %>%
  summarise(n = n(), .groups = 'drop') %>%
  group_by(Q21Experts) %>%
  mutate(percentage = n / sum(n) * 100)




TextSize <- 16



TextSetup <- element_text(size = TextSize,
                          colour = "black",
                          family = "serif")

#

# *****************************
# Plot: ####
# *****************************


Figure1 <- PlotData %>%
  ggplot(aes(x = factor(Q21Experts), y = percentage, fill = factor(value))) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.9), color = "black") +
  scale_x_discrete(name = "Self-reported confidence in experts (/5)",
                   labels = c("1/5", "2/5", "3/5", "4/5", "5/5")) +
  scale_y_continuous(name = "Percentage of Choices within Expert Confidence Level",
                     limits = c(0, 100),
                     breaks = seq(0, 100, by = 10),
                     labels = function(x) paste0(x, "%")) +
  geom_hline(yintercept = 50, alpha = 0.5, linetype = "dotted") +
  theme_bw() +
  scale_fill_manual(
    name = "Choice:",
    labels = c("Option A", "Option B"),
    values = c("lightblue", "darkblue")
  ) +
  theme(
    legend.position = "bottom",
    legend.background = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor.y = element_blank(),
    legend.text = TextSetup,
    legend.title = TextSetup,
    axis.text.x = TextSetup,
    axis.text.y = TextSetup,
    axis.title.y = TextSetup,
    axis.title.x = TextSetup
  )


# ******************************************************************
#### Section 4: Export Plot ####
# ******************************************************************


ggsave(
  Figure1,
  device = "png",
  filename = here("Output/Plots",
                  "Figure1_ChoiceFrequencyByExperts.png"),
  width = 25,
  height = 15,
  units = "cm",
  dpi = 500
)


# ******************************************************************
#### Section 5: Frequency table ####
# ******************************************************************


## Report frequency by level of confidence
FigureX_FreqTable <-
  Data[, c("Q9Choice",
           "Q10Choice",
           "Q11Choice",
           "Q12Choice",
           "Q21Experts")] %>%
  tidyr::pivot_longer(cols = c(Q9Choice, Q10Choice, Q11Choice, Q12Choice)) %>%
  mutate(value = ifelse(value == 0, "Option A", "Option B")) %>%
  group_by(Q21Experts, value) %>%
  summarise(n = n(),
            .groups = 'drop') %>%
  pivot_wider(names_from = value, values_from = n)


FigureX_FreqTable %>% write.csv(quote = FALSE, row.names = FALSE)

# ******************************************************************
#### Section X: Old code ####
# ******************************************************************


## Gather all scenario.x in one column
# Test <- Data[,c(
#   "Q9Choice",
#   "Q10Choice",
#   "Q11Choice",
#   "Q12Choice",
#   "Q21Experts")] %>%
#   pivot_longer(cols = c(1:4)) %>%
#   group_by(name) %>%
#   select(value, Q21Experts) %>%
#   table(.) %>%
#   data.frame() %>%
#   group_by(Q21Experts,
#            value) %>%
#   group_modify(~ mutate(.x,
#                         YMIN = quantile(Freq, 0.025),
#                         YMAX = quantile(Freq, 0.975))) %>%
#   ungroup()

## OLD CODE ##
# FigureX <-  Test %>%
#   ggplot(aes(y = Freq,
#              x = Q21Experts,
#              fill = factor(value))) +
#   stat_boxplot(geom = "errorbar",
#                width = 0.25,
#                position = position_dodge(width = 0.75)) +
#   geom_boxplot(outlier.shape = NA) +
#   theme_bw() +
#   scale_y_continuous(name = "Frequency of choices") +
#   scale_x_discrete(name = "Self-reported confidence in experts",
#                    label = c("1/5", "2/5", "3/5", "4/5", "5/5")) +
#   geom_vline(xintercept = 1.5, alpha = 0.25) +
#   geom_vline(xintercept = 2.5, alpha = 0.25) +
#   geom_vline(xintercept = 3.5, alpha = 0.25) +
#   geom_vline(xintercept = 4.5, alpha = 0.25) +
#   scale_fill_manual(
#     name = "Choice:",
#     labels = c("Option A", "Option B"),
#     values = RColorBrewer::brewer.pal(9, "Blues")[c(4, 8)]) +
#   theme(
#     legend.position = "bottom",
#     legend.background = element_blank(),
#     panel.grid.major.x = element_blank(),
#     panel.grid.minor.x = element_blank(),
#     panel.grid.major.y = element_blank(),
#     panel.grid.minor.y = element_blank(),
#     legend.text = TextSetup,
#     legend.title = TextSetup,
#     axis.text.x = TextSetup,
#     axis.text.y = TextSetup,
#     axis.title.y = TextSetup,
#     axis.title.x = TextSetup
#   )



# End Of Script -----------------------------------------------------------





