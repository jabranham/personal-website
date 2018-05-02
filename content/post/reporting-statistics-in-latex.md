+++
tags = ["code", "latex", "analysis", "r"]
math = false
date = "2018-05-02"
title = "Reporting Numbers in LaTeX Documents"
+++

Let's imagine a situation.
You generate some number(s) in R or Python or whatever and want to include these numbers in a LaTeX document.
Most people (I assume) just copy/paste the numbers from the console to the document.[^1]
This means that if you update the analysis, your document may be reporting incorrect information.

There are some solutions to this, of course.
One solution is to mix the code together with the document (rmarkdown users will be familiar with this).
While that's a good idea in theory, I think, I oftentimes find it lacking in practice.
It's hard to match LaTeX's flexibility when it comes to typesetting.

Lately I've been rolling my own solution to this which has been working nicely so far.
It's nothing groundbreaking, just takes some tools and stitches them together.
The general idea is to write out the information you want to report to a text file, then `\input{}` that into your LaTeX document.

Let's take the following super simple example.
Say we're analyzing the `mtcars` dataset in R and want to report a coefficient from a linear model.
We might do something like this (if using R):

```R
slope <- coef(lm(mpg ~ wt, data = mtcars))[2]
slope_char <- sprintf("%.2f", slope)
writeLines(slope_char, "reg-slope.tex")
```

That gets the slope from the super-simple model in the first line, converts it to a character in the second line (don't rely on `round()` to do this!), and writes it out to a file "reg-slope.tex" in the third.
Then, in our tex file, we can simply report it:

```
The slope from this regression is \input{reg-slope}
```

The great thing about this method is that it doesn't require learning anything new or introducing any more dependencies/packages into your workflow.
We can make it more complicated too.
For example, I'm working on a paper right now where I need to report sampler diagnostics from a Bayesian model estimated via MCMC.
Since that goes in the appendix and is mostly numbers, I just wrote the whole appendix section in python:


```python
# Let's use fake numbers:
burnin = 1000
samples = 4000
rhat = 1

report = "The model ran for " + str(samples) + " after " + str(burnin) + ".  The R-hat was " + str(rhat) + "."

with open("sampler-diags.tex", "w") as tex_file:
    print(report, file=tex_file)
```

And then all we need to do to include that in my paper is input it:

```
\section{Sampler diagnostics}\label{sec:sampler-diags}
\input{sampler-diags}
```

And that's it! Now the numbers we report in our paper stay up-to-date with the analysis.
To make that even more certain, you can compile your LaTeX document in a Makefile, which lets you set it up so that your tex file "depends" on your analysis.
So if your analysis files change, make will re-run your analysis before compiling the pdf.
But that's a topic for another day.

[^1]: Please don't tell me you manually type them out.
