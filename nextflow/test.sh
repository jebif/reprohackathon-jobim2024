#!/usr/bin/env bash
nextflow main.nf --sample "../data/mine/samplesheet_micro.csv" \
    --genome "../data/test-datasets/reference/genome.fa" \
    --annotations "../data/test-datasets/reference/genes.gff" \
    -resume
