

#####################
#### Week 2 code ####
#####################

####################################################################
#### Week 2 Notes Part 1 Probability Distributions and Sampling ####
####################################################################
######################
#### Code Chunk 1 ####
######################
plot(c(0.5,0.5),type='h',lwd=3,xlim=c(0,3),ylim=c(0,1),xaxt='n',
     xlab="",ylab="Probability",cex.lab=1.5,cex.axis=1.5)
axis(1,at=c(1,2),labels=c('H','T'),cex.axis=2)

######################
#### Code Chunk 2 ####
######################
plot(c(0.5,0.5),type='l',pch=19,lwd=3,xlim=c(0,3),
     ylim=c(0,1),xaxt='n',yaxt='n',xlab="",
     ylab="Probability",cex.lab=1.5,cex.axis=1.5)
axis(1,at=c(1,2),labels=c('a','b'),cex.axis=2)
axis(2,at=0.5,labels="1/(b-a)",cex.axis=2)
lines(c(1,1),c(0,0.5),lty=3,lwd=2)
lines(c(2,2),c(0,0.5),lty=3,lwd=2)

######################
#### Code Chunk 3 ####
######################
k<-0:15 # we can observe anywhere from 0 to 15 heads in 15 trials
plot(k,choose(15,k)*0.2^k*
       0.8^(15-k),type='h',
     lwd=3,ylab='Probability',cex.axis=1.5,cex.lab=1.5)

######################
#### Code Chunk 4 ####
######################
plot(dnorm,from=-3,to=3)

######################
#### Code Chunk 5 ####
######################
# The d/p/q/r distribution-function family, illustrated on the normal:
pnorm(1.96)     # P(X <= 1.96) for the standard normal: the CDF value
1 - pnorm(1.96) # P(X > 1.96), the upper tail
qnorm(0.975)    # the value x such that P(X <= x) = 0.975 -- the inverse of the line above

######################
#### Code Chunk 6 ####
######################
set.seed(1)    # optional: reproducible "random numbers"
y <- rnorm(20) # sample at random 20 values from Gaussian
mean(y)        # ooops, mean is far from 0! Let's try again:
y <- rnorm(20); mean(y); y <- rnorm(20); mean(y)

######################
#### Code Chunk 7 ####
######################
y <- rnorm(100); hist(y,breaks=20)


##########################################################
#### Week 2 Notes Part 2 Hypothesis Testing and Power ####
##########################################################
######################
#### Code Chunk 1 ####
######################
# BiocManager::install("ALL")
library(ALL); data(ALL)
pData(ALL)[1:5,1:5]                # take a quick look at patients data
boxplot(pData(ALL)$age,cex.axis=2) # all patients
# stratified by gender (NOTE formula syntax!!):
boxplot(age~sex,pData(ALL),cex.axis=2)
# let's also check the empirical distribution:
hist(pData(ALL)$age,cex.axis=2)

######################
#### Code Chunk 2 ####
######################
set.seed(1234)
all.pdat <- pData(ALL) # save the dataframe for convenience
m.ages <- all.pdat[all.pdat$sex=="M", "age"] # get all male's ages
f.ages <- all.pdat[all.pdat$sex=="F","age"] # all female's ages
x.m <- sample(m.ages[!is.na(m.ages)],9) # random sample: 9 male ages
x.f <- sample(f.ages[!is.na(f.ages)],11) # 11 random female ages
x.m
x.f
stripchart(list(F=x.f,M=x.m),vertical=TRUE) # compare samples
mean(x.f)-mean(x.m)

######################
#### Code Chunk 3 ####
######################
ori.diff <- mean(x.f)-mean(x.m) # diff between original samples
diff.sim <- numeric() # create an empty vector
ge.cnt <- 0 # how many times resampled diff is greater than original
n.sims <- 10000 # perform 10000 resamplings
for ( i.sim in 1:n.sims ) { # in each iteration:
  x.sim <- sample(m.ages[!is.na(m.ages)],20) # sample 20 ages...
  #... assign them to two samples and compute diff between means
  diff.sim[i.sim] <- mean(x.sim[1:9])-mean(x.sim[10:20])
  if ( diff.sim[i.sim] >= ori.diff ) {
    ge.cnt <- ge.cnt + 1
  }
}

######################
#### Code Chunk 4 ####
######################
old.par <- par(mfrow=c(2,1),ps=20)
plot(sort(diff.sim),main=paste("Rank",
                               ge.cnt/n.sims),ylab="",
     xlab=paste("one-sided t-test",
                signif(t.test(x.f,x.m,alt="greater")$p.value,3)))
