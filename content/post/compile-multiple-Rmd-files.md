+++
tags = ["r", "markdown", "rmarkdown", "plain_text"]
math = false
date = "2017-08-18"
title = "Compile multiple (r)markdown files"
+++

Introduction to Math for Political Scientists, AKA "Math Camp," starts on Monday. 
The class is an absolute blast to teach, but that's not the subject of the post. 
I've made the slides for the course in [rmarkdown](https://rmarkdown.rstudio.com) because I mix math and R code together.[^1]
I can then export them fairly easily to pdf slides via the `rmarkdown` package, which relies on [pandoc](http://pandoc.org) to convert the markdown to latex and then compile the latex.
It sounds complicated, but it's less painful in practice.

One pain point involved having several different rmarkdown files.
Math camp has somewhere around 10 different rmarkdown files, and it quickly became difficult to keep track of which files I'd updated since compiling to pdf and which ones I hadn't. 
One solution, of course, is just to recompile the rmarkdown files every day.
I needed a system that could track which files had changed since the pdf file had been created.
Turns out, that's what [GNU Make](https://www.gnu.org/software/make/) was created for.
Basically what Make does is compare the modified date of a file (the "target") with another file (the "source").
If the source file has been modified since the target file, then Make executes whatever command(s) you tell it to.

Make is pretty simple, and Karl Broman has [an excellent tutorial](http://kbroman.org/minimal_make/) that walks through the basics.
As an example, if we have a single rmarkdown file in our directory, our Makefile would look something like this:

    my-rmarkdown-file.pdf: my-rmarkdown-file.Rmd
        Rscript -e "rmarkdown::render('my-rmarkdown-file.Rmd')"

The basic syntax is really easy to understand.[^2]
All this says is that my-rmarkdown-file.pdf relies on my-rmarkdown-file.Rmd. 
So if the Rmd modification time is after the pdf modification time and you run `make`, then it will execute the Rscript command which renders the pdf file.
If, on the other hand, the Rmd file hasn't changed, then Make won't do a thing.

You can get fancier with Make, of course.
The tutorial I linked above explains some of the variables you can use.
What I wanted to do was to keep track of all the Rmd files in the `slides/` directory, as well as one file I send out before math camp starts. 
This is the Makefile I came up with to do that:[^3]

    SRC = $(wildcard slides/*.Rmd)
    
    PDFS=$(SRC:.Rmd=.pdf)
    
    %.pdf: %.Rmd slides/r-setup.R slides/_output.yml
    	Rscript -e "rmarkdown::render('$<')"
    
    pre-math-camp.pdf: pre-math-camp.Rmd
    	Rscript -e "rmarkdown::render('$<')"
    
    all: $(PDFS) pre-math-camp.pdf
    
    clean:
    	rm slides/*.pdf

So all I have to do to ensure all the pdf files in the `slides/` directory as well as the "pre-math-camp" pdf files are up-to-date with the source Rmd files is run `make all`. 
You can see the whole structure of the project on [github](https://www.github.com/jabranham/math-camp/). 

This can take a while, though, because make by default compiles these files one-at-a-time. 
We can be smarter than that, though.
You can modify the behavior of `make` to use more than one process.
So on my laptop, which has 4 cores, I use three of them to compile 3 files at once instead of compiling files one at a time.
This is the `-j` option in make.
So all we need to do to recompile the whole project is `make -j3 all`
This means that I can compile all the slides from scratch in about a third of the time!

[^1]: Usually I'd do this sort of thing in [orgmode](http://orgmode.org), but since I'd like to be able to pass these slides off to the people who teach it after I leave UT, assuming Emacs knowledge seems unfair.

[^2]: One thing to note is that the indentation MUST be a tab, NOT spaces. 

[^3]: Jumping from the super-simple example to this more complex one reminds me a bit of [my favorite meme](http://i0.kym-cdn.com/photos/images/newsfeed/000/572/078/d6d.jpg).
