
library(tidyverse)



soc_data <- read.csv("~/Desktop/github/ESM_Summer2025_Rwork/ward_soc_data.csv")

data_key <- read.csv("~/Desktop/github/ESM_Summer2025_Rwork/sample_key.csv")

lab_data <- read.csv("~/Desktop/github/ESM_Summer2025_Rwork/esm_lab_data.csv")

gps <- read.csv("~/Desktop/github/ESM_Summer2025_Rwork/GPS_coords_SSURGO1.csv")
#read in ssurgo gps file instead

organized <- read.csv("/Users/campbellgray/Desktop/github/ESM_Summer2025_Rwork/claude_reorg.csv")

# Full join on the shared ID column
combined <- left_join(soc_data, data_key, by = "ward_sample_ID") %>% 
  dplyr::select(-ward_sample_ID, -plot_ID)

combined2 <- left_join(combined, organized, b = "sample_ID")
# Full join of esm data to combined
full_data <- full_join(lab_data, combined2, by = "sample_ID") 

full_data2 <- left_join(full_data, gps, by = "sample_ID")
#replace gps with gps ssurgo easiest in excel


simple_ESM  <- full_data2 %>% mutate(bulk_density = soil_mass_Mg_ha/1500) %>% mutate(SOC_g_kg = soc_per*10)

simple_ESM_clean <- simple_ESM %>% select(-farm, -time, -sampler, -mukey, -area_ac, -areasymbol, -musym, -muname, -dbovendry_r, -claytotal_r,
                                          -farm_ID.y, -method.y, -depth.y, -sample_no.y, -x.y, -y.y)

write.csv(simple_ESM_clean, "simple_ESM_clean.csv")

write.csv(simple_ESM_clean, "simple_ESM_cleaned", row.names = FALSE)

hist(simple_ESM_clean$dry_wt_g)

mean(simple_ESM_clean$dry_wt_g)
sd(simple_ESM_clean$dry_wt_g)
min(simple_ESM_clean$dry_wt_g)


  
