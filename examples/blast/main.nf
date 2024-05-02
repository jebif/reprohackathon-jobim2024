/*
* Exercise, in Nextflow
*/

nextflow.enable.dsl=2

params.fasta = "data/*.fasta"

fasta_ch = Channel.fromPath(params.fasta)

process DiamondDB {
    
    input:
        path fasta
    
    output:
        path "reference" 
    
    script:
    """
    diamond makedb --in ${fasta} -d reference
    """
}

process DiamondBLASTp {

    publishDir "$baseDir", mode: 'copy', pattern: 'diamond_alignment'
    
    input:
        path fasta
        path reference
    
    output:
        path "diamond_alignment"
    
    script:
    """
    diamond blastp -d ${reference} -q ${fasta} -o matches.tsv
    """
}

workflow {


    // reads_ch.view()
    DiamondDB(fasta_ch)

    DiamondBLASTp(fasta_ch, DiamondDB.out)
}
