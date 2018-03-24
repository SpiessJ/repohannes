

#Loading required R packages
library(stringi) # stats files
library(NLP)
library(openNLP)
library(tm) # Text mining
library(rJava)
library(RWeka) # tokenizer - create unigrams, bigrams, trigrams
library(RWekajars)
library(SnowballC) # Stemming
library(RColorBrewer) # Color palettes
library(qdap)
library(ggplot2) #visualization


#Set working directory
setwd("C:/Users/spiessj/Documents/WordPredictionJS/data")

#Read files
blogsURL <-
  file("en_US.blogs.txt", open = "rb") # open for reading in binary mode
blogs <- readLines(blogsURL, encoding = "UTF-8", skipNul = TRUE)

newsURL <-
  file("en_US.news.txt", open = "rb") # open for reading in binary mode
news <- readLines(newsURL, encoding = "UTF-8", skipNul = TRUE)

twitterURL <-
  file("en_US.twitter.txt", open = "rb") # open for reading in binary mode
twitter <- readLines(twitterURL, encoding = "UTF-8", skipNul = TRUE)

#Sampling 5000 records per file and writing output file
set.seed(171282)
sTwitter <- sample(twitter, size = 5000, replace = TRUE)
sBlogs <- sample(blogs, size = 5000, replace = TRUE)
sNews <- sample(news, size = 5000, replace = TRUE)
sampleTotal <- c(sTwitter, sBlogs, sNews)
length(sampleTotal)
writeLines(sampleTotal, "./SAMPLE.txt")

#Read back in sample and create corpus

textCon <- file("./SAMPLE.txt")
textCorpus <- readLines(textCon)
textCorpus <-
  Corpus(VectorSource(textCorpus)) # TM reading the text as lists

textCorpus <- tm_map(textCorpus, tolower) # transform to lower case
textCorpus <-
  tm_map(textCorpus, removePunctuation) # remove punctuations
textCorpus <- tm_map(textCorpus, removeNumbers) # remove numbers
textCorpus <-
  tm_map(textCorpus, stripWhitespace) # remove blank spaces
textCorpus <-
  tm_map(textCorpus, PlainTextDocument) #generate plain text
textCorpus <-
  tm_map(textCorpus, removeWords, stopwords("english")) #remove engl.stopwords


#Convert corpus into plain text document and save resulting corpus
textCorpus <- tm_map(textCorpus, PlainTextDocument)
saveRDS(textCorpus, file = "./Corpus.RData")
CorpusMem <- readRDS("./Corpus.RData")

#Tokenization: Unigrams
unigram <-
  NGramTokenizer(CorpusMem,
                 Weka_control(
                   min = 1,
                   max = 1,
                   delimiters = " \\r\\n\\t.,;:\"()?!"
                 ))
unigram <- data.frame(table(unigram))
unigram <- unigram[order(unigram$Freq, decreasing = TRUE), ]
names(unigram) <- c("word1", "freq")
unigram$word1 <- as.character(unigram$word1)
write.csv(unigram[unigram$freq > 1, ], "unigram.csv", row.names = F)
unigram <- read.csv("unigram.csv", stringsAsFactors = F)
saveRDS(unigram, file = "unigram.RData")

#Tokenization: Bigrams

bigram <-
  NGramTokenizer(CorpusMem,
                 Weka_control(
                   min = 2,
                   max = 2,
                   delimiters = " \\r\\n\\t.,;:\"()?!"
                 ))
bigram <- data.frame(table(bigram))
bigram <- bigram[order(bigram$Freq, decreasing = TRUE), ]
names(bigram) <- c("words", "freq")
bigram$words <- as.character(bigram$words)
str2 <- strsplit(bigram$words, split = " ")
bigram <- transform(bigram,
                    one = sapply(str2, "[[", 1),
                    two = sapply(str2, "[[", 2))
bigram <-
  data.frame(
    word1 = bigram$one,
    word2 = bigram$two,
    freq = bigram$freq,
    stringsAsFactors = FALSE
  )
write.csv(bigram[bigram$freq > 1, ], "bigram.csv", row.names = F)
bigram <- read.csv("bigram.csv", stringsAsFactors = F)
saveRDS(bigram, "bigram.RData")

#Tokenization: Trigrams

trigram <-
  NGramTokenizer(CorpusMem,
                 Weka_control(
                   min = 3,
                   max = 3,
                   delimiters = " \\r\\n\\t.,;:\"()?!"
                 ))
trigram <- data.frame(table(trigram))
trigram <- trigram[order(trigram$Freq, decreasing = TRUE), ]
names(trigram) <- c("words", "freq")
trigram$words <- as.character(trigram$words)
str3 <- strsplit(trigram$words, split = " ")
trigram <- transform(
  trigram,
  one = sapply(str3, "[[", 1),
  two = sapply(str3, "[[", 2),
  three = sapply(str3, "[[", 3)
)
trigram <- data.frame(
  word1 = trigram$one,
  word2 = trigram$two,
  word3 = trigram$three,
  freq = trigram$freq,
  stringsAsFactors = FALSE
)
write.csv(trigram[trigram$freq > 1, ], "trigram.csv", row.names = F)
trigram <- read.csv("trigram.csv", stringsAsFactors = F)
saveRDS(trigram, "trigram.RData")

#Tokenization: Quadgrams

quadgram <-
  NGramTokenizer(CorpusMem,
                 Weka_control(
                   min = 4,
                   max = 4,
                   delimiters = " \\r\\n\\t.,;:\"()?!"
                 ))
quadgram <- data.frame(table(quadgram))
quadgram <- quadgram[order(quadgram$Freq, decreasing = TRUE), ]
names(quadgram) <- c("words", "freq")
quadgram$words <- as.character(quadgram$words)
str4 <- strsplit(quadgram$words, split = " ")
quadgram <- transform(
  quadgram,
  one = sapply(str4, "[[", 1),
  two = sapply(str4, "[[", 2),
  three = sapply(str4, "[[", 3),
  four = sapply(str4, "[[", 4)
)
quadgram <- data.frame(
  word1 = quadgram$one,
  word2 = quadgram$two,
  word3 = quadgram$three,
  word4 = quadgram$four,
  freq = quadgram$freq,
  stringsAsFactors = FALSE
)
write.csv(quadgram[quadgram$freq > 1, ], "quadgram.csv", row.names = F)
quadgram <- read.csv("quadgram.csv", stringsAsFactors = F)
saveRDS(quadgram, "quadgram.RData")
