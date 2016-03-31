---
layout: post
title: "Mapping in R with ggplot2"
categories: [rstats, analysis, code, graph, plot, ggplot2]
tags: [rstats, analysis, code, graph, plot, ggplot2]
comments: true
---

![Drone sightings by state and population](/figures/drones-by-state-and-pop.png)

I ran across
[this post](http://rud.is/b/2016/03/30/introducing-a-weekly-r-python-js-etc-vis-challenge/)
announcing a weekly R/python visualization challenge and decided that
this was the perfect excuse I needed to brush up on my mapping skills. 

An R script with all the code in one place is available
[on my github repo](https://github.com/jabranham/jabranham.github.io/tree/master/code).

Here, we'll graph the lower 48 states and color them depending on how
many drone sightings have been reported to the FAA in 2014 and 2015
total. First, we need to load the packages we'll use as well as the
data:

~~~ R
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
~~~

Then, using `dplyr` we can calculate how many sightings there were in
each state for the whole timeframe. I also found out there's no data
in four states. That could either mean there's no sightings or the
data is missing; here, I assume it's missing. 

~~~ R
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
~~~

Note that we calculate `mid` as the mean of the count by state. We'll
use this in the next step to fix where states switch from blue to
purple to red. States that are over `mid` will be redder, those that
are close to `mid` will be purple-y and those far below will be blue.
Finally, we can create the actual graph

~~~ R
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
~~~

`geom_map` does most of the work here - the first call sets up the map
of the US states from the included `map_data("state")` call we made
previously. The second call of `geom_map` fills in color to each state
depending on how large `count` is. The specific colors we choose in
`scale_fill_gradient2`. This fills in color between two colors and a
midpoint. We chose the midpoint to be the mean of the counts. I could
also change the color of the missing values (it defaults to grey), but
I think the default works OK. 

The `coord_map` call would give us a Mercator projection by default,
so we modify that to use an Albers projection, which I think looks a
bit better. 

All that's left after that is tidying up the labels and removing some
of the default ticks and lines that ggplot puts in:

![Drone counts by state](/figures/drones-by-state.png)

Obviously, there's a large correlation between population of a state
and the number of drone sightings there are. There's both more people
to fly drones as well as more people to see them. (Although I was
surprised that Illinois didn't pop out more than it did). 

We can quickly get around this by dividing the number of counts by a
state's population. The census last ran in 2010, so that's the data
we'll use (from the `historydata` package). Note that we also
recalculate `mid` in the same way. I also divided population by a
million so we could have larger numbers. 

~~~ R
by_state$year <- 2010
by_state <- left_join(by_state, us_state_populations, by = c("state", "year"))
by_state$count_per_pop <- by_state$count / (by_state$population / 1000000)


mid <- median(by_state$count_per_pop, na.rm = TRUE)
~~~

Finally, we can create the plot:

~~~ R
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
       title = "Number of Drone sightings per million residents, 2014-2015") +) +
  theme(axis.ticks = element_blank(),
        axis.text = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank())
~~~

![Drone sightings by state and population](/figures/drones-by-state-and-pop.png)
