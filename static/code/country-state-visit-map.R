# Copyright (C) 2017 by J. Alexander Branham
## LICENSE: CC_BY_SA 4.0
## More info at https://creativecommons.org/licenses/by-sa/4.0/

library(tidyverse)
## devtools::install_github("ropenscilabs/rnaturalearth")
library(rnaturalearth)
library(ggthemes)
library(ggalt)

## If you get weird errors from ggalt/ggpltot2, you may need to
## install the development versions on github. I had to on 2017-03-20.

states_lived <- c("Pennsylvania",
                 "Tennessee",
                 "Texas")

world_lived <- c("France",
                "Sweden")

states_visited <- c(
  "Alabama",
  "Alaska",
  "Arizona",
  "Arkansas",
  "California",
  ## "Colorado",
  ## "Connecticut",
  "Delaware",
  "District of Columbia",
  "Florida",
  "Georgia",
  "Idaho",
  "Illinois",
  ## "Indiana",
  "Iowa",
  "Kansas",
  "Kentucky",
  "Louisiana",
  "Maine",
  "Maryland",
  "Massachusetts",
  "Michigan",
  ## "Minnesota",
  "Mississippi",
  ## "Missouri",
  ## "Montana",
  "Nebraska",
  "Nevada",
  "New Hampshire",
  "New Jersey",
  "New Mexico",
  "New York",
  "North Carolina",
  ## "North Dakota",
  "Ohio",
  "Oklahoma",
  ## "Oregon",
  "Pennsylvania", # lived
  ## "Rhode Island",
  "South Carolina",
  "South Dakota",
  "Tennessee", # lived
  "Texas", # lived
  "Utah",
  "Vermont",
  "Virginia",
  ## "Washington",
  "West Virginia",
  ## "Wisconsin",
  "Wyoming"
)

world_visited <- c(
  "Austria",
  "Bahamas",
  "Belgium",
  "Belize",
  "Bermuda",
  "Canada",
  "China",
  "Czech Rep.",
  "Denmark",
  "Estonia",
  "Finland",
  "France", # lived
  "Germany",
  "Greece",
  "Haiti",
  "Honduras",
  "Iceland",
  "Ireland",
  "Italy",
  "Jamaica",
  "Luxembourg",
  "Mexico",
  "Morocco",
  "Norway",
  "Portugal",
  "Puerto Rico",
  "Spain",
  "Sweden", # lived
  "Switzerland",
  "Turkey",
  "United Kingdom",
  "Vatican")

world_map <- ne_countries()
world_map@data$id <- rownames(world_map@data)
world_map <- broom::tidy(world_map, region = "name")

states_map <- ne_states(country = "united states of america")
states_map@data$id <- rownames(states_map@data)
states_map <- broom::tidy(states_map, region = "name")

countries_and_states <- world_map %>%
  filter(id != "United States",
         id != "Antarctica") %>%
  ## Georgia is both a country and state, which creates problems later
  ## on with them having the same name unless we fix it:
  mutate(id = ifelse(id == "Georgia", "Georgia-country", id),
         group = ifelse(group == "Georgia.1", "Georgia.1-country", group)) %>%
  rbind(states_map) %>%
  mutate(status = factor(ifelse(group == 105, 0, # French Guinea
                                ifelse(id %in% c(states_lived,
                                                 world_lived), 2,
                                       ifelse(id %in% c(states_visited,
                                                        world_visited), 1, 0))),
                         0:2,
                         c("Neither", "Visited", "Lived"))) %>%
  ## Create a unique identifier for subunits like French Guinea
  unite(id2, id, piece, group, remove = FALSE)

lseq <- seq(-60, 85, by = .25)
boundary <- data.frame(
  long = c(rep(-180, length(lseq)), rep(180, length(lseq)), -180),
  lat  = c(lseq, rev(lseq), lseq[1]))
## Finally, let's plot it!
ggplot(countries_and_states, aes(long, lat)) +
  geom_polygon(data = boundary, fill = "#002b36") +
geom_polygon(aes(group = id2,
                 fill = status),
             color = "black") +
  ## colors from matplotlib's new theme:
  scale_fill_manual(values = c("#440154",
                               "#21908C",
                               "#FDE725"), guide = FALSE) +
coord_proj("+proj=wintri") +
  theme_bw() +
  theme(axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.border = element_blank())

## Save that sucker!
ggsave("../img/countries-and-states.png",
       width = 177, height = 110, units = c("mm"), bg = "transparent")
