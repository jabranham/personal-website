---
layout: post
title: "SPSA 2016 Wordcloud"
categories: [rstats, analysis, code, twitter, wordcloud]
tags: [rstats, analysis, code, twitter, wordcloud]
comments: true
---

The Southern Political Science Association's 2016 Annual Meeting just
finished up in San Juan, Puerto Rico. Since I've been meaning to learn
the `twitteR` package for a little bit, I figured that this was a
perfect time to do a fun little analysis. You can find the R code I
used to generate the images
[on Github](https://github.com/jabranham/jabranham.github.io/blob/master/code/spsa-2016-wordcloud.R). 

I started out by grabbing all the tweets containing the official
conference tag (#SPSA2016). This was 259 tweets total. I did a little
bit of data munging and then made a wordcloud. You can look at that
here: 

![SPSA tweets wordcloud](/image/spsa-wordcloud.jpeg)

As you can see, political scientists were busy talking about a lot of
different topics! Panel was the single most used word, which is
totally unsurprising. Other topics pop out too - iran policy and
regime change, the CCES (which had its own little "mini conference"),
and some others. 

I thought maybe people would be using similar hashtags, though, to
keep track of a specific conversation. I thought that limiting it to
just hashtags might prove to be annoying, but this was actually really
easy to learn. Here's the result when I limit it to just hashtags:

![SPSA tweets hashtag wordcloud](/image/spsa-hashtags.jpeg)

I quickly learned that political scientists don't use that many
hashtags! Regime change was by far the most used, but only 20 of the
259 tweets in my dataset used it. There were a few other hashtags
used - policy, Iran policy, Puerto Rico (no surprise there!), etc. A
special shoutout to whoever used #sisterhoodofthetravelinglipstick,
though. Well done. 
