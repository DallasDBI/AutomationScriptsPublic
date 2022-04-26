# ODP GoogleAnalytics API data query

# clear environment
rm(list = ls())
# Load libraries
library(tidyverse)
library("googleAnalyticsR")

# declar path to save data
export_path <- "//fscty07/CIS/Information Management/Users/DBI/DBI_Performance_Dashboard/data/"

# credentials
ga_auth(email = "cod.dbi@gmail.com")
account_list <- ga_account_list(type = "ga4")

# dataset to query
my_property_id <- account_list$propertyId

## EVENTS OVER TIME
# query body
events_overtime <- ga_data(
  my_property_id,
  metrics = c("eventCount", "totalUsers", "eventCountPerUser"),
  dimensions = c("unifiedScreenClass","eventName", "date"),
  date_range = c("2021-01-01", "yesterday"),
  limit = -1
)

events_overtime <- as.data.frame(events_overtime) %>%
  dplyr::mutate(updated_on = Sys.Date())

# write data to path
write.csv(events_overtime, paste(export_path, "odp_ga_eventsOverTime.csv", sep = ""))

## EVENTS OVERVIEW
events_overview <- ga_data(
  my_property_id,
  metrics = c("eventCount", "totalUsers", "eventCountPerUser"),
  dimensions = c("eventName"),
  date_range = c("2021-01-01", "yesterday"),
  limit = -1
)

events_overview <- as.data.frame(events_overview)

write.csv(events_overview, paste(export_path, "odp_ga_eventsOverview.csv", sep = ""))
