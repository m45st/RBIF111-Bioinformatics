

#####################
#### Week 1 code ####
#####################

###################################################
#### Week 1 Notes Part 2 Arithmetics and Types ####
###################################################
######################
#### Code Chunk 1 ####
######################
2 + 2  # comment, ignored by R; command in this line adds 2 and 2

######################
#### Code Chunk 2 ####
######################
72*84
(132+498+274)/23 # use parenthesis to specify order of operations
sqrt(18.5) # square root
sin(72) # sine. Argument is assumed to be in radians
sin(72*pi/180) # sine of 72 degrees (180 degrees equals pi radians)

######################
#### Code Chunk 3 ####
######################
x <- 2 # store value 2 in variable x
y <- 3 # assign 3 to y
x # value of this expression is the value stored in x
y
x+y # adding x and y means adding values stored in them
x*3
x <- 4 # we can store new value in the same variable
x*3 # multiplies current value of x by 3 (cf. above)
# z
# Error: object 'z' not found
z <- (x+y)*2 # can assign any expression, not just a number
z # z is defined now

######################
#### Code Chunk 4 ####
######################
1:10

######################
#### Code Chunk 5 ####
######################
x <- 1
for ( i in 1:3 ) x+i

######################
#### Code Chunk 6 ####
######################
x <- 1
for ( i in 1:3 ) print(x+i)

######################
#### Code Chunk 7 ####
######################
c(1,5,7,2,19,179) # this is a sequence of individual numbers
c(1:5, 19, 3:8) # it is possible to concatenate sequences together

######################
#### Code Chunk 8 ####
######################
plot(1:100/pi,sin(1:100/pi),type="b",col=c("red","green",
                                             "blue"),pch=1:5, xlab="x [rad]",ylab="sin(x)")
######################
#### Code Chunk 9 ####
######################
1:10/pi

##############################################
#### ggplot2: a more powerful alternative ####
##############################################
######################
#### Code Chunk 10 ####
######################
library(ggplot2)
df <- data.frame(x = 1:100/pi, y = sin(1:100/pi))
ggplot(df, aes(x = x, y = y)) +
  geom_point(color = "steelblue") +
  geom_line(color = "firebrick", alpha = 0.5) +
  labs(x = "x [rad]", y = "sin(x)")

######################
#### Code Chunk 11 ####
######################
data(iris)
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
  geom_point()

#######################
#### Code Chunk 12 ####
#######################
mode(1)
mode("abc")
mode(TRUE)
mode(7+5i)
x<-5.5
mode(x)
x<-"text"
mode(x)

#######################
#### Code Chunk 13 ####
#######################
3^1000
-3^1000
1/0

#######################
#### Code Chunk 14 ####
#######################
Inf - Inf # note that we can type Inf as a "value" in a command
3^1000 - 3^1000 # same thing. Subtracting Inf from Inf
0/0

#######################
#### Code Chunk 15 ####
#######################
NA==1 # logical expression: is NA (missing value) equal to 1?
1+NA
max(c(NA, 4, 7)) # max() takes a sequence and returns maximum element
max(c(NA, 4, 7), na.rm=T) # use additional optional argument to max
NA | TRUE
NA & TRUE
sort(c(5,3,NA,7)) # sort() takes a sequence and sorts it
sort(c(5,3,NA,7),na.last=T) # ask sort() to keep NA, not discard them

#######################
#### Code Chunk 16 ####
#######################
NA == NA # no, comparing NA to NA directly does not help
is.na(NA) # this is how we check if an object is NA!!
is.null(NULL) # check if the object/value is NULL
is.nan(NaN) # check if the object/value is NaN
is.infinite(Inf)

##############################################
####  Week 1 Notes Part 2 Data Structures ####
##############################################
######################
#### Code Chunk 1 ####
######################
y <- 2:6; y                 # shortcut for seq(2,6,by=1) - see below
z <- seq(1,1.4,by = 0.1); z # general way to create a sequence

######################
#### Code Chunk 2 ####
######################
x <- c(5.2, 1.7, 6.3); x
# we continue after the example commands shown previously - y was
# defined there!
x.y <- c(x,y); x.y

######################
#### Code Chunk 3 ####
######################
w <- rnorm(5); w

######################
#### Code Chunk 4 ####
######################
length(y); length(1); length(NA); length(NULL)

######################
#### Code Chunk 5 ####
######################
c(NULL, NULL,1,2,NA)

######################
#### Code Chunk 6 ####
######################
clrs <- c("red","blue","gray","pink","cyan"); clrs

######################
#### Code Chunk 7 ####
######################
clrs[1]
j<-1
clrs[j]

######################
#### Code Chunk 8 ####
######################
clrs[2:4]              # can select a subset!!
k<-c(1,3,5); clrs[k]   # subset does not have to be continuous
i <- c(1,1,5); clrs[i] # same element can be extracted multiple
# times if the indexing vector happens to
# have repetitions!
clrs[c(-2,-3)]         # negative index specifies element to EXCLUDE

