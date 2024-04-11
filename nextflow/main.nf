/** Run the whole analysis pipeline 
 *
 * First try to reproduce the Differential Expression Analysis from the data source paper paper
 */

nextflow.enable.dsl=2

include { CUTADAPT } from "./workflow/cutadapt.nf"

samplesheet = params.sample;
samplesheet = file(samplesheet);

workflow ADAPTATOR_TRIMMING {
    take:
        sample_tuple
    main:
      fastq_1 = sample_tuple.map { id[0] }
      fastq_2 = sample_tuple.map { id[1] }
      fastq_1_trim = CUTADAPT(fastq_1)
      fastq_2_trim = CUTADAPT(fastq_2)
    emit:
        fastq_1_trim
        fastq_2_trim
}

workflow { 
    samples = Channel.fromPath(samplesheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sample, file(row.fastq_1), file(row.fastq_2))} \
        | ADAPTATOR_TRIMMING
}