#This function requires following packages to be loaded
library(NLP)
library(tm)

#This function cleans the sample data for the SwiftKey Coursera Project
#and returns the corpus, it also removes the profane words from it
cleanData <- function(){
  fCon <- file("Data\\en_US.sample.txt")
  data <- readLines(fCon)
  close(fCon)
  
  #remove all non-english characters from 
  data <- iconv(data, "latin1", "ASCII", sub="")
  
  corpus <- Corpus(VectorSource(data))
  
  removeDecimals <- function(x) {gsub("([0-9]*)\\.([0-9]+)", "\\1 \\2", x)}
  corpus <- tm_map(corpus, removeDecimals)
  corpus <- tm_map(corpus, removeNumbers)
  #We are using data from twitter, so it should contain a lot of Hashtags(#something) lets remove them.
  removeHashtags <- function(x) { gsub("#[a-zA-z0-9]+", "", x)}
  corpus <- tm_map(corpus, removeHashtags)
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, tolower)
  corpus <- tm_map(corpus, removePunctuation)
  
  #profanity words file which is used is downloaded from the following link
  #"https://github.com/RobertJGabriel/Google-profanity-words/blob/master/list.txt"
  fCon <- file("Data\\profanity.words.txt")
  profaneWords <- readLines(fCon)
  close(fCon)
  
  corpus <- tm_map(corpus, removeWords, profaneWords)
  
  return(corpus)
}