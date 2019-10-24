# Load libraries
source("https://bioconductor.org/biocLite.R")
biocLite("DESeq2")


library("DESeq2")



data_path <- "/home/juan/Desktop/juan/bio/mirna_mrcv/data/counts.valid.csv"
result_path <- "/home/juan/Desktop/juan/bio/mirna_mrcv/data/"

data_path = "/home/juan/Desktop/juan/bio/mirna_mrcv/data/CT2/res/counts.valid.csv"
result_path = '/home/juan/Desktop/juan/bio/mirna_mrcv/data/CT2/res/'

result_path = '/home/juan/Desktop/juan/bio/mirna_mrcv/data/CT_old/res/'
data_path = paste(result_path,'counts.valid.csv',sep='')


result_path = '/home/juan/Desktop/juan/bio/mirna_mrcv/data/CT_SM1.2_BT1.2_V2.4/res/'
data_path = paste(result_path,'counts.valid.csv',sep='')

result_path = '/home/juan/Desktop/juan/bio/mirna_mrcv/data/CT4_SM1.9_BT1.2_V2.4/res/'
data_path = paste(result_path,'counts.valid.csv',sep='')


alpha <- 0.1

getwd()

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


resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)), by="row.names", sort=FALSE)
resdata
names(resdata)[1] <- "Name"
head(resdata)
## Write results
write.csv(resdata, file=result_file, row.names=FALSE)
result_file

#volcano
#install.packages('tidyverse')
#library(tidyverse)
#devtools::install_github("hadley/devtools")
#devtools::install_github("kevinblighe/EnhancedVolcano")
library(EnhancedVolcano)
log2cutoff <- 0.5
qvaluecutoff <- 0.05
dds_m <- DESeqDataSetFromMatrix(countData=countdata, colData=coldata, design=~condition)
dds <- DESeq(dds_m)
resultsNames(dds)
res1 <- results(dds, alpha=alpha)

res1
#annotate
ann_path = paste(result_path,'mirna.res.deg.ann.csv',sep='')
ann <- read.table(ann_path,header=TRUE,sep="\t",comment.char='')
ann = ann[c('Name','mirbase')]

row.names(res1)

merge(res1, ann,by.x='', by.y='Name')

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

