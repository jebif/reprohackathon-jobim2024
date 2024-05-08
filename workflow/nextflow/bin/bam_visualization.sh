#!/usr/bin/env bash

bam=${1}
id=${2}

samtools view $bam | head > bam_head_$id.txt

samtools view -c $bam > bam_number_alignment_$id.txt