rm(list = ls())

library("ggplot2")
library("dplyr")
library("DESeq2")

# Set data path
data_path <- "/home/sebastien/Bureau/featureCount/"
metadata_path <- "/home/sebastien/Bureau/metadata.csv"


# Set SRA IDs
WT <- c("SRR6357070", "SRR6357071", "SRR6357072")
Rap1_AID_no_induction <- c("SRR6357073", "SRR6357074", "SRR6357075")
Rap1_AID_induction_30m <- c("SRR6357076", "SRR6357077", "SRR6357078")
Rap1_AID_induction_120m <- c("SRR6357079", "SRR6357080", "SRR6357081")

WT_rep1 <- read.table(paste0(data_path ,WT[1] , '_count.txt'), sep = '\t', header = TRUE)
WT_rep2 <- read.table(paste0(data_path ,WT[2] , '_count.txt'), sep = '\t', header = TRUE)
WT_rep3 <- read.table(paste0(data_path ,WT[3] , '_count.txt'), sep = '\t', header = TRUE)

Rap1_AID_no_induction_rep1 <- read.table(paste0(data_path ,Rap1_AID_no_induction[1] , '_count.txt'), sep = '\t', header = TRUE)
Rap1_AID_no_induction_rep2 <- read.table(paste0(data_path ,Rap1_AID_no_induction[2] , '_count.txt'), sep = '\t', header = TRUE)
Rap1_AID_no_induction_rep3 <- read.table(paste0(data_path ,Rap1_AID_no_induction[3] , '_count.txt'), sep = '\t', header = TRUE)

Rap1_AID_induction_30m_rep1 <- read.table(paste0(data_path ,Rap1_AID_induction_30m[1] , '_count.txt'), sep = '\t', header = TRUE)
Rap1_AID_induction_30m_rep2 <- read.table(paste0(data_path ,Rap1_AID_induction_30m[2] , '_count.txt'), sep = '\t', header = TRUE)
Rap1_AID_induction_30m_rep3 <- read.table(paste0(data_path ,Rap1_AID_induction_30m[3] , '_count.txt'), sep = '\t', header = TRUE)

Rap1_AID_induction_120m_rep1 <- read.table(paste0(data_path ,Rap1_AID_induction_120m[1] , '_count.txt'), sep = '\t', header = TRUE)
Rap1_AID_induction_120m_rep2 <- read.table(paste0(data_path ,Rap1_AID_induction_120m[2] , '_count.txt'), sep = '\t', header = TRUE)
Rap1_AID_induction_120m_rep3 <- read.table(paste0(data_path ,Rap1_AID_induction_120m[3] , '_count.txt'), sep = '\t', header = TRUE)

# Subselect columns of interest

WT_rep1 <- WT_rep1[c("Geneid", "Aligned.sortedByCoord.out.bam")]
WT_rep2 <- WT_rep2[c("Geneid", "Aligned.sortedByCoord.out.bam")]
WT_rep3 <- WT_rep3[c("Geneid", "Aligned.sortedByCoord.out.bam")]

Rap1_AID_no_induction_rep1 <- Rap1_AID_no_induction_rep1[c("Geneid", "Aligned.sortedByCoord.out.bam")]
Rap1_AID_no_induction_rep2 <- Rap1_AID_no_induction_rep2[c("Geneid", "Aligned.sortedByCoord.out.bam")]
Rap1_AID_no_induction_rep3 <- Rap1_AID_no_induction_rep3[c("Geneid", "Aligned.sortedByCoord.out.bam")]

Rap1_AID_induction_30m_rep1 <- Rap1_AID_induction_30m_rep1[c("Geneid", "Aligned.sortedByCoord.out.bam")]
Rap1_AID_induction_30m_rep2 <- Rap1_AID_induction_30m_rep2[c("Geneid", "Aligned.sortedByCoord.out.bam")]
Rap1_AID_induction_30m_rep3 <- Rap1_AID_induction_30m_rep3[c("Geneid", "Aligned.sortedByCoord.out.bam")]

Rap1_AID_induction_120m_rep1 <- Rap1_AID_induction_120m_rep1[c("Geneid", "Aligned.sortedByCoord.out.bam")]
Rap1_AID_induction_120m_rep2 <- Rap1_AID_induction_120m_rep2[c("Geneid", "Aligned.sortedByCoord.out.bam")]
Rap1_AID_induction_120m_rep3 <- Rap1_AID_induction_120m_rep3[c("Geneid", "Aligned.sortedByCoord.out.bam")]

# Merge dataframes

WT <- right_join(WT_rep1, WT_rep2, by = "Geneid")
WT <- right_join(WT, WT_rep3, by = "Geneid")

Rap1_AID_no_induction <- right_join(Rap1_AID_no_induction_rep1, Rap1_AID_no_induction_rep2, by = "Geneid")
Rap1_AID_no_induction <- right_join(Rap1_AID_no_induction, Rap1_AID_no_induction_rep3, by = "Geneid")

Rap1_AID_induction_30m <- right_join(Rap1_AID_induction_30m_rep1, Rap1_AID_induction_30m_rep2, by = "Geneid")
Rap1_AID_induction_30m <- right_join(Rap1_AID_induction_30m, Rap1_AID_induction_30m_rep3, by = "Geneid")

Rap1_AID_induction_120m <- right_join(Rap1_AID_induction_120m_rep1, Rap1_AID_induction_120m_rep2, by = "Geneid")
Rap1_AID_induction_120m <- right_join(Rap1_AID_induction_120m, Rap1_AID_induction_120m_rep3, by = "Geneid")

df <- right_join(WT, Rap1_AID_no_induction, by = "Geneid")
df <- right_join(df, Rap1_AID_induction_30m, by = "Geneid")
df <- right_join(df, Rap1_AID_induction_120m, by = "Geneid")

# Rename columns 
colnames(df) <- c("Geneid", "SRR6357070" , "SRR6357071", "SRR6357072", "SRR6357073", "SRR6357074", "SRR6357075", "SRR6357076", "SRR6357077", "SRR6357078", "SRR6357079", "SRR6357080", "SRR6357081")

# Load metadata
metadata <- read.csv(metadata_path, header = TRUE, sep = ";")

# Create DESeq2 object
dds <- DESeqDataSetFromMatrix(countData = df,
                              colData = metadata,
                              design=~dex, tidy = TRUE)


# Run DESeq2
dds <- DESeq(dds)

# Get results
res <- results(dds)
head(results(dds, tidy=TRUE)) #l

# Sort summary by p-value
res <- res[order(res$padj),]
head(res)

# Order and Save results
resOrdered <- res[order(res$pvalue),]

write.csv(as.data.frame(resOrdered), file = paste0(data_path, "differential_analysis.csv") , row.names = TRUE)

# Plot data

# MA plot
pdf(paste0(data_path, "MA_plot.pdf"))
p <- plotMA(res, ylim=c(-2,2), main="MA plot", cex=0.5)
print(p)
dev.off()

# Volcano plot
pdf(paste0(data_path ,"volcano_plot.pdf"))
p <- with(res, plot(log2FoldChange, -log10(pvalue), pch=20, main="Volcano plot", xlim=c(-3,3)))
print(p)
dev.off()
