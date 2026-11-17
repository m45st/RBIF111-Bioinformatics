

#####################
#### Week 3 code ####
#####################

#################################################
####  Week 3 Notes Part 1 Statistical Models ####
#################################################
######################
#### Code Chunk 1 ####
######################
x <- rnorm(10000,mean=10,sd=3)                          # simulate sampling from X 10000 times
y <- rnorm(10000,mean=10,sd=3)                          # simulate measuring Y 10000 times
br<- -5:25                                              # set manually bins for histograms
hx <- hist(x,breaks=br,plot=F)                          # save histogram of X, don’t plot
hy <- hist(y,breaks=br,plot=F)                          # save histogram of Y, don’t plot
old.par <-par(mfrow=c(1,2))                             # prepare to draw 2 plots in one row
# now plot histograms side by side (they better have same bins, we ensured that):
barplot(rbind(hx$density,hy$density),beside=T,
        col=c(rgb(0,0.2,1),rgb(0,1,0.3)),legend=c('X','Y'),
        main='Empirical distributions of X and Y',names=br[-1])
plot(x,y,xlab='X values',ylab='Y values',main='X vs Y scatterplot',pch=19,cex=0.3)
par(old.par)                                            # restore graphical attributes to previous values

######################
#### Code Chunk 2 ####
######################
range.7 <- x > 6.8 & x < 7.2 # select instances where X is close to 7
range.13 <- x > 12.8 & x < 13.2 # instances where X is close to 13
# take only Y where X~7 and calculate their empirical distribution:
hy.7 <- hist(y[range.7],breaks=br,plot=F)
# select only Y where X~13 and calculate the empirical distribution:
hy.13 <- hist(y[range.13],breaks=br,plot=F)
# plot overall distribution of Y and conditional distributions,
# P(Y|X=7) and P(Y|X=13) side by side
barplot(rbind(hy$density,hy.7$density,hy.13$density),
        beside=T,col=c(rgb(0,1,0.3),rgb(0,0.28,1),rgb(0,0.8,1)),
        legend=c('Y','Y|X=7','Y|X=13'),
        main='Empirical distributions of X and Y',names=br[-1])
t.test(y[range.7],y[range.13])
t.test(y[range.7],y)

######################
#### Code Chunk 3 ####
######################
x <- rnorm(10000,mean=10,sd=sqrt(5))
y <- x # initialize y with x
x <- x + rnorm(10000,sd=2)
y <- y + rnorm(10000,sd=2)

######################
#### Code Chunk 4 ####
######################
br<- -5:25 # set manually bins for histograms
hx <- hist(x,breaks=br,plot=F) # save histogram of X, don’t plot
hy <- hist(y,breaks=br,plot=F) # save histogram of Y, don’t plot
old.par <-par(mfrow=c(1,2)) # prepare to draw 2 plots in one row
# now plot histograms side by side (they better have same bins, we ensured that):
barplot(rbind(hx$density,hy$density),beside=T,
        col=c(rgb(0,0.2,1),rgb(0,1,0.3)),legend=c('X','Y'),
        main='Empirical distributions of X and Y',names=br[-1])
plot(x,y,xlab='X values',ylab='Y values',main='X vs Y scatterplot',pch=19,cex=0.3)
par(old.par) # restore graphical attributes to previous values

######################
#### Code Chunk 5 ####
######################
range.7 <- x > 6.8 & x < 7.2
range.13 <- x > 12.8 & x < 13.2
hy.7 <- hist(y[range.7],breaks=br,plot=F)
hy.13 <- hist(y[range.13],breaks=br,plot=F)
barplot(rbind(hy$density,hy.7$density,hy.13$density),
        beside=T,col=c(rgb(0,1,0.3),rgb(0,0.28,1),rgb(0,0.8,1)),
        legend=c('Y','Y|X=7','Y|X=13'),
        main='Empirical distributions of X and Y',names=br[-1])

#######################################################
####  Week 3 Notes Part 2 Practicing Linear Models ####
#######################################################
######################
#### Code Chunk 1 ####
######################
library(ALL); data(ALL)
ALL.pdat <- pData(ALL)
date.cr.chr <- as.character(ALL.pdat$date.cr)
diag.chr <- as.character(ALL.pdat$diagnosis)
date.cr.t <- strptime(date.cr.chr,"%m/%d/%Y")
diag.t <- strptime(diag.chr,"%m/%d/%Y")
days2remiss <- as.numeric(date.cr.t - diag.t)
plot(exprs(ALL)["34852_g_at",], as.numeric(days2remiss),
     xlab="Gene Expression", ylab="Days-to-remission")                            

######################
#### Code Chunk 2 ####
######################
exprs.34852 <- exprs(ALL)["34852_g_at",]
d2r.34852 <- data.frame(G=exprs.34852,D2R=days2remiss)
lm.34852.g.at <- lm(D2R~G,d2r.34852)                                    

######################
#### Code Chunk 3 ####
######################
coef(lm.34852.g.at)
print(lm.34852.g.at)
plot(exprs(ALL)["34852_g_at",],
     as.numeric(days2remiss),
     xlab="Gene Expression",
     ylab="Days to remission")
points(d2r.34852$G[!is.na(d2r.34852$D2R)],
       predict(lm.34852.g.at),
       col="red",pch=20)

######################
#### Code Chunk 4 ####
######################
qqnorm(resid(lm.34852.g.at))
qqline(resid(lm.34852.g.at))
hist(resid(lm.34852.g.at))
shapiro.test(resid(lm.34852.g.at))$p.value

######################
#### Code Chunk 5 ####
######################
plot(fitted(lm.34852.g.at), d2r.34852[!is.na(d2r.34852$D2R),"D2R"],
     xlab="Fitted",ylab="Observed")
abline(0,1,lty=2)

######################
#### Code Chunk 6 ####
######################
plot(fitted(lm.34852.g.at),
     resid(lm(D2R~G,d2r.34852)),
     xlab="Fitted",ylab="Residuals")
abline(h=0,lty=2)

######################
#### Code Chunk 7 ####
######################
old.par <- par(mfrow=c(2,2),ps=16)
plot(lm.34852.g.at)
par(old.par)

######################
#### Code Chunk 8 ####
######################
anova(lm.34852.g.at)                                    
anova(lm.34852.g.at)$"Pr(>F)"[1] # we can retrieve just the p-value

######################
#### Code Chunk 9 ####
######################
plot(exprs(ALL)["37138_at",],
     as.numeric(days2remiss),
     xlab="Gene Expression",
     ylab="Days-to-remission") 
anova(lm(D2R~G,data.frame(
  G=exprs(ALL)["37138_at",],
  D2R=as.numeric(days2remiss))))