######################
#### Code Chunk 9 ####
######################
z <- integer(0); length(z) # one way to create an empty vector
clrs[z]                    # empty index selects empty subset!
clrs[6]                    # out of bounds
clrs[c(2,6,3)]             # select subset with one index out of bounds
clrs[c(2,NA,3)]

#######################
#### Code Chunk 10 ####
#######################
y <- 2:6; y                 # create a vector (and print it); this part we know:
names(y) <- clrs; y         # we can assign names to elements! Print and see
y[c("blue","pink","green")] # now we can also access by name

#######################
#### Code Chunk 11 ####
#######################
clrs <- c("red","blue","gray","pink","cyan"); clrs
clrs[c(T,F,F,T,F)]   # selects elements at 'TRUE' positions
clrs[c(T,F,F,T,F,T)] # last T out of bounds: returns NA
clrs[c(T,F,F,T,F,F)]
clrs[c(T,F,F,T,NA)]  # NA is logical!!

#######################
#### Code Chunk 12 ####
#######################
clrs[c(T,F)] # if indexing vector is short, it is recycled!
clrs[T]      # oooops, what happened here?

#######################
#### Code Chunk 13 ####
#######################
x <- c(12,-3,7,-5,6)
x[x>0] # selects only positive elements from x!

#######################
#### Code Chunk 14 ####
#######################
clrs[[2]] # for vectors, it's the same as clrs[2]
# clrs[[c(2,3)]] # cannot use multiple indexes at once with [[ ]] !

#######################
#### Code Chunk 15 ####
#######################
clrs <- c("red","blue","gray","pink","cyan"); clrs
clrs[c(1,3)] <- c("scarlet", "black"); clrs
x<-c(3:8,NA); x
x > 5           # let's just check first what x>5 returns
x[x>5] <- -1; x # NOTE: recycling of right hand side occurred here

#######################
#### Code Chunk 16 ####
#######################
x<-c(3:8,NA); x
x+1:7
x+1:4
exp(x)

#######################
#### Code Chunk 17 ####
#######################
xx <- c(-2:2,NA); xx    # generate a vector to play with
xx > 0                  # element by element comparison; gives T if element is > 0
any(xx > 0)             # is at least one element of xx greater than 0?
all(xx > 0)             # are all elements of xx greater than 0?
any(xx > 2)             # is at least one element of xx greater than 2?
sum(xx > 0)             # sum of all elements of xx
sum(xx > 0, na.rm=TRUE) # number of positive elems in xx, ignoring NA
is.element(0,xx)        # is 0 present among elements of xx?
is.element(c(2,10),xx)  # are 2 and 10 present among elements of xx?
match(c(0,-2,10),xx)    # at what positions do 0, -2, 10 occur in xx?

#######################
#### Code Chunk 18 ####
#######################
yy <- c(3,-3,5,-5,4,4)     # create a vector
sort(yy)                   # sort vector
order(yy)                  # find sorting order for the argument
yy[order(yy)]              # sorting=reshuffling a vector into its sorting order
rev(yy[order(yy)])         # revert the order of the argument
yy[order(yy,decreasing=T)] # reshuffle using decreasing sorting order
sort(yy,decreasing=T)      # same thing, but shorter: just decreasing sort
(xx > -1) & (xx < 2)       # Important! &, not &&! xx from previous snippet
xx[(xx > -1) & (xx < 2) ]

#######################
#### Code Chunk 19 ####
#######################
m <- matrix(1:12, nrow=4, byrow = T); m
y <- -1:2
m.new <- m + y; m.new
mode(m)
class(m)

#######################
#### Code Chunk 20 ####
#######################
m.new                             # this matrix was created in the previous snippet
m.new[,2]                         # all rows, column 2;
m.new[c(1,3),]                    # rows 1,3; all columns
m.new[-c(1,3),]                   # discard rows 1,3; select all columns
m.new[-c(2,4),-c(2,4)]            # discard rows 2,4 and columns 2,4
t(m)                              # transpose, i.e. rows become columns and columns become rows
dim(m)                            # very useful: returns dimensions of a matrix (nrows, ncols)
length(m)                         # What is length of a matrix?? Can you explain this??
rownames(m)                       # rows of matrix m have no names so far...
rownames(m) <- c('a','b','c','d') # assign names to rows of a matrix
colnames(m) <- c('x','y','w')     # assign names to columns

#######################
#### Code Chunk 21 ####
#######################
a <- list()
a[[1]] <- "first el"
a[[2]] <- 2
a[[5]] <- 1:3
a

#######################
#### Code Chunk 22 ####
#######################
b <- list(name="some name",
          num.id=1234,
          some.array=c(5,6,7),
          a.mat=matrix(1:2,nrow=2,ncol=3),
          another.list=list(a="a",b=1))
