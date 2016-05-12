---
layout: post
title: Using Github Pages to make an Academic Website
categories: [website, markdown]
tags: [website, markdown]
comments: true
---

UPDATE - 12 May 2016 - I have created a
[github repository](https://github.com/jabranham/github-pages-academic-starter-kit)
that is designed so that you can fork it and get started with your own
website as quickly as possible. 

When you go on the academic job market nowadays, it's definitely the
expectation that you have a personal website that you keep relatively
up-to-date. Since this is by no means a painless process, this post is
intended to be an guide on how to get started with your own website. I
focus here on building a site where you want a homepage, subpages for
teaching, research, and your CV, and a blog that you write in
markdown. In other words, I focus on building a site like the one
you're reading this on. It may be useful for you to look at the
[source files](https://github.com/jabranham/jabranham.github.io) that
I use to build this website. 

# Step 0: Choose how/where to host your site
After you make your website, you'll need to chose where to host your
site. I like to think of there being different levels of these hosting
services. On the one hand, you could choose a place like Google
Sites. If you do that, you don't need to learn much at all, but you
have relatively little control over how your site looks. At the other
extreme, you can set up your own server to host your site at a
web address you own. If you do that, you have total control over every
aspect of your site. I chose [Github Pages](https://pages.github.com/)
for my site because it's relatively painless to get set up, it's free,
and it's automatically under
[version control](/blog/2015/09/version-control.html) (which is a
godsend for stuff like this especially). Github pages uses
[Jekyll](https://jekyllrb.com/). Basically what this means is that you
can setup your pages to look basically however you want them to look,
so long as your site is "static." Having a "static" site means that
your webpages don't change for each user - so no logging in to your
website or anything like that.[^1] They do this because it costs them very
little to host these static sites. If they had to support dynamic
webpages, it would be much more costly.

[^1]: Although you can use things like Disqus for comments.

### Install dependencies
Now for the boring part. If you want to see how your site looks
*before* pushing the changes you make to the internet, you'll need to
install Ruby and Jekyll. Github pages uses these to turn your files
into a proper-looking website. Luckily, this isn't too difficult to
do. Github has a help page
[here](https://help.github.com/articles/using-jekyll-with-pages/) that
describes pretty nicely how to get this set up on your machine. 

# Step 1: Create a Project

People say the word project and mean different things. What I mean
here is to create one folder that will house your entire website. On a
unix-type machine (mac, linux, the BSDs), this would be something like
this: `~/personal-website`. Once you have that setup, initialize it as
a git repository (`git init`, in case you forgot). You can then setup
the basic structure of your website by creating a few folders and
files:

    ~/personal-website
    |--- _config.yml
    |--- _includes
         |--- footer.html
         |--- header.html
         |--- head.html
    |--- _layouts
         |--- default.html
         |--- page.html
         |--- posts.html
    |--- _sass
         |--- base.scss
         |--- _layout.scss
         |----_syntax-highlighting.scss 
    |--- css
         |--- main.scss
    |--- index.md
    |--- Gemfile

That is enough to build a basic site. If you don't know CSS or HTML,
you can just copy the files that I have under `_includes`, `_layouts`,
`_sass`, and `css`. I'll walk through what each of these files does and
how you can control their behavior.

# Step 2: Configure your site
The `_config.yml`  file allows you to set site-wide options. Here is
what mine looks like at the moment:

    # Site settings
    title: J. Alexander Branham
    email: branham@utexas.edu
    description: > # this means to ignore newlines until "baseurl:"
        I'm a PhD Candidate in the Department of Government at UT-Austin.
        I study American politics, public opinion, and methods. 
    url: "http://jabranham.com" # the base hostname & protocol for your site
    twitter_username: JAlexBranham
    github_username:  jabranham
    permalink: /blog/:year/:month/:title.html
    gems:
        - jekyll-sitemap

    # Build settings
    markdown: kramdown

Jekyll uses this file to set sitewide settings. So I just tell it the
title of my site, my email adddress, and a few other things that
various parts of my site use. It's easier to define variables here
rather than go hunting through the other files for your site. The last
few lines tells jekyll how I want markdown handled. I use `kramdown`
for the moment because it correctly handles footnotes. 

# Step 3: Make your homepage
The file `index.md` contains your homepage. So if you're using
github's default, this is what will be displayed at
`username.github.io`. You can write the document using
[markdown](https://help.github.com/articles/markdown-basics/), so no
need to mess with formatting html or whatever. The file **must** start
with

    ---
    layout: default
    ---

Everything between the dashes is frontmatter that jekyll will use to
build the webpage. So all I've done there is told jekyll that the
webpage's layout should come from "default." So Jekyll will dutifully
look at `_layouts/default.html` and make my homepage according to that
layout. In my case, the layout file tells it to include `head.html`
(from `_includes/head.html`), then put header (from
`_includes/header.html`), then the content of the page (this is whatever
I type into the `index.md` file, after the frontmatter), and finally
include the footer (from `_includes/footer.html`). 

# Step 4: Create other pages
You can create other pages pretty easily. They simply go in the same
folder as your `index.md` file. The name of the file will be the name
of the webpage. So, for instance, I have a file named `research.md`
and another called `teaching.md`. I use the `_includes/header.html`
file so that you can get to those pages from any part of my
website. Finally, I also keep my CV in this project. Since it's a
LaTeX file, it gets its own directory so that it doesn't clutter up
everything when it's compiled. Then I can reference it with
`./cv/cv.pdf` when I want to link to the pdf. One day I'll get around
to converting it to be both an html page as well as a pdf page
(perhaps with [org mode](http://orgmode.org/) for emacs), but that's
going to have to stay on the to-do list for now. 

# Step 5: Fiddle with your layout
Finally, I recommended that you simply copy-paste a lot of my layout
files in order to get started as quickly as possible. Of course, the
web would be a pretty boring place if all websites looked the same. So
I definitely recommend that you poke around in the layout and style
files.

You also may want to expand your directory structure a bit. I've
already mentioned that I use another subfolder for my CV files. I also
have a folder for any images that I want on my website (my picture on
the homepage, for example), and another that contains code I used to
make some blog posts. 

# Step 6: Other misc tweaks

### Blog 
Jekyll is really nice for blogging. There are tons of tutorials online
that show you how to set this up, so I won't write much here. The
basic idea is that you can put drafts of posts in the `_drafts`
folder, then move them to the `_posts` folder when you're ready to
publish them. You save them in a specific format:
`YYYY-MM-DD-post-name.md` and then Jekyll takes care of converting
everything for you. You can even get fancy and add comments or
whatnot.

### Analytics
You can use a tool like
[google analytics](https://www.google.com/analytics/) to keep tabs on
the kinds of visitors your site is getting. While not super useful for
me, it's interesting to look at nevertheless. Definitely more useful if
you're trying to reach a certain demographic or trying to sell
something.

### Personal domain 
This one is actually a little tricky to get set up. By default, github
pages hosts at *username*.github.io. If you own your own domain,
though, you can host it there. I found the advice
[here](https://github.com/leeper/leeper.github.io) to be very useful
in getting this set up. If you think you've followed all the
directions and it's still not working just walk away for a few hours -
it seems to take a while to go into effect.
