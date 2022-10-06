# FIRST NATIONS RESEARCHERS COLLECTIVE (2022)
# PREPROCESSING DATA SCRIPT FOR THE OCTOBER EVALUATION
# JEN BEAUDRY

#### LOAD LIBRARY ####

library(here)
library(tidyverse)

source(here("..", "functions", "read_qualtrics.R"))
source(here("..", "functions", "meta_rename.R"))


#### LOAD DATA ####


# evaluation data with labels

df <- here::here("data", "eval_raw_data.csv") %>%
  read_qualtrics(legacy = FALSE) %>%
  select(-c("start_date":"user_language")) %>% 
  mutate(id = 1:n()) %>% 
  relocate(id, .before = position)

# cultural group with labels

#[breadcrumbs: import that cultural data]


# load metadata
meta <- read_csv(here::here("data", "metadata_eval.csv"), 
                     lazy = FALSE) %>%
      filter(old_variable != "") # remove the instruction variables


##### RECODE VARIABLES #####
  
  # recode variable labels according to metadata
  
df <- meta_rename(df = df, metadata = meta, old = old_variable, new = new_variable)


### RECODE VALUES ###

# # Need to recode certain values. 
# # This is the simplest way to do that (search for the values in the entire dataset that match and recode them)
# 
# df_tor [df_tor == "5 times."] <- "5"
# df_tor [df_tor == "3 or 4?"] <- "3" # be conservative
# df_tor [df_tor == "2 or 3"] <- "2" # be conservative
# df_tor [df_tor == "Twice"] <- "2"
# df_tor [df_tor == "4 (I believe)"] <- "4"


#### WRITE DATA ####
  
# when done preprocessing, write the data to new files
# row.names gets rid of the first column from the dataframe.

write.csv(df, here::here("data", "eval_preprocessed.csv"), row.names = FALSE)


