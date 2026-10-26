# R code from vignette source 'Introduction_into_R.Rnw'

#################################################
# code chunk number 1: Getting Around 1 (eval = FALSE)
#################################################
object <- ...

#################################################
# code chunk number 2: Getting Around 2 (eval = FALSE)
#################################################
ls()

#################################################
# code chunk number 3: Getting Around 3 (eval = FALSE)
#################################################
dir()

#################################################
# code chunk number 4: Getting Around 4 (eval = FALSE)
#################################################
getwd()

#################################################
# code chunk number 5: Getting Around 5 (eval = FALSE)
#################################################
setwd("/home/user")

#################################################
# code chunk number 6: Basic Syntax 1 (eval = FALSE)
#################################################
object <- function_name(arguments)
object <- object[arguments]

#################################################
# code chunk number 7: Basic Syntax 2 (eval = FALSE)
#################################################
?function_name

#################################################
# code chunk number 8: Basic Syntax 3 (eval = FALSE)
#################################################
library("my_library")

#################################################
# code chunk number 9: Basic Syntax 4 (eval = FALSE)
#################################################
library(help="my_library")

#################################################
# code chunk number 10: Basic Syntax 5 (eval = FALSE)
#################################################
vignette("my_library")

#################################################
# code chunk number 11: Executing R Scripts (eval = FALSE)
#################################################
source("my_script.R")

#################################################
# code chunk number 12: Data Types I 1
#################################################
x <- c(1, 2, 3); x
is.numeric(x)
as.character(x)

###################################################
### code chunk number 13: Data Types I 2
###################################################
x <- c("1", "2", "3"); x
is.character(x)
as.numeric(x)

###################################################
### code chunk number 14: Data Types II 1
###################################################
c(1, "b", 3)

###################################################
### code chunk number 15: Data Types II 2
###################################################
x <- 1:10 < 5
x
!x
which(x) # Returns index for the 'TRUE' values in logical vector

###################################################
### code chunk number 16: Data Objects I 1
###################################################
myVec <- 1:10; names(myVec) <- letters[1:10]
myVec[1:5]
myVec[c(2,4,6,8)]
myVec[c("b", "d", "f")]

###################################################
### code chunk number 17: Data Objects I 2
###################################################
factor(c("dog", "cat", "mouse", "dog", "dog", "cat"))

###################################################
### code chunk number 18: Data Objects II 1
###################################################
myMA <- matrix(1:30, 3, 10, byrow = TRUE)
class(myMA)
myMA[1:2,]

###################################################
### code chunk number 19: Data Objects II 1
###################################################
myDF <- data.frame(Col1=1:10, Col2=10:1)
myDF[1:2, ]

###################################################
### code chunk number 20: Data Objects III 1
###################################################
myL <- list(name="Fred", wife="Mary", no.children=3, child.ages=c(4,7,9))
myL
myL[[4]][1:2]

###################################################
### code chunk number 21: Data Objects III 2 (eval = FALSE)
###################################################
## myfct <- function(arg1, arg2, ...) {
## 	function_body
## }

###################################################
### code chunk number 22: General Subsetting Rules 1
###################################################
myVec <- 1:26; names(myVec) <- LETTERS
myVec[1:4]

###################################################
### code chunk number 23: General Subsetting Rules 2
###################################################
myLog <- myVec > 10
myVec[myLog]

###################################################
### code chunk number 24: General Subsetting Rules 3
###################################################
myVec[c("B", "K", "M")]

###################################################
### code chunk number 25: General Subsetting Rules 4
###################################################
iris$Species[1:8]

###################################################
### code chunk number 26: Basic Operators and Calculations 1
###################################################
c(1, 2, 3)
x <- 1:3; y <- 101:103
c(x, y)

###################################################
### code chunk number 27: Basic Operators and Calculations 1
###################################################
ma <- cbind(x, y)
ma
rbind(ma, ma)

