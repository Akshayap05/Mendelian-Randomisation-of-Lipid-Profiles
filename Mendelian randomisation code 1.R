library("epigraphdb")

res = query_epigraphdb(
  route="/confounder",
  params=list(exposure_trait="HDL cholesterol", outcome_trait="Apoliprotein A", type="confounder", pval_threshold=1e-05),
  mode="table"
)
res
a <- res[grep("ukb", res$exposure.id), ]
a <- a[grep("ukb", a$outcome.id), ]

a<- a[!grepl("raw", a$exposure.id), ]
a<- a[!grepl("raw", a$outcome.id),]
library(openxlsx)
write.xlsx(a, "C:/Users/aksha/OneDrive/Desktop/Research Project 2 - Mendelian Randomisation/HDL_AP_OTHERvariables.xlsx")


library(TwoSampleMR)
# List available GWASs
ao <- available_outcomes()
# Get instruments
exposure_dat <- extract_instruments("ukb-d-30760_irnt") 
# Get effects of instruments on outcome
outcome_dat <- extract_outcome_data(snps=exposure_dat$SNP, outcomes = "ukb-d-I9_CORATHER")
dat <- harmonise_data(exposure_dat, outcome_dat) 
res <- mr(dat)
write.xlsx(res, "C:/Users/aksha/OneDrive/Desktop/Research Project 2 - Mendelian Randomisation/MR_Triglycerides_lymphocytes.xlsx")


library(ggplot2)
mr_scatter_plot(res, dat)



exposure_dat <- extract_instruments("ukb-d-30760_irnt") 
# Get effects of instruments on outcome
outcome_dat <- extract_outcome_data(snps=exposure_dat$SNP, outcomes = "ukb-d-30880_irnt")
dat <- harmonise_data(exposure_dat, outcome_dat) 
res <- mr(dat)

exposure_dat <- extract_instruments("ukb-d-30880_irnt") 
# Get effects of instruments on outcome
outcome_dat <- extract_outcome_data(snps=exposure_dat$SNP, outcomes = "ukb-d-30760_irnt")
dat <- harmonise_data(exposure_dat, outcome_dat) 
res <- mr(dat)