b[2]                 # "vector"-like access: slice
class(b[2])          # slice is still a list
b[[2]]               # direct element access
class(b[[2]])        # this time we retrieved value
b$num.id             # explicit access by name
b$numid              # there is no 'numid' slot in the list. No error, alas.
b[["num.id"]]        # access by character value, same as b$num.id
z <-"num.id"; b[[z]] # but double-bracket can also use variable!

#######################
#### Code Chunk 23 ####
#######################
m1 <- cbind(age=c(23,43,32),sex=c("M","F","M")) ; m1
class(m1)
mode(m1)

#######################
#### Code Chunk 24 ####
#######################
m2 <- data.frame(age=c(23,43,32),sex=I(c("M","F","M"))) ; m2
class(m2)
mode(m2)
m2$age       # we can use list operator '$' to access dataframe columns
mode(m2$age)
mode(m2$sex)

#######################
#### Code Chunk 25 ####
#######################
m2[1:2,]             # matrix-like access: extract 1st and 2nd rows, all columns
class(m2[1:2,])
m2[,1]; mode(m2[,1]) # select single column using matrix-like access
m2[1,3] <- T         # assign a value into a new column
m2

#######################
#### Code Chunk 26 ####
#######################
dim(m2)
length(m2)
attach(m2); age # tired of typing dataframe's name every time?

#######################
#### Code Chunk 27 (Factors) ####
#######################
s <-c("M","F","M")
f <-as.factor(s); f
as.numeric(s)
as.numeric(f)
levels(f)
as.character(f)
f[3]<-"Z"; f

##############################################
#### Week 1 Notes Part 2 Programming in R ####
##############################################
######################
#### Code Chunk 1 ####
######################
x <-c(3,5)
if ( any(x > 4) ) "apples" else "oranges" # curly braces optional
if ( any(x > 4) ) {                       # multi-line form
  x <- x+3
  print(x)
} else {
  x <- x*2
  print(x)
}

######################
#### Code Chunk 2 ####
######################
if(c(T,F)) { } # empty command to execute, so the result is NULL

######################
#### Code Chunk 3 ####
######################
x<-c(3,5,1,7)
ifelse(x>4,"apples","oranges")

######################
#### Code Chunk 4 ####
######################
for ( i in 1:3 ) print(paste("iteration",i))
i # oooops, i is now defined!
i <- 1; while(i < 4) { print(i); i <- i+1 }

######################
#### Code Chunk 5 ####
######################
my.max <-function ( x, na.rm = F ) {
  x.max <- Inf
  for ( xx in x ) {
    if ( is.na(xx) ) {
      if ( na.rm ) {
        next
      } else {
        return(NA)
      }
    }
    if(xx > x.max) {
      x.max <- xx
    }
  }
  x.max # return value = value of the last command
}

######################
#### Code Chunk 6 ####
######################
# Saving Your Code: once a function is worth keeping, save it in a script
# and re-load it with source() rather than retyping it every session.
# source("my_script.R")

######################
#### Code Chunk 7 ####
######################
my.max(1:10)
my.max(10:1)
my.max(c(1,NA,3))
my.max(c(1,NA,3),T)

######################
#### Code Chunk 8 ####
######################
my.max(na.rm=T,x=c(1,NA,3)) # binding by name: order of arguments no longer matters

######################
#### Code Chunk 9 (Lazy Evaluation) ####
######################
# T || never.defined.function()
# T | never.defined.function() # Can you explain why this does not work?

######################
#### Code Chunk 10 ####
######################
f <- function(x,y=some.function(),z=some.var) {
  if ( x == 0 ) print("DONE")
  if ( x == 1 ) print(y)
  if ( x == 2 ) print(z) }
f(0)
# f(1)
# Error in print(y) : could not find function "some.function"
# f(2)
# Error in print(z) : object 'some.var' not found
some.var <- 3; f(2)

######################
#### Code Chunk 11 (Traditional Loops vs Vector Code) ####
######################
x <- numeric(10000000) # create vector with 10 million elements
system.time(x[] <- 1) # vector assignment, 1 to each element: user system elapsed
system.time(for(i in 1:length(x)) x[i] <- 1)

######################
#### Code Chunk 12 ####
######################
m <-data.frame(A=c(1,2,3), B=c(4,5,6), C=c(7,8,9), D=c(10,11,12)); m
apply(m,MARGIN=1,max)
apply(m,MARGIN=2,function(x) { sum(x^2) } )

###################################################
#### Week 1 Notes Part 2 Packages and Datasets ####
###################################################
######################
#### Code Chunk 1 ####
######################
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("limma")
library(limma)

######################
#### Code Chunk 2 ####
######################
# if (!require("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("ALL")
library(ALL)
data(ALL)

