/*
* Exercise, in Nextflow
*/

nextflow.enable.dsl=2

params.fasta = "data/*.fasta"

process DiamondDB {
    
    input:
        path fasta
    
    output:
        path "reference.dmnd" 
    
    script:
        """
        diamond makedb --in ${fasta} -d reference
        """
}

process DiamondBLASTp {

    publishDir "$baseDir", mode: 'copy', pattern: 'matches.tsv'
    
    input:
        path fasta
        path reference
    
    output:
        path "matches.tsv"
    
    script:
        """
        diamond blastp -d ${reference} -q ${fasta} -o matches.tsv
        """
}

workflow {
    fasta_ch = Channel.fromPath(params.fasta)

    DiamondDB(fasta_ch)

    DiamondBLASTp(fasta_ch, DiamondDB.out)
}
