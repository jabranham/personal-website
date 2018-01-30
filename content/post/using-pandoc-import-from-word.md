+++
date = "2016-11-29"
title = "A Grad Student's Guide to Pandoc: Part Three - Importing from Word"
image = ""
math = false
tags = ["markdown", "rmarkdown", "latex", "pandoc", "git", "emacs"]
categories = ["markdown", "rmarkdown", "latex", "pandoc", "git", "emacs"]
+++

*This is a post in a [series of posts]({{< relref "post/using-pandoc-a-grad-student-guide.md" >}}) about using pandoc to convert between markdown, latex, word, and pdf. It should stand on its own, but you may want to go though the posts sequentially.*

# Intro 

OK, you have [installed pandoc]({{< relref "post/using-pandoc-a-grad-student-guide.md">}}) to [convert your markdown or latex file to docx]({{< relref "post/using-pandoc-export-to-word.md" >}}) and sent it off to your adviser for comments. Now they send that file back, with comments in the word document and changes made using Word's "track changes" feature. What to do?

Happily, pandoc can import back to latex/markdown from Word quite easily. I'll describe a setup that relies on [git](https://git-scm.com/) to see the "track changes" ("diffs" in git terminology) that your adviser made. You ***have*** been [using git]({{< relref "post/version-control.md" >}}) to keep track of your changes, right???

I have set up a [git repository](https://github.com/jabranham/pandoc-a-grad-student-guide) meant to compliment this post. This post references several files and diffs from that repo, so please feel free to check it out. If you aren't familiar with git or github, you may access the history of the repository by clicking the "# committs" button near the top of the page. If you do know git and want to check it out on your local computer, just run `git clone https://github.com/jabranham/pandoc-a-grad-student-guide.git`.

# Step 1: Use pandoc to convert tex to tex

No, that's not a typo. Pandoc in the background uses a "latex template" when converting latex documents. So when you import the Word document later, you'll want to look at the differences between that document and your original document using pandoc's template. If that's not clear, just forge ahead blindly; it will make sense in a bit. So first export the **version of the paper you sent your adviser** to tex:[^5]

```shell
pandoc example.tex --bibliography=/home/alex/Dropbox/bibliography/references.bib --wrap=none -s -o example-exported.tex
```

We went over what most of the flags mean in the [exporting to word post]({{< relref "post/using-pandoc-export-to-word.md">}}). One new one is the `--wrap=none` option. This tells pandoc not to wrap your lines at 80 characters. In other words, each line in your text (latex) file will be one paragraph. The other new flag is `-s`, which tells pandoc to create a standalone document i.e. to include the preamble. 

At this point, you can go ahead and commit the new `example-exported.tex` file to git.[^6]

# Step 2: Look at the tracked changes

Let's look at the changes our adviser made. This method will actually look at *all* the changes our adviser made, whether or not Word had "track changes" mode on. Pretty neat, huh?

First, let's just convert the word document back to markdown/latex. This is easy to do, and just involves flipping the commands:

```shell
pandoc example-post-adviser.docx --wrap=none -s -o example-exported.tex
```

Note that you are overwriting the tex-to-tex export that you just did. This lets git diff the files easily. By default, pandoc will accept all the "tracked changes" and ignore comments. We'll come back to comments in a moment, but for track changes, this is actually pretty useful. 

We can then look at the diffs. In my toy example, a diff would look something [like this](https://github.com/jabranham/pandoc-a-grad-student-guide/commit/5cb0d3d21dd3722ebfeac983cb878d9fd49f9552). As you can see, git is pretty good about highlighting differences between the two documents. You can then choose what to accept and what to ignore. 

OK, so now we've got a document, `example-exported.tex` that contains a pandoc-ified version of your original latex file with your adviser's changes. There will be some things that are different, though, between this file and your original file. For example, references will appear written out instead of using natbib/biblatex. And tables and figures will probably be messed up. So the next step is to merge your original `example.tex` file with this `example-exported.tex` file. 

The basic idea here is to use some program that compares `example.tex` with `example-exported.tex`. Hopefully it will show you the differences between the two files and allow you to pick and choose what to keep. So you can keep your adviser's edits but your tables/references. If you use [Emacs](https://www.gnu.org/software/emacs/), you can use `M-x ediff-merge` to accomplish this. There is a short tutorial [here](https://coderwall.com/p/mcrwag/use-magit-ediff-to-resolve-merge-conflicts) that explains how, and *tons* more info in the manual (accessible via `C-h i m ediff RET`). If you want to rely totally on git, you can stage and discard parts of files instead of whole files. Emacs makes this simple via [magit](https://github.com/magit/magit); other git helper tools may or may not support this. You can also do it with the command line, though it's a bit painful. If you have a tool you use, I'd love to hear about it in the comments!

Regardless of what method you use to merge the two files, you can look at the diff [here](https://github.com/jabranham/pandoc-a-grad-student-guide/commit/22e6064aa415fca4dc409f6e092ef4a0bcdea3a2). As you can see by comparing the [original example.tex](https://github.com/jabranham/pandoc-a-grad-student-guide/blob/7871a1f232d59228820be695a46a223f385ce28c/example.tex) file with the [commented docx file](https://github.com/jabranham/pandoc-a-grad-student-guide/raw/master/example-post-adviser.docx), we successfully incorporated all of our adviser's changes into our own latex document while keeping our latex tables and references. 

# Step 3: Looking at comments

Dealing with comments from a docx file is a little more complicated. Honestly, it's simpler just to open the word document in MS Word or google docs or something and copy/paste the comments into your latex document as real comments. I'll briefly describe how to get comments out of a Word document into a latex file, though, in case someone finds it useful:

First, we need to tell pandoc to include comments in the markdown. We do that by modifying the `track-changes` option:

```shell
pandoc example-post-adviser.docx --track-changes=all -s -o example.tex
```

`track-changes=all` tells pandoc to wrap insertions, deletions, and comments in curly braces.[^2] So, for example, a comment looks something like this:

```latex
{Text of a comment}
```

As you can imagine, this makes our outputted latex file messier, especially if there's a lot of tracked changes or comments. That's why I usually use the first method to get all the proposed insertions/deletions through git. Then I just open up the Word file and copy/paste the comments into my `example.tex` document so that they look something like this:

```latex
Text being commented on
% alex says: this is a great point!
```

And while I'm sure there's probably a way to automate this, I have to deal with it so rarely that this works for now.[^3] 

# Outro 

That covers the basics of word to latex via pandoc! It's by no means perfect, but if you need to convert latex to word, get changes, then go back to latex it works well enough. As mentioned in the previous post, you probably don't want to coauthor with someone this way. But if I get comments & changes from someone, this makes it pretty painless to incorporate them into my paper!

[^2]: The default is `track-changes=accept`, which gives us the behavior described when we were looking at track changes.

[^3]: If you're reading this and know of a better way to deal with comments from Word in latex, please let me know! 

[^5]: To keep track of this, I put a git "tag" on the version I send when I send it. Since tags can't share names, I also put a number. So a tag may look something like, "Smith-1". Also note that if you want to actually run this on your machine using the repo I'm talking about, you'll need to provide a bib file and change the reference in the tex document. *Update* - if pandoc yells at you, you may need to update pandoc or pandoc-citeproc. Be sure that you're running the most recent version.

[^6]: There are other ways to do this so that you don't make a whole new file from your paper - using git branches, for example, could do the trick. This would keep your git repo history a bit cleaner as you don't be adding (then deleting later) what is essentially the same paper. But for simplicity's sake we'll just commit a whole new file here. 
