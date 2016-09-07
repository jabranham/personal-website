---
layout: post
title: A Grad Student's Guide to Pandoc: Part Two - Exporting to Word or PDF
categories: [markdown, rmarkdown, latex, pandoc]
tags: [markdown, rmarkdown, latex, pandoc]
comments: true
---

*This is the first post in a [series of posts]({% post_url using-pandoc-a-grad-student-guide %}) about using pandoc to convert between (r)markdown, latex, word, and pdf. It should stand on its own, but you may want to go though the posts sequentially.*

In this post, I'll walk through the basics of how to use pandoc to convert from (r)markdown or latex to word (docx) or pdf files. The process is actually pretty simple, but can be a bit daunting at first, particularly if you haven't worked with command line tools before. 

# Step 1: Open a terminal where your file is

I'm going to assume that you have a markdown or latex file ready to convert to word to show to your adviser (or whoever).[^1] Open up Finder(mac), File Explorer (windows), or similar if you're on linux/bsd. Navigate to the folder containing your markdown or latex document, right click, and select the option titled something along the lines of "open in terminal". On Windows, you can [click in the address bar](http://stackoverflow.com/a/6599296/4190459)  and type in `powershell`. When your terminal/powershell opens, you may type `ls` (hit enter), and it will print out all the files in that folder. Make sure you can see the one you want to convert.[^2] 

# Step 2: Convert to Word/docx 

Once you have a terminal/powershell open in the right folder (i.e. you see your markdown/latex file when you `ls`), we can convert to a Word document. Here's how we do that. 

```
pandoc my-document.md -S -o my-document.docx
```

All this command does is tell pandoc to take my-document.md and convert it to my-document.docx. We pass two options to pandoc: `-S` which tells pandoc to convert smart quotes, em- and en-dashes, and ellipses where appropriate. `-o mydocument.docx` tells pandoc the output (hence the `o`) that we want. So we could have named the resulting docx file anything - it doesn't need to have the same name as our markdown document.

And that's it - we now have a Word document from our markdown or latex document. You may want to improve the style formatting of the resulting word document, though. 

## Styling docx output

If you don't want to manually go through every resulting word document to change the styles around, you can tell pandoc to use a "reference docx." This is a document that you've previously put through pandoc and tweaked the styles of. 

## Citations

Citations (to other scholars work or within-document citations like equations, Figures, and Tables) may get messed up when converting from markdown/latex to word. We'll go over how to fix that in a later blog post. 

# Converting to pdf

You'll have to have LaTeX installed.[^3] If you don't, go ahead an install TeXLive (Linux), MacTeX (macOS), or MiKTeX (Windows). Now we do basically the same thing as above: 

```
pandoc my-document.md -S -o my-document.pdf
```

And in the background pandoc will convert your markdown to latex, then run it through latex to produce a pdf. As above, any within document references you have may get messed up. Similarly to the docx reference document, pandoc relies on a latex template for decent style defaults. This is customizable, and we'll go over how to do that in a later post. 

[^1]: If you are using rmarkdown, you can convert it to a markdown document by running it through knitr with the following command: `knitr::knit("my-document.Rmd")`. knitr will then go through the document, evaluate all the r chunks, and include whatever output was created when it generates "my-document.md". 

[^2]: If you are not in the right folder, you may see different files. You can quit the window and try again. If it still doesn't work, you can use the `cd` command to navigate your file structure. Pandoc has a good introduction on how to do that [in Step 3 on their guide](http://pandoc.org/getting-started.html). 

[^3]: I'm assuming in this section that you are interested in converting markdown to pdf using pandoc. Trying to convert a latex document to pdf this way using pandoc will likely produce an error if you have any references. But if you're using latex, you should be able to get a pdf by just running `pdflatex` (or similar) on your tex file. 
