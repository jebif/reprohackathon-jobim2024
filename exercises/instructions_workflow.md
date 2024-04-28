# Workflow manager

Here are the instructions for the 2 exercises about workflow managers (Snakemake and Nextlfow).

## Data

Data for this exercise can be found in this [repo](https://github.com/nf-core/test-datasets/tree/rnaseq/testdata).

This exercice will focus on the test data of the repo mentionned above, which can be found in `testdata` folder (reads) and the genome [here](https://github.com/nf-core/test-datasets/tree/rnaseq/reference). 

You have to get the following files: 
- genome.fa
- SRR4238351_subsamp.fastq.gz
- SRR4238355_subsamp.fastq.gz
- SRR4238359_subsamp.fastq.gz
- SRR4238379_subsamp.fastq.gz

## Rational

The main step during NGS analysis is the alignement of the reads. Such require indexing of the reference (genome) and the mapping of the reads on the freshly indexed genome.

Worflow managers are very usefull for the treatment of multiple libraries following the same steps in the same time by only one command.

Indexing and alignment will be performed with [Bowtie2](https://bowtie-bio.sourceforge.net/bowtie2/index.shtml)



## Instructions

You will have to create a workflow either using Snakemake or Nextflow.
The workflow has to contain 2 rules (Snakemake) or 2 processes (Nextflow) : 
- Genome indexing
- Read alignment

Reads should be placed in the folder `reads`, genome in `genome` alignments (.sam files) in `alignments` and index in `index`.

The tree of the folder should be : 

```bash
|--Snakefile or main.nf
|--genome/genome.fa
|--reads/*.fastq.gz
|--index/*.bt2l
|--alignments/*.sam
```

## Help

Genome indexing can e performed using: 

```bash
bowtie2-build --threads <cpu_nb> -f <genome.fa> <index_prefix>
```

Read alignement can be performed using:

```bash
bowtie2 -x <index_prefix> -U <input.fastq.gz> -S <output.sam>
```



