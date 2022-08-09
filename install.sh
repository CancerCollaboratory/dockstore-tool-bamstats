#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

if [[ "${LANGUAGE}" == "cwl" ]]; then
    curl -o requirements.txt "https://raw.githubusercontent.com/dockstore/dockstore/develop/dockstore-webservice/src/main/resources/requirements/1.10.0/requirements3.txt"
    pip3 install --user -r requirements.txt
elif [[ "${LANGUAGE}" == "wdl" ]]; then
    wget https://github.com/broadinstitute/cromwell/releases/download/44/cromwell-44.jar
elif [[ "${LANGUAGE}" == "nfl" ]]; then
    curl -s https://get.nextflow.io | bash
    cp nextflow $HOME/bin
fi
