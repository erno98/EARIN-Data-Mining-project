#setwd("~/EARIN-Data-Mining-project")

# load dataset
data <- read.csv(file="gun-violence-data_01-2013_03-2018.csv", header=TRUE)

# attributes to be removed:
to_remove <- c("incident_id", "address", "incident_url", "source_url", "incident_url_fields_missing", 
        "congressional_district", "gun_stolen", "incident_characteristics", "location_description",
        "notes", "participant_age", "participant_name", "sources", "state_house_district",
        "state_senate_district")

# dropping unnecessary attributes
#install.packages("dplyr")
library(dplyr)
data <- select(data, -to_remove)