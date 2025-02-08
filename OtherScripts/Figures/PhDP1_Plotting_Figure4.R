#### PhDP1: Experts ####
## Function: Outputs WTP by level of confidence in experts
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 14/12/2022
## Change: Added facet_wrap so we can compare models



#------------------------------
# Replication Information: ####
#------------------------------


# R version 4.2.0 (2022-04-22 ucrt)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows 10 x64 (build 19044)
#   [1] LC_COLLATE=English_United Kingdom.utf8  LC_CTYPE=English_United Kingdom.utf8
# [3] LC_MONETARY=English_United Kingdom.utf8 LC_NUMERIC=C
# [5] LC_TIME=English_United Kingdom.utf8
#   [1] ggplot2_3.3.6  reshape2_1.4.4 apollo_0.2.7



#------------------------------
# Setup Environment: ####
#------------------------------


rm(list = ls())


library(dplyr)
library(magrittr)
library(ggplot2)
library(ggridges)
library(here)
library(data.table)
library(tidyverse)
library(ggdist)


#------------------------------------------
# Import Necessary Data: ####
#------------------------------------------



## Database and model-specific WTP:
database <- data.frame(fread(here("Data", "Long_Weights_Category_Clean.csv")))
ModelFive_WTP <- data.frame(fread(here("Output/ModelFiveB", "PhD_MXL_ModelFiveB_2023_02_18_WTP.csv")))
ModelSeven_WTP <- data.frame(fread(here("Output/ModelSevenB", "PhD_MXL_ModelSevenB_2023_02_18_WTP.csv")))



#------------------------------------------
# Combine Data: ####
#------------------------------------------



## Combine variables her:
CombinedFive <-  cbind("b_Price.post.mean" = ModelFive_WTP$b_Price.post.mean,
                        "b_Performance_10.post.mean" = ModelFive_WTP$b_Performance_10.post.mean,
                        "b_Performance_50.post.mean" = ModelFive_WTP$b_Performance_50.post.mean,
                        "b_Emissions_40.post.mean" = ModelFive_WTP$b_Emissions_40.post.mean,
                        "b_Emissions_90.post.mean" = ModelFive_WTP$b_Emissions_90.post.mean,
                        "Experts" = database$Experts[seq.int(1, nrow(database), 4)],
                       "Weighted" = rep(0,ModelFive_WTP %>% nrow())
) %>% data.frame()


## Same with weighted data:
CombinedSeven <-  cbind("b_Price.post.mean" = ModelSeven_WTP$b_Price.post.mean,
                   "b_Performance_10.post.mean" = ModelSeven_WTP$b_Performance_10.post.mean,
                   "b_Performance_50.post.mean" = ModelSeven_WTP$b_Performance_50.post.mean,
                   "b_Emissions_40.post.mean" = ModelSeven_WTP$b_Emissions_40.post.mean,
                   "b_Emissions_90.post.mean" = ModelSeven_WTP$b_Emissions_90.post.mean,
                   "Experts" = database$Experts[seq.int(1, nrow(database), 4)],
                   "Weighted" = rep(1,ModelSeven_WTP %>% nrow())
) %>% data.frame()


## Now combine here
WTP <- bind_rows(CombinedFive, CombinedSeven)



#------------------------------------------
# Plotting WTP ####
#------------------------------------------

## Need this for defining legend labels and sample sizes here
## divide_by(2) bc we're doubling up the dataframes
Labels <- WTP$Experts %>% table() %>% divide_by(2) %>% unlist() %>% data.frame()


## Specify and transform data here
PlotData <-
  WTP %>% pivot_longer(
    cols = 1:5,
    names_to = c("variable"),
    values_to = c("value")
  ) %>%
  mutate(variable = factor(variable,  levels = unique(variable)))


