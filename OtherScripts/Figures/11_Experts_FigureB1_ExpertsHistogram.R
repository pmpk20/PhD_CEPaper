#### Experts: Figure A1 Histogram Plot Of Experts ####
## Author: Dr Peter King (p.king1@leeds.ac.uk)
## Last change: 16/05/2024
## Change: formatted more nicely


# ******************************************************************
# Replication Information: ####
# ******************************************************************


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


# ******************************************************************
#### Section 1: Import Data ####
# ******************************************************************


## Read in the completed data
Data <-
  here("Data", "SurveyData_Clean.csv") %>%
  fread() %>%
  data.frame()



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

# ******************************************************************
#### Section 2: Define Histogram Function  ####
# ******************************************************************


## I use this function in all these histograms to make the lines:
fun = function(x, mean, sd, n){
  n * dnorm(x = x, mean = mean, sd = sd)
}




## Specify once here for consistency
TextSize <- 14
TextFamily <- "sans"
TextType <- element_text(size = TextSize,
                         colour = "black",
                         family = TextFamily)


# ******************************************************************
#### Section 3: Create Plot ####
# ******************************************************************



### Q21 Histogram
FigureB1 <-
  ggplot(Data, aes(x = Q21Experts)) +
  geom_histogram(
    aes(y = after_stat(density)),
    color = "black",
    fill = "white", binwidth = 1,
  ) +
  theme_bw() +
  stat_function(fun = fun,
                args = with(Data, c(
                  mean = mean(Q21Experts),
                  sd = sd(Q21Experts),
                  n = 1
                ))) +
  scale_x_continuous(breaks = seq.int(from = 1, to = 5,by = 1),
                     name = "Self-reported confidence in the ability of experts to provide reliable information. ",
                     labels = c(
                       "1: Unconfident\n (N = 16)",
                       "2\n (N = 46)",
                       "3\n (N = 251)",
                       "4\n (N = 237)",
                       "5: Confident\n (N = 120)"
                     )

  ) +

  theme(
    legend.position = "bottom",
    legend.background = element_blank(),
    legend.box.background = element_rect(colour = "black"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor.y = element_blank(),
    strip.text = TextType,
    text = TextType,
    legend.text = TextType,
    axis.text.x = TextType,
    axis.text.y = TextType,
    axis.title.y = TextType,
    axis.title.x = TextType
  )

# ******************************************************************
#### Section 4: Export Plot ####
# ******************************************************************


ggsave(
  FigureB1,
  device = "tiff",
  filename = here("Output/Plots", "FigureB1_HistogramOfResponses.tiff"),
  width = 25,
  height = 15,
  units = "cm",
  dpi = 500
)

# End Of Script -----------------------------------------------------------
