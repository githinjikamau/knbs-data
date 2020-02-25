#======================================= Load Libraries ======================================
library(tidyverse)
library(tabulizer)

file_location1 <- "./census reports/VOLUME IV KPHC 2019.pdf"
pages <- c(57:87)
population_school <- extract_tables(file = file_location1, pages = pages)

# remove the 1:5 rows of each of the list elements
population_school_df <- map_df(.x = population_school, .f = ~slice(as.data.frame(.x, stringsAsFactors = F), -c(1:5)))

# get the column names
column_names <- population_school[[1]] %>% .[3,]
column_names[8] <- "adult_basic_education"
column_names[6] <- "tvet"

# set the column names and tidy the case
names(population_school_df) <- column_names
population_school_df <- janitor::clean_names(population_school_df)

# replace all the dashes which represent missing values with NA
population_school_df <- map_df(.x = population_school_df, ~str_replace(string = ., pattern = "-", NA_character_)) 

# Save the data set as a csv file
# write_csv(x = population_school_df, path = ".\\tidy data\\t2.3_population_currently_attending_school.csv")