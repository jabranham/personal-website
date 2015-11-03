---
layout: post
title: Combining Code and Writing
categories: [emacs, latex, rmarkdown, markdown, R]
tags: [emacs, latex, rmarkdown, markdown, R]
comments: true
---


Combining code and the document that you're writing is called
"literate programming". It's one of the best practices associated with
reproducible research, which is a hot topic in political science and
other disciplines. This post isn't about *why* you should do this,
it's just about *how* to do it.

I'm going to talk about how to combine R code with markdown via
rmarkdown and LaTeX via knitr. There are other ways of doing this
(such as org-mode in emacs), so this isn't supposed to be a
comprehensive guide to all of the ways of doing this. I'm focusing on
LaTeX because that's probably the most popular way of writing prose in
academia, and markdown is easy to cover as well. If you need to
include languages other than R in your analysis, you should consider
org-mode with emacs.

Knitr is just one way of combining R code with prose. There is another
way of doing this (with Sweave), but knitr is much easier and includes
some features that Sweave is lacking, so I focus on knitr here.

# LaTeX and knitr
The usual file extension for these kinds of files is `.Rnw`. Knitr is
smart enough that you don't actually have to do much; Just type up the
LaTeX document like normal. Whenever you want to use R code, you can
simply put:

    <<>>=
    mean(c(1,2,3))
    @

Everything between `<<>>=` and `@` will be fed to R. You can label the
chunk by giving it a name. This helps if there are any compile
errors. You can also set up options for each chunk individually. So if
we have a chunk that looks like this:

    <<mean-of-cars-by-cyl, echo=FALSE>>=
    library(dplyr)
    mtcars %>%
      group_by(cyl) %>%
      summarize(mean(wt))
    @

then knitr will name the chunk "mean-of-cars-by-cyl" and output the
expression to the PDF file without including the code we used to get
those values (we'll cover knitr options below). 

We can also evaluate R code inline using `\Sexpr{}`. That's short for
S-expression. Remember that R is built on top of S, so that's where
the terminology comes from. So if we wanted to show the mean of the
numbers 1-10, we could simply write `\Sexp{mean(1:10)}`. 

## Compiling .Rnw
So now we have a great `.Rnw` file that has all of our code and text
in the same place. How do we get a `.tex` file or a PDF? The easiest
way is to open up R, and run `knitr::knit("my-doc-title.Rnw")`. This
will produce a .tex file which you can then process to create a PDF in
the usual way (latexmk, pdflatex, or whatever). 

# rmarkdown
[Rmarkdown](http://rmarkdown.rstudio.com/) is an invention by RStudio
that enables us to write in pandoc-flavored markdown and include R
code to be evaluated. We can then convert the rmarkdown file (usually
with the `.Rmd` extension) to any filetype that rmarkdown
supports. Since rmarkdown relies on [pandoc](http://pandoc.org/) to do
the heavy lifting of the file conversions, we can actually translate
between quite a few different filetypes. Most useful for us are PDFs,
HTML, and Word documents.

In rmarkdown, we can do R code in display mode with tick marks. So if
we wanted the rmarkdown version of the code above, it would look like
this:

<pre class="markdown"><code>&#96;&#96;&#96;{r, echo=FALSE}
library(dplyr)
mtcars %>%
  group_by(cyl) %>%
  summarize(mean(wt))
&#96;&#96;&#96;
</code></pre>

## Compiling .Rmd
Once you've finished writing, you can compile your .Rmd document
pretty easily. Open up R and type
`rmarkdown::render("my-doc-title.Rmd")` and that will output whatever
filetype you have specified in the YAML frontmatter. If you've
specified multiple filetypes (PDF and HTML, for example) in the YAML
metadata, you'll need to tell R to produce all the filetypes:
`rmarkdown::render("my-doc-title.Rmd", "all")`. 

# knitr options 
There are a lot of options that you can feed to knitr, which you
can review [here](http://yihui.name/knitr/options/). Some of the most
important options are 

* `eval`: This tells knitr whether it should evaluate the chunk or
  not. It's default is `TRUE`, set to `FALSE` if you don't want the
  chunk evaluated
* `echo`: Should the source code be included in the output document?
  Default is `TRUE`, but for academic articles you probably want to
  overwrite this and set it to `FALSE`. 
* `results`: How should results be put into the document? The default
  here is `markup`, which results in a special LaTeX
  environment. Another option I find myself using is `asis`. For
  example, if you're using the `xtable` package to create a table, you
  need to change `results="asis"` so that the LaTeX gets passed
  through properly.
* `warning`: This defaults to `TRUE`, which prints warnings in your
  document. Great for catching errors, but ugly. Turn it off and it
  prints the warnings in the R console instead.

<!-- ## The cache -->
<!-- Knitr supports the cache, so if you're compiling a document multiple -->
<!-- times, it doesn't actually have to evaluate all of the R code every -->
<!-- time. You can enable this in a chunk with the `cache=TRUE` option. You -->
<!-- can also enable it globally for a document by setting the option at -->
<!-- the beginning of your document: -->

<!-- <<setup, include=FALSE, cache=FALSE>>= -->
<!-- library(knitr) -->
<!-- # set global chunk options -->
<!-- opts_chunk$set(cache=TRUE, autodep=TRUE) -->
<!-- @ -->

<!-- This will tell knitr to automatically cache everything. The `autodep` -->
<!-- option lets knitr figure out that chunks later in your document may -->
<!-- depend on chunks earlier in the document, so if the earlier ones -->
<!-- change, it will update the later chunks if it needs to.  -->