## Compares the weighted and unweighted models side by side:
WTPPlot <- PlotData %>%
  ggplot(aes(
    y = variable,
    x = value,
    fill = factor(Experts)
  )) +

  stat_boxplot(geom = "errorbar",
               width = 0.25,
               position = position_dodge(width = 0.75)) +
  geom_boxplot(outlier.shape = NA) +

  facet_wrap( ~ Weighted, labeller = as_labeller(c('0' = "Unweighted", '1' = "Weighted"))) +
  geom_vline(xintercept = 0, linetype = 'dashed') +
  scale_y_discrete(
    name = "Attribute",
    label = c(
      "Price",
      "Performance:\n Medium",
      "Performance:\n High",
      "Emissions:\n Medium",
      "Emissions:\n High"
    )
  ) +
  theme_bw() + geom_vline(xintercept = 0) +
  scale_x_continuous(
    name = "WTP in Pounds Per Product",
    limits = c(-5, 2.5)
    ,
    breaks = seq(-5, 2.5, 0.5)
  ) +
  scale_fill_manual(
    name = "Confidence:",
    values = RColorBrewer::brewer.pal(9,  "Blues")[c(1, 3, 5, 7, 9)],
    label = paste0(Labels[, 1], "\n(N: ",  Labels[, 2], ")") %>% c(),
    guide = guide_legend(reverse = FALSE)
  ) +
  theme(
    legend.position = "bottom",
    legend.background = element_blank(),
    legend.box.background = element_rect(colour = "black"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_blank(),
    axis.text.x = element_text(color = "black"),
    axis.text.y = element_text(color = "black")
  ) +
  coord_flip()



#----------------------------------------------------------------------------------------------------------
#### Section 3: Export Plots ####
#----------------------------------------------------------------------------------------------------------



ggsave(
  WTPPlot,
  device = "jpeg",
  filename = here("Output/Plots", "Figure4_WTPPlot.jpeg"),
  width = 25,
  height = 15,
  units = "cm",
  dpi = 500
)


#----------------------------------------------------------------------------------------------------------
#### Section Extra: Density Plots ####
#----------------------------------------------------------------------------------------------------------


## I like density plots but in this case they don't look so striking
# WTP_DensityPlot <- WTP %>% pivot_longer(cols = 1:5, names_to = c("variable"), values_to = c("value")) %>%
#   mutate(variable=factor(variable,  levels=unique(variable)))%>%
#   ggplot(aes(y=variable,  x=value,  fill=factor(Experts))) +
#   stat_halfeye(normalize="groups", position="dodge")+
#   facet_wrap(~Weighted, labeller = as_labeller(
#     c('0' = "Unweighted", '1' = "Weighted")))+
#   geom_vline(xintercept=0, linetype='dashed')+
#   scale_y_discrete(name="Attribute",
#                    label=c("Price",
#                            "Performance: Medium",
#                            "Performance: High",
#                            "Emissions: Medium",
#                            "Emissions: High"))+
#   theme_bw()+geom_vline(xintercept=0)+
#   scale_x_continuous(name="WTP in Pounds Per Product",
#                      limits=c(-5, 5)
#                      , breaks = seq(-5, 5, 0.5))+
#   scale_fill_manual(name="Confidence:", values=RColorBrewer::brewer.pal(9,  "Blues")[c(1, 3, 5, 7, 9)],
#                     label=paste0(Labels[, 1], "\n(N: ",  Labels[, 2], ")") %>% c(),
#                     guide=guide_legend(reverse = FALSE))+
#   theme(legend.position = "bottom",
#         legend.background=element_blank(),
#         legend.box.background = element_rect(colour="black"),
#         panel.grid.major.x=element_blank(),
#         panel.grid.minor.x=element_blank(),
#         panel.grid.major.y=element_blank())



# ggsave(WTP_DensityPlot,  device = "jpeg",
#        filename = "WTP_DensityPlot.jpeg",
#        width=20, height=15, units = "cm", dpi=1000)
#

# End Of Script ----------------------------------------------------
