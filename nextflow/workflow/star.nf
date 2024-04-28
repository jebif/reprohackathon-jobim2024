
/** Create the genome index file for STAR
 *
 * Shamelessly stolen from nf-core training: https://training.nextflow.io/hands_on/04_implementation/#process-1b-create-a-fasta-genome-sequence-dictionary-with-picard-for-gatk
 */

process STAR_INDEX {
    container 'quay.io/biocontainers/star:2.7.10b--h6b7c446_1'
    input:
        path genome
    output:
        path "genomeDir", emit: genome_index
    script:
    """
    mkdir -p genomeDir
    STAR --runMode genomeGenerate \
        --genomeDir genomeDir \
        --genomeFastaFiles ${genome} \
        --runThreadN ${task.cpus}
    """
}

process STAR_MAPPING {
    container 'quay.io/biocontainers/mulled-v2-52f8f283e3c401243cee4ee45f80122fbf6df3bb:e3bc54570927dc255f0e580cba1789b64690d611-0'
    input:
        path genome
        path genomeDir
        tuple val(replicateId), path(reads)
    output:
        path('Aligned.sortedByCoord.out.bam'), emit: bam
    script:
        """
        #STAR --genomeDir ${genomeDir} \
        #    --readFilesIn ${reads} \
        #    --runThreadN ${task.cpus} \
        #    --readFilesCommand cat
        #    # --outFilterType BySJout \
        #    # --alignSJoverhangMin 8 \
        #    # --alignSJDBoverhangMin 1 \
        #    # --outFilterMismatchNmax 999


        STAR --genomeDir ${genomeDir} \
            --readFilesIn ${reads} \
            --runThreadN ${task.cpus} \
            --readFilesCommand cat \
            --outSAMtype BAM SortedByCoordinate \
            --outSAMattrRGline ID:${replicateId} LB:library PL:illumina \
                                PU:machine SM:GM12878
            # --outFilterType BySJout \
            # --alignSJoverhangMin 8 \
            # --alignSJDBoverhangMin 1 \
            # --outFilterMismatchNmax 999 \

        """
}


process STAR_BAM_INDEX {
    input:
        path bam
    output:
        path "${bam}.bai"
    script:
    """
    samtools index "${bam}"
    """
}
