#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

if [[ "${LANGUAGE}" == "cwl" ]]; then
    dockstore workflow cwl --entry github.com/dockstore/dockstore-tool-bamstats/bamstats_cwl:feature/update | tee bamstats.cwl	
    dockstore workflow convert cwl2json --cwl bamstats.cwl | tee Dockstore.json
    jq '.bam_input.path |= "ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/NA12878/alignment/NA12878.chrom20.ILLUMINA.bwa.CEU.low_coverage.20121211.bam"| .bamstats_report.path |= "/tmp/bamstats_report.zip"' Dockstore.json | sponge  Dockstore.json
    dockstore workflow launch --entry github.com/dockstore/dockstore-tool-bamstats/bamstats_cwl:feature/update --json Dockstore.json
elif [[ "${LANGUAGE}" == "wdl" ]]; then
    dockstore workflow wdl --entry github.com/dockstore/dockstore-tool-bamstats/wdl:feature/update | tee bamstats.wdl
    dockstore workflow convert wdl2json --wdl bamstats.wdl | tee Dockstore.json
    dockstore workflow launch --entry github.com/dockstore/dockstore-tool-bamstats/wdl:feature/update --json Dockstore.json
elif [[ "${LANGUAGE}" == "nfl" ]]; then
    echo "nextflow is not supported by the Dockstore CLI (yet?)"; 
fi
