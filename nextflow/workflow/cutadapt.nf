

process CUTADAPT {
  input:
    file fastq_input
  output:
    val "${fastq_input.baseName}.trim.fastq"  
  script:
  """
  cutadapt --minimum-length=25 --quality-cutoff=20 -a AGATCGGAAGAGC -A AGATCGGAAGAGC -o ${output} ${fastq_input}
  """
}