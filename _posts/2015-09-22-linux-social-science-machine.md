---
layout: post
title: A Linux Social Science Machine
categories: [linux, ubuntu, social-science, machine, computing]
tags: [linux, ubuntu, social-science, machine, computing]
comments: true
---

I put together a guide to how to set up your Linux machine for
quantitative work. It is based loosely on the guide put together by
Jake Bowers and Jeff Gill available
[here](https://github.com/jwbowers/SocialScienceMacConfig).

Much (most? all?) of the guide applies to Macs and Windows based
machines, although the installation instructions may differ. I think
that Ubuntu comes with some developer tools that Mac and Windows
machines do not, so if you get an error when trying to run something,
that's where I'd start.[^xcode]

[^xcode]: For example, on Mac I'm pretty sure you'll
    have to at least install
    [XCode](https://developer.apple.com/xcode/). Note that Xcode comes
    with emacs, but I've been told that it's not up-to-date at all, so
    you'll still want to install emacs as described below. 

The guide is available
[on Github](https://github.com/jabranham/SocialScienceLinuxConfig),
and I have copied the readme file here. I encourage you to go to the
github repository, as it may be updated and differ from the text
here. If you notice anything missing or run into any issues, feel free
to use Github's issues system (or better yet set a pull request)
noting the change. 

# Configuring your Ubuntu-based PC for Quantitative Social Science Work
This file will help you get your Ubuntu-based Linux machine up and
running to do quantitative social science data work. It was inspirited
by the similarly-titled
[SocialScienceMacConfig](https://github.com/jwbowers/SocialScienceMacConfig)
put together by Jake Bowers and Jeff Gill.

Steps should be similar or identical in other Debian-based Linux
distros. For other desktop GNU/Linux systems, you'll probably have access to
everything I describe here, but may need to change the commands a
bit.

Most (all?) programs included in this list are
[FOSS](https://en.wikipedia.org/wiki/Free_and_open-source_software). Thus,
they are also available on Windows and Mac. Just
google around to find out how to get them for your operating system. 

# Step 0: Install Ubuntu
This is not meant as a manual to help you install Ubuntu. However,
you can install Ubuntu on pretty much any computer. I use the 6-month
rolling releases instead of the LTS. You can get more information
about how to install Ubuntu from
[Ubuntu's website](http://www.ubuntu.com/). A quick Google search will
also pull up helpful instructions. Be sure to test it out from a
bootable USB or other disc before installing it. This'll make sure
that it works well on your computer. 

# Step 1: Install programs from Ubuntu's repositories
You'll want Emacs (at least 24) for LaTeX, markdown, R, and git. Yes,
it really does all of that. You'll also want
[ESS](http://ess.r-project.org/) (Emacs Speaks Statistics), which
provides a way for Emacs and R to cooperate. Finally, you'll want git
for all your version control needs. 

    sudo apt-get install emacs24 ess git

If you're doing Bayesian statistics and want to be able to use JAGS,
you'll also need to get JAGS, which is available and up-to-date on
Ubuntu's repositories: `sudo apt-get install jags`

## Step 1a: Configure git
You'll need to tell git your name and email. Run these two commands in
the terminal, replacing the "John Doe" information with your name and
email:

    git config --global user.name "John Doe"
    git config --global user.email johndoe@example.com

The global option will tell git to remember those values, so you
shouldn't have to do this again. 

# Step 2: Install R
Installing R on an Ubuntu type Linux distribution is easy. You can
simply follow the steps
[here](https://cran.r-project.org/bin/linux/ubuntu/README). Be sure to
read about the secure APT part. Note that you *can* get R from
Ubuntu's repositories, but you really shouldn't. The version there is
pretty dated (3.0 as of this writing, and the latest R version is 3.2.2)

## Step 2a: Configure CRAN mirror
This step isn't totally necessary, but it may save you some time in
the future. In your `.Rprofile` file (usually located at ~/), you can
set the CRAN mirror so that R doesn't ask you. I use RStudio's mirror,
since it should work fairly quickly anywhere in the world. If you want
to use a different mirror, replace `"https://cran.rstudio.com/"` with
your favorite CRAN mirror. You can find the full list of mirrors
[here](https://cran.r-project.org/mirrors.html). 

    local({
      r <- getOption("repos")
          r["CRAN"] <- "https://cran.rstudio.com/"
              options(repos = r)
    })

## Step 2b: Install R packages
R can do a lot out of the box, but it's real strength lies in packages
that extend it. Here's a quick list of some of the packages that I
find myself using frequently:

    install.packages("lintr", "ggplot2", "dplyr", "zoo",
                     "rstan", "rjags", "MCMCpack", "rmarkdown",
                     "knitr", "reshape2", "servr")

# Step 3: Install TeXLive
This is a bit trickier than R. Ubuntu actually has TeXLive in its
repositories, but the version there tends to be a bit out of date. If
you want, you can install it via `sudo apt-get texlive-full`. Be
warned - it's a huge file, so it will take a lot of data (and time) to
download and install.

I really don't recommend doing that, though. You can install what's
referred to as "vanilla" TeXLive fairly easily. There's a stackoverflow
answer [here](http://tex.stackexchange.com/a/95373) that gives
step-by-step instructions for how to get vanilla TeXLive set up on
your system. In addition to getting the most up-to-date version of
LaTeX, the vanilla version will also let you use TeXLive''s package
management system. 

If you usually have regular access to the internet, I'd recommend
skipping the *doc* and *source*  files. They add a lot to the
installation and are totally unnecessary if you have internet
connectivity. 

If you're on a Mac, you can install [MaCTeX](https://tug.org/mactex/) and Windows users probably
want [MiKTeX](http://www.miktex.org/). 

# Step 4: Configure Emacs
Emacs is infinitely configure-able. You could spend months (years?)
getting it *just* right. Feel free to do so. It's probably not worth
it, though. My advice is just to commit to using emacs, and develop
your specific configuration as you go. There are definitely a few
things that you'll want to set up beforehand, though.

I keep my .emacs file in
a [github repository](https://github.com/jabranham/emacs), so feel
free to check it out. If you drop the init.el file into ~/.emacs.d/,
it should work just fine on your setup. It adds the ability to connect
to [MELPA](https://melpa.org/) to your emacs setup, so you'll need an
internet connection the first time you use it.

I'm not sure I'd recommend just using my .emacs file, though (or
anyone else's). Setting up emacs yourself teaches you a bit about how
the program thinks. So I'll list some packages here that I think are
particularly invaluable:

* magit - for all your git needs, inside emacs
* auctex - for writing LaTeX
* polymode - for .Rnw (knitr + LaTeX) and .Rmd (rmarkdown) files
* ebib - for .bib file management
* markdown-mode - for working with markdown files
* reftex - this comes bundled with emacs in recent versions (so no
  need to install it separately), but makes
  working with .bib files a breeze 

Those are absolute must-haves for doing the sort of work we do. If you
work with languages other than R, LaTeX, and markdown, you'll want to
make sure you have the proper "major mode" for that language. ESS
(which you already installed above) makes emacs work with R, so no
need to do anything there. There are some other packages that just
make emacs work a little better, and I'll list some here:

* better-defaults - literally better defaults for emacs. Pretty much
everyone should use this
* smex - easier way to navigate commands (like `M-x`)
* There are several "ido" packages - go look them up. They'll make
your life easier.
* smartparens - easier parentheses management
* company - for autocompletion (there's also auto-complete, but I
prefer company)
* flyspell - for spell checking on the fly
* smooth-scrolling - for doing away with emacs' nonsense default
scrolling
* flycheck - checks for good style and syntax

There are tons more packages available, but those should get you
started. 

# Step 5: Profit!
You're now set up to use a combination of git, R, markdown, and LaTeX
in a sane working environment. You didn't have to pay a penny, either!
These programs (emacs and R in particular) have a bit of a learning
curve, but don't be dissuaded. There are tons of resources online that
can help you out. I also write about this kind of stuff on
[my blog](https://jabranham.github.io). 
