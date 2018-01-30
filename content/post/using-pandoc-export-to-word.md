+++
image = ""
math = false
tags = ["markdown", "rmarkdown", "latex", "pandoc"]
categories = ["markdown", "rmarkdown", "latex", "pandoc"]
date = "2016-11-14"
title = "A Grad Student's Guide to Pandoc: Part Two - Exporting to Word"
+++

*This is a post in a [series of posts]({{< relref "post/using-pandoc-a-grad-student-guide.md" >}}) about using pandoc to convert between r/markdown, latex, word, and pdf. It should stand on its own, but you may want to go though the posts sequentially.*

Even though [word processors are stupid](http://ricardo.ecn.wfu.edu/~cottrell/wp.html), MS Word's ubiquity means that occasionally I have to convert a latex or markdown document to a docx file for a colleague who insists on using Word's "comments" feature or for submission to a journal that doesn't accept pdfs (though thankfully, the vast majority do today).

In this post, I'll walk through the basics of how to use pandoc to convert from r/markdown or latex to word (docx) or pdf files. The process is actually pretty simple, but can be a bit daunting at first, particularly if you haven't worked with command line tools before. 

# Step 1: Open a terminal where your file is
I'm going to assume that you have a markdown or latex file ready to convert to word to show to your adviser (or whoever). So if you're using rmarkdown, knitr, sweave or the like, you'll need to use the appropriate command to generate a latex or markdown document. 

Open up Finder(mac), File Explorer (windows), or similar if you're on linux/bsd. Navigate to the folder containing your markdown or latex document, right click, and select the option titled something along the lines of "open in terminal". On Windows, you can [click in the address bar](http://stackoverflow.com/a/6599296/4190459)  and type in `powershell`. When your terminal/powershell opens, you may type `ls` (hit enter), and it will print out all the files in that folder. Make sure you can see the one you want to convert.

If you are not in the right folder, you may see different files. You can quit the window and try again. If it still doesn't work, you can use the `cd` command to navigate your file structure. Pandoc has a good introduction on how to do that [in Step 3 on their guide](http://pandoc.org/getting-started.html). 

If you're interested in learning more about the terminal and how to use it, there are tons of tutorials online. You can google around to fine many. For example, [code academy](https://www.codecademy.com/learn/learn-the-command-line) has one. And there's a kinda RPG-like one [here](http://www.mprat.org/Terminus/)

# Step 2: Convert to Word/docx 
Once you have a terminal/powershell open in the right folder (i.e. you see your markdown/latex file when you `ls`), we can convert to a Word document. Here's how we do that. If you're writing with markdown instead of latex, you use the same commands but your document will be named something like "my-document.md" instead of "my-document.tex"

```shell
pandoc my-document.tex -o my-document.docx
```

All this command does is tell pandoc to take my-document.tex and convert it to my-document.docx. We pass the `-o` option to pandoc: `-o mydocument.docx` tells pandoc the output (hence the `o`) that we want. So we could have named the resulting docx file anything - it doesn't need to have the same name as our markdown document.

And that's it - we now have a Word document from our markdown or latex document. It's really that easy. If it's a simple latex document, pandoc does an excellent job. If it's more complicated you may need to make some manual adjustments to the Word document. In particular, you may have to descend into the hell that is MS Word Table Editor to get tables looking decent. 

Sometimes pandoc has an easier time outputting to .odt first rather than straight to .docx. So you might try to do that and open the resulting .odt file in Word directly. 

## Figures not appearing 
If you have figures in your latex document that you want to appear in the Word document, you have to include them in a file format that Word supports. Word does not support PDFs. I've found that eps files are supported pretty well, so that's what I've been using recently. YMMV.

## Citations
Citations may get messed up when converting from markdown/latex to word. Luckily this is an easy fix. The solution relies on `pandoc-citeproc`, which lets pandoc figure out citations. You probably installed this when you installed pandoc, but if not you'll need to install it. Once you have it installed, you simply let pandoc know where your `.bib` file is. So if your `.bib` file is in the same folder as your latex document, it is this simple:[^1]

```shell
pandoc my-document.tex --bibliography=library.bib -o my-document.docx
```

You can use paths like `~/path/to/library.bib` if it is elsewhere on your computer.

## Styling docx output
If you are going to convert frequently to docx, you may want to set up a reference-docx. The easiest way to do this is to convert to docx as above, open the resulting docx file, and change the "styles" until the document looks like what you want. Pandoc calls this your "reference-docx." You can find a list of supported styles [in pandoc's user guide](http://pandoc.org/MANUAL.html) (search for "--reference-docx"). 

When you convert new markdown/latex files to docx, you can then tell pandoc that the resulting docx file should have the same formatting styles as your "reference-docx" file. This is a fairly straightforward extension of the above command:

```shell
pandoc my-document.tex --bibliography=library.bib --reference-docx=reference-docx.docx -o my-document.docx
```

you'll obviously need to replace with the path name of your reference docx on your computer. 

# Step 3: Make life easier for future you
OK, so converting from latex/markdown to Word is fairly painless. Sure, some minor editing is needed, and the reference-docx thing is annoying, but it generally works. Now let's make life easier for future us. 

## If you're using Emacs...
Emacs has great support for pandoc with [pandoc-mode](https://joostkremers.github.io/pandoc-mode/). Install it and turn it on my running `M-x pandoc-mode` in the buffer. Of course, you can have it turn on automatically in tex files by: `(add-hook 'latex-mode-hook 'pandoc-mode)`. Now you can peruse all of the settings (including using a bib file and reference-docx) by hitting "C-c /". 

## Have a master reference-docx
Once you set up one reference docx, there's no reason not to use that one for every analysis. Go ahead and put it somewhere on your computer (Dropbox, for example) and then you can reference it from anywhere: 

```shell
pandoc my-document.tex --reference-docx=/home/alex/Dropbox/reference-word.docx -o my-document.docx
```

## Set up an alias 
*HT to [Brendan Apfeld](http://brendanapfeld.com/) for this tip.*

If you're frequently converting the same thing (your prospectus, say, or a chapter of your dissertation), you can set up an alias to make this quick. Just stick something like this in the file: `~/.bashrc` (on linux, mac users may want to use `~/.bash_profile`, windows is more complicated):

```shell
alias convert_proposal="pandoc --reference-docx=/home/alex/Dropbox/reference.docx proposal.tex --bibliography=bib_file.bib -o proposal.pdf"
```

# Outro 
That about wraps it up. I hope this was useful. After using pandoc to convert latex to Word, I've come to the conclusion that it's good enough for infrequent or one-off conversions. It's certainly not the case that I'll be stuck retyping the whole paper to submit it to a journal that only accepts docx files, for example. What it is not good enough to do (yet?) is collaboration with a coauthor who uses word.

[^1]: Update 2017-11-10: A helpful reader pointed out to me that if your bib file is incorrectly formatted, this will cause pandoc-citeproc to throw an error. You can use `pandoc-citeproc -y library.bib` to find out which entry is causing the error.
