----------------------------


## PhD_CEPaper
Repo for replication code and data for the paper *How confident are you in the ability of experts to provide reliable information? Evidence from a choice experiment on microplastics.*  
Manuscript Number: EDE-2024-0285 under review at *Environment and Development Economics*  

- **Last change:** 
  - 12/02/2025  
- **Changes:**  
  - Preparing first-round revisions  
- **Contents:**  
  - `README_ModelNumbers.md`: Details each estimated model  

---

---
### Scripts to execute in order:
# Run: 00_Experts_Replicate.R



---

### **Session Info & Package Dependencies**
To ensure reproducibility, below is the full session information for the analysis.

```

─ Session info ──────────────────────────────────────────────────────────────
 setting  value
 version  R version 4.4.1 (2024-06-14 ucrt)
 os       Windows 11 x64 (build 22631)
 system   x86_64, mingw32
 ui       RStudio
 language (EN)
 collate  English_United Kingdom.utf8
 ctype    English_United Kingdom.utf8
 tz       Europe/London
 date     2025-02-12
 rstudio  2023.06.2+561 Mountain Hydrangea (desktop)
 pandoc   NA

─ Packages ──────────────────────────────────────────────────────────────────
 package        * version    date (UTC) lib source
 apollo         * 0.3.4      2024-10-01 [1] CRAN (R 4.4.1)
 backports        1.5.0      2024-05-23 [1] CRAN (R 4.4.0)
 bgw              0.1.3      2024-03-29 [1] CRAN (R 4.4.0)
 chk              0.9.1      2023-10-06 [1] CRAN (R 4.4.0)
 cli              3.6.3      2024-06-21 [1] CRAN (R 4.4.1)
 cobalt         * 4.5.5      2024-04-02 [1] CRAN (R 4.4.0)
 coda             0.19-4.1   2024-01-31 [1] CRAN (R 4.4.0)
 colorspace       2.1-0      2023-01-23 [1] CRAN (R 4.4.0)
 crayon           1.5.3      2024-06-20 [1] CRAN (R 4.4.1)
 data.table     * 1.15.4     2024-03-30 [1] CRAN (R 4.4.0)
 digest           0.6.35     2024-03-11 [1] CRAN (R 4.4.0)
 distributional * 0.4.0      2024-02-07 [1] CRAN (R 4.4.0)
 dplyr          * 1.1.4      2023-11-17 [1] CRAN (R 4.4.0)
 fansi            1.0.6      2023-12-08 [1] CRAN (R 4.4.0)
 forcats        * 1.0.0      2023-01-29 [1] CRAN (R 4.4.0)
 generics         0.1.3      2022-07-05 [1] CRAN (R 4.4.0)
 ggdist         * 3.3.2      2024-03-05 [1] CRAN (R 4.4.0)
 ggplot2        * 3.5.1      2024-04-23 [1] CRAN (R 4.4.0)
 ggridges       * 0.5.6      2024-01-23 [1] CRAN (R 4.4.0)
 glue             1.7.0      2024-01-09 [1] CRAN (R 4.4.0)
 gridExtra      * 2.3        2017-09-09 [1] CRAN (R 4.4.0)
 gtable           0.3.5      2024-04-22 [1] CRAN (R 4.4.0)
 here           * 1.0.1      2020-12-13 [1] CRAN (R 4.4.0)
 hms              1.1.3      2023-03-21 [1] CRAN (R 4.4.0)
 lattice          0.22-6     2024-03-20 [1] CRAN (R 4.4.1)
 lifecycle        1.0.4      2023-11-07 [1] CRAN (R 4.4.0)
 lubridate      * 1.9.3      2023-09-27 [1] CRAN (R 4.4.0)
 magrittr       * 2.0.3      2022-03-30 [1] CRAN (R 4.4.0)
 MASS             7.3-61     2024-06-13 [1] CRAN (R 4.4.1)
 Matrix           1.7-0      2024-04-26 [1] CRAN (R 4.4.1)
 MatrixModels     0.5-3      2023-11-06 [1] CRAN (R 4.4.0)
 matrixStats      1.3.0      2024-04-11 [1] CRAN (R 4.4.0)
 maxLik           1.5-2.1    2024-03-24 [1] CRAN (R 4.4.0)
 mcmc             0.9-8      2023-11-16 [1] CRAN (R 4.4.0)
 MCMCpack         1.7-0      2024-01-18 [1] CRAN (R 4.4.0)
 mded           * 0.1-2      2015-04-27 [1] CRAN (R 4.4.0)
 miscTools        0.6-28     2023-05-03 [1] CRAN (R 4.4.0)
 mnormt           2.1.1      2022-09-26 [1] CRAN (R 4.4.0)
 munsell          0.5.1      2024-04-01 [1] CRAN (R 4.4.0)
 mvtnorm          1.2-5      2024-05-21 [1] CRAN (R 4.4.0)
 numDeriv         2016.8-1.1 2019-06-06 [1] CRAN (R 4.4.0)
 pillar           1.9.0      2023-03-22 [1] CRAN (R 4.4.0)
 pkgconfig        2.0.3      2019-09-22 [1] CRAN (R 4.4.0)
 plyr             1.8.9      2023-10-02 [1] CRAN (R 4.4.0)
 purrr          * 1.0.2      2023-08-10 [1] CRAN (R 4.4.0)
 quantreg         5.98       2024-05-26 [1] CRAN (R 4.4.0)
 R6               2.5.1      2021-08-19 [1] CRAN (R 4.4.0)
 randtoolbox      2.0.4      2023-01-28 [1] CRAN (R 4.4.0)
 RColorBrewer   * 1.1-3      2022-04-03 [1] CRAN (R 4.4.0)
 Rcpp             1.0.12     2024-01-09 [1] CRAN (R 4.4.0)
 readr          * 2.1.5      2024-01-10 [1] CRAN (R 4.4.0)
 reshape2       * 1.4.4      2020-04-09 [1] CRAN (R 4.4.0)
 rlang            1.1.4      2024-06-04 [1] CRAN (R 4.4.0)
 rngWELL          0.10-9     2023-01-16 [1] CRAN (R 4.4.0)
 rprojroot        2.0.4      2023-11-05 [1] CRAN (R 4.4.0)
 RSGHB            1.2.2      2019-07-03 [1] CRAN (R 4.4.0)
 Rsolnp           1.16       2015-12-28 [1] CRAN (R 4.4.0)
 rstudioapi       0.16.0     2024-03-24 [1] CRAN (R 4.4.0)
 sandwich         3.1-0      2023-12-11 [1] CRAN (R 4.4.0)
 scales           1.3.0      2023-11-28 [1] CRAN (R 4.4.0)
 sessioninfo    * 1.2.2      2021-12-06 [1] CRAN (R 4.4.2)
 SparseM          1.83       2024-05-30 [1] CRAN (R 4.4.0)
 stringi          1.8.4      2024-05-06 [1] CRAN (R 4.4.0)
 stringr        * 1.5.1      2023-11-14 [1] CRAN (R 4.4.0)
 survival         3.7-0      2024-06-05 [1] CRAN (R 4.4.1)
 tibble         * 3.2.1      2023-03-20 [1] CRAN (R 4.4.0)
 tidyr          * 1.3.1      2024-01-24 [1] CRAN (R 4.4.0)
 tidyselect       1.2.1      2024-03-11 [1] CRAN (R 4.4.0)
 tidyverse      * 2.0.0      2023-02-22 [1] CRAN (R 4.4.0)
 timechange       0.3.0      2024-01-18 [1] CRAN (R 4.4.0)
 truncnorm        1.0-9      2023-03-20 [1] CRAN (R 4.4.0)
 tzdb             0.4.0      2023-05-12 [1] CRAN (R 4.4.0)
 utf8             1.2.4      2023-10-22 [1] CRAN (R 4.4.0)
 vctrs            0.6.5      2023-12-01 [1] CRAN (R 4.4.0)
 WeightIt       * 1.1.0      2024-05-04 [1] CRAN (R 4.4.0)
 withr            3.0.0      2024-01-16 [1] CRAN (R 4.4.0)
 zoo              1.8-12     2023-04-13 [1] CRAN (R 4.4.0)
```
