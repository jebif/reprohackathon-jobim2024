process Qualimap {

    label 'qualimap'

    publishDir "${params.results}/qualimap", mode: 'copy', pattern: "${replicateId}-qualimap-report"

    input:
        tuple val(replicateId), path(aligned_bam)

    output:
        path("${replicateId}-qualimap-report")

    script:
        """
        qualimap rnaseq -bam ${aligned_bam} -gtf ${params.gtf} -outdir ${replicateId}-qualimap-report --java-mem-size=16G
        """
}