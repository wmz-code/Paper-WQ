# Example for estimation for the response of protein content to climate at the national scale using Bayesian mixed model 
rm(list = ls()) 
library(openxlsx)
library(brms)
library(dplyr)
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
R = NULL

for (i in 2){ 
  eachquality = quality_name[i]  # protein content when i = 2
  wheat_quality = newdata[, eachquality]
  
  subdata1 = cbind(wheat_quality, newdata[, c(3,4,7,9:12)])
  
  subdata1$year <- factor(subdata1$year) #year
  subdata1$variety <- factor(subdata1$variety) #cultivar
  subdata1$PAC <- factor(subdata1$PAC) # location
  subdata1 = na.omit(subdata1)
  sapply(subdata1, class)
  
  model <- brm(
    formula = log(wheat_quality) ~ Tmean + Pre + (1 | year) + (1 | variety) + (1 | PAC),
    data = subdata1,
    family = gaussian(),  
    control = list(adapt_delta = 0.95),
    prior = c(
      set_prior("normal(0, 10)", class = "b"),   
      set_prior("student_t(3, 0, 10)", class = "Intercept"),   
      set_prior("exponential(0.1)", class = "sd"),
      set_prior("normal(0, 10)", class = "sigma")
    ),
    iter = 4000,   
    chains = 4,    
    cores = 4,     
    seed = 123     
  )
  
  summary(model)

  # estimation
  fixef_estimates <- fixef(model)
  E_tem=fixef_estimates[2,1]
  E_pre=fixef_estimates[3,1]
  
  interval_90 <- posterior_interval(model, prob = 0.90)  # CI90
  tem_d90=interval_90[2,1]  
  tem_u90=interval_90[2,2]
  pre_d90=interval_90[3,1]  
  pre_u90=interval_90[3,2]
  
  # R2
  r2_samples=bayes_R2(model,summary = FALSE)
  r2=bayes_R2(model)[1]
  r2_90 <- quantile(r2_samples, probs = c(0.05, 0.95))
  r2_d90=r2_90[1]
  r2_u90=r2_90[2]
  et <- rbind(et, data.frame(E_tem, tem_d90,tem_u90))
  ep <- rbind(ep, data.frame(E_pre, pre_d90,pre_u90))
  
  R=rbind(R, data.frame(r2, r2_d90,r2_u90))
}

et = as.data.frame(et)
ep = as.data.frame(ep)
R = as.data.frame(R)

sheets = list("et" = et,
              "ep" = ep,
              'R'=R)

filename=paste0('/results/Model_bayes_national.xlsx')

write.xlsx(sheets, file = filename, colNames = TRUE, borders = "columns",rowNames = TRUE)




