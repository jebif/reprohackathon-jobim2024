

process CUTADAPT {
  conda 'bioconda::cutadapt=4.7'
  input:
    file fastq_1
    file fastq_2
  output:
    path "${fastq_1.baseName}.trim.fastq"
    path "${fastq_2.baseName}.trim.fastq"
  script:
  """
  cutadapt --minimum-length=25 --quality-cutoff=20 -a AGATCGGAAGAGC -A AGATCGGAAGAGC -o "${fastq_1.baseName}.trim.fastq" -p "${fastq_2.baseName}.trim.fastq" "${fastq_1}" "${fastq_2}"
  """
}
