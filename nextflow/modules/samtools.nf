process SamtoolsPrepareGenome {

    label 'samtool'

    input:
        path genome

    output:
        path "${genome}.fai"

    script:
        """
        samtools faidx ${genome}
        """

}