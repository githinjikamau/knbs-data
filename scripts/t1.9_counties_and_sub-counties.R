#======================================= Load Libraries ======================================
library(tidyverse)
library(tabulizer)

#======================================= scarping the Data ======================================
pages <- c(20:22)
reference_table <- extract_tables(file = file_location1, pages = pages)

# get column names
column_names <- c("county_code", "county_name", "sub-county_code","sub-county_name")

#======================================= Tidying the Data ======================================
reference_table_df1 <- map_df(.x = reference_table, 
                              .f = ~slice(as.data.frame(.x, stringsAsFactors = F), -c(1:2)) %>% 
                                select(1:4))
reference_table_df2 <- map_df(.x = reference_table, 
                              .f = ~slice(as.data.frame(.x, stringsAsFactors = F), -c(1:2)) %>% 
                                select(5:8))

reference_table_df1<- `colnames<-`(reference_table_df1, column_names)
reference_table_df2<- `colnames<-`(reference_table_df2, column_names)

reference_table_df <- bind_rows(reference_table_df1, reference_table_df2)

#======================================= Save to CSV ======================================
write_csv(x = reference_table_df, path = ".\\tidy data\\t1.9_counties_and_sub-counties.csv")