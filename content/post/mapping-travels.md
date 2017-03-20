+++
tags = ["r", "code", "travel", "ggplot2"]
math = false
date = "2017-03-20"
title = "Mapping your travels with R"
+++

I've always wanted one of those wall maps that you can push pins into to show where all you've been.
However, with college and grad school and whatnot, I've never really had the energy to put one up, since I know I'll just have to take it down the next time I move.
Then, something occurred to me:

1. I like maps.
2. I like traveling.
3. I like R.

So why not spend a night putting them all together?

I decided to make a world map and color each country according to whether I've visited or not.[^1]
It would also be cool if I could get a little more fine-grained for the US, so I decided to break it out by state.

This all seemed like a pretty simple project, but it turns out to be not super straightforward.
After more time than I care to admit, I stumbled on [this post](https://github.com/adamhsparks/Import_and_Visualise_Data_from_PDF_Using_R) which lead me to ROpenSci's `rnaturalearth` package, which seems to be the best way to get reasonable map data.
Eventually, I was able to get everything just the way I wanted.

So, without further ado, here's a map of countries/states I've visited (tealish) and lived in (yellow)!

{{< figure src="/img/countries-and-states.png" title="Where I've been" >}}

Looking at that map, it doesn't seem like I've traveled much, even though it *feels* like I've been to a lot of places!
I mean, there are several whole *continents* I've yet to go to!
Maybe I should've used the Mercator projection to make the US and Europe larger.
Of course, that has [problems of its own](https://youtu.be/vVX-PrBRtTY).
I wound up using the Winkel-Tripel projection, which is what National Geographic uses and is apparently [the best way to project a map](https://arxiv.org/pdf/astro-ph/0608501.pdf).

In the spirit of sharing, I've made reproduction code available [through my website](/code/country-state-visit-map.R).
If you are familiar with R, you should be able to make a map of your own using my code quite quickly.
Let me know if you run into any issues!


[^1]: I'm cheating a bit and including some countries I've got plans to visit in the next few months but haven't yet.