###################################################
### code chunk number 28: Basic Operators and Calculations 1
###################################################
length(iris$Species)
dim(iris)

###################################################
### code chunk number 29: Basic Operators and Calculations 1
###################################################
rownames(iris)[1:8]
colnames(iris)

###################################################
### code chunk number 30: Basic Operators and Calculations 1
###################################################
names(myVec)
names(myL)

###################################################
### code chunk number 31: Basic Operators and Calculations 1
###################################################
sort(10:1)

###################################################
### code chunk number 32: Basic Operators and Calculations 1
###################################################
sortindex <- order(iris[,1], decreasing = FALSE)
sortindex[1:12]
iris[sortindex,][1:2,]
sortindex <- order(-iris[,1]) # Same as decreasing=TRUE

###################################################
### code chunk number 33: Basic Operators and Calculations 1
###################################################
iris[order(iris$Sepal.Length, iris$Sepal.Width),][1:2,]

###################################################
### code chunk number 34: Basic Operators and Calculations 1
###################################################
1==1

###################################################
### code chunk number 35: Basic Operators and Calculations 1
###################################################
x <- 1:10; y <- 10:1
x > y & x > 5

###################################################
### code chunk number 36: Basic Operators and Calculations 1
###################################################
x + y
sum(x)
mean(x)
apply(iris[1:6,1:3], 1, mean)

###################################################
### code chunk number 37: Reading and Writing External Data 1 (eval = FALSE)
###################################################
## myDF <- read.delim("myData.xls", sep="\t")

###################################################
### code chunk number 38: Reading and Writing External Data 2 (eval = FALSE)
###################################################
## write.table(myDF, file="myfile.xls", sep="\t", quote=FALSE, col.names=NA)

###################################################
### code chunk number 39: Reading and Writing External Data 3 (eval = FALSE)
###################################################
## ## On Windows/Linux systems:
## read.delim("clipboard")
## ## On Mac OS X systems:
## read.delim(pipe("pbpaste"))

###################################################
### code chunk number 40: Reading and Writing External Data 4 (eval = FALSE)
###################################################
## ## On Windows/Linux systems:
## write.table(iris, "clipboard", sep="\t", col.names=NA, quote=F)
## ## On Mac OS X systems:
## zz <- pipe('pbcopy', 'w')
## write.table(iris, zz, sep="\t", col.names=NA, quote=F)
## close(zz)

###################################################
### code chunk number 41: Scatter Plot Exercise
###################################################
class(iris)
dim(iris)
colnames(iris)

###################################################
### code chunk number 42: Great R Functions 1
###################################################
length(iris$Sepal.Length)
length(unique(iris$Sepal.Length))

###################################################
### code chunk number 43: Great R Functions 2
###################################################
table(iris$Species)

###################################################
### code chunk number 44: Great R Functions 3
###################################################
aggregate(iris[,1:4], by=list(iris$Species), FUN=mean, na.rm=TRUE)

###################################################
### code chunk number 45: Great R Functions 4
###################################################
month.name %in% c("May", "July")

###################################################
### code chunk number 46: Great R Functions 5
###################################################
frame1 <- iris[sample(1:length(iris[,1]), 30), ]
frame1[1:2,]
dim(frame1)
my_result <- merge(frame1, iris, by.x = 0, by.y = 0, all = TRUE)
dim(my_result)

###################################################
### code chunk number 47: Introduction_into_R.Rnw:658-660
###################################################
set.seed(1410)
y <- matrix(runif(30), ncol=3, dimnames=list(letters[1:10], LETTERS[1:3]))

###################################################
### code chunk number 48: Introduction_into_R.Rnw:664-665
###################################################
plot(y[,1], y[,2])

###################################################
### code chunk number 49: Introduction_into_R.Rnw:680-681
###################################################
pairs(y)

###################################################
### code chunk number 50: Introduction_into_R.Rnw:693-695
###################################################
plot(y[,1], y[,2], pch=20, col="red", main="Symbols and Labels")
text(y[,1]+0.03, y[,2], rownames(y))

