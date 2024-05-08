process BamVisualization {
    
    /*
    * BAM visualization
    */

    publishDir "${params.results}/bam_visualization", mode: 'copy', pattern: "bam_head_*.txt"
    publishDir "${params.results}/bam_visualization", mode: 'copy', pattern: "bam_number_alignment_*.txt"

    label 'samtools'

    input:
        tuple val(replicateId), path(aligned_bam)

    output:
        path("bam_head_*.txt")
        path("bam_number_alignment_*.txt")
    
    script:
        """
        bam_visualization.sh ${aligned_bam} ${replicateId}
        """
}

process IndexBam {

    /*
    *  index the bam file
    */

    label 'samtools'

    input:
        tuple val(replicateId), path(aligned_bam)
        //      path('Aligned.sortedByCoord.out.bam.bai')

    output:
        tuple val(replicateId), path(aligned_bam), path('Aligned.sortedByCoord.out.bam.bai')

    script:
        """
        samtools index ${aligned_bam}
        """

}

process Flagstat {

    /*
    *  index the bam file
    */

    label 'samtools'

    input:
        tuple val(replicateId), path(aligned_bam)
        //      path('Aligned.sortedByCoord.out.bam.bai')

    output:
        tuple val(replicateId), path(aligned_bam), path('Aligned.sortedByCoord.out.bam.bai')

    script:
        """
        samtools flagstat ${aligned_bam} ${aligned_bam.baseName}.flagstat
        """

}