library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)


consumer_key <- Sys.getenv("TWITTER_API_KEY")
consumer_secret <- Sys.getenv("TWITTER_API_SECRET")

setup_twitter_oauth(consumer_key, consumer_secret)

SPSA <- searchTwitter("#SPSA2016", n = 1500,
                      since = "2016-01-06", until = "2016-01-09")

spsa_text <- sapply(SPSA, function(x) x$getText())

spsa_corpus <- Corpus(VectorSource(spsa_text))

spsa_corpus<- tm_map(spsa_corpus, content_transformer(tolower))
spsa_corpus <- tm_map(spsa_corpus, removePunctuation)
spsa_corpus <- tm_map(spsa_corpus, function(x)removeWords(x,stopwords()))

pal2 <- brewer.pal(8,"Dark2")
wordcloud(spsa_corpus,min.freq=2,max.words=150, random.order=FALSE, colors=pal2)
