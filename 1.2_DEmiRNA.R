# Load libraries
source("https://bioconductor.org/biocLite.R")
#install.packages('gplots')
biocLite("DESeq2")
library("DESeq2")
alpha <- 0.05
setwd(dirname(rstudioapi::getActiveDocumentContext()$path));
getwd()
data_path <- "/home/juan/Desktop/juan/bio/mirna_mrcv/data/counts.valid.csv"
result_path <- "/home/juan/Desktop/juan/bio/mirna_mrcv/data/"
# Load data
countdata <- read.table(data_path,header=TRUE,sep="\t")
result_file = paste(result_path,"mirna.deg.csv",sep="");
#DROP unique miRNA clusters
# I don't know why I have to do this first, otherwise RStudio hangs
countdata <- countdata[!is.na(countdata$Name),]
row.names(countdata) <- countdata$Name
countdata <- subset(countdata, select = -c(main))
countdata <- subset(countdata, select = -c(Name))
countdata <- subset(countdata, select = -c(Locus))
countdata <- as.matrix(countdata)
head(countdata)
# Assign condition (first four are controls, second four contain the expansion)
(condition <- factor(c("control","control","treatment","treatment")))
# Analysis with DESeq2 ----------------------------------------------------
# Create a coldata frame and instantiate the DESeqDataSet. See ?DESeqDataSetFromMatrix
(coldata <- data.frame(row.names=colnames(countdata), condition))
levels(coldata$condition)
coldata
dds_m <- DESeqDataSetFromMatrix(countData=countdata, colData=coldata, design=~condition)
# Run the DESeq pipeline
dds <- DESeq(dds_m)
res <- results(dds, alpha=alpha)
res <- res[!is.na(res$padj), ]
res <- res[res$padj <= alpha, ]
res
alpha
options(scipen = 999)



#res = table(res$padj <= alpha)
## Order by adjusted p-value
#res <- res[order(res$padj), ]
## Merge with normalized count data
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)), by="row.names", sort=FALSE)
resdata
names(resdata)[1] <- "Name"
head(resdata)
## Write results
write.csv(resdata, file=result_file, row.names=FALSE)
result_file



#volcano
install.packages('tidyverse')
library(tidyverse)
devtools::install_github("hadley/devtools")
devtools::install_github("kevinblighe/EnhancedVolcano")
library(EnhancedVolcano)

log2cutoff <- 0.5
qvaluecutoff <- 0.05


dds_m <- DESeqDataSetFromMatrix(countData=countdata, colData=coldata, design=~condition)
dds <- DESeq(dds_m)
resultsNames(dds)
res1 <- results(dds, alpha=alpha)

#res1 <- res1[!is.na(res1$padj), ]
#res1 = res1[res1$padj <= alpha, ]
#res1 = res1[res1$log2FoldChange <= -0.5 |  res1$log2FoldChange >= 0.5,]
res1

EnhancedVolcano(res1,
                lab = rownames(res1),
                title = 'Mock-infected vs MRCV-infected',
                subtitle = "Differential accumulation",
                ylab = bquote(~-Log[10]~italic(Q)),
                x = 'log2FoldChange',
                legend=c('NS','Log2 FC','Adjusted p-value',
                         'Adjusted p-value & Log2 FC'),
                
                y = 'padj',
                ylim = c(0, 6),
                pCutoff = alpha,
                FCcutoff = log2cutoff   ,
                legendPosition = 'right',
                legendLabSize = 12,
                legendIconSize = 4.0,
                drawConnectors = TRUE,
                widthConnectors = 0.2,
                colConnectors = 'grey30')

