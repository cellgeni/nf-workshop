#!/usr/bin/env nextflow

params.str = 'Hello world!'

process splitLetters {
    output:
    file 'chunk_*' into letters mode flatten

    script:
    """
    printf '${params.str}' | split -b 6 - chunk_
    """
}

process convertToUpper {
    input:
    file x from letters

    output:
    stdout result

    script:
    """
    cat $x | tr '[a-z]' '[A-Z]'
    """
}

result.subscribe {
    println it.trim()
}