######################
#### Code Chunk 3 ####
######################
ls()

######################
#### Code Chunk 4 ####
######################
x <- numeric(5) # create variable x
ls()            # list objects in the session: x is there...
rm(x)           # delete object x...
ls()            # ...and recheck objects in the current session: x is gone

######################
#### Code Chunk 5 ####
######################
dim(pData(ALL))      # 128 samples (patients), 21 characteristics for each
colnames(pData(ALL)) # what data are available for each patient?
dim(exprs(ALL))      # expression of 12625 genes (rows) measured in 128 patients (columns)
pData(ALL)[1:3,1:5]  # let's take a peek at small part of pData table
exprs(ALL)[1:5,1:3]  # expression data; rows=genes, columns=patients

######################
#### Code Chunk 6 ####
######################
class(ALL) # all is an object of class ExpressionSet
class(pData(ALL)) # pData returns data frame with clinical info
class(pData(ALL)[,1]) # 1st column of clinical info is a char vector
class(pData(ALL)[,"age"]) # column named "age" is a numeric vector
class(pData(ALL)$sex) # data frames (and lists) allow access with '$'
unlist(lapply(pData(ALL)[,1:12],class)) # apply class to each element
table(pData(ALL)[,"sex"])
varMetadata(ALL) # show list of all variables

######################
#### Code Chunk 7 ####
######################
getwd()                     # prints current working directory
# setwd("J:/RBIF 111 Master/Week 1") # change working dir to your local path
write.table(pData(ALL)[1:5,1:5], "ALLtmp.txt", quote=F, sep="\t", col.names=T, row.names=F)
all.tmp <- read.table("ALLtmp.txt",sep="\t", header=T)
all.tmp

######################
#### Code Chunk 8 ####
######################
colnames(pData(ALL))[1:5]              # column names in the original data
colnames(all.tmp)                      # column names in the table we read back: ok
unlist(lapply(pData(ALL)[1:5], class)) # column data types, original
sapply(all.tmp,class)                  # column data types, read back

######################
#### Code Chunk 9 ####
######################
all.tmp$diagnosis <- as.character(all.tmp$diagnosis)

####################################################
#### Week 1 Notes Part 2 Descriptive Statistics ####
####################################################
######################
#### Code Chunk 1 ####
######################
library(ALL)
data(ALL)
table(pData(ALL)$sex)         # count levels (M and F) in column 'sex'
pie(table(pData(ALL)$sex))
table(pData(ALL)$CR)          # tally original remission data for patients
pie(table(pData(ALL)$CR))

######################
#### Code Chunk 2 ####
######################
old.par <- par(ps=20)
stripchart(ALL$age,method="jitter")
stripchart(ALL$age,method="stack",cex.axis=1.5)
stem(ALL$age)
dotchart(ALL$age)
par(old.par)

######################
#### Code Chunk 3 ####
######################
hist(ALL$age)

######################
#### Code Chunk 4 ####
######################
plot(ALL$age,type="p",main="ALL$Age",ylab="Years")
plot(sort(ALL$age),type="p",main="ALL$Age",ylab="Years")
plot(ALL$age,type="h",main="ALL$Age",ylab="Years")

######################
#### Code Chunk 5 ####
######################
mean(1:5); mean(c(1:5,100))
median(1:5); median(c(1:5,100))

######################
#### Code Chunk 6 ####
######################
sd(ALL$age,na.rm=T) # standard deviation of patients' ages in ALL
mad(ALL$age,na.rm=T)

######################
#### Code Chunk 7 ####
######################
range(ALL$age,na.rm=T) # range of all observed values, min to max
IQR(ALL$age,na.rm=T) # interquartile distance

######################
#### Code Chunk 8 ####
######################
quantile(ALL$age,na.rm=T)
boxplot(ALL$age)
boxplot(age~sex,ALL)


########################################################
####  Week 1 Notes Part 3 Downloading Data from GEO ####
########################################################

######################
#### Code Chunk 1 ####
######################
# Install required packages if not already installed:
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("DESeq2")
# BiocManager::install("limma")
# BiocManager::install("GEOquery")
# BiocManager::install("org.Hs.eg.db")
# install.packages("data.table")
# install.packages("DT")
library(DESeq2); library(limma); library(GEOquery)
library(org.Hs.eg.db); library(data.table); library(DT)

