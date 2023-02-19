#### PhDP1: Model Summaries ####
## Function: Compares MXL results
## Author: Dr Peter King (p.m.king@kent.ac.uk)
## Last change: 13/12/2022
## TODO: add density plots



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


library(apollo)
library(dplyr)
library(magrittr)
library(ggplot2)
library(ggridges)
library(reshape2)
library(mded)
library(here)
library(data.table)



#------------------------------------------
# Import Results And Models: ####
#------------------------------------------


#--------- Estimates:
ModelOne_Estimates <- data.frame(read.csv("PhD_MNL_ModelOne_2022_08_25_estimates.csv"))
ModelTwo_Estimates <- data.frame(read.csv("PhD_MNL_ModelTwo_2022_08_25_estimates.csv"))
ModelThree_Estimates <- data.frame(read.csv("PhD_MNL_ModelThree_2022_08_25_estimates.csv"))
ModelFour_Estimates <- data.frame(read.csv("PhD_MNL_ModelFour_2022_08_25_estimates.csv"))
ModelFive_Estimates <- data.frame(read.csv("PhD_MXL_ModelFive_2022_08_25_estimates.csv"))
ModelSix_Estimates <- data.frame(read.csv("PhD_MXL_ModelSix_2022_08_25_estimates.csv"))
ModelSeven_Estimates <- data.frame(read.csv("PhD_MXL_ModelSeven_2022_08_25_estimates.csv"))
ModelEight_Estimates <- data.frame(read.csv("PhD_MXL_ModelEight_2022_08_25_estimates.csv"))


#--------- Outputs:
ModelOne_Models <- readRDS("PhD_MNL_ModelOne_2022_08_25_model.rds")
ModelTwo_Models <- readRDS("PhD_MNL_ModelTwo_2022_08_25_model.rds")
ModelThree_Models <- readRDS("PhD_MNL_ModelThree_2022_08_25_model.rds")
ModelFour_Models <- readRDS("PhD_MNL_ModelFour_2022_08_25_model.rds")
ModelFive_Models <- readRDS("PhD_MXL_ModelFive_2022_08_25_model.rds")
ModelSix_Models <- readRDS("PhD_MXL_ModelSix_2022_08_25_model.rds")
ModelSeven_Models <- readRDS("PhD_MXL_ModelSeven_2022_08_25_model.rds")
ModelEight_Models <- readRDS("PhD_MXL_ModelEight_2022_08_25_model.rds")

#------------------------------------------
# First Table: Summary Of MNLs ####
#------------------------------------------



ModelOutput <- function(Estimates) {
  data.frame("Variable" =  Estimates$X, 
             "Estimate" =  paste(
               ifelse(
                 Estimates$Rob.p.val.0. < 0.01, 
                 paste0(round(Estimates$Estimate,  3),  "***"), 
                 ifelse(
                   Estimates$Rob.p.val.0. < 0.05, 
                   paste0(round(Estimates$Estimate,  3),  "**"), 
                   ifelse(
                     Estimates$Rob.p.val.0. < 0.1, 
                     paste0(round(Estimates$Estimate,  3),  "*"), 
                     round(Estimates$Estimate,  3)
                   )
                 )
               ), 
               paste0("(", round(Estimates$Rob.std.err.,  3), ")")))
}


## Export Categorical MNL Models:
cbind(ModelOutput(ModelOne_Estimates),
      ModelOutput(ModelTwo_Estimates)[,2]) %>% 
  write.csv(quote=F,row.names=F)

## Export Dummy MNL Models:
cbind(ModelOutput(ModelThree_Estimates),
      ModelOutput(ModelFour_Estimates)[,2]) %>% 
  write.csv(quote=F,row.names=F)


#------------------------------------------
# Second Table: Summary Of Mixed Logits ####
#------------------------------------------


## Export Categorical MNL Models:
cbind(ModelOutput(ModelSix_Estimates),
      ModelOutput(ModelEight_Estimates)[,2]) %>% 
  write.csv(quote=F,row.names=F)

## Export Dummy MNL Models:
cbind(ModelOutput(ModelFive_Estimates),
      ModelOutput(ModelSeven_Estimates)[,2]) %>% 
  write.csv(quote=F,row.names=F)


#------------------------------------------
# Third Table: Summary Of Group WTP ####
#------------------------------------------


database <- data.frame(read.csv("Long_Weights_Dummy_2022_08_25.csv"))
ModelFive_WTP <- data.frame(read.csv("PhD_MXL_ModelFive_2022_08_25_WTP.csv"))
ModelSix_WTP <- data.frame(read.csv("PhD_MXL_ModelSix_2022_08_25_WTP.csv"))
ModelSeven_WTP <- data.frame(read.csv("PhD_MXL_ModelSeven_2022_08_25_WTP.csv"))
ModelEight_WTP <- data.frame(read.csv("PhD_MXL_ModelEight_2022_08_25_WTP.csv"))



