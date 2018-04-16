library(SingleCellExperiment)
library(SC3)

args <- commandArgs(trailingOnly = TRUE)

# create a SingleCellExperiment object
sce <- SingleCellExperiment(
    assays = list(
        counts = as.matrix(yan),
        logcounts = log2(as.matrix(yan) + 1)
    ), 
    colData = ann
)

# define feature names in feature_symbol column
rowData(sce)$feature_symbol <- rownames(sce)
# remove features with duplicated names
sce <- sce[!duplicated(rowData(sce)$feature_symbol), ]

# define spike-ins
isSpike(sce, "ERCC") <- grepl("ERCC", rowData(sce)$feature_symbol)

# run SC3
sce <- sc3(sce, ks = 6, rand_seed = args[1])
write.csv(colData(sce)$sc3_6_clusters, file = "clusters.txt", quote = F)