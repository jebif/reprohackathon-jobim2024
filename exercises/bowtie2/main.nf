/*
* Exercise, in Nextflow
*/

nextflow.enable.dsl=2

params.genome = "data/genome.fasta"
params.datapath = "data/*.fastq.gz"
params.index_prefix = "test"

reads_ch = Channel.fromPath(params.datapath)
genome_ch = Channel.fromPath(params.genome)

process index {
    
    input:
        path genome
    
    output:
        path "${params.index_prefix}.*.bt2", emit: index
    
    script:
    """
    bowtie2-build --threads ${task.cpus} -f "${genome}" "${params.index_prefix}"
    """
}

process align {

    publishDir "$baseDir/results", mode: 'copy', pattern: '*.sam'
    
    input:
        path index
        path reads
    
    output:
        path "${reads.baseName}.sam", emit: sam
    
    script:
    """
    bowtie2 -x "${params.index_prefix}" -U "${reads}" -S "${reads.baseName}.sam"
    """
}

workflow {
    // reads_ch.view()
    index(genome_ch)

    align(index.out, reads_ch)
}
