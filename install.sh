#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

if [[ "${LANGUAGE}" == "cwl" ]]; then
    curl -o requirements.txt "https://staging.dockstore.org/api/metadata/runner_dependencies?client_version=1.7.0-rc.2&python_version=3"
    pip3 install --user -r requirements.txt
elif [[ "${LANGUAGE}" == "wdl" ]]; then
    wget https://github.com/broadinstitute/cromwell/releases/download/44/cromwell-44.jar
elif [[ "${LANGUAGE}" == "nfl" ]]; then
    curl -s https://get.nextflow.io | bash
    mv nextflow $HOME/bin
fi
