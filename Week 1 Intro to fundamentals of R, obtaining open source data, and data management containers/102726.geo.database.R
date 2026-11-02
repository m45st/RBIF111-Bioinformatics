#...............
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
    #### Set up raw names ####
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
    #### subset ####
    ex2 <- data.table(subset(tT, select=c("ID", "logFC", "P.Value", "adj.P.Val")))
    ex2$ID <- as.character(ex2$ID)
    #### annotate with gene names ####
    plat <- PlateAnnotInfo[GPLID == gpl,][,!"GPLID", with = FALSE]
    if(nrow(plat) == 0){ print(paste("There is no annotation information available for", gpl)) }
    plat$ID <- as.character(plat$ID)
    plat <- plat[!duplicated(plat$ID),]
    ex2 <- merge(plat, ex2, by = "ID")
    ex2$ID <- as.character(ex2$ID)
    exraw <- data.table(ex)
    exraw$ID <- as.character(rownames(ex))
    #### annotate raw data with gene names ####
    ex2 <- merge(ex2, exraw, by = "ID")
    #### Generate Meta Data ####
    Pdat <- pData(gset)
    #### Add Meta data ####
    Pdat <- as.data.table(Pdat)
    return(list(Data = ex2, MetaData = Pdat))
  }
  
  if(Technology == "RNAseq"){
    ACC <- paste("acc=", DS, sep = "")
    file <- paste("file=", DS, "_raw_counts_GRCh38.p13_NCBI.tsv.gz", sep = "")
    comp <- gsub(" ", "", gsm)
    comp <- gsub(",", "", comp)
    gsms <- paste0(comp)
    #### Set up DEG names ####
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
    #### subset ####
    ex2 <- data.table(subset(tT, select=c("GeneID", "Symbol", "Description", "log2FoldChange", "pvalue", "padj")))
    #### Adjust column names ####
    setnames(ex2, c("GeneID", "Symbol", "Description"), c("ENTREZID", "SYMBOL", "GENENAME"))
    #### Get Raw data ####
    GeneID <- as.integer(rownames(exraw))
    exraw <- as.data.table(exraw)
    #### Update column names ####
    exraw$ENTREZID <- GeneID
    #### merge FC and raw data together ####
    mer <- merge(ex2, exraw, by = "ENTREZID")
    return(mer)
  }
}

#..............









#gsms <- "01000011000"
library(data.table)
library(BiocManager)
library(DESeq2)
library(geodata)

RNAseqData <- GEODataDownload(DS = "GSE266550",
                              gpl = "GPL18573",
                              gsm = "1011101100",
                              PlateAnnotInfo = "Only needed if the data was generated using MicroArrays",
                              GenerateMetaData = "Only needed if the data was generated using MicroArrays",
                              Technology = "RNAseq")

datatable(head(as.data.frame(RNAseqData),10), filter = 'top', options = list(pageLength = 10, scrollX = TRUE, scrollY = "400px", autoWidth = TRUE))