SummariseWTP <- function(WTP) {
  data.frame("Title"=rbind(
    paste0(round(median(WTP$b_Price.post.mean),  2), " (", round(quantile(WTP$b_Price.post.mean,  c(0.025)),  2),  ") - (",  round(quantile(WTP$b_Price.post.mean,  c(0.975)), 2), ")"), 
    paste0(round(median(WTP$b_Performance_10.post.mean),  2), " (", round(quantile(WTP$b_Performance_10.post.mean,  c(0.025)),  2),  ") - (",  round(quantile(WTP$b_Performance_10.post.mean,  c(0.975)), 2), ")"), 
    paste0(round(median(WTP$b_Performance_50.post.mean),  2), " (", round(quantile(WTP$b_Performance_50.post.mean,  c(0.025)),  2),  ") - (",  round(quantile(WTP$b_Performance_50.post.mean,  c(0.975)), 2), ")"), 
    paste0(round(median(WTP$b_Emissions_40.post.mean),  2), " (", round(quantile(WTP$b_Emissions_40.post.mean,  c(0.025)),  2),  ") - (",  round(quantile(WTP$b_Emissions_40.post.mean,  c(0.975)), 2), ")"), 
    paste0(round(median(WTP$b_Emissions_90.post.mean),  2), " (", round(quantile(WTP$b_Emissions_90.post.mean,  c(0.025)),  2),  ") - (",  round(quantile(WTP$b_Emissions_90.post.mean,  c(0.975)), 2), ")")))
}


## Export Table
cbind(
  SummariseWTP(-1*ModelEight_WTP %>% filter(b_Price.ID %in% (database$ID[database$ExpertsDummy==0] ))),
  SummariseWTP(-1*ModelEight_WTP %>% filter(b_Price.ID %in% (database$ID[database$ExpertsDummy==1] )))) %>% write.csv(quote=F,row.names=F)



ModelEight_WTP$Dummy <- ifelse(ModelEight_WTP$b_Price.ID %in% 
                                 (database$ID[database$ExpertsDummy==0]),0,1)

ModelEight_WTP_Trimmed <- ModelEight_WTP[ModelEight_WTP$b_Price.post.mean>-25,]


ModelEight_WTP_Trimmed <- data.frame(cbind(
  "b_Price.post.mean"=ModelEight_WTP_Trimmed$b_Price.post.mean,
  "b_Performance_10.post.mean"=ModelEight_WTP_Trimmed$b_Performance_10.post.mean*-1,
  "b_Performance_50.post.mean"=ModelEight_WTP_Trimmed$b_Performance_50.post.mean*-1,
  "b_Emissions_40.post.mean"=ModelEight_WTP_Trimmed$b_Emissions_40.post.mean*-1,
  "b_Emissions_90.post.mean"=ModelEight_WTP_Trimmed$b_Emissions_90.post.mean*-1,
  "Dummy"=ModelEight_WTP_Trimmed$Dummy))
  
  # ModelEight_WTP_Trimmed %>% select(ends_with(".post.mean")),"Dummy"=ModelEight_WTP_Trimmed$Dummy)

WTPPlot <- ModelEight_WTP_Trimmed %>% 
  reshape2::melt(id.vars="Dummy") %>% 
  ggplot(aes(y=variable, x=value, fill=factor(Dummy))) +
  geom_boxplot(varwidth = 0.5,outlier.shape = NA)+
  geom_vline(xintercept=0,linetype='dashed')+
  scale_y_discrete(name="Attribute",
                   label=c("Price",
                           "Performance: High",
                           "Performance: Medium",
                           "Emissions: High",
                           "Emissions: Medium"))+
  theme_bw()+geom_vline(xintercept=0)+
  scale_x_continuous(name="WTP in Pounds Per Product", 
                     limits=c(-5,5)
                     ,breaks = seq(-5,5,0.5))+
  scale_fill_manual(name="Group:",values=RColorBrewer::brewer.pal(9, "Blues")[c(5,9)],
                    label=c("Low\n (N = 280)\n",
                            "High\n (N = 326)\n"),
                    guide=guide_legend(reverse = FALSE))+
  theme(legend.position = "bottom", 
        legend.background=element_blank(),
        legend.box.background = element_rect(colour="black"),
        panel.grid.major.x=element_blank(),
        panel.grid.minor.x=element_blank(),
        panel.grid.major.y=element_blank())+
  coord_flip()
  


WTP_DensityPlot <- 
ModelEight_WTP_Trimmed %>% 
  reshape2::melt(id.vars="Dummy") %>% 
  ggplot(aes(y=variable, x=value, fill=factor(Dummy))) +
  stat_halfeye(normalize="groups",position="dodge")+
  geom_vline(xintercept=0,linetype='dashed')+
  scale_y_discrete(name="Attribute",
                   label=c("Price",
                           "Performance: Medium",
                           "Performance: High",
                           "Emissions: Medium",
                           "Emissions: High"))+
  theme_bw()+geom_vline(xintercept=0)+
  scale_x_continuous(name="WTP in Pounds Per Product", 
                     limits=c(-5,5)
                     ,breaks = seq(-5,5,0.5))+
  scale_fill_manual(name="Group:",values=RColorBrewer::brewer.pal(9, "Blues")[c(5,9)],
                    label=c("Low\n (N = 280)\n",
                            "High\n (N = 326)\n"),
                    guide=guide_legend(reverse = FALSE))+
  theme(legend.position = "bottom", 
        legend.background=element_blank(),
        legend.box.background = element_rect(colour="black"),
        panel.grid.major.x=element_blank(),
        panel.grid.minor.x=element_blank(),
        panel.grid.major.y=element_blank())
  
#----------------------------------------------------------------------------------------------------------
#### Section 3: Export Plots ####
#----------------------------------------------------------------------------------------------------------


ggsave(WTPPlot, device = "jpeg",
       filename = "WTPPlot.jpeg",
       width=20,height=15,units = "cm",dpi=1000)



ggsave(WTP_DensityPlot, device = "jpeg",
       filename = "WTP_DensityPlot.jpeg",
       width=20,height=15,units = "cm",dpi=1000)

# End Of Script ----------------------------------------------------