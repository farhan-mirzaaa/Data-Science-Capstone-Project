options(java.parameters = "-Xmx2048m")

library(RWeka)
library(tidyr)

WriteNGramsRDS <- function(corpus)
{
  #unigram <- NGramTokenizer(corpus, Weka_control(min = 1, max = 1))
  #unigram <- data.frame(table(unigram))
  #unigram <- unigram[unigram$Freq>=10, ] #remove less frequent terms
  #unigram <- unigram[order(-unigram$Freq),]
  #names(unigram) <- c("Word_1", "Freq")
  
  #na.omit(unigram)
  #print(nrow(unigram))
  #print(head(unigram))
  #saveRDS(unigram, "Data\\unigrams.rds")
  #rm(unigram)
  
  bigram <- NGramTokenizer(corpus, Weka_control(min = 2, max = 2))
  bigram <- data.frame(table(bigram))
  bigram <- bigram[bigram$Freq>=10, ] #remove less frequent terms
  bigram <- bigram[order(-bigram$Freq),]
  bigram <- separate(bigram, bigram, c("Word_1", "Word_2"), " ")
  
  na.omit(bigram)
  print(nrow(bigram))
  #print(head(bigram))
  saveRDS(bigram, "Data\\bigrams.rds")
  rm(bigram)
  
  trigram <- NGramTokenizer(corpus, Weka_control(min = 3, max = 3))
  trigram <- data.frame(table(trigram))
  trigram <- trigram[trigram$Freq>=4, ] #remove less frequent terms
  trigram <- trigram[order(-trigram$Freq),]
  trigram <- separate(trigram, trigram, c("Word_1", "Word_2", "Word_3"), " ")
  
  na.omit(trigram)
  print(nrow(trigram))
  #print(head(trigram))
  saveRDS(trigram, "Data\\trigrams.rds")
  rm(trigram)
  
  quadgram <- NGramTokenizer(corpus, Weka_control(min = 4, max = 4))
  quadgram <- data.frame(table(quadgram))
  quadgram <- quadgram[quadgram$Freq>=3, ] #remove less frequent terms
  quadgram <- quadgram[order(-quadgram$Freq),]
  quadgram <- separate(quadgram, quadgram, c("Word_1", "Word_2", "Word_3", "Word_4"), " ")
  
  na.omit(quadgram)
  print(nrow(quadgram))
  #print(head(quadgram))
  saveRDS(quadgram, "Data\\quadgrams.rds")
  rm(quadgram)
  
  pentagram <- NGramTokenizer(corpus, Weka_control(min = 5, max = 5))
  pentagram <- data.frame(table(pentagram))
  pentagram <- pentagram[pentagram$Freq>=2, ] #remove less frequent terms
  pentagram <- pentagram[order(-pentagram$Freq),]
  pentagram <- separate(pentagram, pentagram, c("Word_1", "Word_2", "Word_3", "Word_4", "Word_5"), " ")
  
  na.omit(pentagram)
  print(nrow(pentagram))
  #print(head(pentagram))
  saveRDS(pentagram, "Data\\pentagrams.rds")
  rm(pentagram)
}