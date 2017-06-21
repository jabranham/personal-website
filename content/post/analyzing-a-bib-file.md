+++
tags = ["r", "journals", "analysis", "code"]
math = false
date = "2016-12-08T15:11:38-06:00"
title = "Analyzing a resolution to read more"
+++

Lots of little things happen in grad school that take you by surprise but really shouldn't. One of those things for me happened after I finished all of my coursework. Without the deadlines of weekly seminars, I didn't read journal articles or books nearly as often as I should have. I figured this out about this time last year and made it my New Year's resolution to get better at keeping up with journals. 

When I started working on this, one thing that became immediately apparent was that I lacked any sort of organized system for getting notified about new articles. Which seems like something I should have done year 1 and is rather obvious in retrospect. But hey, I was a young grad student.

I tested out two ways of getting notifications. One was with email alerts. All the publishers are more than happy to email you about new issues/articles. This worked, but it was annoying to get all these emails in my inbox. So I then switched to using RSS.[^1] That's my current setup. All of the major publishers publish RSS or Atom feeds for their journals, so it's easy to get subscribed. Well, all of them except Cambridge. Luckily, there is a webapp that lets you [add RSS posts via email](https://zapier.com/zapbook/zaps/1363/add-a-new-rss-posts-via-email/). So I signed up for Cambridge's email alerts but gave them an email address that that company gave me. 

Now that I get notifications about new articles/issues, it certainly *feels* like I read more. But having some empirical evidence would be nice. 

So I analyzed my .bib file in R. 

You can import a bib file with the "bibtex" package. I then did a little wrangling to get a `data.frame` with one row per citation. The code is available [on github](https://gist.github.com/jabranham/887495eaf029680316fecb374f0723e0), and I've embedded it at the bottom of this post. 

When taking classes I did an OK job at keeping track of what I read, but a lot of stuff I read for coursework will be missing. Also missing are things that I read but didn't put in my bib file (yet), like articles I reviewed or working papers that colleagues had me read. So the data actually undercount what I read. Since we're relying on citation information, we'll also be plotting the year the article was written, not the year I read it.

First, I looked at a plot of all the years of the articles/books I had. 2016 is the rightmost bar. 

![Count by Year](/img/2016-journals-by-year.jpg)

You can see that my suspicion was probably right - the lines for 2014 and 2015 are pretty short. 2015 was the last year I took classes, and 2014 was a methods-heavy year so not much reading there. 

It looks like I did a pretty decent job with my new years resolution. 2016 is pretty clearly the tallest bar (and it's not over yet! In fact, I still have 23 articles to read on my todo list). 

Of course, now that we have the data in R, we can make all kinds of interesting plots. I know that I read a lot of AJPS/APSR/JOP (the top three journals in political science) articles when I was taking coursework, so I was interested to see the distribution of the things I've read by journal (only plotting journals where I have more than 5 articles)

![](/img/2016-count-by-journal.jpg)

Suspicion confirmed again. We read *a lot* from the same three journals in coursework. I think that since I'm reading from many more journals now that this discrepancy will lessen over time though. 

{{< gist jabranham 887495eaf029680316fecb374f0723e0 >}}

[^1]: And yes, of course you can read RSS in Emacs. [gnus](http://www.gnus.org/) is built-in and there's also [elfeed](https://github.com/skeeto/elfeed), which is what I use.

