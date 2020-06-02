library(stringr)

bigrams <- readRDS("Data\\bigrams.rds")
trigrams <- readRDS("Data\\trigrams.rds")
quadgrams <- readRDS("Data\\quadgrams.rds")
pentagrams <- readRDS("Data\\pentagrams.rds")

GetWordsFromBigrams <- function(inputWords, wordCount)
{
  matchCases <- subset(bigrams, Word_1 == inputWords[wordCount])
  
  #select top three choices form the subset
  words <- na.omit(matchCases[1:15,])$Word_2
  
  return(words)
}

GetWordsFromTrigrams <- function(inputWords, wordCount)
{
  matchCases <- subset(trigrams, Word_1 == inputWords[wordCount-1] &
                                 Word_2 == inputWords[wordCount])
  
  #select top three choices form the subset
  words <- na.omit(matchCases[1:15,])$Word_3
  
  if (length(words) < 15)
  {
    qwords <- GetWordsFromBigrams(inputWords, wordCount)
    words <- unique(c(words, qwords))
  }
  
  return(words)
}

GetWordsFromQuadgrams <- function(inputWords, wordCount)
{
  matchCases <- subset(quadgrams, Word_1 == inputWords[wordCount-2] &
                                  Word_2 == inputWords[wordCount-1] &
                                  Word_3 == inputWords[wordCount])
  
  #select top three choices form the subset
  words <- na.omit(matchCases[1:15,])$Word_4
  
  if (length(words) < 15)
  {
    qwords <- GetWordsFromTrigrams(inputWords, wordCount)
    words <- unique(c(words, qwords))
  }
  
  return(words)
}

GetWordsFromPentagrams <- function(inputWords, wordCount)
{
  matchCases <- subset(quadgrams, Word_1 == inputWords[wordCount-3] &
                                  Word_2 == inputWords[wordCount-2] &
                                  Word_3 == inputWords[wordCount-1] &
                                  Word_4 == inputWords[wordCount])
  
  #select top three choices form the subset
  words <- na.omit(matchCases[1:15,])$Word_5
  
  if (length(words) < 15)
  {
    qwords <- GetWordsFromQuadgrams(inputWords, wordCount)
    words <- unique(c(words, qwords))
  }
  
  return(words)
}

PredictNextWords <- function(inputText)
{
  #split the input into words
  sInput <- strsplit(inputText, " ")
  
  #remove all non alphanumeric characters and convert all words to lower case
  inputWords <- tolower(str_replace_all(unlist(sInput), "[^[:alnum:]]", ""))
  
  wordCount <- length(inputWords)
  
  #now get the next words from n-grams
  if (wordCount >= 4)
  {
    words <- GetWordsFromPentagrams(inputWords, wordCount)
  }
  else if(wordCount == 3)
  {
    words <- GetWordsFromQuadgrams(inputWords, wordCount)
  }
  else if(wordCount == 2)
  {
    words <- GetWordsFromTrigrams(inputWords, wordCount)
  }
  else
  {
    words <- GetWordsFromBigrams(inputWords, wordCount)
  }
  
  if(length(words) == 0)
  {
    words <- "Unable to predict..."
  }
  else
  {
    words <- paste(words, ", ");
  }
  
  # Output
  return(words)
}