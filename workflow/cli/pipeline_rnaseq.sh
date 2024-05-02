#!/usr/bin/env bash

date 

genome="`pwd`/data/reference/genome.fa"
reads_1="`pwd`/data/reads/SRR6357070_1.fastq.gz"
reads_2="`pwd`/data/reads/SRR6357070_2.fastq.gz"
gtf="`pwd`/data/reference/genes.gtf"
results="`pwd`/results"
wkdir="`pwd`/wdir"

# results folder
mkdir results

#CONDA environment
#echo "Build environment"
#conda env create -f environment.yml
#conda activate pipeline

# identifiant
id=`echo $reads_1 | cut -d "_" -f 1`

# indéxation du génome
mkdir -p genome_dir

echo "Genome index"
STAR --runMode genomeGenerate \
     --genomeDir genome_dir \
     --genomeFastaFiles $genome \
     --runThreadN 8

echo "Genome alignment"
STAR --genomeDir genome_dir \
     --readFilesIn $reads_1 $reads_2 \
     --runThreadN 8 \
     --readFilesCommand zcat \
     --outFilterType BySJout \
     --alignSJoverhangMin 8 \
     --alignSJDBoverhangMin 1 \
     --outFilterMismatchNmax 999 \
     --outSAMtype BAM Aligned.SortedByCoordinate \
     --outSAMattrRGline ID:$id LB:library PL:illumina PU:machine SM:GM12878

echo "Bam index"
samtools index SortedByCoordinate

echo "Quality alignment"
qualimap rnaseq -bam Aligned.SortedByCoordinate -gtf $gtf -outdir $results/$id-qualimap-report --java-mem-size=16G

echo "Count reads"
featureCounts -p -s 0 \
              -t exon \
              -g gene_id \
              -a $gtf} \
              -o $results/$id_count.txt \
              Aligned.SortedByCoordinate

#conda deactivate