#### Experts: Test sample  ###############
# Function: Calculate and output tests for the sample
# Script author: Peter King (p.m.king@kent.ac.uk)
# Last Edited: 14/04/2023
# TODO:
# - Fix row order to match text
# - Investigate rstatix

# # Table B2: Comparison of our sample and target population using
# five socioeconomic variables reported in our survey.
# N for number of respondents with “sample” and “population”
# recording the percentage of each that is represented by that
# variable category. χ^2 test statistics and p values reported against the
# null hypothesis that the frequency of each group is not different
# between the sample and target population at time of analysis.


# ****************************************************************************
#### Section 0: Setup ####
# ****************************************************************************


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


## Libraries: **************************************************************
library(tidyverse)
library(dplyr)
library(here)
library(data.table)
library(stats)


## ****************************************************************************
#### Step One: Read in data frame with all respondents ####
## ****************************************************************************



Data <-
  here("Data", "SurveyData_Clean.csv") %>% fread() %>% data.frame()



## ****************************************************************************
#### Step Two: Construct table variable by variable ####
## ****************************************************************************


## Total number of respondents. Defined here for repeated later use
Total <- Data %>% nrow()

## Drop less common genders
Data  <- Data[Data$Q1Gender < 2,]


## ***************************************************************************
#### Gender ####


## G test of frequencies of male/female sample vs population
Test_Gender <- chisq.test(
  Data$Q1Gender %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total),
  p = c(46, 53),
  rescale.p = TRUE
)


Row1_Gender <- cbind(
  "Variable" = "Gender",
  "Category" = "Male",
  "N" = data.frame(Data$Q1Gender %>% table() %>% as.numeric())[1, ] %>% round(3),
  "Sample (%)" = data.frame(
    Data$Q1Gender %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total)
  )[, 1] %>% round(3) %>% multiply_by(100),
  "Population (%)" = 46,
  "PV" = Test_Gender$statistic %>% as.numeric() %>% round(3)
)


Row2_Gender <- cbind(
  "Variable" = "Gender",
  "Category" = "Female",
  "N" = data.frame(Data$Q1Gender %>% table() %>% as.numeric())[2, ] %>% round(3),
  "Sample (%)" = data.frame(
    Data$Q1Gender %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total)
  )[, 2] %>% round(3) %>% multiply_by(100),
  "Population (%)" = 53,
  "PV" = paste0("PV: ", Test_Gender$p.value %>% as.numeric() %>% round(3))
)


## Add all rows together here
Rows_Gender <- rbind(Row1_Gender, Row2_Gender)


## ***************************************************************************
#### ExactAge ####





## G test here
## P are given frequency
Test_ExactAge <- chisq.test(
  Data$Q2Age %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total),
  p = c(16.2, 13.3, 14.6, 22.90, 11.7),
  rescale.p = TRUE
)


Row1_ExactAge <- cbind(
  "Variable" = "AgeCategory",
  "Category" = "18 - 29",
  "N" = data.frame(Data$Q2Age %>% table() %>% as.numeric())[1, ] %>% round(3),
  "Sample (%)" = data.frame(
    Data$Q2Age %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total)
  )[, 1] %>% round(3) %>% multiply_by(100),
  "Population (%)" = 16.2,
  "PV" = Test_ExactAge$statistic %>% as.numeric() %>% round(3)
)


Row2_ExactAge <- cbind(
  "Variable" = "AgeCategory",
  "Category" = "30 - 39",
  "N" = data.frame(Data$Q2Age %>% table() %>% as.numeric())[2, ] %>% round(3),
  "Sample (%)" = data.frame(
    Data$Q2Age %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total)
  )[, 2] %>% round(3) %>% multiply_by(100),
  "Population (%)" = 13.3,
  "PV" = Test_ExactAge$statistic %>% as.numeric() %>% round(3)
)

