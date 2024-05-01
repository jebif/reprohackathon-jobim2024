/*
* Run the whole analysis pipeline
*
* First try to reproduce the Differential Expression Analysis from the data source paper paper
*/

nextflow.enable.dsl=2


// import module
include { GenomeIndexation } from "./modules/star.nf"
include { StarAlignment    } from "./modules/star.nf"
include { IndexBam         } from "./modules/samtools.nf"
include { BamVisualization } from "./modules/samtools.nf"
include { Qualimap         } from "./modules/qualimap.nf"
include { FeatureCounts     } from "./modules/featurecounts.nf"

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	RUN WORKFLOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

workflow {
    reads_ch = Channel.fromFilePairs(params.reads)
    
    // Indéxation du génome
    GenomeIndexation(params.genome)
    
    // alignement des reads contre le génome 
    StarAlignment(GenomeIndexation.out, reads_ch)

    // indéxation des fichier bam
    IndexBam(StarAlignment.out)

    // visualisation des fichiers bam
    BamVisualization(StarAlignment.out)

    // controle qualité des alignements
    Qualimap(StarAlignment.out)

    // comptage des reads
    FeatureCounts(StarAlignment.out)
}