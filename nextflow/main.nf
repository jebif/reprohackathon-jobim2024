/** Run the whole analysis pipeline
 *
 * First try to reproduce the Differential Expression Analysis from the data source paper paper
 */

nextflow.enable.dsl=2

include { CUTADAPT } from "./workflow/cutadapt.nf"
include { GUNZIP as GUNZIP_1 } from "./workflow/gunzip.nf"
include { GUNZIP as GUNZIP_2 } from "./workflow/gunzip.nf"


samplesheet = params.sample;
samplesheet = file(samplesheet);

workflow ADAPTATOR_TRIMMING {
    take:
        sample_tuple
    main:
        fastq_1_gz = sample_tuple.map { it[1] }
        fastq_2_gz = sample_tuple.map { it[2] }
        GUNZIP_1(fastq_1_gz)
        GUNZIP_2(fastq_2_gz)
        CUTADAPT(GUNZIP_1.out, GUNZIP_2.out)

    emit:
        CUTADAPT.out[0]
        CUTADAPT.out[1]
}

workflow READ_MAPPING {
    take:
        fastq
}

workflow {
    Channel.fromPath(samplesheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sample, file(row.fastq_1), file(row.fastq_2))} \
        | ADAPTATOR_TRIMMING
}
