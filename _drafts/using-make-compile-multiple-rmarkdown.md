---
layout: post
title: Using make to compile multiple Rmarkdown documents
categories: [emacs, rmarkdown, markdown]
tags: [emacs, rmarkdown, markdown]
comments: true
---

This week I'm teaching [math camp](https://jabranham.com/math-camp).
As a part of that, I have a bunch of
[rmarkdown](http://rmarkdown.rstudio.com/) files that I compile to pdf
presentations using the rmarkdown R package (which relies on pandoc
and beamer). 

The files for these presentations all rely on the same R script
(`r-setup.R`) and `yml` (`_output.yml`) file to control output
settings. You can look at the whole project on
[gihub](https://github.com/jabranham/math-camp/). 

I've known about `GNU make`'s existance for a while but never really
bothered to look into it. However, since math camp is hosted on
github, I got tired of figuring out when I needed to recompile the pdf
documents (since they take up space in the git repository there's
reason not to just recompile all the time). 

Enter `GNU make`. `make` can monitor a file and check whether its
dependencies have changed or not. If they have, `make` can re-make
that file. There are a ton of tutorials online on how to use `make` to
do exactly that; I'd recommend
[Karl Broman's](http://kbroman.org/minimal_make/), which is directly
applicable for latex-y type setups. 

However. 

The best part of `make` in my opinion isn't told you you in these
tutorials. A secret of `make` is that you can use it to compile
multiple `rmarkdown` files at the same time. 

Running `make -j4` lets `make` use four cores. 

If you run `nproc`[^1] it will tell you how many cores you can use


[^1]: Does this exist on a mac?