Row3_ExactAge <- cbind(
  "Variable" = "AgeCategory",
  "Category" = "40 - 49",
  "N" = data.frame(Data$Q2Age %>% table() %>% as.numeric())[3, ] %>% round(3),
  "Sample (%)" = data.frame(
    Data$Q2Age %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total)
  )[, 3] %>% round(3) %>% multiply_by(100),
  "Population (%)" = 14.6,
  "PV" = Test_ExactAge$statistic %>% as.numeric() %>% round(3)
)


Row4_ExactAge <- cbind(
  "Variable" = "AgeCategory",
  "Category" = "50 - 69",
  "N" = data.frame(Data$Q2Age %>% table() %>% as.numeric())[4, ] %>% round(3),
  "Sample (%)" = data.frame(
    Data$Q2Age %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total)
  )[, 4] %>% round(3) %>% multiply_by(100),
  "Population (%)" = 22.90,
  "PV" = Test_ExactAge$statistic %>% as.numeric() %>% round(3)
)

Row5_ExactAge <- cbind(
  "Variable" = "AgeCategory",
  "Category" = "70+",
  "N" = data.frame(Data$Q2Age %>% table() %>% as.numeric())[5, ] %>% round(3),
  "Sample (%)" = data.frame(
    Data$Q2Age %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total)
  )[, 5] %>% round(3) %>% multiply_by(100),
  "Population (%)" = 11.7,
  "PV" = paste0("PV: ", Test_ExactAge$p.value %>% as.numeric() %>% round(3))
)


## Combine all rows here
Rows_ExactAge <- rbind(
  Row1_ExactAge,
  Row2_ExactAge,
  Row3_ExactAge,
  Row4_ExactAge,
  Row5_ExactAge
)






## ***************************************************************************
#### Q22Education ####


Data$EducationDummy <- ifelse(Data$Q22Education < 3, 0 , 1)

Test_Q22Education <- chisq.test(
  Data$EducationDummy %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total),
  p = c(40.4, 42),
  rescale.p = TRUE
)


Row1_Q22Education <- cbind(
  "Variable" = "Q22Education",
  "Category" = "Non-white",
  "N" = data.frame(Data$EducationDummy %>% table() %>% as.numeric())[1, ] %>% round(3),
  "Sample (%)" = data.frame(
    Data$EducationDummy %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total)
  )[, 1] %>% round(3) %>% multiply_by(100),
  "Population (%)" = 40.4,
  "PV" = Test_Q22Education$statistic %>% as.numeric() %>% round(3)
)


Row2_Q22Education <- cbind(
  "Variable" = "Q22Education",
  "Category" = "White",
  "N" = data.frame(Data$EducationDummy %>% table() %>% as.numeric())[2, ] %>% round(3),
  "Sample (%)" = data.frame(
    Data$EducationDummy %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total)
  )[, 2] %>% round(3) %>% multiply_by(100),
  "Population (%)" = 42,
  "PV" = paste0(
    "PV: ",
    Test_Q22Education$p.value %>% as.numeric() %>% round(3)
  )
)


Rows_Q22Education <-
  rbind(Row1_Q22Education, Row2_Q22Education)



## ***************************************************************************
#### Income ####



Test_Income <- chisq.test(
  Data$IncomeDummy %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total),
  p = c(45, 55),
  rescale.p = TRUE
)


Row1_Income <- cbind(
  "Variable" = "Income",
  "Category" = "Rural",
  "N" = data.frame(Data$IncomeDummy %>% table() %>% as.numeric())[1, ] %>% round(3),
  "Sample (%)" = data.frame(
    Data$IncomeDummy %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total)
  )[, 1] %>% round(3) %>% multiply_by(100),
  "Population (%)" = 45,
  "PV" = Test_Income$statistic %>% as.numeric() %>% round(3)
)


Row2_Income <- cbind(
  "Variable" = "Income",
  "Category" = "Urban",
  "N" = data.frame(Data$IncomeDummy %>% table() %>% as.numeric())[2, ] %>% round(3),
  "Sample (%)" = data.frame(
    Data$IncomeDummy %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total)
  )[, 2] %>% round(3) %>% multiply_by(100),
  "Population (%)" = 55,
  "PV" = paste0("PV: ", Test_Income$p.value %>% as.numeric() %>% round(3))
)


