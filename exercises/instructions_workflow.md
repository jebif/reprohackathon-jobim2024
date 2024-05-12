# Workflow manager

Here are the instructions for the 2 exercises about workflow managers (Snakemake and Nextlfow).

## Data

Data for this exercise can be found in this [repo](https://github.com/nf-core/test-datasets/tree/rnaseq).

Cet exercice se concentre sur les données de test du repo mentionné ci-dessus, qui peuvent re

This exercice will focus on the test data of the repo mentionned above, which can be found in `testdata` folder (reads and the genome) [here](https://github.com/nf-core/test-datasets/tree/rnaseq/testdata/GSE110004) and in the `reference` folder for the gene file (GTF) [here](https://github.com/nf-core/test-datasets/tree/rnaseq/reference). 

You have to get the following files: 
- gene.gtf
- genome.fa 
- SRR6357070_1.fastq.gz
- SRR6357070_2.fastq.gz
- SRR6357071_1.fastq.gz
- SRR6357071_2.fastq.gz
- SRR6357072_1.fastq.gz
- SRR6357072_2.fastq.gz
- SRR6357073_1.fastq.gz
- SRR6357073_2.fastq.gz
- SRR6357074_1.fastq.gz
- SRR6357074_2.fastq.gz
- SRR6357075_1.fastq.gz
- SRR6357075_2.fastq.gz
- SRR6357076_1.fastq.gz
- SRR6357076_2.fastq.gz
- SRR6357077_1.fastq.gz
- SRR6357077_2.fastq.gz
- SRR6357078_1.fastq.gz
- SRR6357078_2.fastq.gz
- SRR6357079_1.fastq.gz
- SRR6357079_2.fastq.gz
- SRR6357080_1.fastq.gz
- SRR6357080_2.fastq.gz
- SRR6357081_1.fastq.gz
- SRR6357081_2.fastq.gz

## Rational

### Step 1

The main step during NGS analysis is the alignement of the reads. Such require indexing of the reference (genome) and the mapping of the reads on the freshly indexed genome.

Worflow managers are very usefull for the treatment of multiple libraries following the same steps in the same time by only one command.

Indexing and alignment will be performed with [STAR](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3530905/)

### Step 2

It is important to check the quality of the alignments. For this step, it is necessary to index the BAM files.

Indexing BAM files and checking alignment quality can be done with [SAMTOOLS](https://pubmed.ncbi.nlm.nih.gov/33590861/) and [QUALIMAP](https://academic.oup.com/bioinformatics/article/28/20/2678/206551?login=false).

## Step 3

Finally, it's possible to count reads.

One of the most frequently used tools is [FeatureCounts](https://pubmed.ncbi.nlm.nih.gov/24227677/).

## Instructions

You will have to create a workflow either using Snakemake or Nextflow.
The workflow has to contain 6 rules (Snakemake) or 6 processes (Nextflow) : 
- Genome indexing
- Read alignment
- BAM indexing
- Quality controde
- Count reads

Reads should be placed in the folder `reads`, genome and gtg in `reference` workflow results in `results`.  In `results` we should find at least 5 folders: `bam_files`, `genome_indexing`, `bam_indexing`, `qualimap` and `featurecounts`.

The final folder tree must be : 

```note
jebif2024/
├── data/
│   ├── references/
│   │   ├── genome.fa
│   │   └── genes.gtf
│   └── reads/
│       └── SRR*.fastq.gz
│
├── bin/ # optional (*.py, *.R, *.sh, ...)
│   ├── ...
│   ...
│
├── results/
│   ├── bam_files/
│   │   ├── ...
│   │   ...
│   ├── genome_indexing/
│   │   ├── ...
│   │   ...
│   ├── bam_indexing/
│   │   ├── ...
│   │   ...
│   ├── qualimap/
│   │   ├── ...
│   │   ...
│   ├── featurecounts/
│   │   ├── ...
│   │   ...
│   ...
│
├── modules/ # for Nextflow
│   ├── *.nf
│   ...
│
├── conda
│   └── *.yml (or *.yaml)
│
├── nextflow.config # Nextflow
│
├── config.yaml # Snakemake
│
├──  main.nf # Nextflow
│
└── Snakefile # Snakemake
```

## Help

If you need help using the tools, the documentation is just what you need:
- [SART](https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf)
- [SAMTOOLS](http://www.htslib.org/doc/samtools.html)
- [QUALIMAP](http://qualimap.conesalab.org/doc_html/index.html)
- [FeatureCounts](https://subread.sourceforge.net/featureCounts.html)