
library(readr)
library(dplyr)

raw_database = read_csv('data/raw/database_may_2016.csv', skip = 2)

database = raw_database %>%
  select(Incident_number, Year, Country, "Region/Province", "City/Town/Village", Route, Year_found, Where_found,
         How_long_dead, Where_death_registered, Date_death_registered, Circumstances, Details_of_incident, Primary_cause,
         Secondary_cause, Identification_status, Details_of_identification, "Label(s)_used_in_administration",
         Sex, Age, Estimated_age, Stated_nationality, Place_of_birth, Place_of_last_known_residence,
         Guessed_nationality, "Descriptions_of_race/ethnicity", Personal_items, Features, Other_information) %>%
  rename(city = "City/Town/Village", region = "Region/Province",
         labels = "Label(s)_used_in_administration", descriptions_of_race = "Descriptions_of_race/ethnicity") %>%
  mutate_if(sapply(., is.character), as.factor)
  

names(database) = tolower(names(database))
summary(database)
 
write_csv(database, "data/pretty/dataset.csv")
