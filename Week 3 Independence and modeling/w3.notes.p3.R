library(ALL); data(ALL)
# Reconstruct days-to-remission:
ALL.pdat    <- pData(ALL)
date.cr.chr <- as.character(ALL.pdat$date.cr)
diag.chr    <- as.character(ALL.pdat$diagnosis)
date.cr.t   <- strptime(date.cr.chr, "%m/%d/%Y")
diag.t      <- strptime(diag.chr,    "%m/%d/%Y")
days2remiss <- as.numeric(date.cr.t - diag.t)
gene.names  <- rownames(exprs(ALL))
G <- exprs(ALL)[gene.names[50], ]
complete <- !is.na(days2remiss)
d2r   <- days2remiss[complete]
g.vec <- G[complete]

par(mfrow=c(1,2))
# Scatterplot to visualize the relationship:
plot(g.vec, d2r, pch=16, col="gray60",
     xlab="Gene expression", ylab="Days to remission",
     main="Gene expression vs. D2R")
abline(lm(d2r ~ g.vec), col="red", lwd=2)

# Pearson correlation (parametric):
pearson.result  <- cor.test(g.vec, d2r, method="pearson")
# Spearman correlation (non-parametric):
spearman.result <- cor.test(g.vec, d2r, method="spearman")

cat("Pearson r:", round(pearson.result$estimate, 3),
    "  p =", round(pearson.result$p.value, 4), "\n")



plot(rank(g.vec), rank(d2r), pch=16, col="steelblue",
     xlab="Rank of gene expression", ylab="Rank of D2R",
     main="Spearman: correlation of ranks")
abline(lm(rank(d2r) ~ rank(g.vec)), col="green", lwd=2)


# Spearman correlation of all genes with days-to-remission:
expr.mat <- exprs(ALL)[, complete]
spearman.cors <- apply(expr.mat, 1, function(g) {
  cor(g, d2r, method="spearman", use="complete.obs")
})
# Distribution of Spearman correlations across all genes:
hist(spearman.cors, breaks=50, col="steelblue",
     xlab="Spearman rho", main="Distribution of gene-D2R Spearman correlations",
     border="white")
abline(v=0, lty=2, col="red")


print(sort(spearman.cors, decreasing=TRUE)[1:5])
print(sort(spearman.cors)[1:5])


library(ALL); data(ALL)
# Compare gene expression levels between relapsed and non-relapsed patients:
b.mask     <- !is.na(pData(ALL)$relapse)
relapse    <- pData(ALL)$relapse[b.mask]
gene.expr  <- exprs(ALL)[gene.names[50], b.mask]

# Check normality within each group:
cat("Shapiro-Wilk test within relapsed group:\n")
print(shapiro.test(gene.expr[relapse]))
print(shapiro.test(gene.expr[!relapse]))

par(mfrow=c(1,2))
# Visualize distributions:
boxplot(gene.expr ~ relapse,
        names=c("No relapse","Relapse"),
        col=c("steelblue","tomato"),
        ylab="Gene expression",
        main="Gene expression by relapse status")

# t-test (parametric):
t.result <- t.test(gene.expr[relapse], gene.expr[!relapse])
# Wilcoxon rank-sum test (non-parametric):
w.result <- wilcox.test(gene.expr[relapse], gene.expr[!relapse])


cat("\nt-test:         p =", round(t.result$p.value, 4), "\n")
# Visualize the rank logic:



all.expr   <- c(gene.expr[relapse], gene.expr[!relapse])
group.labs <- c(rep("Relapse", sum(relapse)), rep("No relapse", sum(!relapse)))
all.ranks  <- rank(all.expr)
boxplot(all.ranks ~ group.labs,
        col=c("steelblue","tomato"),
        ylab="Rank",
        main="Ranks by relapse status\n(what Wilcoxon actually tests)")