######################
#### Code Chunk 2 ####
######################
# GEODataDownload: unified function for downloading RNAseq and Array
# data from GEO. Arguments:
#   DS              - GEO accession number (e.g. "GSE266550")
#   gpl             - Platform accession number (e.g. "GPL18573")
#   gsm             - Binary string indicating sample groups
#                     (0 = Control, 1 = Treatment, X = exclude)
#   PlateAnnotInfo  - Probe-to-gene mapping table (Array only)
#   GenerateMetaData- Not used in current version (Array only placeholder)
#   Technology      - "RNAseq" or "Array"
GEODataDownload <- function(DS, gpl, gsm, PlateAnnotInfo, GenerateMetaData, Technology){
  library(DESeq2); library(limma); library(data.table)
  if(Technology == "Array"){
    gset <- getGEO(DS)
    if(length(gset) > 1) idx <- grep(gpl, attr(gset, "names")) else idx <- 1
    gset <- gset[[idx]]
    fvarLabels(gset) <- make.names(fvarLabels(gset))
    comp <- gsub(" ", "", gsm)
    comp <- gsub(",", "", comp)
    gsms <- paste0(comp)
    sml <- c()
    for(i in 1:nchar(gsms)){ sml[i] <- substr(gsms,i,i)}
    ex <- exprs(gset)
    qx <- as.numeric(quantile(ex, c(0., 0.25, 0.5, 0.75, 0.99, 1.0), na.rm=T))
    LogC <- (qx[5] > 100) ||
      (qx[6]-qx[1] > 50 && qx[2] > 0) ||
      (qx[2] > 0 && qx[2] < 1 && qx[4] < 2)
    if(LogC){ ex[which(ex <= 0)] <- NaN
    exprs(gset) <- log2(ex) }
    sml <- paste("G", sml, sep="")
    f1 <- as.factor(sml)
    gset$description2 <- f1
    design <- model.matrix(~description2 + 0, gset)
    colnames(design) <- levels(f1)
    fit <- lmFit(gset, design)
    cont.matrix <- makeContrasts(G1-G0, levels = design)
    fit2 <- contrasts.fit(fit, cont.matrix)
    fit2 <- eBayes(fit2, 0.01)
    tT <- topTable(fit2, adjust="fdr", sort.by = "B", number = 25000000000)
    ex2 <- data.table(subset(tT, select=c("ID", "logFC", "P.Value", "adj.P.Val")))
    ex2$ID <- as.character(ex2$ID)
    plat <- PlateAnnotInfo[GPLID == gpl,][,!"GPLID", with = FALSE]
    if(nrow(plat) == 0){ print(paste("There is no annotation information available for", gpl)) }
    plat$ID <- as.character(plat$ID)
    plat <- plat[!duplicated(plat$ID),]
    ex2 <- merge(plat, ex2, by = "ID")
    ex2$ID <- as.character(ex2$ID)
    exraw <- data.table(ex)
    exraw$ID <- as.character(rownames(ex))
    ex2 <- merge(ex2, exraw, by = "ID")
    Pdat <- pData(gset)
    Pdat <- as.data.table(Pdat)
    return(list(Data = ex2, MetaData = Pdat))
  }

  if(Technology == "RNAseq"){
    ACC <- paste("acc=", DS, sep = "")
    file <- paste("file=", DS, "_raw_counts_GRCh38.p13_NCBI.tsv.gz", sep = "")
    comp <- gsub(" ", "", gsm)
    comp <- gsub(",", "", comp)
    gsms <- paste0(comp)
    urld <- "https://www.ncbi.nlm.nih.gov/geo/download/?format=file&type=rnaseq_counts"
    path <- paste(urld, ACC, file, sep="&");
    tbl <- as.matrix(data.table::fread(path, header=T, colClasses="integer"), rownames="GeneID")
    exraw <- tbl
    apath <- paste(urld, "type=rnaseq_counts", "file=Human.GRCh38.p13.annot.tsv.gz", sep="&")
    annot <- data.table::fread(apath, header=T, quote="", stringsAsFactors=F, data.table=F)
    rownames(annot) <- annot$GeneID
    sml <- strsplit(gsms, split="")[[1]]
    sel <- which(sml != "X")
    sml <- sml[sel]
    tbl <- tbl[ ,sel]
    gs <- factor(sml)
    groups <- make.names(c("Ctrl", "Tx"))
    levels(gs) <- groups
    sample_info <- data.frame(Group = gs, row.names = colnames(tbl))
    keep <- rowSums( tbl >= 10 ) >= min(table(gs))
    tbl <- tbl[keep, ]
    ds <- DESeqDataSetFromMatrix(countData=tbl, colData=sample_info, design= ~Group)
    ds <- DESeq(ds, test="Wald", sfType="poscount")
    r <- results(ds, contrast=c("Group", groups[2], groups[1]), alpha=0.05, pAdjustMethod ="fdr")
    tT <- r[order(r$padj)[1:length(r$padj)],]
    tT <- merge(as.data.frame(tT), annot, by=0, sort=F)
    tT <- subset(tT, select=c("GeneID","padj","pvalue","lfcSE","stat","log2FoldChange","baseMean","Symbol","Description"))
    ex2 <- data.table(subset(tT, select=c("GeneID", "Symbol", "Description", "log2FoldChange", "pvalue", "padj")))
    setnames(ex2, c("GeneID", "Symbol", "Description"), c("ENTREZID", "SYMBOL", "GENENAME"))
    GeneID <- as.integer(rownames(exraw))
    exraw <- as.data.table(exraw)
    exraw$ENTREZID <- GeneID
    mer <- merge(ex2, exraw, by = "ENTREZID")
    return(mer)
  }
}

