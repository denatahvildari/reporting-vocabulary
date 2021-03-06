#read documents from the folder 
d <- file.path ("/Users/denatahvildari/Desktop/TextAnalysiswithR/Second experiment/methodsection-extended")
dir(d)
#Create a corpus of the text documents
dc <- Corpus(DirSource(d))
writeLines(as.character(dc[[001]]))
meta(dc[[001]], "id")

dc <- tm_map(dc, removePunctuation)
myStopwords <- c(stopwords("english"),"arabinose","cation exchange","chromatography type","chromatographic system","disperse","DLS","dynamic light scattering","equilibrium","equivalent","glucuronic acid","glucose","inline","intensity", "signal intensity","mass range","microlitres","offline","outlet","run time", "sample preparation", "sample pre-treatment","Superdex 75","affinity chromatography","charge","column temperature","combustion","blank","fragmentation", "GC-MS", "MQ", "MQ water", " milliq water", "needle wash", "online", "real-time", "peak area", "vacuum", "bar","BEH AMIDE Column", "brand", "manufacturer", " company", "chromeleon","elution volume","formic acid","Kw-803", "limit","oxygen", "O2","polysaccharide","pore size", "poresize","purging", "purge", "flushing","sequence", "elution order","signal","syringe pump","extraction","Hilic","integration","monosaccharide","post column", "post-column","preparation","stationary phase", "column material", "column packing","vial","auto sampler","cellulose","conductivity","distilled water","equipment","fractionation","fucose","inositol","MALLS","reducing","reduction","break disulfide bridges","cm/h", "column oven","duplicate", "in duplo","identification", "annotate","organic acid","silica","stirr","Urea","alditol acetate","drymatter", "DM", "DB", "dry-matter","protocol", "procedure","wavelength", "wave length","wave_length","BEH","Calibration curve","neutral", "non-charged","oven temperature","pascal","Pa"," PDA", "Photo diode array","amide","curve","fraction collector","hydrophobic interaction chromatography", "reverse phase", " RI ", " N2 ", "nitrogen","place", "location","quantification", "area under the curve", " amounts were determined", "quantify", "galacturonic acid","oven","pre-column", "pre column","Superdex 200","agilent","Akta","state","retention time", "elution time", " RT ","UV","Xcalibur","area","dilute","pressure","supernatant","HPSEC","injection volume","minutes","He", "helium","light scattering", "LSD","preparative", "medium scale","uronic acid","phosphate", "PO4","room temperature", "rt","25 degrees","ambient temperature","Thermo scientific","abundance", "amount","occurrence", "quantity","centrifuge","superdex","acetic acid","UHPLC", "UPLC ","ultra high performance", "UHPLC ","filter","purification", "isolation", " purifying","software","anion exchange","RP-UPLC","RP","ion exchange","RI","refractive index","oligosaccharide","pump","calibration","carbopac","methanol","mg/mL","g/mL","C-18","C18","MWCO","molecular mass","molecular weight","dissolve","guard column","HPAEC","heat","CV","column volume","peak","equilibrate", "equilibration","injection","waters","separation","concentration","isocratic","result", "output", " end result", " outcome", "data","volume","Acetonitrile", "AcN","reversed phase", "RP","nanometer", "nm","phase","control", "comparison", "standards", "external standard", "internal standard","mass spectroscopy", "mass spectrometry", " MS","dionex","High performance LC", "HPLC","detection","SEC","size exclusion chromatography","size exclusion","NaOH ","sodium hydroxide","flow rate","linear","size","temperature", "T", "C", "degree celsius","mL/min","mobile phase","eluent","solvent", "eluent","buffer","gas","sugar","carbohydrate","saccharide","gradient","elution profile","detector","mL", "mililitre","pH","acid","water","molar", "M","graph", "chromatogram","sample","specimen","%")
docs <-tm_map(dc, removeWords, myStopwords)
dc <- tm_map(dc, removeNumbers) 
#library(SnowballC)   
#dc <- tm_map(dc, stemDocument)
dc <- tm_map(dc, PlainTextDocument)
dc <- tm_map(dc, stripWhitespace)
writeLines(as.character(dc[[001]]))
dt<- DocumentTermMatrix(dc)
dt<- as.matrix(dt)
write.csv (format(dt, scientific=FALSE), file = paste("/Users/denatahvildari/Desktop/TextAnalysiswithR/Second experiment", "dt.csv", sep="/"), sep=",")



inspect(dt[1:2,1:10])

freq <- colSums(as.matrix(dt))  
length(freq)

findFreqTerms(dt, 2, 100)
dt$dimnames$Docs =="1001.txt"
findFreqTerms(dt[dt$dimnames$Docs == "001"], 2, 100)

list_freqs <- lapply(dt$dimnames$Docs, 
                     function(i) findFreqTerms(dt[dt$dimnames$Docs == i], 2, 100))


L <- list_freqs
cfun <- function(L) {
  pad.na <- function(x,len) {
    c(x,rep(NA,len-length(x)))
  }
  maxlen <- max(sapply(L,length))
  do.call(data.frame,lapply(L,pad.na,len=maxlen))
}
# make dataframe of words (but probably you want words as rownames and cells with counts?)
tab_freqa <- cfun(L)













#rm(dts)
dim(dt)
m <- as.matrix(dt)
#write.csv(m, file = paste("/Users/denatahvildari/Desktop/TextAnalysiswithR/Second experiment", "dtm.csv", sep="/"))
dts <- removeSparseTerms(dt, .98)

summary(dt)
dim(dts)

n_tokens <- sum(as.matrix(dts))
n_types <- length(dts$dimnames$Terms)
n_types / n_tokens



