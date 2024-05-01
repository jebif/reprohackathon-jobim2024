## références
https://github.com/CebolaLab/RNA-seq

TP RNAseq, Master de Bioinformatique de l'Université de Rennes, semestre 7, Mme Vonick Sibut

## Pipeline

* Étape 1 (**STAR**) - indéxation du génome
* Étape 2 (**STAR**) - alignement des reads contre le génome
* Étape 3 (**samtools**) - indéxation des fichiers bam
* Étape 4 (**samtools**) - visualisation des fichiers bam (permets de montrer que l'on peut utiliser des scripts perso)
* Étape 5 (**qualimap**) - controle qualité post alignemnt
* Étape 6 (**featureCounts**) - comptage des reads alignés

