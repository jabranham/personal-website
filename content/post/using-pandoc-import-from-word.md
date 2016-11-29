n+++
date = "2016-11-14T15:01:48-06:00"
title = "A Grad Student's Guide to Pandoc: Part Three - Importing from Word"
image = ""
math = false
tags = ["markdown", "rmarkdown", "latex", "pandoc", "git"]
categories = ["markdown", "rmarkdown", "latex", "pandoc", "git"]
draft = true
+++

*This is a post in a [series of posts]({{< relref "post/using-pandoc-a-grad-student-guide.md" >}}) about using pandoc to convert between markdown, latex, word, and pdf. It should stand on its own, but you may want to go though the posts sequentially.*

OK, you have [installed pandoc]({{< relref "post/using-pandoc-a-grad-student-guide.md">}}) to [convert your markdown or latex file to docx]({{< relref "post/using-pandoc-export-to-word.md" >}}) and sent it off to your adviser for comments. Now they send that file back, with comments in the word document and changes made using Word's "track changes" feature. What to do?

Happily, pandoc can import back to latex/markdown from Word quite easily. I'll describe a setup that relies on [git](https://git-scm.com/) to see the "track changes" ("diffs" in git terminology) that your adviser made. You **have** been [using git]({{< relref "post/version-control.md" >}}) to keep track of your changes, right???

# Step 1: Use pandoc to convert tex to tex

No, that's not a typo. Pandoc in the background uses a "latex template" when converting latex documents. So when you import the Word document later, you'll want to look at the differences between that document and your original document using pandoc's template. If that's not clear, just forge ahead blindly; it will make sense in a bit. So first export the **version of the paper you sent your adviser** to tex:[^5]

```shell
pandoc example.tex --bibliography=/home/alex/Dropbox/bibliography/references.bib --wrap=none -S -s -o example-exported.tex
```

We went over what most of the flags mean in the [exporting to word post]({{< relref "post/using-pandoc-export-to-word.md">}}). One new one is the `--wrap=auto` option. This tells pandoc to wrap your lines at 80 characters. Open up the resulting `example-exported.tex` file and look at it. You'll notice two things are different from your original document. First, pandoc has used its template, so the preamble is likely quite different. Second, your paragraphs have been wrapped at (around) 80 characters per line. The other new flag is `-s`, which tells pandoc to create a standalone document i.e. to include the preamble. 

# Step 2: Look at the tracked changes

First, let's just convert the word document back to markdown/latex. This is easy to do, and just involves flipping the commands:

```shell
pandoc example.docx --wrap=none -S -s -o example-exported.tex
```

Note that you are overwriting the tex-to-tex export that you just did. This lets git diff the files easily. By default, pandoc will accept all the "tracked changes" and ignore comments. We'll come back to comments in a moment, but for track changes, this is actually pretty useful. 

We can then look at the diffs. In my toy example, a diff would look something [like this](https://github.com/jabranham/pandoc-a-grad-student-guide/commit/5cb0d3d21dd3722ebfeac983cb878d9fd49f9552). As you can see, git is pretty good about highlighting differences between the two documents. You can then choose what to accept and what to ignore. 


# Step 3: Looking at comments

Dealing with comments from a docx file is a little more complicated. First, we need to tell pandoc to include comments in the markdown. We do that by modifying the `track-changes` option:

```shell
pandoc my-document.docx -track-changes=all -S -s -o my-document.md
```

`track-changes=all` tells pandoc to wrap insertions, deletions, and comments in html-style classes.[^2] So, for example, a comment looks something like this:

```
<span class="comment-start" id="1" author="Alex Branham" date="2016-09-12T14:14:00Z">Text of the comment</span>
Text being commented on <span class="comment-end" id="1"></span>
```

As you can imagine, this makes our outputted markdown file messier, especially if there's a lot of tracked changes or comments. That's why I usually use the first method to get all the proposed insertions/deletions through git. I then go through pandoc a second time with the wordier `track-changes=all` and search through the resulting markdown document for the comments. I can then deal with them manually. I usually end up converting them to comments looking something like the following:

```shell
Text being commented on
<!-- Alex says: text of the comment -->
```

And while I'm sure there's probably a way to automate this, I have to deal with it so rarely that this works for now.[^3] 

[^2]: The default is `track-changes=accept`, which gives us the behavior described when we were looking at track changes.

[^3]: If you're reading this and know of a better way to deal with comments from Word in markdown, please let me know! 

[^5]: To keep track of this, I put a git "tag" on the version I send when I send it. Since tags can't share names, I also put a number. So a tag may look something like, "Smith-1"
