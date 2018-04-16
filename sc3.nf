#!/usr/bin/env nextflow

params.n = 3

process run_sc3 {
    input:
    val n from 1..params.n

    output:
    file "clusters.txt" into clusters_to_merge

    script:
    """
    Rscript sc3.R ${n}
    """
}

process merge_results {
    publishDir ".", mode: 'copy'

    input:
    file input_files from clusters_to_merge.collect()

    output:
    file 'merged_gene_counts.csv'

    script:
    """
    Rscript merge.R ${input_files}
    """
}
