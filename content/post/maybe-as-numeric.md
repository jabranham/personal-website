+++
image = ""
math = false
tags = ["r"]
date = "2016-12-06T13:27:56-06:00"
title = "Maybe as Numeric"
+++

I submitted final course grades today. The semester is over, hurrah! 

Of course, getting the grades out of my university's learning management system (we use Canvas) was a pain. It exported to csv, but the first three rows contained some meta-information instead of students' grades. And there were some rows that weren't students. So this meant that when I imported this into R, all the columns in my data.frame were of type character instead of numeric:

~~~R
grades <- data.frame(student = c("","Joe Schmoe","Jane Schmane"),
                     quiz = c("","87","98"))
grades
       student quiz
1
2   Joe Schmoe   87
3 Jane Schmane   98
~~~

Easy solution, though. I can just drop the problematic rows and then run:

```R
library(tidyverse)
map_df(grades, as.numeric)
```

and all will be well, right? 

Wrong. Some of the columns are *actually* character (names, Ids), and will return `NA`s if we try to treat them as numeric. No good. 

One solution, probably easier than what I came up with, would be to just manually run `as.numeric` over the offending columns. But that seemed unsatisfying since that's a lot of manual typing (there were many columns). So I wrote a quick function that only converts character to numeric if the vector is *actually* a numeric.[^1] 

```R
maybe_as_numeric <- function(v){
  if (is.factor(v)) v <- as.character(v)
  if (is(tryCatch(as.numeric(v),
                  warning = function(w) w),
         "warning")){
    return(v)
  } else{
    return(as.numeric(v))
  }
}
```

There's probably a better way to do this[^2], but this seems to work at least for now. Hopefully someone else finds it useful. Now we can `map_df(grades, maybe_as_numeric)` and all goes well. Our secretly-numeric columns are now actually numeric, and we keep important things like students' names and ID's. 

[^1]: "Actually" being defined as `as.numeric` not throwing a warning

[^2]: Update 2017-11-20: Turns out there was a better way. Brendan Apfeld helpfully reminded me that R's way of dealing with strings can be problematic because it secretly stores them as factors. To get around this, I just dumbly convert factors to characters before checking what as.numeric does. 
