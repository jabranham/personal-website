---
layout: post
title: A Grad Student's Guide to Pandoc: Part Three - Importing from Word
categories: [markdown, rmarkdown, latex, pandoc]
tags: [markdown, rmarkdown, latex, pandoc]
comments: true
---

*This is a post in a [series of posts]({% post_url using-pandoc-a-grad-student-guide %}) about using pandoc to convert between (r)markdown, latex, word, and pdf. It should stand on its own, but you may want to go though the posts sequentially.*

OK, you have used pandoc to [convert your markdown or latex file to docx]({& post_url using-pandoc-export-to-word-or-pdf %}) and sent it off to your adviser for comments. Now they send that file back, with comments in the word document and changes made using Word's "track changes" feature. What to do?

Happily, pandoc can deal with this situation.

# Word to markdown or latex

First, let's just convert the word document back to markdown/latex. This is easy to do, and just involves flipping the commands from the last post:

```
pandoc my-document.docx -S -s -o my-document.md
```

The only difference here is that we've added the `-s` for `standalone` which makes pandoc produce a standalone document (i.e. it includes the preamble for latex documents). 

However, you'll notice that it hasn't done what we want it to do with the comments and tracked changes. The default behavior is to accept all the tracked changes and ignore comments. This is actually pretty useful - especially if you're keeping your markdown/latex file under version control [using git]({% post_url version-control %}). You can simply diff these two documents to see whatever changes your adviser has made.[^1] 

Dealing with comments from a docx file is a little more complicated. First, we need to tell pandoc to include comments in the markdown. We do that by modifying the `track-changes` option:

```
pandoc my-document.docx -track-changes=all -S -s -o my-document.md
```

`track-changes=all` tells pandoc to wrap insertions, deletions, and comments in html-style classes.[^2] So, for example, a comment looks something like this:

```
<span class="comment-start" id="1" author="Alex Branham" date="2016-09-12T14:14:00Z">Text of the comment</span>
Text being commented on <span class="comment-end" id="1"></span>
```

As you can imagine, this makes our outputted markdown file messier, especially if there's a lot of tracked changes or comments. That's why I usually use the first method to get all the proposed insertions/deletions through git. I then go through pandoc a second time with the wordier `track-changes=all` and search through the resulting markdown document for the comments. I can then deal with them manually. I usually end up converting them to comments looking something like the following:

```
Text being commented on
<!-- Alex says: text of the comment -->
```

And while I'm sure there's probably a way to automate this, I have to deal with it so rarely that this works for now.[^3] 

[^1]: There will probably be other changes in the diff as well - for example, references will probably mess this up. That's easy enough to deal with, though - you can just reject that "faux change" in the diff. 

[^2]: The default is `track-changes=accept`, which gives us the behavior described above

[^3]: If you're reading this and know of a better way to deal with comments from Word in markdown, please let me know! 
