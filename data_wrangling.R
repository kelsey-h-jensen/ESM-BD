
library(tidyverse)

soc_data <- read.csv("../ESM-BD/ward_soc_data.csv")

data_key <- read.csv("../ESM-BD/sample_key.csv")

lab_data <- read.csv("../ESM-BD/esm_lab_data.csv")

gps <- read.csv("../ESM-BD/GPS_coords_core.csv")

# Full join on the shared ID column
combined <- left_join(soc_data, data_key, by = "ward_sample_ID") %>% 
  dplyr::select(-ward_sample_ID, -plot_ID)

# Full join of esm data to combined
full_data <- left_join(lab_data, combined, by = "sample_ID") %>% 
  left_join(., gps, by = "sample_ID") %>% 
  relocate(soc_per, .after = root_rock_vol_ml)


  
