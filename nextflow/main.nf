/** Run the whole analysis pipeline
 *
 * First try to reproduce the Differential Expression Analysis from the data source paper paper
 */

nextflow.enable.dsl=2

include { CUTADAPT } from "./workflow/cutadapt.nf"
include { GUNZIP as GUNZIP_1 } from "./workflow/gunzip.nf"
include { GUNZIP as GUNZIP_2 } from "./workflow/gunzip.nf"

include { STAR_INDEX } from "./workflow/star.nf"
include { STAR_MAPPING } from "./workflow/star.nf"
include { STAR_BAM_INDEX } from "./workflow/star.nf"


samplesheet = params.sample;
samplesheet = file(samplesheet);
genome = Channel.fromPath(params.genome);
annotations = params.annotations;


workflow ADAPTATOR_TRIMMING {
    take:
        sample_tuple
    main:
        sampleId = sample_tuple.map { it[0] }
        fastq_1_gz = sample_tuple.map { it[1] }
        fastq_2_gz = sample_tuple.map { it[2] }
        GUNZIP_1(fastq_1_gz)
        GUNZIP_2(fastq_2_gz)
        CUTADAPT(sampleId, GUNZIP_1.out, GUNZIP_2.out)

    emit:
        sampleId = sampleId
        trimmed_reads = CUTADAPT.out
}


workflow {
    samples = Channel.fromPath(samplesheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sample, file(row.fastq_1), file(row.fastq_2))}
    ADAPTATOR_TRIMMING(samples)

    trimmed_reads = ADAPTATOR_TRIMMING.out.trimmed_reads

    STAR_INDEX(genome)

    genome_index = STAR_INDEX.out.genome_index

    STAR_MAPPING(genome, genome_index, trimmed_reads)

    bam = STAR_MAPPING.out.bam

    STAR_BAM_INDEX(bam)
}
