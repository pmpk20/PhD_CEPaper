#### Experts: Table 3 SQ by confidence ####
## Function: Hypothesis One Tests
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 12/02/2025
## Change: Changing to the categorical models instead
# - "Table 3. χ^2test statistics (p values in parentheses) against
# the null hypothesis that choice frequency did not differ between
# levels of self-reported confidence in experts.
# A diagonal matrix was produced to report all test combinations. "



# *****************************
# Replication Information: ####
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



# *****************************
# Setup Environment: ####
# *****************************


rm(list = ls())


library(dplyr)
library(magrittr)
library(here)
library(data.table)


# *****************************
# Import Results And Models: ####
# *****************************


database <- here(
  "Data",
  "Long_Weights_Category_Clean.csv") %>%
  fread() %>%
  data.frame()


# *****************************
# Chi Square Test: ####
# *****************************



Means <- rbind(
  database$Choice[database$Experts==1] %>% table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Choice[database$Experts==2] %>% table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Choice[database$Experts==3] %>% table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Choice[database$Experts==4] %>% table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Choice[database$Experts==5] %>% table() %>% as.numeric() %>% data.frame() %>% t()
) %>% data.frame()


Freqs <- rbind(
  database$Choice[database$Experts==1] %>% table() %>% prop.table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Choice[database$Experts==2] %>% table() %>% prop.table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Choice[database$Experts==3] %>% table() %>% prop.table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Choice[database$Experts==4] %>% table() %>% prop.table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Choice[database$Experts==5] %>% table() %>% prop.table() %>% as.numeric() %>% data.frame() %>% t()
) %>% data.frame()


Freqs_Table <- Freqs %>%
  multiply_by(100) %>%
  round(2)


Rows <- c("1", "2", "3", "4", "5")
Cols <- c("Option A","Option B")

rownames(Means) <- Rows
rownames(Freqs_Table) <- Rows

colnames(Means) <- Cols
colnames(Freqs_Table) <- Cols


# *****************************
# Setup data: ####
# *****************************


## Here I rewrite the output into a more understandable format
TableData_TopSection <- bind_cols(
  data.frame("1"=paste0(Means[1, ]," (",Freqs[1, ] %>% multiply_by(100) %>% round(2),"%)")),
  data.frame("2"=paste0(Means[2, ]," (",Freqs[2, ] %>% multiply_by(100) %>% round(2),"%)")),
  data.frame("3"=paste0(Means[3, ]," (",Freqs[3, ] %>% multiply_by(100) %>% round(2),"%)")),
  data.frame("4"=paste0(Means[4, ]," (",Freqs[4, ] %>% multiply_by(100) %>% round(2),"%)")),
  data.frame("5"=paste0(Means[5, ]," (",Freqs[5, ] %>% multiply_by(100) %>% round(2),"%)"))
) %>% t() %>% data.frame()


## Convenient labelling here
rownames(TableData_TopSection) <- Rows
colnames(TableData_TopSection) <- Cols


# Flip table around so the dims are 3x5
TableData_TopSection_Original <- TableData_TopSection
TableData_TopSection %<>% t()


# *****************************
# Chi Square Tests: ####
# *****************************


ChiTests_LoopOne = vector("list", length = 5)
ChiTests_LoopTwo = vector("list", length = 5)
ChiTests_LoopAll = vector("list", length = 5)


for (Col in 1:5){
  for (Row in 1:5){
    ChiTests_LoopOne[[Row]] <- chisq.test(x = Means[Row,] %>% as.numeric() %>% c(),
                                          p = Freqs[Col,] %>% as.numeric() %>% c())[c("statistic", "p.value")] %>% data.frame()
  }
  ChiTests_LoopTwo[[Col]] = do.call(bind_rows, ChiTests_LoopOne) %>% data.frame()
}



# *****************************
# Chi Square Test Results: ####
# *****************************


ChiTests_LoopAll = do.call(bind_rows, ChiTests_LoopTwo) %>% data.frame()

ChiTests_Merged <- paste0(ChiTests_LoopAll$statistic %>% round(3), " (P. Value: ", ChiTests_LoopAll$p.value %>% round(3),")") %>% data.frame()


ChiTests_Merged_Rearranged <- bind_cols(
  ChiTests_Merged[1:5, ] %>% data.frame(),
  ChiTests_Merged[6:10, ] %>% data.frame(),
  ChiTests_Merged[11:15, ] %>% data.frame(),
  ChiTests_Merged[16:20, ] %>% data.frame(),
  ChiTests_Merged[21:25, ] %>% data.frame()
)

rownames(ChiTests_Merged_Rearranged) <- Rows
colnames(ChiTests_Merged_Rearranged) <- Rows


## Rename for conveniene
TableData_BottomSection  <- ChiTests_Merged_Rearranged


# *****************************
# Combining All Results: ####
# *****************************


Table3 <-
  rbind(TableData_TopSection,
        TableData_BottomSection)



# *****************************
#### Section 4: Export Table ####
# *****************************


## Export results to screen for copy and pasting
## NOW TABLE 3
Table3 %>% write.csv(quote = FALSE, row.names = FALSE)


## Export:
Table3 %>%
  fwrite(sep=",",
         here("Output/Tables","Table4_Choices_ChiSquare.txt"),
         row.names = TRUE,
         quote = FALSE)


# End Of Script ----------------------------------------------------------------
