---
layout: post
title: A Grad Student's Guide to Pandoc: Part One
categories: [markdown, rmarkdown, latex, pandoc]
tags: [markdown, rmarkdown, latex, pandoc]
comments: true
---

I'm all the time asked something along the lines of "Hey, you taught me markdown/latex, but my adviser wants to give me comments in Word. How can I make that happen?" 

The answer, unfortunately, is a little complicated. The best way to do this is to use [pandoc](http://pandoc.org/), an absolutely wonderful program that converts between all kinds of markup formats (including between markdown, latex, and docx documents).[^2] Pandoc is very powerful, but a little overwhelming, especially if you aren't used to working with command line applications.

So I thought I'd put together a guide to how to use pandoc, paying special attention to some of the most common tasks grad students would want to use it for.[^3] Here's a list of topics I'll be covering, and please feel free to let me know if there's something you think is missing (I'll add hyperlinks as the posts go up):

* Exporting to word (and pdf)
* Importing from a commented and "tracked changes" Word document (back to markdown/latex)

These next two will be more useful if you want to write in markdown or rmarkdown and convert to word/pdf: 

* Using pandoc-citeproc to include a properly-formatted bibliography
* Using pandoc-crossref to reference Figures, Tables, and equations

I'm not going to go through how to install pandoc, as it's relatively simple and they have [a webpage with installation instructions](http://pandoc.org/installing.html). You'll want to make sure you have a relatively recent version; the most recent as of this writing is pandoc 1.17.2. You may check what version you have installed by typing 

```
pandoc --version
```

in a terminal (powershell on Windows) and then pressing enter.[^1] It will tell you what version of pandoc you have installed. 

[^1]: If you don't know how to open a terminal, just search for "terminal" (for Linux/Mac) or "powershell" (for Windows). The terminal/powershell programs come preinstalled with the operating system, so you shouldn't need to do anything else. 

[^2]: Pandoc is also free, open-source software.

[^3]: So, for example, while it's possible to use pandoc to convert to and from html (and many other formats), we won't mention that. 
