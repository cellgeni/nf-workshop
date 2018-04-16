args <- commandArgs(trailingOnly = TRUE)

res <- NULL
for(f in args) {
    res <- cbind(res, read.csv(f))
}

write.csv(res, file = "merged_gene_counts.csv", quote = F)