library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)
library(stringr)


consumer_key <- Sys.getenv("TWITTER_API_KEY")
consumer_secret <- Sys.getenv("TWITTER_API_SECRET")

setup_twitter_oauth(consumer_key, consumer_secret)

SPSA <- searchTwitter("#SPSA2016", n = 1500,
                      since = "2016-01-06", until = "2016-01-09")

save(SPSA, file = "../data/SPSA-2016-tweets.R")

spsa_text <- sapply(SPSA, function(x) x$getText())

spsa_corpus <- Corpus(VectorSource(spsa_text))

spsa_corpus<- tm_map(spsa_corpus, content_transformer(tolower))
spsa_corpus <- tm_map(spsa_corpus, removePunctuation)
spsa_corpus <- tm_map(spsa_corpus, function(x)removeWords(x,stopwords()))
spsa_corpus <- tm_map(spsa_corpus, function(x)removeWords(x, "spsa2016"))

pal2 <- brewer.pal(8,"Dark2")

jpeg("../image/spsa-wordcloud.jpeg")
wordcloud(spsa_corpus, min.freq = 3,
          random.order = FALSE, colors = pal2)
dev.off()

hashtags <- unlist(str_extract_all(spsa_text, "#\\w+"))
hashtags_freq <- table(hashtags)
conference_tags <- c("#SPSA2016", "#spsa2016")

jpeg("../image/spsa-hashtags.jpeg")
wordcloud(names(hashtags_freq[!names(hashtags_freq) %in% conference_tags]),
          hashtags_freq[!names(hashtags_freq) %in% conference_tags],
          random.order = FALSE, min.freq = 2, colors = pal2)
dev.off()
