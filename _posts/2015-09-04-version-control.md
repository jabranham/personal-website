---
layout: post
title:  "Version Control for Academics"
categories: [best_practices, version_control]
tags: [git, github, version_control, best_practices]
---

My [first post](/blog/2015/09/why-blog.html) explained why I started this blog.
Essentially, I started to make notes to myself about how I setup and use all the various bits of software that I use.
But then I figured that it would be nice of me to put them online, since it's not much more work for me, and maybe it'll help out some other hapless person (e.g. grad students trying to figure out this grad school thing). 
I then mentioned version control, which is one of those things I wish someone had talked with me about at the very beginning of grad school. 

Version control is one of those things that you don't need, until you *really really really* need it. 
There's a [great article](http://www.jakebowers.org/PAPERS/tpm_v18_n2.pdf) by Jake Bowers in The Political Methodologist that makes the case for why you need version control in your life, so I won't focus too much on that here. 
There are a few other good articles online on the advantages of version control. 
For example. [here](http://academia.stackexchange.com/questions/5277/why-use-version-control-systems-for-writing-a-paper) and [here](http://christinabergey.com/blog/2014/01/version-control-for-academics/).
Finally, [here's a good article](https://www.sharelatex.com/blog/2012/10/16/collaborating-with-latex-and-git.html) on why git is so great to use with collaborators (co-authors). 
One of my favorite features of using a formal version control system is that it lets me avoid things like this: 

![version control hell](http://www.phdcomics.com/comics/archive/phd101212s.gif)

Instead, I'm going to focus on my setup and how I implement version control.
There are a few different ways to do this, but I'm pretty happy with my setup, so that's what I'll focus on here.
I use git and Github.
Git is the version management system, Github is just an online host (probably the most popular git-based one).
You absolutely don't need to use github if you use git.
You can see all my public repos on github [here](https://github.com/jabranham)

# Step 1: Download and Install git (and a GUI, if you want one)
Installing git is super easy. 
You can navigate to [git's website](https://git-scm.com/) and find a link to download the file. 
Some Linux distributions have git installed already. 
If not, you can do `sudo apt-get install git` or similar. 

git is a command line tool, which is great if you're comfortable there. 
If not, there are a few programs out there that will provide a graphical interface for git. 
There's a list available [here](http://git-scm.com/downloads/guis).
I tend to use git either from the command line or from within my text editor, so I don't have much experience with the GUIs. 
Of the ones I've looked at, though I recommend (in no particular order) SmartGit, SourceTree, and Github. 

# Step 2: Configure git
Now that we have git installed, you need to tell it who you are. 
This is, again, super easy.[^1] 
From the terminal (or command line or powershell, depending on your OS), run

    $ git config --global user.name "John Doe"
    $ git config --global user.email johndoe@example.com

[^1]: If you are using a GUI instead of the command line, you should be able to set these global configurations yourself. Poke around in the preferences until you find it. 

The first line tells git to configure your user name to be "John Doe" (which you'll obviously want to change, unless you happen to actually be named John Doe).
The second line tells git your email (which you'll also need to change).
The `--global` option tells git to remember this for everywhere on your computer, so you will not need to tell git your username or email address ever again.
You can check to make sure that git is remembering those options with:

    git config --list 


which will list all the options that git is remembering. 

# Step 3: Learn git
You can learn everything you'll need to know in about 15 minutes. 
There are so many online guides on how to learn git that I'm not going to cover this. 
[This tutorial](https://try.github.io/levels/1/challenges/1) is nice because you don't even have to have git installed. 
[Here](https://www.atlassian.com/git/) is a more in-depth guide.
You can also just google "learn git" and a bajillion resources will pop up. 
Don't pay for anything; everything you will need is available online.

Git plays well with [Github](https://github.com), which is an online resource. 
Think of it as a kind of "facebook for nerds". 
You can put your repos on github for free if they're made public. 
They give out a few private repos to academics for free, but you have to request it [here](https://education.github.com/)[^3]
This will allow you to "push" your changes to github.
Then a coauthor can "pull" your changes to their computer (or you can "pull" them to sync between different computers).

[^3]: There are other websites that give you more private repos, like [Bitbucket](https://bitbucket.org) and [GitLab](https://gitlab.com).

# Step 4: Write!
Now that you've got git up and running, it's time to write! 
You can add git version control to any folder with `git init`, and then off you go! 
I've got a few quick recommendations on how to get the most out of git:

## Write in plain text

Git was originally designed to be used with computer code.
That doesn't mean that we can't use it with prose. 
It's quite easy, in fact. 
However, git really excels when you write in **plain text**. 
So put down Microsoft Word. 
There are basically two ways of writing academic-style articles in plain text (that I know of)
You can write the whole thing in LaTeX or you can write in markdown.[^2] 
I started with LaTeX (which is more popular,  at least in my corner of political science), but have converted to markdown ([rmarkdown](http://rmarkdown.rstudio.com/) in particular). 

[^2]: The -TeX part of LaTeX is pronounced "tech", *not* like the "tex" part of "Texas". 

LaTeX gives you more control over the structure of your document, but has a much steeper learning curve than markdown. 
Markdown is much easier to learn.
It also creates a LaTex .tex file along the way when you compile a .pdf document, so it's relatively easy to convert from markdown to LaTeX if you need to gain the extra power. 
I'll also write a blog post soonish about the pros and cons of writing in LaTeX vs markdown. 

## Branches
Git has this really cool feature called "branches". 
You can start one with `git checkout -b <name_of_the_branch>`.
The branch you start on (and what I think of as the "main" branch) is called by default "master". 
This is the branch that is the "public" release of your document. 
So, for example, the "master" branch contains the version that I've shared with my advisor most recently. 
You can also use branches to keep track of different thoughts or different formats. 
So, for example, if I am preparing to submit to a journal, I create a branch called "journal-name" and then make all of the formatting adjustments they require for submission. 

## .gitignore  
The ".gitignore" file is your friend, especially if you're using LaTeX. 
The ".gitignore" file tells git to automatically ignore files or file extensions. 
Since LaTeX makes quite a few files when it compiles, I tell git to ignore all of those files. 
This is what my ".gitignore" file looks like for a recent project that I used LaTeX for: 


    *.aux
    *.bbl
    *.blg
    *.log
    *.synctex.gz
    *.pdf
    *.fls
    *.fdb_latexmk


The asterisk before the period tells it to ignore all files whose file names are anything then a period followed by those letters. 
So, for example, "*.pdf" tells git to ignore pdf files. 
If you want git to track the pdf files, you'd just leave that out of the ".gitignore" file (especially useful if you want to host them on github, for example).[^4]

[^4]: Because .pdf files are binary, git won't be able to see the difference between two different versions like it can with your LaTeX or markdown files. However, there is a tool called [`latexdiff`](http://www.ctan.org/tex-archive/support/latexdiff/) that will do that for you.


## Tags and releases 

Git (and Github) also supports [tagging](https://git-scm.com/book/en/v2/Git-Basics-Tagging) certain commits. 
This is just a way to point to a specific instance as being important. 
I use these as a way to mark important moments in the life of a document.
So, for example, whenever I show a draft to someone to get feedback, I make a tag.
That way I can keep working on it, then whenever I get their comments I can easily find the version that they received.
I also use tags to keep track of other things, like when I submit a manuscript or when I present it at a conference. 
