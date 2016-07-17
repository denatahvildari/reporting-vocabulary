getwd()
setwd("/Users/denatahvildari/Desktop/TextAnalysiswithR/Second experiment")
Needed <- c("tm", "SnowballCC", "qdap", "NLP")   
install.packages(Needed, dependencies=TRUE)
#read documents from the folder 
docs <- file.path ("/Users/denatahvildari/Desktop/TextAnalysiswithR/Second experiment/methodsection-extended")
#Create a corpus of the text documents
docs <- Corpus(DirSource(docs))
#inspect(dtm[1:5, 1000:1005])
#dim(dtm)
#m <- as.matrix(dtm)
#write.csv(m, file = paste("/Users/denatahvildari/Desktop/TextAnalysiswithR/Second experiment", "dtm.csv", sep="/"))
#dtms <- removeSparseTerms(dtm, .99)
#dim(dtms)
#freq <- colSums(as.matrix(dtms))

#meta(docs[[094]], "id")
#writeLines(as.character(docs[[117]]))
#preparing the corpus
##Remove Stopwords
myStopwords <- c(stopwords("english"))#,"arabinose","cation exchange","chromatography type","chromatographic system","disperse","DLS","dynamic light scattering","equilibrium","equivalent","glucuronic acid","glucose","inline","intensity", "signal intensity","mass range","microlitres","offline","outlet","run time", "sample preparation", "sample pre-treatment","Superdex 75","affinity chromatography","charge","column temperature","combustion","blank","fragmentation", "GC-MS", "MQ", "MQ water", " milliq water", "needle wash", "online", "real-time", "peak area", "vacuum", "bar","BEH AMIDE Column", "brand", "manufacturer", " company", "chromeleon","elution volume","formic acid","Kw-803", "limit","oxygen", "O2","polysaccharide","pore size", "poresize","purging", "purge", "flushing","sequence", "elution order","signal","syringe pump","extraction","Hilic","integration","monosaccharide","post column", "post-column","preparation","stationary phase", "column material", "column packing","vial","auto sampler","cellulose","conductivity","distilled water","equipment","fractionation","fucose","inositol","MALLS","reducing","reduction","break disulfide bridges","cm/h", "column oven","duplicate", "in duplo","identification", "annotate","organic acid","silica","stirr","Urea","alditol acetate","drymatter", "DM", "DB", "dry-matter","protocol", "procedure","wavelength", "wave length","wave_length","BEH","Calibration curve","neutral", "non-charged","oven temperature","pascal","Pa"," PDA", "Photo diode array","amide","curve","fraction collector","hydrophobic interaction chromatography", "reverse phase", " RI ", " N2 ", "nitrogen","place", "location","quantification", "area under the curve", " amounts were determined", "quantify", "galacturonic acid","oven","pre-column", "pre column","Superdex 200","agilent","Akta","state","retention time", "elution time", " RT ","UV","Xcalibur","area","dilute","pressure","supernatant","HPSEC","injection volume","minutes","He", "helium","light scattering", "LSD","preparative", "medium scale","uronic acid","phosphate", "PO4","room temperature", "rt","25 degrees","ambient temperature","Thermo scientific","abundance", "amount","occurrence", "quantity","centrifuge","superdex","acetic acid","UHPLC", "UPLC ","ultra high performance", "UHPLC ","filter","purification", "isolation", " purifying","software","anion exchange","RP-UPLC","RP","ion exchange","RI","refractive index","oligosaccharide","pump","calibration","carbopac","methanol","mg/mL","g/mL","C-18","C18","MWCO","molecular mass","molecular weight","dissolve","guard column","HPAEC","heat","CV","column volume","peak","equilibrate", "equilibration","injection","waters","separation","concentration","isocratic","result", "output", " end result", " outcome", "data","volume","Acetonitrile", "AcN","reversed phase", "RP","nanometer", "nm","phase","control", "comparison", "standards", "external standard", "internal standard","mass spectroscopy", "mass spectrometry", " MS","dionex","High performance LC", "HPLC","detection","SEC","size exclusion chromatography","size exclusion","NaOH ","sodium hydroxide","flow rate","linear","size","temperature", "T", "C", "degree celsius","mL/min","mobile phase","eluent","solvent", "eluent","buffer","gas","sugar","carbohydrate","saccharide","gradient","elution profile","detector","mL", "mililitre","pH","acid","water","molar", "M","graph", "chromatogram","sample","specimen","%")
docs <-tm_map(docs, removeWords, myStopwords)
#docs <- tm_map(docs, removePunctuation)
#library(SnowballC)   
#docs <- tm_map(docs, stemDocument)   