points(n.sims-ge.cnt,ori.diff,
       cex=4,col="red",pch=20)
plot(hist(diff.sim,breaks=20,plot=F),main="",xlab="")
abline(v=ori.diff,lwd=2,col="red")
par(old.par)

######################
#### Code Chunk 5 ####
######################
exprs.p <- apply(exprs(ALL),1, function(x)t.test(x[pData(ALL)$sex=="F"], x[pData(ALL)$sex=="M"])$p.value)
hist(exprs.p)
plot(sort(exprs.p),log="y",ylab="p-value", main="Men vs women gene expression t-test results")
boxplot(exprs(ALL)["37583_at",]~pData(ALL)$sex)

##############################################################
#### Code Chunk 6 (QQ Plots: Visual Normality Assessment) ####
##############################################################
library(ALL); data(ALL)
# Compare a normally-distributed variable vs. a skewed one:
par(mfrow=c(1,3))
# Normal data: ages of ALL patients
qqnorm(pData(ALL)$age, main="QQ plot: Patient age\n(approximately normal)")
qqline(pData(ALL)$age, col="red", lwd=2)
# Gene expression (often approximately normal after log-transformation):
gene.expr <- exprs(ALL)[rownames(exprs(ALL))[1], ]
qqnorm(gene.expr, main="QQ plot: Gene expression\n(log-scale microarray)")
qqline(gene.expr, col="red", lwd=2)
# Simulated right-skewed data for contrast:
skewed <- rexp(128, rate=0.5)
qqnorm(skewed, main="QQ plot: Skewed data\n(exponential distribution)")
qqline(skewed, col="red", lwd=2)
par(mfrow=c(1,1))

####################################################################
#### Code Chunk 7 (Shapiro-Wilk Test: Formal Normality Testing) ####
####################################################################
# install.packages("medicaldata")
library(medicaldata)
head(blood_storage)

######################
#### Code Chunk 8 ####
######################
normalityfindR <- function(DT, cols){
  finDT <- data.table()
  for(i in 1:length(cols)){
    if(length(table(as.numeric(DT[[cols[i]]]))) > 1){
    test <- shapiro.test(as.numeric(DT[[cols[i]]]))
    if(test$p.value < 0.05){
      distribution <- "Not normally distributed"
    }else{
      distribution <- "normally distributed"
    }
    Nobs <- sum(!is.na(DT[[cols[i]]]))
    DT2 <- data.table(method = test$method,
                      pvalue = test$p.value,
                      variable = colnames(DT[,cols[i], with = FALSE]),
                      normality = distribution,
                      NumberObservations = Nobs
    )
    finDT <- rbind(finDT,DT2)
    } else {
      print(paste("Aw Snap. All values in", colnames(DT)[cols[i]], "are identical"))
    }
  }
  return(finDT)
}

######################
#### Code Chunk 9 ####
######################
library(data.table)
normalityfindR(DT=as.data.table(blood_storage), cols=c(2,6,12,20))

#################################################################
#### Code Chunk 10 (Mann-Whitney U Test / Wilcoxon Rank-Sum) ####
#################################################################
wilcox.test(blood_storage$Median.RBC.Age, blood_storage$PreopPSA, conf.int = TRUE, paired = FALSE, formula = "lhs")

####################################################################
#### Code Chunk 11 (Sample Size Calculation: Two-Sample t-test) ####
####################################################################
power.t.test(delta=0.5, sd=1, sig.level=0.05, power=0.80)

#######################
#### Code Chunk 12 ####
#######################
power.t.test(n=30, delta=0.5, sd=1, sig.level=0.05)

#####################################################
#### Code Chunk 13 (Visualizing the Power Curve) ####
#####################################################
n.seq <- seq(5, 100, by=1)
power.seq <- sapply(n.seq, function(n) power.t.test(n=n, delta=0.5, sd=1, sig.level=0.05)$power)
plot(n.seq, power.seq, type="l", xlab="Sample size per group", ylab="Power",
     main="Power vs. sample size (delta=0.5, sd=1)")
abline(h=0.80, lty=2, col="red")
abline(v=power.t.test(delta=0.5, sd=1, sig.level=0.05, power=0.80)$n, lty=2, col="blue")

#################################################
#### Code Chunk 14 (Power for Other Designs) ####
#################################################
power.prop.test(p1=0.3, p2=0.5, sig.level=0.05, power=0.80)
