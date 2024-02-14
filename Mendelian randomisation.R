#EXPOSURE HDL
library("epigraphdb")

res = query_epigraphdb(
  route="/mr",
  params=list(exposure_trait="HDL cholesterol", outcome_trait=NULL, pval_threshold=1e-05),
  mode="table"
)
res

a <- res[grep("ukb", res$exposure.id), ]
a <- a[grep("ukb", a$outcome.id), ]

a<- a[!grepl("raw", a$exposure.id), ]
a<- a[!grepl("raw", a$outcome.id),]

write.xlsx(a, "C:/Users/aksha/OneDrive/Desktop/Research Project 2 - Mendelian Randomisation/HDL_Exposure2.xlsx")

##OUTCOME HDL

library("epigraphdb")

res = query_epigraphdb(
  route="/mr",
  params=list(exposure_trait=NULL, outcome_trait="HDL cholesterol", pval_threshold=1e-05),
  mode="table"
)
res

a<-res[grepl("ukb", res$exposure.id), ]
a<-a[grepl("ukb", a$outcome.id), ]

a<-a[!grepl("raw", a$exposure.id), ]
a<-a[!grepl("raw", a$outcome.id), ]

write.xlsx(a, "C:/Users/aksha/OneDrive/Desktop/Research Project 2 - Mendelian Randomisation/HDL_Outcome2.xlsx")


#####LDL CHOLESTEROL EXPOSURE
library("epigraphdb")

res = query_epigraphdb(
  route="/mr",
  params=list(exposure_trait="LDL direct", outcome_trait=NULL, pval_threshold=1e-05),
  mode="table"
)
res

library(data.table)

a<-res[grepl("ukb", res$exposure.id), ]
a<-a[grepl("ukb", a$outcome.id), ]

a<-a[!grepl("raw", a$exposure.id), ]
a<-a[!grepl("raw", a$outcome.id), ]

write.xlsx(a, "C:/Users/aksha/OneDrive/Desktop/Research Project 2 - Mendelian Randomisation/LDL_Exposure2.xlsx")


###LDL OUTCOME:

library("epigraphdb")

res = query_epigraphdb(
  route="/mr",
  params=list(exposure_trait=NULL, outcome_trait="LDL direct", pval_threshold=1e-05),
  mode="table"
)
res

a <- res[grep("ukb", res$exposure.id), ]
a <- a[grep("ukb", a$outcome.id), ]
a <- a[!grepl("raw", a$exposure.id), ]
a <- a[!grepl("raw", a$outcome.id), ]

write.xlsx(a, "C:/Users/aksha/OneDrive/Desktop/Research Project 2 - Mendelian Randomisation/LDL_Outcome2.xlsx")



###TRIGLYCERIDES EXPOSURE:
library("epigraphdb")

res = query_epigraphdb(
  route="/mr",
  params=list(exposure_trait="Triglycerides", outcome_trait=NULL, pval_threshold=1e-05),
  mode="table"
)
res

a <- res[grep("ukb", res$exposure.id), ]
a <- a[grep("ukb", a$outcome.id), ]
a <- a[!grepl("raw", a$exposure.id), ]
a <- a[!grepl("raw", a$outcome.id), ]

write.xlsx(a, "C:/Users/aksha/OneDrive/Desktop/Research Project 2 - Mendelian Randomisation/Triglycerides_Exposure2.xlsx")



### TRIGLYCERIDES OUTCOME:
library("epigraphdb")

res = query_epigraphdb(
  route="/mr",
  params=list(exposure_trait=NULL, outcome_trait="Triglycerides", pval_threshold=1e-05),
  mode="table"
)
res

a <- res[grepl("ukb", res$exposure.id), ]
a <- a[grepl("ukb", a$outcome.id), ]
a <- a[!grepl("raw", a$exposure.id), ]
a <- a[!grepl("raw", a$outcome.id), ]

write.xlsx(a, "C:/Users/aksha/OneDrive/Desktop/Research Project 2 - Mendelian Randomisation/Triglycerides_Outcome2.xlsx")





#####
library(dplyr)
library("readxl")
df<- read_excel('HDL_Exposure2.xlsx')




