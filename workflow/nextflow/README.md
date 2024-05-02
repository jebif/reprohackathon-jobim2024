## Pipeline

* Step 1 (**STAR**) - genome indexation
* Step 2 (**STAR**) - read alignment against the genome
* Step 3 (**samtools**) - indexing BAM files
* Step 4 (**samtools**) - view BAM files (using a personal script)
* Step 5 (**qualimap**) - post-alignment quality control
* Step 6 (**featureCounts**) - count of aligned reads

## References
* RNA-seq: a step-by-step analysis pipeline : https://github.com/CebolaLab/RNA-seq
* TP RNAseq, Master de Bioinformatique de l'Université de Rennes, semestre 7, Mme Vonick Sibut
