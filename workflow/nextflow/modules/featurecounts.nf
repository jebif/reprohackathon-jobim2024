process FeatureCounts {

    /*
    * comptage des reads mappé
    */

    label 'featurecounts'

    publishDir "${params.results}/featureCount", mode: 'copy', pattern: "${replicateId}_count.txt"
    publishDir "${params.results}/featureCount/summary", mode: 'copy', pattern: "${replicateId}_count.txt.summary"
    publishDir "${params.results}/featureCount/out", mode: 'copy', pattern: "${replicateId}_featureCounts.out"

    input:
        tuple val(replicateId), path(aligned_bam)

    output:
        path("${replicateId}_count.txt")
        path("${replicateId}_count.txt.summary")
        path("${replicateId}_featureCounts.out")

    script:
        """
        featureCounts -p -s 0 \
                      -t exon \
                      -g gene_id \
                      -a ${params.gtf} \
                      -o ${replicateId}_count.txt \
                      ${aligned_bam}
        cp .command.log ${replicateId}_featureCounts.out
        """
}