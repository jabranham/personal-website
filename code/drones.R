1## from http://rud.is/b/2016/03/30/introducing-a-weekly-r-python-js-etc-vis-challenge/
library(readxl)
library(tidyr)
library(dplyr)
library(ggplot2)
library(gganimate)
library(historydata)

URL1 <- "http://www.faa.gov/uas/media/UAS_Sightings_report_21Aug-31Jan.xlsx"
URL2 <- "http://www.faa.gov/uas/media/UASEventsNov2014-Aug2015.xls"

fil1 <- basename(URL1)
fil2 <- basename(URL2)

if (!file.exists(fil1)) download.file(URL1, fil1)
if (!file.exists(fil2)) download.file(URL2, fil2)

xl1 <- read_excel(fil1)
xl2 <- read_excel(fil2)

drones <- setNames(bind_rows(xl2[, 1:3],
                             xl1[, c(1, 3, 4)]),
                   c("ts", "city", "state"))
drones <- mutate(drones,
                 year = format(ts, "%Y"),
                 year_mon = format(ts, "%Y%m"),
                 ymd = as.Date(ts),
                 yw = format(ts, "%Y%V"))

## map cumulative drone sitings in each state
by_state <- drones %>%
  group_by(state) %>%
  summarize(count = n()) %>%
  mutate(region = tolower(state))

missing_states <- data_frame(
  region = c("wyoming", "vermont", "nebraska", "iowa")
)

by_state <- bind_rows(by_state, missing_states)

us <- map_data("state")

mid <- mean(by_state$count, na.rm = TRUE)

ggplot() +
  geom_map(aes(x = long, y = lat, map_id = region), data = us,
           map = us, fill = "#ffffff", color = "#ffffff", size = 0.15) +
  geom_map(aes(fill = count, map_id = region),
           map = us, data = by_state,
           color = "#ffffff", size = 0.15) +
  scale_fill_gradient2(name = "# Sightings", midpoint = mid,
                       low = "blue", mid = "purple",
                       high = "red") +
  coord_map("albers", lat0 = 39, lat1 = 45) +
  labs(x = NULL, y = NULL,
       title = "Counts of US drone sightings by state, 2014-2015") +
  theme(axis.ticks = element_blank(),
        axis.text = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank())

ggsave("../figures/drones-by-state.png", height = 4, width = 8)

## by population
by_state$year <- 2010
by_state <- left_join(by_state, us_state_populations, by = c("state", "year"))
by_state$count_per_pop <- by_state$count / (by_state$population / 1000000)


mid <- median(by_state$count_per_pop, na.rm = TRUE)

ggplot() +
  geom_map(aes(x = long, y = lat, map_id = region), data = us,
           map = us, fill = "#ffffff", color = "#ffffff", size = 0.15) +
  geom_map(aes(fill = count_per_pop, map_id = region),
           map = us, data = by_state,
           color = "#ffffff", size = 0.15) +
  scale_fill_gradient2(name = "# Sightings / 1 mil people",
                       midpoint = mid, low = "blue", mid = "purple",
                       high = "red") +
  coord_map("albers", lat0 = 39, lat1 = 45) +
  labs(x = NULL, y = NULL,
       title = "Number of Drone sightings per million residents, 2014-2015") +
  theme(axis.ticks = element_blank(),
        axis.text = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank())

ggsave("../figures/drones-by-state-and-pop.png", height = 4, width = 8)
