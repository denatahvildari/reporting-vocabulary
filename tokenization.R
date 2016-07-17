getwd()
setwd("/Users/denatahvildari/Desktop/TextAnalysiswithR/Second experiment")
Needed <- c("tm", "SnowballCC", "qdap", "NLP")   
install.packages(Needed, dependencies=TRUE)
#read documents from the folder 
docs <- file.path ("/Users/denatahvildari/Desktop/TextAnalysiswithR/Second experiment/methodsection-extended")
#Create a corpus of the text documents
docs <- Corpus(DirSource(docs))
docs<-tm_map(docs, removeWords, stopwords("english"))

##convert to lower case
docs <- tm_map(docs, content_transformer(tolower))
##remove punctuations
docs <- tm_map(docs, removePunctuation)
inspect(docs[2])
##stemming 
docs <- tm_map(docs, stemDocument)



tdm <- TermDocumentMatrix(docs, control = list(removePunctuation = TRUE, stopwords = TRUE))


Docs(tdm)
nDocs(tdm)
nTerms(tdm)
t <-Terms(tdm)
a <- write.csv(t, file = "corpusterms.csv")
a
