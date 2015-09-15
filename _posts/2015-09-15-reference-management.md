---
layout: post
title: "Reference Management for Academics"
categories: [reference-management, latex, bibtex]
tags: [latex, bibtex, reference-management, biblatex, biber]
comments: true
---

So as a grad student, I write a lot.  Like, a lot a lot.  And as a
part of that, I cite a lot of articles and books.  And there are, of
course, those few articles that I find myself citing in nearly every
paper I write.  So ideally, I could have one central repository for
all of the papers that I want to be able to cite, and reference that
from whatever paper I'm working on.  Then, whatever program I'm using
to convert the plain text to a good looking document (LaTeX, for
example) should be able to take combine the citations from the text of
the document with the information from this central repository and
output properly formatted citations, as well as a properly formatted
bibliography.  Luckily, this is very easy to do.

The big picture is that you'll keep all of your references in a .bib
file.  You can call it anything, so long as the file extension is
.bib.  My default name for these is `library.bib`, but you can really
use whatever.  Then, LaTeX (or markdown, if you're using that) can
talk to this file using a program called BibTeX.  So in your LaTeX
document, all you need to do to cite something is call a simple
command (`\cite{}`, for example) and then insert a "key" linking what
you want to cite with an entry in the .bib file.  Then, at the end of
your LaTeX document, you can simply tell it to include a bibliography
and specify the style you want (APSR, for example).  All of the
formatting and inserting the actual citation will be taken care of.
Magically, in my opinion.

So although there's a bit of setup cost, once you've done that (once),
you can just write your document and simply drop in citations with a
simple command (like `\cite{}`).  Good editors will let you search
through your .bib file for the reference you want without actually
opening it.  The format of the citations and the reference list will
be automatically inserted and properly formatted.

It will seem a little overwhelming to set up, but fear not.  It is
actually really simple.  Setup may take a bit, but once you have that
down you shouldn't need to do it again.  Even if you do (say, for a
second computer), it will be much easier.

