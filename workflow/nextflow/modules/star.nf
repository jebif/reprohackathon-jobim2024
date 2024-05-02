process GenomeIndexation {

    /*
    *
    */

    label 'star'

    input:
        path genome

    output:
        path 'genome_dir'

    script:
        """
        mkdir -p genome_dir

        STAR --runMode genomeGenerate \
             --genomeDir genome_dir \
             --genomeFastaFiles ${genome} \
             --runThreadN ${task.cpus}
        """
}

process StarAlignment {

    /*
    *
    */

    label 'star'

    input:
        path genomeDir
        tuple val(replicateId), path(reads)
    
    output:
        tuple val(replicateId), path('Aligned.sortedByCoord.out.bam')

    script:
        """
        STAR --genomeDir ${genomeDir} \
            --readFilesIn ${reads} \
            --runThreadN ${task.cpus} \
            --readFilesCommand zcat \
            --outFilterType BySJout \
            --alignSJoverhangMin 8 \
            --alignSJDBoverhangMin 1 \
            --outFilterMismatchNmax 999 \
            --outSAMtype BAM SortedByCoordinate \
            --outSAMattrRGline ID:${replicateId} LB:library PL:illumina PU:machine SM:GM12878
        """
}

