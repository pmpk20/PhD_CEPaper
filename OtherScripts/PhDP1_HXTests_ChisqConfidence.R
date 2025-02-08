#### PhDP1: WTP Summary ####
## Function: Hypothesis One Tests
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 03/06/2023
## Change: Changing to the categorical models instead



# *****************************
# Replication Information: ####
# *****************************


# R version 4.2.0 (2022-04-22 ucrt)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows 10 x64 (build 19044)
#   [1] LC_COLLATE=English_United Kingdom.utf8  LC_CTYPE=English_United Kingdom.utf8
# [3] LC_MONETARY=English_United Kingdom.utf8 LC_NUMERIC=C
# [5] LC_TIME=English_United Kingdom.utf8
#   [1] ggplot2_3.3.6  reshape2_1.4.4 apollo_0.2.7



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
    "Long_Weights_Category_2022_12_12.csv") %>%
  fread() %>%
  data.frame()



# *****************************
# Chi Square Test: ####
# *****************************

TestTable <- rbind(
  database$Q12CECertainty[database$Experts==1] %>% table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Q12CECertainty[database$Experts==2] %>% table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Q12CECertainty[database$Experts==3] %>% table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Q12CECertainty[database$Experts==4] %>% table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Q12CECertainty[database$Experts==5] %>% table() %>% as.numeric() %>% data.frame() %>% t())


rownames(TestTable)<- c("1","2",
                        "3","4",
                        "5")
colnames(TestTable)<- c("Unsure","Quite","Very")




# *****************************
# Setup data: ####
# *****************************



Lists_Means = vector("list", length = 5)
Lists_Freqs = vector("list", length = 5)
Table_Freqs = matrix(0,5,3)
Table_Means = matrix(0,5,3)


for (i in 1:5){
  Lists_Means[[i]] <- data.frame(database$Q12CECertainty[database$Experts==i] %>% table() %>% data.frame())[,2]
  Lists_Freqs[[i]] <- data.frame(database$Q12CECertainty[database$Experts==i] %>% table() %>% prop.table() %>% data.frame())[,2]
}
Table_Means = do.call(bind_cols, Lists_Means) %>% data.frame()
Table_Freqs = do.call(bind_cols, Lists_Freqs) %>% data.frame()



## Rename dimension names:

colnames(Table_Means) <- c("1","2","3","4","5")
colnames(Table_Freqs) <- c("1","2","3","4","5")

rownames(Table_Means) <-  c("Unsure","Quite","Very")
rownames(Table_Freqs) <-  c("Unsure","Quite","Very")


# *****************************
# Chi Square Test: ####
# *****************************

Comparisons <- data.frame("Comparisons"=c("5","1","2","3","4"))


## Test frequency of A and B choices per level with the reference level being `low`:
Tests <- bind_cols(
  chisq.test(x = c(Table_Means$`1`),p = c(Table_Freqs$`5`),correct = TRUE)$p.value,
  chisq.test(x = c(Table_Means$`2`),p = c(Table_Freqs$`1`),correct = TRUE)$p.value,
  chisq.test(x = c(Table_Means$`3`),p = c(Table_Freqs$`2`),correct = TRUE)$p.value,
  chisq.test(x = c(Table_Means$`4`),p = c(Table_Freqs$`3`),correct = TRUE)$p.value,
  chisq.test(x = c(Table_Means$`5`),p = c(Table_Freqs$`4`),correct = TRUE)$p.value
) %>% t() %>% data.frame()


## To fit with output
rownames(Tests) <- c("1","2","3","4","5")
colnames(Tests) <- c("P Values")
Tests$`P Values` %<>% round(3)


# *****************************----------------------------------------------------------------
#### Section 5: Combining outputs ####
# *****************************----------------------------------------------------------------


Output <- bind_cols(
  data.frame("1"=paste0(Table_Means$`1`," (",Table_Freqs$`1` %>% multiply_by(100) %>% round(2),"%)")),
  data.frame("2"=paste0(Table_Means$`2`," (",Table_Freqs$`2` %>% multiply_by(100) %>% round(2),"%)")),
  data.frame("3"=paste0(Table_Means$`3`," (",Table_Freqs$`3` %>% multiply_by(100) %>% round(2),"%)")),
  data.frame("4"=paste0(Table_Means$`4`," (",Table_Freqs$`4` %>% multiply_by(100) %>% round(2),"%)")),
  data.frame("5"=paste0(Table_Means$`5`," (",Table_Freqs$`5` %>% multiply_by(100) %>% round(2),"%)"))
) %>% t() %>% data.frame()


## To fit with tests
rownames(Output) <- c("1","2","3","4","5")
colnames(Output) <-  c("Unsure","Quite","Very")


## Combine frequencies and chi square test results
Table4 <- bind_cols(Output,Comparisons,Tests)

# *****************************----------------------------------------------------------------
#### Section 4: Export Table ####
# *****************************----------------------------------------------------------------


## Export results to screen for copy and pasting
Table4 %>% write.csv(quote=F)


## Export:
Table4 %>%
  fwrite(sep=",",
         here("Output/Tables","TableX_ChisqConfidence.txt"),
         row.names = TRUE,
         quote = FALSE)



# End Of Script ----------------------------------------------------------------
