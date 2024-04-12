process GUNZIP {
  input:
    path archive_gz
  output:
    path archive_gz.baseName
  script:
  real_gz = "readlink ${archive_gz}" // ref. https://github.com/nextflow-io/nextflow/issues/1009#issuecomment-534428865
  """
  gunzip -c "\$(${real_gz})" > "${archive_gz.baseName}" 
  """
}