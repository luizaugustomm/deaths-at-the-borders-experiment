
library(readr)
library(dplyr)

raw_database = read_csv('data/raw/Deaths-at-the-Borders-Database-for-the-Southern-EU-public-version-12-May-2016.csv.csv', skip = 2) %>%
  mutate(Estimated_age = as.integer(
    lapply(
      lapply(
        strsplit(Estimated_age, "-"),
        as.integer),
      mean)
      )
    ) %>% # Transforms estimated age such as 20-30 to a rounded mean: 25.
  mutate(Age = coalesce(Age, Estimated_age)) %>% # Replaces NA values of age to the estimated age
  mutate(nationality = coalesce(Stated_nationality, Guessed_nationality))
  

# Deaths at the Borders Database, from 1991 to 2014
dataset = raw_database %>%
  select(Case_number, # country + registry where the data was collected + individual number
         Incident_number,  # Identifier that corresponds to the region and number of the incident 
         Year, # When the incident happened
         Country,
         "Region/Province",
         "City/Town/Village",
         Route,
         Year_found, # When the body was found
         Where_found,
         Location_of_death,
         How_long_dead,
         Circumstances,
         Details_of_incident,
         Primary_cause,
         Secondary_cause,
         Identification_status,
         Details_of_identification,
         "Label(s)_used_in_administration",
         Sex,
         Age,
         nationality,
         "Descriptions_of_race/ethnicity",
         Personal_items,
         Features,
         Other_information) %>%
  rename(city = "City/Town/Village",
         region = "Region/Province",
         labels = "Label(s)_used_in_administration",
         descriptions_of_race = "Descriptions_of_race/ethnicity")


missing_migrants = read_csv("data/raw/MissingMigrants-Global-2018-11-07T14-37-40.csv")

# Organizing column names
names(dataset) = tolower(names(dataset)) 
 
write_csv(dataset, "data/pretty/dataset.csv")
