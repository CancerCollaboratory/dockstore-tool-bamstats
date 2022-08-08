#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

if [[ "${LANGUAGE}" == "cwl" ]]; then
    cwltool --non-strict Dockstore.cwl test.json
elif [[ "${LANGUAGE}" == "wdl" ]]; then
    java -jar cromwell-32.jar run Dockstore.wdl --inputs test.wdl.json
elif [[ "${LANGUAGE}" == "nfl" ]]; then
    ./nextflow run main.nf
fi
