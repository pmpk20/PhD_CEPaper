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
  "Long_Weights_Category_Clean.csv") %>%
  fread() %>%
  data.frame()



# *****************************
# Chi Square Test: ####
# *****************************



Means <- rbind(
  database$Q12CECertainty[database$Experts==1] %>% table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Q12CECertainty[database$Experts==2] %>% table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Q12CECertainty[database$Experts==3] %>% table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Q12CECertainty[database$Experts==4] %>% table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Q12CECertainty[database$Experts==5] %>% table() %>% as.numeric() %>% data.frame() %>% t()
  ) %>% data.frame()


Freqs <- rbind(
  database$Q12CECertainty[database$Experts==1] %>% table() %>% prop.table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Q12CECertainty[database$Experts==2] %>% table() %>% prop.table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Q12CECertainty[database$Experts==3] %>% table() %>% prop.table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Q12CECertainty[database$Experts==4] %>% table() %>% prop.table() %>% as.numeric() %>% data.frame() %>% t(),
  database$Q12CECertainty[database$Experts==5] %>% table() %>% prop.table() %>% as.numeric() %>% data.frame() %>% t()
  ) %>% data.frame()


Freqs_Table <- Freqs %>%
  multiply_by(100) %>%
  round(2)


Rows <- c("1", "2", "3", "4", "5")
Cols <- c("Unsure","Quite","Very")

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


TableData_Complete <-
  rbind(TableData_TopSection,
        TableData_BottomSection)



# *****************************
#### Section 4: Export Table ####
# *****************************


## Export results to screen for copy and pasting
TableData_Complete %>% write.csv(quote = FALSE, row.names = FALSE)


## Export:
TableData_Complete %>%
  fwrite(sep=",",
         here("Output/Tables","Table5_Certainty_ChiSquare.txt"),
         row.names = TRUE,
         quote = FALSE)



# End Of Script ----------------------------------------------------------------
