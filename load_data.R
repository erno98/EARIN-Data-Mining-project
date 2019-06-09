#setwd("~/EARIN-Data-Mining-project")
#install.packages("dplyr")
#install.packages("ggplot2")

# load dataset
data <- read.csv(file="gun-violence-data_01-2013_03-2018.csv", header=TRUE)

# attributes to be removed:
to_remove <- c("incident_id", "address", "incident_url", "source_url", "incident_url_fields_missing", 
        "congressional_district", "gun_stolen", "incident_characteristics", "location_description",
        "notes", "participant_age", "participant_name", "sources", "state_house_district",
        "state_senate_district")

# dropping unnecessary attributes
library(dplyr)
data <- select(data, -to_remove)

# removing data from before 2014
start <- as.Date("2014-01-01", "%Y-%m-%d")
data <- data %>% filter(as.Date(date) > start)


# ------------ data visualization ------------

# number of gun violence occurrences
gun_v_occurrences <- data %>% group_by(date) %>% summarise(counts=n())


library(ggplot2)
ggplot(data=gun_v_occurrences, aes(as.Date(date))) +
  geom_point(alpha=1/10, aes(y=gun_v_occurrences$counts)) +
  geom_smooth(se=FALSE, aes(y=gun_v_occurrences$counts)) + 
  xlab("Date") + ylab("Number of occurrences")


# number of gun violence occurrences by state
state_occurrence <- data %>% group_by(state) %>% summarise(counts=n())

# sort
state_occurrence <- state_occurrence[order(-state_occurrence$counts), ]

ggplot(data=state_occurrence, aes(x=reorder(state, -counts), y=counts)) + 
  geom_bar(stat="identity") + 
  theme(axis.text.x = element_text(angle=90, hjust=1)) +
  xlab("State") + ylab("Number of occurrences")

# casualties
casualties_data <- data[c("n_killed", "n_injured")]
ggplot(data=casualties_data, aes(x=n_injured, y=n_killed)) + 
  geom_point() + xlab("Number of injured") + ylab("Number of killed")
