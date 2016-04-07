---
layout: post
title: "R Packages & Updates"
categories: [rstats, packages]
tags: [rstats, packages]
comments: true
---

R's packaging system is great, but there are a few minor annoyances it
has. I think I've solved them, and wanted to share my setup so that
others can fix these annoyances as well. I use Linux, and this setup
works well there. It *should* work on Mac and Windows as well. If you
run into problems, though, feel free to comment on this post. 

# Where R installs packages

By default, R installs packages somewhere quite obnoxious. You can
find out where by running `.libPaths()` in the R console. This usually
defaults to some crazy setting with a bunch of subfolders and R's
version number included in the path.
    
This is horrible for a few reasons. Why in the world would you want R
to install packages in a version-specific folder!? If you do this, R
won't find any of your installed packages after you update it. Most
people I know just delete the old folder then re-install their
packages or manually copy their packages from one folder to the other.
There's an easier way, though.

You can add a single line to your `.Renviron` file:[^1]

    R_LIBS_USER = ~/path/to/wherever
    
That way, you can specify exactly where you want R to install and look
for packages. I set it to `~/.config/r/library`, but you can tell it
wherever. 

Now R installs packages to a decently-named directory. After an R
update, you'll need to tell R to make sure that your packages work
with the updated R version by running:

~~~R
update.packages(checkBuilt = TRUE)
~~~
    
# How to update R

Yes, you need to update R itself every now and then. The current
version as of this writing is 3.2.4. The update mechanism differs
depending on your operating system. Remember that after updating
you'll need to run:

~~~R
update.packages(checkBuilt = TRUE)
~~~

In order to make sure your packages will work properly on the new R
version. 

## Linux

Use your package manager. Done.

## Windows

There are two options here. Option number one is to uninstall R,
download the new version from
[CRAN's website](https://cran.r-project.org/bin/windows/base/), then
reinstall R. 

Option number two is to use the `installr` package from within R
itself.[^2] The following code will update R:

~~~R
install.packages("installr") 
setInternet2(TRUE)
installr::updateR() 
~~~

## Mac

Updating R on a mac depends on how you installed it in the first
place. If you downloaded it from CRAN, the best thing is to uninstall
R, download the new R version from CRAN, then reinstall R. 

If you used [homebrew](http://brew.sh/) to install R, you can use it
to update R as well. 

[^1]: If this doesn't exist, you can just create it. Add that one line
    and end the file with an empty line. On Unix systems (Linux and
    Mac), this file should be at `~/.Renviron`. On Windows, it's
    *probably* `C:\Users\yourusername\Documents\.Renviron`. You can
    check where R is looking by running `normalizePath("~")` from an R
    session.

[^2]: Note that you need to do this from the R GUI, *not* from RStudio.
