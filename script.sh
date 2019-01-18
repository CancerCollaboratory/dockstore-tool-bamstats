#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

if [[ "${LANGUAGE}" == "cwl" ]]; then
    cwltool --non-strict Dockstore.cwl test.json
    wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/NA12878/alignment/NA12878.chrom20.ILLUMINA.bwa.CEU.low_coverage.20121211.bam
    mv NA12878.chrom20.ILLUMINA.bwa.CEU.low_coverage.20121211.bam /tmp/
    cwltool --non-strict Dockstore.cwl sample_configs.local.json
elif [[ "${LANGUAGE}" == "wdl" ]]; then
    java -jar cromwell-32.jar run Dockstore.wdl --inputs test.wdl.json
elif [[ "${LANGUAGE}" == "nfl" ]]; then
    nextflow run main.nf
fi
