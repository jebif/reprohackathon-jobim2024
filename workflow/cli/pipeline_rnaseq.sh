#!/usr/bin/env bash

start=`date`

genome="`pwd`/data/reference/genome.fa"
reads_1="`pwd`/data/reads/SRR6357070_1.fastq.gz"
reads_2="`pwd`/data/reads/SRR6357070_2.fastq.gz"
gtf="`pwd`/data/reference/genes.gtf"
results="`pwd`/results"
wkdir="`pwd`/wdir"

# results folder
mkdir results

# identifiant
id=`echo $reads_1 | cut -d "_" -f 1`

mkdir -p genome_dir

echo "------------"
echo "Genome index"
echo "------------"
STAR --runMode genomeGenerate \
     --genomeDir genome_dir \
     --genomeFastaFiles $genome \
     --runThreadN 8

echo "----------------"
echo "Genome alignment"
echo "----------------"
STAR --genomeDir genome_dir \
     --readFilesIn $reads_1 $reads_2 \
     --runThreadN 8 \
     --readFilesCommand zcat \
     --outFilterType BySJout \
     --alignSJoverhangMin 8 \
     --alignSJDBoverhangMin 1 \
     --outFilterMismatchNmax 999 \
     --outSAMtype BAM SortedByCoordinate \
     --outSAMattrRGline ID:$id LB:library PL:illumina PU:machine SM:GM12878

echo "---------"
echo "Bam index"
echo "---------"
samtools index Aligned.sortedByCoord.out.bam

echo "-----------------"
echo "Quality alignment"
echo "-----------------"
qualimap rnaseq -bam Aligned.sortedByCoord.out.bam. -gtf $gtf -outdir $results/$id-qualimap-report --java-mem-size=16G

echo "-----------"
echo "Count reads"
echo "-----------"
featureCounts -p -s 0 \
              -t exon \
              -g gene_id \
              -a $gtf \
              -o $results/$id_count.txt \
              Aligned.sortedByCoord.out.bam

end=`date`

echo "start: "$start
echo "end :"$end
