/*
* Run the whole analysis pipeline
*
* First try to reproduce the Differential Expression Analysis from the data source paper paper
*/

nextflow.enable.dsl=2


// import module
include { Cutadapt } from "./modules/cutadapt.nf"
include { SamtoolsPrepareGenome } "./modules/samtools.nf"


/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	RUN WORKFLOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

workflow {
    reads_ch = Channel.fromFilePairs(params.reads)
    
    SamtoolsPrepareGenome(params.genome)
}