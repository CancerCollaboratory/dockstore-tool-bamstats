#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

if [[ "${LANGUAGE}" == "cwl" ]]; then
    pip2.7 install --user cwl-runner cwltool==1.0.20190915164430 schema-salad==4.5.20190906201758 avro==1.8.1
elif [[ "${LANGUAGE}" == "wdl" ]]; then
    wget https://github.com/broadinstitute/cromwell/releases/download/44/cromwell-44.jar
elif [[ "${LANGUAGE}" == "nfl" ]]; then
    curl -s https://get.nextflow.io | bash
    mv nextflow $HOME/bin
fi
