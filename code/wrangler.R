
library(readr)
library(dplyr)

# Deaths at the Borders Database, from 1991 to 2014
# http://www.borderdeaths.org/?page_id=7
deaths_at_the_borders = read_csv('data/raw/Deaths-at-the-Borders-Database-for-the-Southern-EU-public-version-12-May-2016.csv.csv', skip = 2) %>%
  mutate(Estimated_age = as.integer(lapply(lapply(strsplit(Estimated_age, "-"), as.integer), mean))) %>% # Transforms estimated age such as 20-30 to a rounded mean
  mutate(Age = coalesce(Age, Estimated_age)) %>% # Replaces NA values of age to the estimated age
  mutate(Nationality = coalesce(Stated_nationality, Guessed_nationality)) %>%
  select(Case_number, # country + registry where the data was collected + individual number
         Incident_number,  # Identifier that corresponds to the region and number of the incident 
         Year, # When the incident happened
         Country,
         Region = `Region/Province`,
         City = `City/Town/Village`,
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
         Labels = `Label(s)_used_in_administration`,
         Sex,
         Age,
         Nationality,
         Descriptions_of_race = `Descriptions_of_race/ethnicity`,
         Personal_items,
         Features,
         Other_information)

# Organizing column names
names(deaths_at_the_borders) = deaths_at_the_borders %>% names() %>% tolower() 
write_csv(deaths_at_the_borders, "data/pretty/deaths-at-the-borders.csv")


# Missing Migrants Database, from 2014 to 2018
# http://missingmigrants.iom.int/methodology
missing_migrants = read_csv("data/raw/MissingMigrants-Global-2018-11-07T14-37-40.csv") %>%
  select(`Region` = `Region of Incident`, #The region in which an incident took place
         `Date` = `Reported Date`, # Estimated date of death
         `Year` = `Reported Year`, #The year in which the incident occurred.
         #`Number Dead`, #The total number of people confirmed dead in one incident.  If migrants are missing and presumed dead, such as in cases of shipwrecks, leave blank.
         #`Minimum Estimated Number of Missing`, #The total number of those who are missing and are thus assumed to be dead. The number of missing is calculated by subtracting the number of bodies recovered from a shipwreck and the number of survivors from the total number of migrants reported to have been on the boat. If no missing persons are reported, it is left blank.
         `Deaths` = `Total Dead and Missing`, # The sum of the ‘number dead’ and ‘number missing’ variables.
         `Women` = `Number of Females`, # Indicates the number of females found dead or missing. If unknown, it is left blank.
         `Men` = `Number of Males`, # Indicates the number of males found dead or missing. If unknown, it is left blank.
         `Children` = `Number of Children`, # Indicates the number of individuals under the age of 18 found dead or missing. If unknown, it is left blank.
         `Survivors` = `Number of Survivors`, # The number of migrants that survived the incident, if known
         `Cause of Death`, # The determination of conditions resulting in the migrant's death
         `Location Description`, # Place where the death(s) occurred or where the body or bodies were found.
         `Location Coordinates`, # Place where the death(s) occurred or where the body or bodies were found.
         `URL`)

# Organizing column names
names(missing_migrants) = missing_migrants %>% names() %>% tolower() %>% gsub(" ", "_", .)
write_csv(missing_migrants, "data/pretty/missing-migrants.csv")