###################################################
### code chunk number 51: Show labels (eval = FALSE)
###################################################
## plot(y[,1], y[,2], type="n", main="Plot of Labels")
## text(y[,1], y[,2], rownames(y))

###################################################
### code chunk number 52: Plotting parameters (eval = FALSE)
###################################################
## grid(5, 5, lwd = 2)
## op <- par(mar=c(8,8,8,8), bg="lightblue")
## plot(y[,1], y[,2], type="p", col="red", cex.lab=1.2, cex.axis=1.2,
##      cex.main=1.2, cex.sub=1, lwd=4, pch=20, xlab="x label",
##      ylab="y label", main="My Main", sub="My Sub")
## par(op)

###################################################
### code chunk number 53: Regression line (eval = FALSE)
###################################################
## plot(y[,1], y[,2])
## myline <- lm(y[,2]~y[,1]); abline(myline, lwd=2)
## summary(myline)

###################################################
### code chunk number 54: Log scale (eval = FALSE)
###################################################
## plot(y[,1], y[,2], log="xy")

###################################################
### code chunk number 55: Math expression (eval = FALSE)
###################################################
## plot(y[,1], y[,2]); text(y[1,1], y[1,2],
##      expression(sum(frac(1,sqrt(x^2*pi)))), cex=1.3)

###################################################
### code chunk number 56: Scatter Plot Exercise
###################################################
class(iris)
iris[1:4,]
table(iris$Species)

###################################################
### code chunk number 57: Introduction_into_R.Rnw:776-777
###################################################
plot(y[,1], type="l", lwd=2, col="blue")

###################################################
### code chunk number 58: Introduction_into_R.Rnw:791-799
###################################################
split.screen(c(1,1));
plot(y[,1], ylim=c(0,1), xlab="Measurement", ylab="Intensity", type="l", lwd=2, col=1)
for(i in 2:length(y[1,])) {
	screen(1, new=FALSE)
	plot(y[,i], ylim=c(0,1), type="l", lwd=2, col=i, xaxt="n", yaxt="n", ylab="",
             xlab="", main="", bty="n")
}
close.screen(all=TRUE)

###################################################
### code chunk number 59: Introduction_into_R.Rnw:811-815
###################################################
barplot(y[1:4,], ylim=c(0, max(y[1:4,])+0.3), beside=TRUE,
        legend=letters[1:4])
text(labels=round(as.vector(as.matrix(y[1:4,])),2), x=seq(1.5, 13, by=1)
     +sort(rep(c(0,1,2), 4)), y=as.vector(as.matrix(y[1:4,]))+0.04)

###################################################
### code chunk number 60: Introduction_into_R.Rnw:827-830
###################################################
bar <- barplot(m <- rowMeans(y) * 10, ylim=c(0, 10))
stdev <- sd(t(y))
arrows(bar, m, bar, m + stdev, length=0.15, angle = 90)

###################################################
### code chunk number 61: Introduction_into_R.Rnw:842-843
###################################################
hist(y, freq=TRUE, breaks=10)

###################################################
### code chunk number 62: Introduction_into_R.Rnw:855-856
###################################################
plot(density(y), col="red")

###################################################
### code chunk number 63: Introduction_into_R.Rnw:868-871
###################################################
pie(y[,1], col=rainbow(length(y[,1]), start=0.1, end=0.8), clockwise=TRUE)
legend("topright", legend=row.names(y), cex=1.3, bty="n", pch=15, pt.cex=1.8,
col=rainbow(length(y[,1]), start=0.1, end=0.8), ncol=1)

###################################################
### code chunk number 64: Palette
###################################################
palette()
palette(rainbow(5, start=0.1, end=0.2))
palette()
palette("default")

###################################################
### code chunk number 65: Grays
###################################################
gray(seq(0.1, 1, by= 0.2))

###################################################
### code chunk number 66: Gradients (eval = FALSE)
###################################################
## library(gplots)
## colorpanel(5, "darkblue", "yellow", "white")

