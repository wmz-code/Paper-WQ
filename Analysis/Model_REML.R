# Example for estimation for the response of protein content to climate at the national scale using REML method
rm(list = ls())
library(openxlsx)
library(boot)
library(lme4)
library(Matrix)

wheatdata = read.xlsx("/data/Others/wheat data.xlsx", sheet = 'Sheet1')
cli = read.xlsx("/data/Others/wheat data.xlsx", sheet = 'cli')
newdata = cbind(wheatdata, cli)

quality_name = c(
  "hardness.index",
  "crude.protein.content",
  "sedimentation.index",
  "wet.gluten.content",
  "water.absorption",
  "stability.time",
  "stretch.area",
  "max.resistance"
)

et = NULL
ep = NULL

for (i in 2){
  eachqulity = quality_name[i]  # protein content when i = 2
  wheat_quality = newdata[, eachqulity]
  
  subdata1 = cbind(wheat_quality, newdata[, c(3,4,7,9:12)])

  subdata1$year<-factor(subdata1$year)
  subdata1$variety<-factor(subdata1$variety)
  subdata1$PAC<-factor(subdata1$PAC)
  subdata1=na.omit(subdata1)
  sapply(subdata1,class)
  
  Model1 <- lmer(log(wheat_quality) ~ Tmean + Pre + (1 | year) + (1 | variety) + (1 | PAC),data = subdata1)
  
  re1 = summary(Model1)
  
  bt1 = re1$coefficients[2, 1]
  bp1 = re1$coefficients[3, 1]
  
  coeft = function(data, indices) {
    d = data[indices, ]
    fit = lmer(log(wheat_quality) ~ Tmean + Pre + (1 | year) + (1 | variety) + (1 | PAC),
               data = d)
    return(summary(fit)$coefficients[2])
  }
  
  coefp = function(data, indices) {
    d = data[indices, ]
    fit = lmer(log(wheat_quality) ~ Tmean + Pre + (1 | year) + (1 | variety) + (1 | PAC),
               data = d)
    return(summary(fit)$coefficients[3])
  }
  
  set.seed(123)
  results1 = boot(data = subdata1,
                  statistic = coeft,
                  R = 5000)
  stem = results1$t0
  ci1 = boot.ci(results1, conf = 0.90, type = c('bca'))
  conf1 = ci1[[4]]
  doci1 = conf1[[4]]
  upci1 = conf1[[5]]
  
  results2 = boot(data = subdata1,
                  statistic = coefp,
                  R = 5000)
  spre = results2$t0
  ci2 = boot.ci(results2, conf = 0.90, type = c('bca'))
  conf2 = ci2[[4]]
  doci2 = conf2[[4]]
  upci2 = conf2[[5]]
  
  et <- rbind(et, data.frame(stem, doci1, upci1))
  ep <- rbind(ep, data.frame(spre, doci2, upci2))
  
}

et = as.data.frame(et)
ep = as.data.frame(ep)

sheets = list("et" = et,
              "ep" = ep)

filename=paste0('/results/Model_REML_national.xlsx')

write.xlsx(
  sheets,
  file = filename,
  colNames = TRUE,
  borders = "columns",
  rowNames = TRUE
)











