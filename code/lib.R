library(tidyverse)

import_dataset = function(dataset_name) {
  require(readr)
  
  dataset_cols = cols(
    incident_number = col_factor(NULL),
    country = col_factor(NULL),
    region = col_factor(NULL),
    city = col_factor(NULL),
    route = col_factor(NULL),
    year_found = col_integer(),
    where_found = col_factor(NULL),
    where_death_registered = col_factor(NULL),
    date_death_registered = col_date(format = "%d/%m/%Y"),
    primary_cause = col_factor(NULL),
    secondary_cause = col_factor(NULL),
    identification_status = col_factor(NULL),
    sex = col_factor(NULL),
    stated_nationality = col_factor(NULL),
    place_of_birth = col_factor(NULL),
    place_of_last_known_residence = col_factor(NULL),
    guessed_nationality = col_factor(NULL),
    descriptions_of_race = col_factor(NULL)
  )
  
  dataset = read_csv(dataset_name, col_types = dataset_cols)
  
  # dataset_cols = cols(
  #   .default = col_character(),
  #   incident_number = col_factor(),
  #   year = col_integer(),
  #   country = col_factor(),
  #   region = col_factor(),
  #   city = col_factor(),
  #   route = col_factor(),
  #   year_found = col_integer(),
  #   where_found = col_factor(),
  #   how_long_dead = col_character(),
  #   where_death_registered = col_factor(),
  #   date_death_registered = col_date(),
  #   circumstances = col_character(),
  #   details_of_incident = col_character(),
  #   primary_cause = col_factor(),
  #   secondary_cause = col_factor(),
  #   identification_status = col_factor(),
  #   details_of_identification = col_character(),
  #   labels = col_character(),
  #   sex = col_factor(),
  #   age = col_integer(),
  #   estimated_age = col_character(),
  #   stated_nationality = col_factor(),
  #   place_of_birth = col_factor(),
  #   place_of_last_known_residence = col_factor(),
  #   guessed_nationality = col_factor(),
  #   descriptions_of_race = col_factor(),
  #   personal_items = col_character(),
  #   features = col_character(),
  #   other_information = col_character()
  # )
  
  return(dataset)
}