# The .bib file
In my last post, I briefly mentioned that you should
write your files in plain text.  This applies to your bibliography
files as well.  There is a pretty standardized way to format your
bibliography files: the ".bib" file.  Your .bib file contains
information about each reference you want.  So, for example, if you
wanted to cite
[Understanding Interaction Models](http://pan.oxfordjournals.org/content/14/1/63.short) (which everyone should read), your .bib file would contain something like the following:

    @article{brambor2006,
        title={Understanding Interaction Models: Improving Empirical Analyses},
        author={Brambor, Thomas and Clark, William Roberts and Golder, Matt},
        journal={Political Analysis},
        volume={14},
        number={1},
        pages={63--82},
        year={2006}
    }

The `@` says to begin a new reference.  We then say what kind of thing it is (in this case, an article).
Everything between the curly braces is information about the reference.
So we have information about the title, author, the journal that it's in, etc.
The very first thing ("brambor2006" in this case) is called a bibtex key.
That's how you'll link up the references in your LaTeX (or markdown or whatever) file to the references in your .bib file.
Lucky for us, we don't actually have to remember how to format all this.
Do google scholar search, and underneath the reference that we want, click "cite" then click "BibTeX" in the window that pops up.
It should then pop up with information similar to what I've posted
above. I very rarely actually ever look at the bib file directly,
since there are tons of great programs out there that will generate it
for you.

Let me be clear - this .bib file is all you need to do reference management from a LaTeX document.  Everything else I suggest here are simply tools to make it easier to manage your .bib file or to integrate it into your writing.

# Using the .bib file in LaTeX
There are two different programs and two different packages in LaTeX to manage your bibliography.
[This answer](http://tex.stackexchange.com/a/25702)
to a stackexchange question gives a really good idea of the difference
between them. The main gist is that biblatex (and biber) are more
current programs, whereas natbib (and bibtex) are slightly older. I'd
recommend using biblatex (and biber) if you're just starting, as they
offer a lot of advantages over natbib and bibtex. For the reasons you
might prefer one over the other, look at the stackexchange answer
linked above. You'll probably be fine using either combination.

Basically, biblatex and natbib are LaTeX packages that enable all the
citation commands that you want. Biber and BibTeX are the backends
that do the hard work of linking up your .tex and .bib files to
properly format all the citations and the reference list. The
differences between the two in practice are minimal.

## BibLaTeX and Biber
BibLaTeX and biber are the newer, snazzier
versions of natbib and BibTeX. As such, they come with plenty of
support for things that natbib and BibTeX either can't do (or don't do
well).

To use them, you'll need to enable biblatex in your
preamble. Somewhere, you can add
`\usepackage[<options>]{biblatex}`. The options are actually a bit
important here. For example, you can set the citation style. The most
common one that I use is `citestyle=authoryear`. I also like to set
the backend (which is probably just an old habit - biblatex used to
set the backend as BibTeX instead of biber). So I usually do
`\usepackage[backend=biber, citestyle=authoryear]{biblatex}` That
produces citations in the author-year format, like (Lastname 1999),
which is the most common in political science. There are other
citation styles that you can check out with a quick Google search, if
you need them.

The second part is to tell biblatex/biber where your .bib file is. You
do this with the `\addbibresource{}` command. Inside the curly braces
should be the path to your .bib file, relative to where your .tex file
is. So if you put your .bib file in the same folder as your .tex file,
all you need to do is specify the name of your .bib file. For example,
if you've named it "library.bib", then you simply need to place it in
the same folder and then put `\addbibresource{library.bib}`. You can
specify relative or absolute file paths if you want.

At the end of your document (but before `\end{document}`, you'll want
to add a command `\printbibliography` command). This will actually put
in a reference list at the end.

Now you're all good to go! You can cite things with the usual biblatex
reference commands. `\autocite{bibtexkey}` will create a citation to
the bibtexkey. Autocite will attempt to create the best kind of
citation from available information (like citestyle, etc). You can
specify citation styles more fully with commands like
`\parencite{bibkey}`, which specifies that the citation should be in
parentheses. `\footcite{}` is similar, except it creates a citation as
a footnote. There are other commands you can use, which are all easily
found online.

## Natbib and BibTeX
Natbib and BibTeX are the older cousins of
BibLaTeX and biber. They are very similar in use. You need to tell
LaTeX that you're using natbib using the `\usepackage{natbib}`
command. You set up the bibliography using the `\bibliographystyle{}`
command (you can put in `apsr`) there for APSR-type citations. At the
end of the document, put `\bibliography{library.bib}` to use your .bib
file. Like biblatex, natbib supports relative and absolute file path
names.

Once you've done all that, you can actually start citing things in
your document. In natbib, there are two main ways to cite things:
`\citep{}` and `\citet{}`. `citep` will enclose the citation in
parentheses while `citet` will print out a citation with the author's
name in text and the year in parentheses.

# Using .bib in (r)markdown
Since rmarkdown really wasn't written with academic papers in mind,
citations are a bit trickier. You need to specify your .bib file in
the YAML frontmatter (the stuff at the top). So if your .bib file is
named `library.bib` and is in the same folder as the .Rmd document,
you can set up citations like so:

    ---
    title: My Title
    author: Me!
    bibliography: library.bib
    ---

To set up the reference section, you need to put `# References` at the
end of the document (remember, the `#` symbol denotes section headings
in rmarkdown). You must use pandoc-style citations. So if I wanted to
reference the article from the beginning of this post, I would need to
have brackets around it `[@brambor2006]`. That would insert a
parenthetical citation. There are more examples of citation formats on
[rmarkdown's website](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html).

To tell rmarkdown (and pandoc) what citation style you want, you'll
need a .csl file. There is a large repository of these available on
[github](https://github.com/citation-style-language/styles) and on
[Zotero's website](https://www.zotero.org/styles). You
specify the .csl file in the YAML frontmatter in the `csl:` field. 

# .bib file management programs
There are a lot of different programs out there that can manage your .bib file (and sync it across
computers).  Some of them that I know of are jabref, Mendeley, and
Zotero.  A few Mac people I know use Bibdesk.  There's also a program
that runs in emacs that manages .bib datases
([ebib](http://joostkremers.github.io/ebib/)).  I use ebib, which I
recommend if you use emacs.

For those of you who don't use emacs, I heartily recommend
[Zotero](https://www.zotero.org/).[^zotero] It can manage your pdf
files as well as sync your bibliography across multiple computers.
There is a plug in that allows you to export your bibliography as a
.bib file: [Better BibTeX](https://zotplus.github.io/better-bibtex/).
The Better BibTeX plugin can also keep the .bib file updated, so if
you add a reference to zotero, it will automatically add it to your
.bib file.

Zotero also has other features.
It seems to be able to manage pdf files and images and whatnot. If you aren't writing in plain
text, Zotero can also integrate with Word and OpenOffice.

[^zotero]: It's also open source!

# Auto-completion
This is just a quick note about auto-completion.
You *need* to get an editor that has auto-completion for your
references.  It will make your life so much easier.  So, for example,
one way to cite things in LaTeX is with the `\citep{}` command.  A
good editor will connect your .bib file and your .tex file
intelligently so that you don't have to remember all those bibtex
keys.  So, for example, you can just type `\citep{` and it will pop up
with a list of completions.  The best programs will let you search
your .bib file and find the reference you want.  The best of the best
(e.g. emacs) let you search via title, author(s), year, etc.