######################
#### Code Chunk 3 ####
######################
# Example RNAseq download from GEO accession GSE266550:
# RNAseqData <- GEODataDownload(DS = "GSE266550",
#                               gpl = "GPL18573",
#                               gsm = "1011101100",
#                               PlateAnnotInfo = "Only needed for MicroArrays",
#                               GenerateMetaData = "Only needed for MicroArrays",
#                               Technology = "RNAseq")
# head(RNAseqData)
#
# To access metadata for an RNAseq dataset, navigate to the Accession
# Display page and click the "Run Selector" link, then click "Metadata"
# to download the sample metadata file.

######################
#### Code Chunk 4 ####
######################
# Build probe-to-gene annotation table for Microarray platform GPL570
# (Affymetrix Human Genome U133 Plus 2.0 Array):
# library(GEOquery); library(org.Hs.eg.db)
# z <- getGEO("GPL570")
# PlateAnnotInfo <- as.data.table(z@dataTable@table)
# PlateAnnotInfo <- PlateAnnotInfo[,c("ID", "Gene Symbol", "ENTREZ_GENE_ID"), with = FALSE]
# PlateAnnotInfo$`Gene Symbol` <- gsub(" ///.+", "", PlateAnnotInfo$`Gene Symbol`)
# PlateAnnotInfo$ENTREZ_GENE_ID <- gsub(" ///.+", "", PlateAnnotInfo$ENTREZ_GENE_ID)
# PlateAnnotInfo <- PlateAnnotInfo[!PlateAnnotInfo$`Gene Symbol` == "",]
# setnames(PlateAnnotInfo, c("Gene Symbol", "ENTREZ_GENE_ID"), c("SYMBOL", "ENTREZID"))
# PlateAnnotInfo <- PlateAnnotInfo[!is.na(ENTREZID),]
# PlateAnnotInfo <- PlateAnnotInfo[!ENTREZID == "",]
# PlateAnnotInfo$ENTREZID <- as.character(PlateAnnotInfo$ENTREZID)
# mappings <- AnnotationDbi::select(org.Hs.eg.db,
#               keys=PlateAnnotInfo$ENTREZID,
#               columns=c("GENENAME"), keytype="ENTREZID")
# PlateAnnotInfo <- unique(merge(PlateAnnotInfo, mappings, by="ENTREZID", allow.cartesian=TRUE))
# PlateAnnotInfo <- PlateAnnotInfo[,c("ID", "ENTREZID", "SYMBOL", "GENENAME")]
# PlateAnnotInfo$GPLID <- "GPL570"
# head(PlateAnnotInfo)

######################
#### Code Chunk 5 ####
######################
# Example Microarray download from GEO accession GSE98578:
# ArrayData <- GEODataDownload(DS = "GSE98578",
#                               gpl = "GPL570",
#                               gsm = "011111111111011111111111101110011111101011101101",
#                               PlateAnnotInfo = PlateAnnotInfo,
#                               Technology = "Array")
# names(ArrayData)
# head(ArrayData[["Data"]])    # fold change and statistics table
# head(ArrayData[["MetaData"]]) # sample-level metadata


#####################################################################
####  Week 1 Notes Part 3 Building and Querying a DuckDB/Parquet ####
####  Repository with repoquet ######################################
#####################################################################

######################
#### Code Chunk 1 ####
######################
# install.packages("remotes")
# remotes::install_github("brendangongol/repoquet", force = TRUE, build_vignettes = TRUE)
library(repoquet)
# vignette("repoquet", package = "repoquet")
# browseVignettes("repoquet")