Rows_Income <- rbind(Row1_Income, Row2_Income)



## ***************************************************************************
#### Employment ####


Data$Employment <-
  ifelse(Data$Q23Employment %in% c(0, 2), 0, Data$Q23Employment)


Test_Employment <- chisq.test(
  Data$Employment %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total),
  p = c(30.4, 3.7, 3.5, 10.4, 15.10, 36.90),
  rescale.p = TRUE
)


Row1_Employment <- cbind(
  "Variable" = "Employment",
  "Category" = "No data",
  "N" = data.frame(Data$Employment %>% table() %>% as.numeric())[1, ] %>% round(3),
  "Sample (%)" = data.frame(
    Data$Employment %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total)
  )[, 1] %>% round(3) %>% multiply_by(100),
  "Population (%)" = 30.4,
  "PV" = Test_Employment$statistic %>% as.numeric() %>% round(3)
)


Row2_Employment <- cbind(
  "Variable" = "Employment",
  "Category" = "NEET",
  "N" = data.frame(Data$Employment %>% table() %>% as.numeric())[2, ] %>% round(3),
  "Sample (%)" = data.frame(
    Data$Employment %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total)
  )[, 2] %>% round(3) %>% multiply_by(100),
  "Population (%)" = 3.7,
  "PV" = Test_Employment$statistic %>% as.numeric() %>% round(3)
)


Row3_Employment <- cbind(
  "Variable" = "Employment",
  "Category" = "Student",
  "N" = data.frame(Data$Employment %>% table() %>% as.numeric())[3, ] %>% round(3),
  "Sample (%)" = data.frame(
    Data$Employment %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total)
  )[, 3] %>% round(3) %>% multiply_by(100),
  "Population (%)" = 3.5,
  "PV" = Test_Employment$statistic %>% as.numeric() %>% round(3)
)


Row4_Employment <- cbind(
  "Variable" = "Employment",
  "Category" = "Part-time",
  "N" = data.frame(Data$Employment %>% table() %>% as.numeric())[4, ] %>% round(3),
  "Sample (%)" = data.frame(
    Data$Employment %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total)
  )[, 4] %>% round(3) %>% multiply_by(100),
  "Population (%)" = 10.4,
  "PV" = paste0("PV: ", Test_Employment$p.value %>% as.numeric() %>% round(3))
)



Row5_Employment <- cbind(
  "Variable" = "Employment",
  "Category" = "Self-employed",
  "N" = data.frame(Data$Employment %>% table() %>% as.numeric())[5, ] %>% round(3),
  "Sample (%)" = data.frame(
    Data$Employment %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total)
  )[, 5] %>% round(3) %>% multiply_by(100),
  "Population (%)" = 15.10,
  "PV" = paste0("PV: ", Test_Employment$p.value %>% as.numeric() %>% round(3))
)


Row6_Employment <- cbind(
  "Variable" = "Employment",
  "Category" = "Full-time",
  "N" = data.frame(Data$Employment %>% table() %>% as.numeric())[6, ] %>% round(3),
  "Sample (%)" = data.frame(
    Data$Employment %>% table() %>% as.numeric() %>% data.frame() %>% t() %>% divide_by(Total)
  )[, 6] %>% round(3) %>% multiply_by(100),
  "Population (%)" = 36.90,
  "PV" = paste0("PV: ", Test_Employment$p.value %>% as.numeric() %>% round(3))
)


Rows_Employment <- rbind(Row1_Employment,
                         Row2_Employment,
                         Row3_Employment,
                         Row4_Employment,
                         Row5_Employment,
                         Row6_Employment)



# ****************************************************************************
#### Section D: Combination ####
# ****************************************************************************


TableB2 <- rbind(
  Rows_Gender,
  Rows_ExactAge,
  Rows_Q22Education,
  Rows_Income,
  Rows_Employment
) %>% data.frame()


## Export
TableB2 %>%
  fwrite(
    sep = ",",
    here("Output/Tables", "TableB2_SampleTests.txt"),
    row.names = TRUE,
    quote = FALSE
  )


# End Of Script **************************************************************
