rm(list=ls()) #PCA 
library(openxlsx)
library(tidyverse)
library(factoextra)
library(corrplot)
library(pheatmap)
library(RColorBrewer)
library(ggplot2)

wheatdata=read.xlsx("wheat.xlsx",sheet='Sheet1')
qualitydata=wheatdata[,c(11,14,17,19,21,23,24,26)] # eight indicators

qualitydata=na.omit(qualitydata)
summary(qualitydata)

p=prcomp(qualitydata,scale=TRUE)  #Rotation  
summary(p)  
p$rotation #loading
var=get_pca_var(p)
 
# biplot
fviz_pca_var(p, axes = c(2, 3),
             repel = TRUE) +   
  theme_classic() +   
  theme(panel.border = element_rect(color = "black", fill = NA, size = 1))+
  theme(
    axis.ticks.length = unit(-0.2, "cm"),   
    axis.ticks = element_line(color = "black")   
  )

# screen plot
fviz_screeplot(p,addlabels=T,barfill="#8b9dc3",barcolor="#8b9dc3")+theme_classic()+
  theme(panel.border = element_rect(color = "black", fill = NA, size = 1))+
  theme(axis.ticks.length = unit(0.15,"cm"),
        axis.text.x = element_text(margin = unit(c(0.15,0.15,0.15,0.15),"cm"),size=10,color="black"),
        axis.text.y = element_text(margin = unit(c(0.15,0.15,0.15,0.15),"cm"),angle=90,size=10,color="black"))+
  theme(axis.title.x =element_text(size=12), axis.title.y=element_text(size=12),axis.text.x = element_text(size=12,colour = "black"),
        axis.text.y = element_text(size=12,colour = "black"))+ylim(0,50)+
  theme(
    axis.ticks.length = unit(-0.2, "cm"),   
    axis.ticks = element_line(color = "black"),  
  )
  
# heatmap
corrplot(var$cos2,is.corr=F,col=brewer.pal(n=8,name="YlGnBu"),tl.col = "black")







