#======================================= Load Libraries ======================================
library(tidyverse)
library(tabulizer)

#======================================= scarping the Data ======================================
file_location1 <- "./census reports/VOLUME IV KPHC 2019.pdf"
pages <- c(438:444)
population_mobile_ownership <- extract_tables(file = file_location1, pages = pages)

#======================================= Tidying the Data ======================================
population_mobile_ownership_df <- map_df(.x = population_mobile_ownership, .f = ~slice(as.data.frame(.x, stringsAsFactors = F), -c(1,2)))
# the first two rows have additional white space. Remove the additional white space
population_mobile_ownership_df$V2 <- str_replace(string = population_mobile_ownership_df$V2, pattern = "\\s{2}", replacement = "" )
# split the column
population_mobile_ownership_df <- separate(population_mobile_ownership_df, col = V2, into = c("Total","Male","Female"), sep = " ")
# split the column
population_mobile_ownership_df <- separate(population_mobile_ownership_df, col = V5, into = c("male2","per_cent"), sep = "\\s")
#column names
population_mobile_ownership_df <- rename(population_mobile_ownership_df, "county/sub-county" = V1, "total2" = V3, 
                                         "per_cent_total" = V4, "per_cent_male" = `per_cent`, "female2" = V6, 
                                         "per_cent_female" = V7)

#======================================= Save to CSV ======================================
write_csv(x = population_mobile_ownership_df, path = ".\\tidy data\\t2.32_population_mobile_ownership.csv")