######################
#### Code Chunk 2 ####
######################
# Building the repository is a one-time, disk- and network-heavy setup step
# (it downloads and materializes MIMIC-III, NHANES, UCI, and ClinVar sources,
# surveys their schemas, and writes everything out as Parquet + registers it
# as DuckDB views), so it is shown here fully worked but commented out rather
# than run automatically every time this script is sourced. Run it once,
# yourself, with eval'd (uncommented) code, in its own session.
#
# setwd("Path to Directory where the database will be stored")
# public_example <- generate_real_world_repository( dir = file.path(getwd(), "repoquet_public_example"),
#   profile = c("comprehensive"), # "quick", "relational", "schema_drift", "stress", "comprehensive",
#   IncludeLarge = NULL, Download = FALSE, overwrite = TRUE)
# cfg   <- load_repository_config(public_example$ConfigPath)
# paths <- RepositoryInitialize(cfg$FormattedDBPath)
# RunId <- new_repository_run_id()
# MDT   <- openxlsx::read.xlsx(public_example$MDTPath, sheet = "Sheet1")
# MDT <- MaterializeRemoteSources(MDT = MDT,
#                                 DownloadCachePath = paths$DownloadCachePath,
#                                 Offline = isTRUE(cfg$RemoteOffline),
#                                 DefaultDownloadPolicy = cfg$DownloadPolicy %||% "if_missing",
#                                 TimeoutSeconds = cfg$DownloadTimeout %||% 10800,
#                                 Strict = FALSE,
#                                 LogPath = paths$LogPath, RunId = RunId)
# failed <- MDT[MDT$RemoteCacheStatus == "failed", ]
# MDT    <- MDT[MDT$RemoteCacheStatus != "failed", ]
# TempDirPath <- file.path(cfg$FormattedDBPath, "duckdb_temp")
# dir.create(TempDirPath, recursive = TRUE, showWarnings = FALSE)
# con <- open_duckdb(FormattedDBPath = cfg$FormattedDBPath,
#                    DBName = cfg$DBName,
#                    TempDirPath = TempDirPath,
#                    GB = cfg$DuckDB_GB,
#                    ReadOnly = FALSE)
# completed_checkpoint <- load_checkpoint(paths$CheckpointPath)
# done <- MDT[checkpoint_completed_mask(MDT,
#                                       completed_checkpoint,
#                                       MasterDBPath = cfg$MasterDBPath,
#                                       SourceFingerprintMode = cfg$SourceFingerprintMode ), ]
# if(nrow(done) == 0L && nrow(MDT) > 0L){
#   probe_row     <- MDT[1L, , drop = FALSE]
#   computed_key  <- repository_checkpoint_key(probe_row,
#                                              MasterDBPath = cfg$MasterDBPath,
#                                              SourceFingerprintMode = cfg$SourceFingerprintMode)
#   closest_stored <- grep(paste0("^", probe_row$Database, "\\|\\|", probe_row$TableName, "\\|\\|"),
#                          completed_checkpoint, value = TRUE)
#   cat("Computed key for this MDT row:\n  ", computed_key, "\n\n", sep = "")
#   cat("Closest stored checkpoint entr", if(length(closest_stored)==1L) "y" else "ies", " for the same Database/TableName:\n", sep = "")
#   print(closest_stored)
# }
# register_parquet_view_compile(con = con,
#                               ParquetBasePath = paths$ParquetBasePath,
#                               tables_written = unique(repository_table_names(done)),
#                               TableSchemaPath = paths$TableSchemaPath,
#                               SchemaRegistryPath = paths$SchemaRegistryPath,
#                               validate = TRUE,
#                               strict_validation = TRUE,
#                               LogPath = paths$LogPath,
#                               RunId = RunId)
# contract_results <- validate_data_contracts(con = con,
#                                             DataContractPath = paths$DataContractPath,
#                                             strict = TRUE,
#                                             LogPath = paths$LogPath,
#                                             RunId = RunId)

######################
#### Code Chunk 3 ####
######################
# Once the repository above has been built at least once, GetSchemaObservations()
# can pull just the slice of the recorded schema survey needed for troubleshooting
# one specific column, instead of loading everything. This example first finds a
# real UCI Database/TableName pair from MDT, then looks up which columns of that
# table have recorded observations, then does a fully targeted lookup.
# Find a real UCI Database/TableName pair from the inventory
uci_rows_preview <- MDT[grepl("uci", MDT$Database, ignore.case = TRUE), ]
example_db       <- unique(uci_rows_preview$Database)[1]
example_table    <- unique(uci_rows_preview$TableName)[1]
# See which columns of that table have recorded schema observations
table_observations <- GetSchemaObservations(paths$SchemaObservationPath,
                                            Database = example_db,
                                            TableName = example_table)
example_column <- unique(table_observations$Column)[1]
# Targeted lookup: pull just the observations for that one Database/TableName/Column
Observations <- GetSchemaObservations(paths$SchemaObservationPath,
                     Database = example_db,
                     TableName = example_table,
                     Column = example_column)
Observations[,1:9]

######################
#### Code Chunk 4 ####
######################
# Reconnect read-only before exploring/querying: a read-only connection cannot
# accidentally overwrite a view or drop a table while you are just querying data,
# which matters once several people share the same DuckDB file.
TempDirPath <- file.path(cfg$FormattedDBPath, "duckdb_temp")
dir.create(TempDirPath, recursive = TRUE, showWarnings = FALSE)

if(exists("con") && DBI::dbIsValid(con)){ DBI::dbDisconnect(con, shutdown = TRUE) }
con <- open_duckdb(FormattedDBPath = cfg$FormattedDBPath,
                   DBName = cfg$DBName,
                   TempDirPath = TempDirPath,
                   GB = cfg$DuckDB_GB,
                   ReadOnly = TRUE)

