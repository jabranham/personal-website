---
layout: post
title:  "Markdown vs Latex for Academic Writing"
categories: [plain_text, latex, markdown]
tags: [plain_text, latex, markdown, rmarkdown, best_practices]
---

I hope that my last post convinced everyone that they need to use at least some kind of version control.
Near the end of that post, I noted that git (and Github) are geared towards plain text files. 
In this post, I hope to convince you that plain text is your friend. 
If you're coming from word processing land (like Microsoft Word or similar), then there can be a bit of a learning curve. 
But the flexibility and power you gain far outweigh the costs of switching. 

Here's a (very) brief rundown of why you should prefer typing text to a word processor:

* Math equations are much easier to type
* You can type your references in easily and the program you use to make a final document (LaTeX or markdown) will put in your reference list and format it automatically
* Word processors are [stupid and inefficient](http://ricardo.ecn.wfu.edu/~cottrell/wp.html). Think about all the time you spend trying to get Word to put a figure or table where you want it. 
* The typesetting is taken care of for you and is generally of higher quality than a word processor 
* In twenty years, you might not be able to open that word file. Even now, it's hard to open word files from 15 years ago. Computers will *always* be able to read text files
* Text files are typically much smaller than their word processor (or pdf) cousins 
* Word is expensive. LaTeX and markdown are free (and open source)

The real purpose of this blog post is not to weigh the pros and cons of plain text vs a word processor, however. 
It is to compare two different ways that we can type up articles in plain text and then convert them to nicely-formatted files (like a pdf). 

# LaTeX
First - what is LaTeX? 
The simple answer is that it is a document markup language. 
It takes plain text documents that are tagged in a specific way that specifies the structure of the document and creates an output file (usually pdf) suitable for human reading. 
It is built on top of TeX, but that's not super important for our purposes. 
In order to use LaTeX, you'll need to install it. 

## Installation 
There are different distributions of LaTeX for each operating system. 
For Linux, the best is TeXLive.
You can do `sudo apt-get install texlive-full` or similar.[^linuxlatex]
Get the full version - it's a huge download, but well worth it.
For Windows users, [MikTeX](http://www.miktex.org/) is what you want.
For Mac OS people, try [MacTeX](https://tug.org/mactex/).

[^linuxlatex]: Debian/Ubuntu repositories tend to be a bit behind the more up-to-date Tex User Group's official builds. While this isn't usually an issue, if you ask for help online (stackoverflow or reddit or whatever), people tend to assume you're using the most current version. So you may want to install what's referred to as "vanilla" LaTeX. You can find install instructions [here](https://www.tug.org/texlive/debian.html). 

## Writing
LaTeX has a bit of a learning curve. 
Generally speaking, you just type the text that you want into a plain text file.
We usually use ".tex" as the file extension.
So your paper named "document" would be "document.tex".
Then, if you want to either use a command (like inserting a figure) or define some structure of the document (a section header, say) you use `\` then the name of what you want to do. 
So, for example, if you want to start a new section, you just do `\section{Section Name}`. 
That starts a new section and names it "Section Name". 
When you compile your output file (pdf), LaTeX will automatically make it look nice and neat.

### The preamble 
Every LaTeX document has to have a preamble where you define the overall structure of the document. 
This includes telling LaTeX what kind of document you're writing (an article, for example), as well as other information like the author's name, the title of the document, and whatever packages you're going to use. 
You end the preamble by beginning the document. 
So, for example, here is a LaTeX document:


    % hello.tex - Our first LaTeX example!
    \documentclass{article}
    \begin{document}
    This is a sentence. 
    \end{document}


This is about as simple as it gets with LaTeX. 
The first line is a comment - LaTeX will ignore anything on a line after a percentage sign when it compiles the output pdf. 
The second line is the only line in our preamble. 
It tells LaTeX that we are writing an article. 
The third line tells LaTeX to end the preamble and begin the document. 
"This is a sentence." is the text of our document. 
Finally, we end the document with `\end{document}`. 

Of course, a typical research paper is much more complicated than that. 
For me, though, it was easiest to just start with that minimal style document and then simply google "How do I ... in latex" whenever I needed to do something beside simple text. 
There's a great community online that helps out with any LaTeX woes you might run into. 
If you do want some more material, though, there is a good basic introduction available [here](https://en.wikibooks.org/wiki/LaTeX/Basics). 

Note that LaTeX doesn't care about how many spaces you put between words or after a period or whatever. 
To start a new paragraph, you need to have an empty line between them:


    This is my first paragraph.
    This is a second sentence in the first paragraph. This is a third.
    
    This starts a second paragraph. 


Any other difficulties you run into you can solve online by using the google machine. 

### Math Mode
In the intro for this post, I indicated that it is super easy to use math in LaTeX documents. 
There are two math modes: inline and display. 
Inline math displays the math inline and starts and ends with dollar signs: $x=3$
Display math displays the math centered and prominent.
Display math is similar, except you use double dollar signs.[^l] So for an integral you could write: `$$\int_a^b x^2 dx$$`.

[^l]: Some people use `\[...\]` for display math mode, but I've always found that difficult to remember, so I stick with double dollar signs. 

## Compiling (and choosing an editor)
You can compile LaTeX documents from the terminal once you have a LaTeX distribution installed with the `pdflatex` command. 
However, most editors will do this for you. 
You can either use a LaTeX specific editor (in which case I recommend [TeXStudio](http://www.texstudio.org/)), or you can use any general purpose text editor such as [Atom](https://atom.io/), [Emacs](https://www.gnu.org/software/emacs/), or [Sublime Text](http://www.sublimetext.com/).
[Rstudio](https://www.rstudio.com) is a good R interface (and the makers of the rmarkdown package), but the text editing in Rstudio itself I find to be lacking, so that's a nonstarter for me.
Maybe it will get better in future releases, but at the moment it is no good to write documents in. 
You can get a full list of available LaTeX editors [here](http://tex.stackexchange.com/questions/339/latex-editors-ides). 

The internet has strong opinions about what editor you should use. 
Here's a list of what I look for in a good editor:

* Cross-platform
* Free and open source
* Syntax highlighting (for R, LaTeX, and rmarkdown)
* Code completion (for R, LaTeX, and rmarkdown)
* Spell checking
* Ability to send R code to console
* BibTeX key completion[^bib] 
* git integration 

Since I use rmarkdown files, a general-purpose TeX editor is not what I want. 
Sublime Text can do most of these things, but is neither free nor open-source.[^textpackages]
So instead, I use Emacs.

Emacs is a part of the [GNU project](https://www.gnu.org), the same as R and many Linux-based operating systems. 
Emacs is amazingly powerful.
Some people refer to it as "an operating system that happens to be particularly good at editing text."
This is both a bonus and a drawback; while you can do basically anything in emacs[^emacs], it has a steep-ish learning curve.
I've only recently switched and am still getting used to the program, but am pretty amazed at how powerful it is.
I will write a blog post soonish on how to get started in emacs.
For now, if you want, you can check out my `.emacs` file on [github](https://github.com/jabranham/emacs).

Regardless of which program you decide on, you should give a great deal of thought to which [workflow apps](http://kieranhealy.org/files/misc/workflow-apps.pdf) you use. 

[^textpackages]: I use the excellent [package control](https://packagecontrol.io/) system to manage the packages. I use git, LaTeXing, RBox, citer, SublimeREPL, and Terminal. They are all install-able from the Package Control system.

[^emacs]: For example, it comes with tetris. But it can integrate with your calendar, handle your email, be your to-do list manager... the list goes on. 

[^bib]: I promise to cover BibTeX and all its wonders soon. But believe you me, it has saved me many hours of putting together all my references. And yes, you can make it play nicely with Zotero or Mendely, if you're already using those. 

# (R)markdown
So enough about LaTeX.
Let's talk about it's simpler cousin, markdown.[^rmdinstall]
Markdown is a simpler way of marking files to tell a computer how they should be typset.
So, for example, in LaTeX to begin a new section, you type:


    \begin{Section Title}


In markdown, however, it is much simpler.
You simply do:

    # Section Title

As you can see, this is *much* easier.
Not only is it much easier to type, it is much easier to remember.
When I write in LaTeX, I find myself constantly googling "how do I ... in LaTeX?"
No so in markdown.
Simple formatting is taken care of with asterisks:
so `*this*` becomes *this* and `**this**` becomes **this**.
One octothorpe/hashtag/pound sign (as above) denotes a section, two denote a subsection, and three a subsubsection.
There is a full cheatsheet available [here](https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf).

[^rmdinstall]: In order to install rmarkdown, you'll need to open R and run `install.packages("rmarkdown"). If you want to produce pdf documents as output, you'll also need to install a full LaTeX distribution, as described earlier in this post. 

The flavor of markdown I've presented here is rmarkdown, which is based on pandoc markdown.[^markdown]
Rmarkdown documents some code at the beginning (this is referred to as YAML frontmatter) that tells the document how to behave.
Think of it as similar to the preamble in LaTeX documents.
The YAML frontmatter is placed between hyphons like so:


    ---
    author: J. Alexander Branham
    title: My Document
    output: pdf_document
    ---

    This would be the first sentence of this documen
    # Section

    This is the first sentence of the first  section! 


So here we can see that the document's "settings" are set up in the YAML frontmatter.
Here, I've told the document that the author's name is "J. Alexander Branham."
I've said that it is titled "My Document," and that I would like it to be a pdf document when it compiles.
I've also gone ahead and written the first sentence of the document, as well as the first heading and the first sentence under that heading.

[^markdown]: There are many different "flavors" of markdown. Rmarkdown plays nicely with R code. Pandoc markdown lets you convert between markdown, pdfs, .docx, and many other file types. If you use Gitub, there is also Github flavored markdown, which is similar in spirit to rmarkdown and pandoc markdown. 

If you want to build your rmarkdown document, open an R instance, make sure that its working directory is where your file is, then run rmarkdown::render("document-title.Rmd") in R.
If there are no errors in your document, yout desired output (pdf, .docx, html, whatever) should be produced!

Note that rmarkdown does not give you as much control over the style of your document as LaTeX does.
However, if you are going to build a pdf at the end (as basically all of our research articles will do), rmarkdown actually passes your markdown file through LaTeX to build the pdf.
Guess what?
To get there, it actually builds a .tex file first!
This gives you two options.
First, you can simply put the LaTeX directly into your rmarkdown file.
When you `rmarkdown::render()` the file, it is smart enough to just pass the LaTeX code on to the LaTeX engine you use (TeXLive or whatever).
So you can use LaTeX code directly in rmarkdown files just fine, so long as all you want is a pdf.
Alternatively, you can tell rmarkdown to keep the `.tex` file that it creates with the `keep_tex: true` option.
Once you've done that, you can simply edit the `.tex` file to the exact specifications that you want.

One advantage of rmarkdown is the ability to easily include R code in your file.
I will do another blog post in the near future for *why* you would want this, as well as more information about *how* to do it.
For now, you can look at the [rmarkdown website](http://rmarkdown.rstudio.com/) for how to do that. 

# LaTeX vs rmarkdown
Ultimately, I don't view this as an either-or battle.
Rmarkdown is very clearly easier to write in, and easier to read, especially for people who arne't used to LaTeX.
For that reason, I think that rmarkdown is definitely better to write in, all else equal.

Of course, all else isn't equal.
LaTeX gives you much more control over your document's output.
One thing that rmarkdown can't do (or at least I can't figure out a way to do it in rmarkdown) is reference equations/figures/tables elsewhere in the document.
In LaTeX this is relatively easy - you simply define the thing that you want to reference with a `\label{my-reference-key}` and then reference it in your document like: `see Figure \ref{my-reference-key}`.
I can't seem to find an easy way to do this in rmarkdown, though.

For an acadmeic, that's a dealbreaker.
However, luckily for us, rmarkdown can handle LaTeX code no problem.
So we can use the easier-to-read and easier-to-write rmarkdown syntax, then use LaTeX code throughout the document to augment our output pdf.[^pdfwarning]

[^pdfwarning]: Note, however, that if you want something other than a pdf, the LaTeX code might not work. So if you're looking to compile an html site as well as a pdf file, you'll need to have html code for the first and LaTeX code for the second (assuming you can't get it done in markdown in the first place!)