#TRIGLYCERIDES
library(dplyr)
install.packages("remotes")
remotes::install_github("MRCIEU/TwoSampleMR")
library(TwoSampleMR)
# List available GWASs
ao <- available_outcomes()
# Get instruments
exposure_dat <- extract_instruments("ukb-b-5779")
# Get effects of instruments on outcome
outcome_dat <- extract_outcome_data(snps=exposure_dat$SNP, outcomes = "ukb-d-30870_irnt")

# Harmonise the exposure and outcome data
dat <- harmonise_data(exposure_dat, outcome_dat)

# Perform MR
res <- mr(dat)

library(openxlsx)
write.xlsx(res, "C:/Users/aksha/OneDrive/Desktop/Research Project 2 - Mendelian Randomisation/MR-try6.xlsx")

library(ggplot2)
mr_scatter_plot(res, dat)


#HDL CHOLESTEROL

library(TwoSampleMR)
# List available GWASs
ao <- available_outcomes()
# Get instruments
exposure_dat <- extract_instruments("ukb-a-271")
# Get effects of instruments on outcome
outcome_dat <- extract_outcome_data(snps=exposure_dat$SNP, outcomes = "ukb-d-30760_irnt")

# Harmonise the exposure and outcome data
dat <- harmonise_data(exposure_dat, outcome_dat)

# Perform MR
res <- mr(dat)

write.xlsx(res, "C:/Users/aksha/OneDrive/Desktop/Research Project 2 - Mendelian Randomisation/MR-try5.xlsx")


#LDL CHOLESTEROL

library(TwoSampleMR)
# List available GWASs
ao <- available_outcomes()
# Get instruments
exposure_dat <- extract_instruments("ukb-a-450")
# Get effects of instruments on outcome
outcome_dat <- extract_outcome_data(snps=exposure_dat$SNP, outcomes = "ukb-d-30780_irnt")

# Harmonise the exposure and outcome data
dat <- harmonise_data(exposure_dat, outcome_dat)

# Perform MR
res <- mr(dat)

write.xlsx(res, "C:/Users/aksha/OneDrive/Desktop/Research Project 2 - Mendelian Randomisation/MR-try4.xlsx")



#BOTH WAYS HDL CHOLESTEROL:
library(dplyr)
library(TwoSampleMR)
# List available GWASs
ao <- available_outcomes()
# Get instruments
exposure_dat <- extract_instruments("ukb-b-10753") 
# Get effects of instruments on outcome
outcome_dat <- extract_outcome_data(snps=exposure_dat$SNP, outcomes = "ukb-d-30870_irnt")
dat <- harmonise_data(exposure_dat, outcome_dat) 
res <- mr(dat)
write.xlsx(res, "C:/Users/aksha/OneDrive/Desktop/Research Project 2 - Mendelian Randomisation/MR_TG_DIABETES2.xlsx")
library(openxlsx)

library(ggplot2)
plot1 <- mr_scatter_plot(res, dat)
plot1

#change the x and y axis in dat and res
dat$outcome[dat$outcome == 'Triglycerides || id:ukb-d-30870_irnt'] <- 'Triglycerides'
dat$exposure[dat$exposure == 'Diabetes diagnosed by doctor || id:ukb-b-10753'] <- 'Diabetes'
res$outcome[res$outcome == 'Major coronary heart disease event || id:ukb-d-I9_CHD'] <- 'Major coronary heart disease event'
res$exposure[res$exposure == 'HDL cholesterol || id:ukb-d-30760_irnt'] <- 'HDL cholesterol'


#save as pdf
ggsave(plot1[[1]], file = "filename.pdf", width = 9, height = 10)

#save as png image
ggsave(plot1[[1]], file = "filename3.png", width = 8, height = 7)
ggsave(plot1[[1]], file = "filename3.1.png", width = 7, height = 5)

ggsave(plot1[[1]], file = "filename3.1.png", width = 7, height = 5.5)

ggsave(plot1[[1]], file = "filenameLDL.png", width = 9.7, height = 8.8)


ggsave(plot1[[1]], file = "filenameHDL.png", width = 7, height = 5.5)


