#### PhDP1: Experts ####
## Function: Outputs WTP by level of confidence in experts
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 14/12/2022
## Change: Added facet_wrap so we can compare models



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
library(ggplot2)
library(ggridges)
library(here)
library(data.table)
library(tidyverse)
library(ggdist)


# *****************************
# Import Necessary Data: ####
# *****************************




## Database and model-specific WTP:
database <-
  data.frame(fread(here(
    "Data", "Long_Weights_Category_2022_12_12.csv"
  )))
ModelFive_WTP <-
  data.frame(fread(
    here(
      "Output/ModelFiveB",
      "PhD_MXL_ModelFiveB_2023_02_18_WTP.csv"
    )
  ))
ModelSeven_WTP <-
  data.frame(fread(
    here(
      "Output/ModelSevenB",
      "PhD_MXL_ModelSevenB_2023_02_18_WTP.csv"
    )
  ))



# *****************************
# Combine Data: ####
# *****************************




## Combine variables her:
CombinedFive <-
  cbind(
    "b_Price.post.mean" = ModelFive_WTP$b_Price.post.mean,
    "b_Performance_10.post.mean" = ModelFive_WTP$b_Performance_10.post.mean,
    "b_Performance_50.post.mean" = ModelFive_WTP$b_Performance_50.post.mean,
    "b_Emissions_40.post.mean" = ModelFive_WTP$b_Emissions_40.post.mean,
    "b_Emissions_90.post.mean" = ModelFive_WTP$b_Emissions_90.post.mean,
    "Experts" = database$Experts[seq.int(1, nrow(database), 4)],
    "Weighted" = rep(0, ModelFive_WTP %>% nrow())
  ) %>% data.frame()



## Same with weighted data:
CombinedSeven <-
  cbind(
    "b_Price.post.mean" = ModelSeven_WTP$b_Price.post.mean,
    "b_Performance_10.post.mean" = ModelSeven_WTP$b_Performance_10.post.mean,
    "b_Performance_50.post.mean" = ModelSeven_WTP$b_Performance_50.post.mean,
    "b_Emissions_40.post.mean" = ModelSeven_WTP$b_Emissions_40.post.mean,
    "b_Emissions_90.post.mean" = ModelSeven_WTP$b_Emissions_90.post.mean,
    "Experts" = database$Experts[seq.int(1, nrow(database), 4)],
    "Weighted" = rep(1, ModelSeven_WTP %>% nrow())
  ) %>% data.frame()


## Now combine here
WTP <- bind_rows(CombinedFive, CombinedSeven)

TextSize <- 12

# *****************************
# Create plot data ####
# *****************************


## Need this for defining legend labels and sample sizes here
## divide_by(2) bc we're doubling up the dataframes
Labels <-
  WTP$Experts %>% table() %>% divide_by(2) %>% unlist() %>% data.frame()


## Specify and transform data here
PlotData <-
  WTP %>% pivot_longer(
    cols = 1:5,
    names_to = c("variable"),
    values_to = c("value")
  ) %>%
  mutate(variable = factor(variable,  levels = unique(variable))) %>%
  group_by(Experts,
           Weighted,
           variable) %>%
  group_modify( ~ mutate(
    .x,
    YMIN = quantile(value, 0.025),
    YMAX = quantile(value, 0.975)
  )) %>%
  ungroup()


## Dropping the few rows who waste the plot white space
PlotData_Filtered <- PlotData %>%
  filter(!(variable == "b_Price.post.mean" & value < -10))



# *****************************
# Plot  ####
# *****************************


FigureX <- PlotData_Filtered %>%
  ggplot(aes(
    x = Experts %>% as.factor(),
    y = value,
    fill = factor(Weighted))) +

  stat_boxplot(geom = "errorbar",
               width = 0.25,
               position = position_dodge(width = 0.75)) +

  geom_boxplot(outlier.shape = NA) +

  # ggdist::stat_halfeye(normalize = "groups", position = "dodge") +

  facet_wrap( ~ variable,
              scales = "free_y",
              labeller = as_labeller(c(
                'b_Price.post.mean' = "Price",
                'b_Performance_10.post.mean' = "Performance: Medium",
                'b_Performance_50.post.mean' = "Performance: High",
                'b_Emissions_40.post.mean' = "Emissions: Medium",
                'b_Emissions_90.post.mean' = "Emissions: High"))) +

  theme_bw() +

  scale_x_discrete(name = "Self-reported confidence in experts",
                   label = c("1/5", "2/5", "3/5", "4/5", "5/5")) +

  scale_fill_manual(
    name = "Model type",
    values = RColorBrewer::brewer.pal(9,  "Blues")[c(3, 7)],
    label = c("Unweighted", "Weighted")
  ) +
  theme(
    legend.position = "bottom",
    legend.text = element_text(
      size = TextSize,
      colour = "black",
      family = "serif"
    ),
    strip.background = element_rect(fill = "white"),
    legend.background = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor.y = element_blank(),
    legend.title = element_text(
      size = TextSize,
      colour = "black",
      family = "serif"
    ),
    axis.text.x = element_text(
      size = TextSize,
      colour = "black",
      family = "serif"
    ),
    ## Change text to be clearer for reader
    axis.text.y = element_text(
      size = TextSize,
      colour = "black",
      family = "serif"
    ),
    axis.title.y = element_text(
      size = TextSize,
      colour = "black",
      family = "serif"
    ),
    axis.title.x = element_text(
      size = TextSize,
      colour = "black",
      family = "serif"
    )
  ) + geom_vline(xintercept = 0) +
  scale_y_continuous(
    name = "WTP in Pounds Per Product"
  )


# *****************************
#### Section 3: Export Plots ####
# *****************************



ggsave(
  FigureX,
  device = "png",
  filename = here("Output/Plots", "Figure4_WTPPlotFacet.png"),
  width = 25,
  height = 15,
  units = "cm",
  dpi = 500
)


# *****************************
#### Section Extra: Density Plots ####
# *****************************


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
