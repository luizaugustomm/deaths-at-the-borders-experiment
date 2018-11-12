library(tidyverse)
library(tm)

import_dataset = function(dataset_name) {
  
  dataset_cols = cols(
    incident_number = col_factor(NULL),
    country = col_factor(NULL),
    region = col_factor(NULL),
    city = col_factor(NULL),
    route = col_factor(NULL),
    year_found = col_integer(),
    where_found = col_factor(NULL),
    primary_cause = col_factor(NULL),
    secondary_cause = col_factor(NULL),
    identification_status = col_factor(NULL),
    sex = col_factor(NULL),
    nationality = col_factor(NULL),
    descriptions_of_race = col_factor(NULL)
  )
  
  read_csv(dataset_name, col_types = dataset_cols)
}


count_words = function(phrases) {
  phrases %>%
    VectorSource() %>%
    Corpus() %>%
    tm_map(content_transformer(tolower)) %>%
    tm_map(removePunctuation) %>%
    tm_map(stripWhitespace) %>%
    tm_map(removeWords, stopwords("english")) %>%
    DocumentTermMatrix() %>%
    as.matrix() %>%
    colSums()
}

