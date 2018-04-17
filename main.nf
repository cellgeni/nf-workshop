#!/usr/bin/env nextflow

params.n = 3

process run_sc3 {
    input:
    val n from 1..params.n

    output:
    file "clusters_${n}.txt" into clusters_to_merge

    script:
    """
    sc3.R ${n}
    """
}

process merge_results {
    publishDir "./results", mode: 'copy'

    input:
    file input_files from clusters_to_merge.collect()

    output:
    file "merged_sc3_results.csv"

    script:
    """
    merge.R ${input_files}
    """
}