###################################################
### code chunk number 67: file (eval = FALSE)
###################################################
## pdf("test.pdf"); plot(1:10, 1:10); dev.off()

###################################################
### code chunk number 68: file (eval = FALSE)
###################################################
## library("RSvgDevice"); devSVG("test.svg"); plot(1:10, 1:10); dev.off()

###################################################
### code chunk number 69: Bar Plot Exercise
###################################################
class(iris)
iris[1:4,]
table(iris$Species)

###################################################
### code chunk number 70: Exercise 4.1
###################################################
## Import molecular weight table
my_mw <- read.delim(file="MolecularWeight_tair7.xls", header=T, sep="\t")
my_mw[1:2,]
## Import subcelluar targeting table
my_target <- read.delim(file="TargetP_analysis_tair7.xls", header=T, sep="\t")
my_target[1:2,]

###################################################
### code chunk number 71: Exercise 4.2 (eval = FALSE)
###################################################
## ## Online import of molecular weight table
## my_mw <- read.delim(file="http://faculty.ucr.edu/~tgirke/Documents/R_BioCond/Samples/MolecularWeight_tair7.xls", header=T, sep="\t")
## ## Online import of subcelluar targeting table
## my_target <- read.delim(file="http://faculty.ucr.edu/~tgirke/Documents/R_BioCond/Samples/TargetP_analysis_tair7.xls", header=T, sep="\t")

###################################################
### code chunk number 72: Exercise 4.3
###################################################
colnames(my_target)[1] <- "ID"
colnames(my_mw)[1] <- "ID"

###################################################
### code chunk number 73: Exercise 4.4
###################################################
my_mw_target <- merge(my_mw, my_target, by.x="ID", by.y="ID", all.x=T)

###################################################
### code chunk number 74: Exercise 4.5
###################################################
my_mw_target2a <- merge(my_mw, my_target[1:40,], by.x="ID", by.y="ID", all.x=T)
   # To remove non-matching rows, use the argument setting 'all=F'.
my_mw_target2 <- na.omit(my_mw_target2a)
   # Removes rows containing "NAs" (non-matching rows).

###################################################
### code chunk number 75: Exercise 4.7
###################################################
query <- my_mw_target[my_mw_target[, 2] > 100000 & my_mw_target[, 4] == "C", ]
query[1:4, ]
dim(query)

###################################################
### code chunk number 76: Exercise 4.7
###################################################
my_mw_target3 <- data.frame(loci=gsub("\\..*", "",
                            as.character(my_mw_target[,1]), perl = TRUE),
                            my_mw_target)
my_mw_target3[1:3,1:8]

###################################################
### code chunk number 77: Exercise 4.9
###################################################
mycounts <- table(my_mw_target3[,1])[my_mw_target3[,1]]
my_mw_target4 <- cbind(my_mw_target3, Freq=mycounts[as.character(my_mw_target3[,1])])

###################################################
### code chunk number 78: Exercise 4.10
###################################################
data.frame(my_mw_target4, avg_AA_WT=(my_mw_target4[,3] / my_mw_target4[,4]))[1:2,5:11]

###################################################
### code chunk number 79: Exercise 4.11
###################################################
mymean <- apply(my_mw_target4[,6:9], 1, mean)
mystdev <- apply(my_mw_target4[,6:9], 1, sd, na.rm=TRUE)
data.frame(my_mw_target4, mean=mymean, stdev=mystdev)[1:2,5:12]

###################################################
### code chunk number 80: Introduction_into_R.Rnw:1080-1081
###################################################
plot(my_mw_target4[1:500,3:4], col="red")

###################################################
### code chunk number 81: Exercise 4.13
###################################################
write.table(my_mw_target4, file="my_file.xls", quote=F, sep="\t",
            col.names = NA)

###################################################
### code chunk number 82: Introduction_into_R.Rnw:1106-1107
###################################################
sessionInfo()
