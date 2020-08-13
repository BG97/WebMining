#Create a Keyword Sentiment Analyzer

#Tokenize your documents using the Stanford CoreNLP or Apache OpenNLP package (See NLP.R on Moodle)

#Create a function called "sentiment(doc)" that takes a documents as it's input and returns a sentiment score by summing the number of positive and negative words in a document.  The final score=number_of_positive_words - number_of_negative_words.


#Useful functions for this lab:

#tokenizedwords %in% positivewordlist     :  This line will check the individual words membership in the positivewordlist variable.  It returns a boolean vector.
#which(booleanvector)                     :  This function returns the vector locations with TRUE values in a boolean vector
#length(vectorlocations)                  :  This function returns the number of elements in a vector

#Come up with some documents of your own to test
doc<-"This dinner is WONDERFUL"


library(openNLP)
library(openNLPdata)
library(NLP)
library(sjmisc)
library(stringr)

positive_words <- read.delim("positive-words.txt")
negative_words <- read.delim("negative-words.txt")
sentiment<-function(doc,positive_words,negative_words){
  
  s <- as.String(doc)
  
  #Break into sentences
  sent_token_annotator <- Maxent_Sent_Token_Annotator(probs=TRUE)
  a1<-annotate(s,sent_token_annotator)
  #s[a1]
  
  #Break into tokens
  word_token_annotator<-Maxent_Word_Token_Annotator(probs=TRUE)
  
  a2 <- annotate(s, word_token_annotator, a1)
  
  a2w <- subset(a2, type == "word")
  positive = 0
  negative = 0
  #s[a2w]
  for(i in tolower(s[a2w])){
    if (i %in% positive_words[,1]){
      
      positive= positive +1
    }else if (i %in% negative_words[,1]){
      negative= negative+1
    }
  }
  score=positive - negative
  return(score)
  
}

sentiment(doc,positive_words,negative_words)