######################
#### Code Chunk 5 ####
######################
# Which data set families ("Databases") are in this repository?
sort(unique(MDT$Database))
# Which tables actually loaded and are queryable in DuckDB right now?
# DBI::dbListTables(con)
tables <- DBViewSummary(con = con, verbose = TRUE, logStatus = FALSE)

######################
#### Code Chunk 6 ####
######################
# Find the UCI-sourced tables that loaded successfully, then inspect one of
# their column names/types with DESCRIBE (schema only, not the actual data):
uci_rows   <- MDT[grepl("uci", MDT$Database, ignore.case = TRUE), ]
uci_tables <- unique(repository_table_names(uci_rows))
uci_tables <- uci_tables[uci_tables %in% DBI::dbListTables(con)]
head(uci_tables, 10)

first_uci_table <- uci_tables[1]
DBI::dbGetQuery(con, paste0("DESCRIBE ", first_uci_table))

######################
#### Code Chunk 7 ####
######################
# Load just the top 5 rows of a UCI table through DuckDB, without pulling the
# full table into R's memory:
top5_uci <- DBI::dbGetQuery(con, paste0("SELECT * FROM ", first_uci_table, " LIMIT 5"))
datatable(top5_uci, options = list(scrollX = TRUE))


###########################################################
####  Week 1 Notes Part 3 SummarizedExperiment Objects ####
###########################################################

######################
#### Code Chunk 1 ####
######################
# Install SummarizedExperiment if needed:
# BiocManager::install("SummarizedExperiment")
library(SummarizedExperiment)

# Set up example count and FPKM matrices.
# Row names = genes; column names = samples.
# Both matrices must share identical row and column names.
RowNames <- c("Gene1","Gene2","Gene3", "gene4", "gene5")
ColNames <- c("Tx_1","Tx_2","Ctrl_1", "Ctrl_2")
countMat <- matrix(sample(1:20, 20), nrow = 5, ncol = 4,
                   dimnames = list(RowNames, ColNames))
countMat
FPKMMat <- matrix(sample(20:40, 20), nrow = 5, ncol = 4,
                  dimnames = list(RowNames, ColNames))
FPKMMat

######################
#### Code Chunk 2 ####
######################
# Set up row metadata (gene-level statistics):
# Row names must match the row names of the count/FPKM matrices.
RowData <- data.frame(
  foldChange = c(1.5, 1.2, 3.5, -2.6, -1.5),
  FDR        = c(0.13, 0.0052, 0.4, 0.025, 0.00487)
)
row.names(RowData) <- RowNames
RowData

######################
#### Code Chunk 3 ####
######################
# Set up column metadata (sample-level information):
# Row names must match the column names of the count/FPKM matrices.
Coldata <- data.frame(
  Sex       = c("M", "F", "F", "M"),
  BMI       = c(1.3, 2.6, 15.6, 14.3),
  Treatment = c("Tx", "Tx", "Ctrl", "Ctrl")
)
row.names(Coldata) <- ColNames
Coldata

######################
#### Code Chunk 4 ####
######################
# Verify alignment between matrix dimensions and metadata dimensions:
identical(rownames(Coldata), colnames(countMat))
identical(rownames(Coldata), colnames(FPKMMat))

######################
#### Code Chunk 5 ####
######################
# Construct the SummarizedExperiment object:
SE <- SummarizedExperiment(
  assays  = list(counts = countMat, FPKM = FPKMMat),
  rowData = RowData,
  colData = Coldata
)
SE

######################
#### Code Chunk 6 ####
######################
# Accessing assay matrices:
assays(SE)             # list all assay slots
assays(SE)[["counts"]] # access the counts matrix
assays(SE)[["FPKM"]]   # access the FPKM matrix

######################
#### Code Chunk 7 ####
######################
# Accessing metadata:
colData(SE) # sample-level metadata
rowData(SE) # gene-level metadata

######################
#### Code Chunk 8 ####
######################
# Accessing specific rows from an assay:
assays(SE)[["counts"]][1,] # first gene, all samples
assays(SE)[["FPKM"]][1,]   # first gene, FPKM values

######################
#### Code Chunk 9 ####
######################
# Subsetting by column metadata (sample-level filter):
SEsub <- SE[, colData(SE)$Treatment == "Tx"]  # keep only treatment samples
assays(SEsub)[["counts"]]

SEsub <- SE[, colData(SE)$Sex == "M"]         # keep only male samples
assays(SEsub)[["counts"]]

colData(SE)$BMI                                # access a single metadata column

######################
#### Code Chunk 10 ####
######################
# Subsetting by row metadata (gene-level filter):
SEsub <- SE[rowData(SE)$foldChange > 1.2, ]   # keep genes with FC > 1.2
assays(SEsub)[["counts"]]

