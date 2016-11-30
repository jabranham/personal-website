---
categories:
- markdown
- rmarkdown
- latex
- pandoc
comments: true
date: 2016-11-11T00:00:00Z
tags:
- markdown
- rmarkdown
- latex
- pandoc
title: A Grad Student's Guide to Pandoc - Part One
---

I'm all the time asked something along the lines of "Hey, you taught me markdown/latex, but my adviser wants to give me comments in Word. How can I make that happen?" 

The answer, unfortunately, is a little complicated. The best way to do this is to use [pandoc](http://pandoc.org/), an absolutely wonderful program that converts between all kinds of markup formats (including between markdown, latex, and docx documents).[^2] Pandoc is very powerful, but a little overwhelming, especially if you aren't used to working with command line applications.

So I thought I'd put together a guide to how to use pandoc, paying special attention to some of the most common tasks grad students would want to use it for.[^3] Pandoc has a [starter guide](http://pandoc.org/getting-started.html) online, but it includes some info that isn't directly relevant for us (and omits some interesting stuff pandoc can do). Here's a list of topics I'll be covering, and please feel free to let me know if there's something you think is missing (I'll add hyperlinks as the posts go up). Everything is meant to make it easy to write in latex (or markdown) and share with someone who wants a Word document.

1. [Exporting to word (and pdf)]({{< relref "post/using-pandoc-export-to-word.md" >}})
2. [Importing from a commented and "tracked changes" Word document (back to markdown/latex)]({{< relref "post/using-pandoc-import-from-word.md">}})

I'm not going to go through how to install pandoc, as it's relatively simple and they have [a webpage with installation instructions](http://pandoc.org/installing.html). You'll want to make sure you have a relatively recent version; the most recent as of this writing is pandoc 1.18. You may check what version you have installed by typing 

```
pandoc --version
```

in a terminal (powershell on Windows) and then pressing enter.[^1] It will tell you what version of pandoc you have installed. 

Once you have verified you have pandoc installed and up to date, we can move on to [Part Two - Exporting to Word]({{< relref "post/using-pandoc-export-to-word.md" >}}).

[^1]: If you don't know how to open a terminal, just search for "terminal" (for Linux/Mac) or "powershell" (for Windows). The terminal/powershell programs come preinstalled with the operating system, so you shouldn't need to do anything else. On older Windows versions, you may need to manually install powershell.

[^2]: Pandoc is also free, open-source software. It is developed [on github](https://github.com/jgm/pandoc).

[^3]: So, for example, while it's possible to use pandoc to convert to and from org-mode documents, html, and many other formats, we won't focus on that. 
