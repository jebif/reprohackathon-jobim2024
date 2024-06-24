# JEBiF@JOBIM: Git Tutorial
## **Nextflow overview**

Nextflow is a workflow system for creating scalable, portable, and reproducible workflows. 

It is based on the dataflow programming model, which greatly simplifies the writing of parallel and distributed pipelines, allowing you to focus on the flow of data and computation. 

Nextflow can deploy workflows on a variety of execution platforms, including your local machine, HPC schedulers, AWS Batch, Azure Batch, Google Cloud Batch, and Kubernetes. 

Additionally, it supports many ways to manage your software dependencies, including Conda, Spack, Docker, Podman, Singularity, and more.

> For more information, please consult the [documentation](https://www.nextflow.io/docs/latest/index.html).


<br> 

_______ 

## **Installation**

> Installation steps are available on this [page](https://www.nextflow.io/docs/latest/install.html).

### 1. Install java

```bash
# Install SDKMAN:
curl -s https://get.sdkman.io | bash

# Open a new terminal and install Java:
sdk install java 17.0.10-tem

# Confirm that Java is installed correctly:
java -version
```

### 2. Install Nextflow

```bash
# Install Nextflow:
curl -s https://get.nextflow.io | bash

# Make Nextflow executable:
chmod +x nextflow

# Move Nextflow into an executable path:
sudo mv nextflow /usr/local/bin

# Confirm that Nextflow is installed correctly:
nextflow info
```

<br>

___ 

## **Exercise**

You are now going to develop two workflows. You'll need to use conda to run the tools (If you wish, you can also use Docker).

### Workflow 1 

The first workflow aims to align reads against a genome.

Data :
- genome : `path/to/directory/data/workflow_managers/genome/genome.fasta`
- reads : `path/to/directory/data/workflow_managers/reads/*fastq.gz`

Tool :
- [Bowtie2](https://bowtie-bio.sourceforge.net/bowtie2/index.shtml)

### Workflow 2

For the second workflow, you will use Diamond to :
- Build a database
- Use BLASTp

Data :
- fasta file : `path/to/directory/examples/blastp/data/EP00398_MALV-I-01_sp_L67-1.fasta`

Tool :
- [Diamond](https://bowtie-bio.sourceforge.net/bowtie2/index.shtml) 2.1.8

___

<br>

### **Authorship & Acknowledgments**

- Written by Jérémy Rousseau (jrousseau)

- Reviewed for JEBif@JOBIM 2024 by Savandara Besse (@ladyson1806) 

>_Last modification: 06-24-2024_
