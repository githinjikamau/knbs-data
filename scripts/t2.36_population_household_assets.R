#======================================= Load Libraries ======================================
library(tidyverse)
library(tabulizer)

#======================================= scarping the Data ======================================
file_location1 <- "./census reports/VOLUME IV KPHC 2019.pdf"
pages <- c(475:481)
population_conventional_ownership <- extract_tables(file = file_location1, pages = pages)

#======================================= Tidying the Data ======================================
population_conventional_ownership_df <- map_df(.x = population_conventional_ownership, .f = ~slice(as.data.frame(.x, stringsAsFactors = F), -c(1:4)))

# split the column
population_conventional_ownership_df <- separate(population_conventional_ownership_df, col = V6, into = c("atv","internet","bicycle"), sep = " ")

#column names
population_conventional_ownership_df <- rename(population_conventional_ownership_df, "county/sub-county" = V1, 
                                               "households" = V2, 
                                               "radio" = V3, "laptop_tablet" = V4, "ftv" = V5, 
                                               "motor_cycle" = V7, "refrigerator" = V8, "car" = V9, 
                                               "truck/lorry/bus/three_wheeler" = V10, "tuk_tuk" = V11)

#======================================= Save to CSV ======================================
write_csv(x = population_conventional_ownership_df, path = ".\\tidy data\\t2.36_population_household_assets.csv")