#dtm <- DocumentTermMatrix(docs)
#dim(dtm)
#dtms <- removeSparseTerms(dtm, .98) ##max allowed sparsity 0.998
#dim(dtms)
#DF <- as.data.frame(dtms, stringsAsFactors = FALSE)
#write.csv(DF,"dtms.csv")
#Some other 
#"equivalent","ammonia", "catalyst","heater", 
#"equilibrium", "MALLS", "vials", "charge","minutes", "outlet", "resolution", "quality"

#writeLines(as.character(docs[[075]]))

#writeLines(as.character(docs[[075]]))
##convert to lower case
#docs <- tm_map(docs, content_transformer(tolower))
##remove punctuations
#docs <- tm_map(docs, removePunctuation)
##stemming 
#docs <- tm_map(docs, stemDocument)
#dataframe<-data.frame(text=unlist(sapply(docs, `[`, "content")), 
                        #stringsAsFactors=F)
#check_text(docs)
#loading the terms  and creating list of terms. And assugne name to each vectors of the list  
fc <- file("/Users/denatahvildari/Desktop/TextAnalysiswithR/Second experiment/terms and synonymstest.txt")
concept_list <- strsplit(readLines(fc), ",")
names(concept_list) <- sapply (concept_list, function(x) x)

# calculating the count and frequency of terms occurneces of the terms -- terms in the list ( for each vector )
# -- in the textual data 
termco_out <- apply_as_df(docs, termco, match.list = concept_list) 
term_out_m <- termco2mat(termco_out)


zero <- term_out_m [apply (term_out_m, 1, sum) == 0, ]
#write.csv(format(zero, scientific=FALSE), 
 #        file = paste("/Users/denatahvildari/Desktop/TextAnalysiswithR/Second experiment", "resultzero.csv", sep="/"), sep=",")

nonzero <- term_out_m [apply (term_out_m, 1, sum) !=0, ]
#write.csv(format(nonzero, scientific=FALSE), 
 #         file = paste("/Users/denatahvildari/Desktop/TextAnalysiswithR/Second experiment", "result-nonzero.csv", sep="/"), sep=",")
#############################
#############################
#Zip'f law -- long-tail distribution in a corpus 
#termco_out_df <- as.data.frame(term_out_m)
#tdm <- TermDocumentMatrix(termco_out_df) # there are many more clean up steps, but I am simplifying 

#z <- Zipf_plot(term_out_m) 
#class(z)
#Heaps_plot(tdm) # how vocabulary grows as size of text grows
#dtm analysis 
#dtm <- DocumentTermMatrix(docs)
#inspect(dtm)
#t <- MC_tokenizer(dtm)
#dtm2 <- as.matrix(dtm)
#dtm$dimnames$docs
#dt<-rowSums(as.matrix(dtm))
#frequency <- colSums(dtm2)
#frequency <- sort(frequency, decreasing=TRUE)
#head(frequency)
#words <- names(frequency)
#wordcloud(words[1:100], frequency[1:100])
#success example of the approach 
#reut21578 <- system.file("text", "docs", package = "tm") 
#reuters <- Corpus(DirSource(reut21578), readerControl = list(reader = readReut21578XML))
#matches2 <- list( money = c("money", "economic"), c("dena", "denaa"), c("ali", "price"))
#termco_out <- apply_as_df(reuters, termco, match.list = matches2) 
#m<-termco2mat(termco_out)
#plot(termco_out, values = TRUE, high="red")