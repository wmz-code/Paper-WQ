rm(list=ls()) 
library(openxlsx)
library(pheatmap)
library(RColorBrewer)
display.brewer.all()
A=read.xlsx("D:\\Home\\Data\\Fig2\\Fig2b.xlsx",sheet='R')
B=read.xlsx("D:\\Home\\Data\\Fig2\\Fig2b.xlsx",sheet='P')
C=round(A, digits = 2)
bk=c(seq(-1,-0.01,by=0.025),seq(0,1,by=0.025))
A[lower.tri(A)] <- NULL
p1=pheatmap(A,display_numbers = C,cluster_rows = T,cluster_cols = T,color=colorRampPalette((brewer.pal(9,"BrBG")))(81),
            legend_breaks = c(-1,-0.8,-0.6,-0.4,-0.2,0,0.2,0.4,0.6,0.8,1),breaks=bk,legend_labels = c("-1","-0.8","-0.6","-0.4","-0.2","0","0.2","0.4","0.6","0.8","1"),
            labels_row=c("hardness index","crude protein content","sedimentation index","wet gluten content","water absorption","stability time","stretch area","max resistance"),fontsize = 10,border_color="black")
