#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

if [[ "${LANGUAGE}" == "cwl" ]]; then
    cwltool --non-strict bamstats.cwl test.json
elif [[ "${LANGUAGE}" == "wdl" ]]; then
    java -jar cromwell-44.jar run bamstats.wdl --inputs test.wdl.json
elif [[ "${LANGUAGE}" == "nfl" ]]; then
    ./nextflow run main.nf
fi
