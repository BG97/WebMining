#Write a function in R to compute the cosine similarity between a document and a query

#Use:
#library(RTextTools)
library(tm)
library(stringr)
library(sjmisc)
#documents=c("the grey cat is nice","how to feed a cats","dogs make great pets")
#corpus<-create_matrix(documents,removeStopwords = T,stemWords = T)
#corpus<- as.matrix(corpus)
myCorpus <- c("the cat is grey",
              "how to feed a cats",
              "caring for pets")
corpus <- Corpus(VectorSource(myCorpus))
#q1="cats"

#Question 1: Show your results without stemming and stopword removal
td=DocumentTermMatrix(corpus, control = list(removeNumbers = TRUE,
                                             stopwords = FALSE,
                                             stemming = FALSE))

td=as.data.frame(as.matrix(td))
#View result 1
td
#Question 2: Show your results with stemming and stop word removal
td2=DocumentTermMatrix(corpus, control = list(removeNumbers = TRUE,
                                             stopwords = TRUE,
                                             stemming = TRUE
                                             ))

td2=as.data.frame(as.matrix(td2))
#View result 1
td2

#The format of the function should be as follows:
#document <- myCorpus[2]
#document <- 'hardware software '
query <- 'feeding cats'

cosinesim<-function(query,document,StopAndStemming){
  #Your code here 
  corpus <- Corpus(VectorSource(document))
  doc=DocumentTermMatrix(corpus, control = list(removeNumbers = TRUE,
                                                stopwords = StopAndStemming,
                                                stemming = StopAndStemming))
  
  doc=as.data.frame(as.matrix(doc))
  
  corpusq <- Corpus(VectorSource(query))
  query=DocumentTermMatrix(corpusq, control = list(removeNumbers = TRUE,
                                                stopwords = StopAndStemming,
                                                stemming = StopAndStemming))
  
  query=as.data.frame(as.matrix(query))
  
  commonWords=intersect(names(doc),names(query))

  sumOfDocITQueryI = 0

  for(i in commonWords){
    if (str_contains(names(doc),i) && str_contains(names(query),i)){
      sumOfDocITQueryI = sumOfDocITQueryI + doc[i]*query[i]
    }
  }
  sqrtOfsumOfdocumentTerm = sqrt(sum(doc*doc))
  sqrtOfsumOfqueryTerm = sqrt(sum(query*query))
   
  result = sumOfDocITQueryI/(sqrtOfsumOfdocumentTerm*sqrtOfsumOfqueryTerm)
  return(as.numeric(result))  
}
#without stemming and stopword removal
for(i in 1:length(myCorpus)){
  cat("doc", i, "result is", cosinesim(query,myCorpus[i],FALSE), "\n")}
#with stemming and stopword removal
for(i in 1:length(myCorpus)){
  cat("doc", i, "result is", cosinesim(query,myCorpus[i],TRUE), "\n")
}