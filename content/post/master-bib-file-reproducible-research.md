---
categories:
- research
- makefile
- reproducibility
comments: true
date: 2016-10-25T00:00:00Z
tags:
- research
- makefile
- reproducibility
title: Dealing with a bib file in reproducible research
---

*Updated 27 October 2016*: Added note about getting a "final" bib file

Lately I've been putting in a not insignificant amount of effort to make sure that my research is reproducible. Ideally, this means that it's not just the final product that is reproducible --- it should be reproducible at each step along the way.

One tool I've been increasingly reliant on is [GNU make](https://www.gnu.org/software/make/), which is a way to describe dependencies between files. So, for example, you tell it that the final paper pdf depends on your figures, tables, and the tex file. `make` is smart enough that if you ask it to recompile your pdf, it goes through and reruns the analyses that need to be rerun. In other words, if nothing but the tex file has updated, just recompile the pdf. But if you've changed your R code to make the figures, it'll remake the figures before recompiling the pdf. It's a really great tool that there are tons of resources on. I learned a lot from [Karl Broman's](http://kbroman.org/minimal_make/) website as well as [Jon Zelner's](http://www.jonzelner.net/statistics/make/reproducibility/2016/06/01/makefiles/) example. 

One problem I ran into is references. I keep one master `bib` file just to keep things simple. Right now I keep it on Dropbox but I'm trying to figure out the best way to move it to git. However, this obviously complicates things for reproducible research. Since [it's not reproducible if it only runs on your laptop](http://www.jonzelner.net/docker/reproducibility/2016/06/03/docker/), I need some way to figure out how to make this bib file available whenever (or wherever) I compile this document. 

The system I've come up with relies on Dropbox and `make`. You can make any file in Dropbox "public" by right clicking on it in the Dropbox website and selecting the "share" option. 

Then I add a line to my Makefile that goes something like this:

    references.bib:
    	@echo --- Downloading bib file ---
    	Rscript --vanilla -e 'download.file("dropbox-link", "references.bib")'

Where you'll have to replace `"dropbox-link"` with the link that you get from Dropbox, above. I name the file `references.bib` and can add it to my tex file by doing `\addbibresource{references.bib}` (if you use biblatex). 

{{% alert note %}}
The link dropbox gives you ends in `...?dl=0`. In order to download the actual file, though, you have to change that to: `...?dl=1`. 
{{% /alert %}}

You can also make your pdf file rely on your bib file by doing something like this:

    output/partisan-feedback.pdf: output/partisan-feedback.tex output/references.bib output/figures/predicted-probs-by-partisanship-all.pdf
    	@echo --- Creating pdf ---
    	latexmk -synctex=1 -shell-escape -pdf paper

Some potential drawbacks, depending on your application: 

* Will overwrite the bib file each time you call `make` - this isn't a big deal for me since I think of it as "updating," but you should keep it in mind.
* Requires an internet connection to compile the pdf
* Harder to collaborate. This is I think the biggest drawback of this method - if I'm collaborating with someone, I either need to allow them to directly edit my master bib file (something I'm hesitant to do since I have a system that keeps track of what I've read and what I need to read that relies on this file), or I have to manage the references for the project. There's probably a better way to do this, and it's something I'm still working on. 

[Brendan Apfeld](http://brendanapfeld.com/) emailed me after I posted this reminding me that it is a good thing to be able to get a bib file containing *only* the references you used in your paper. He also helpfully provided the means of doing so: Assuming you use `biblatex`, you can do this easily with `biber`. After you run `latexmk` (or whatever), you can just run:

    biber paper-file.bcf --output_format=bibtex -O newbib.bib --strip-comments
    
