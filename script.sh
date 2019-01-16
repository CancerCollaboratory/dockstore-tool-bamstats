#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

if [[ "${LANGUAGE}" == "cwl" ]]; then
    cwltool --non-strict Dockstore.cwl test.json
    cwltool --non-strict Dockstore.cwl sample_configs.local.json
elif [[ "${LANGUAGE}" == "wdl" ]]; then
    java -jar cromwell-32.jar run Dockstore.wdl --inputs test.wdl.json
elif [[ "${LANGUAGE}" == "nfl" ]]; then
    nextflow run main.nf
fi
