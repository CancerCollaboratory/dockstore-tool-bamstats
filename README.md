# dockstore-tool-bamstats

A repo for the `Dockerfile` to create a Docker image for the BAMStats command. Also contains the
`Dockstore.yml` which is used by the [Dockstore](https://www.dockstore.org) to register
this container and describe how to call BAMStats for the community.

## Validation 

This tool has been validated as a CWL draft-3 and v1.0 CommandLineTool. 

Versions that we tested with are documented iin https://raw.githubusercontent.com/dockstore/dockstore/1.13.0-beta.3/dockstore-webservice/src/main/resources/requirements/1.13.0/requirements3.txt


## Building Manually

Normally you would let GitHub actions build this.  But, if you need to build manually (for example due to https://github.com/broadinstitute/cromwell/issues/6827)  you would execute:

    docker build -t ghcr.io/dockstore/dockstore-tool-bamstats:1.25-8 .

## Running Manually

```
$ wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/NA12878/alignment/NA12878.chrom20.ILLUMINA.bwa.CEU.low_coverage.20121211.bam
$ docker run -it -v `pwd`/NA12878.chrom20.ILLUMINA.bwa.CEU.low_coverage.20121211.bam:/NA12878.chrom20.ILLUMINA.bwa.CEU.low_coverage.20121211.bam ghcr.io/dockstore/dockstore-tool-bamstats:1.25-8

# within the docker container
$ /usr/local/bin/bamstats 4 /NA12878.chrom20.ILLUMINA.bwa.CEU.low_coverage.20121211.bam
```
You'll then see a file, `bamstats_report.zip`, in the current directory, that's the report file. You can use `-v` to mount the result out of the container.

## Running Through the Dockstore CLI

This tool can be found at the [Dockstore](https://dockstore.org), login with your GitHub account and follow the 
directions to setup the CLI.  It lets you run a Docker container with a CWL/WDL descriptor locally, using Docker and the CWL/WDL command line utility.  This is great for testing.

### With CWL

#### Make a Parameters JSON

This is the parameterization of the BAM stat tool, a copy is present in this repo called `sample_configs.json`:

```
{
  "bam_input": {
        "class": "File",
        "path": "ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/NA12878/alignment/NA12878.chrom20.ILLUMINA.bwa.CEU.low_coverage.20121211.bam"
    },
    "bamstats_report": {
        "class": "File",
        "path": "/tmp/bamstats_report.zip"
    }
}
```

#### Run with the CLI

Run it using the `dockstore` CLI:

```
# Fetch CWL workflow
dockstore workflow cwl --entry github.com/dockstore/dockstore-tool-bamstats/bamstats_cwl:feature/update > bamstats.cwl

# Make a runtime JSON template and edit it (or use the content of sample_configs.json above)
dockstore workflow convert cwl2json --cwl bamstats.cwl > Dockstore.json

# Update the "path" field for both input and output files within Dockstore.json
jq '.bam_input.path |= "ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/NA12878/alignment/NA12878.chrom20.ILLUMINA.bwa.CEU.low_coverage.20121211.bam"| .bamstats_report.path |= "/tmp/bamstats_report.zip"' Dockstore.json | sponge  Dockstore.json

# Run it locally with the Dockstore CLI
dockstore workflow launch --entry github.com/dockstore/dockstore-tool-bamstats/bamstats_cwl:feature/update --json Dockstore.json
```

### With WDL
#### Make a Parameters JSON

This is the parameterization of the BAM stat tool, a copy is present in this repo called `test.wdl.json`:

```
{
  "bamstatsWorkflow.bam_input": "rna.SRR948778.bam",
  "bamstatsWorkflow.mem_gb": "4"
}
```

#### Run with the CLI

Run it using the `dockstore` CLI:

```
Usage:
# fetch WDL
$> dockstore workflow wdl --entry github.com/dockstore/dockstore-tool-bamstats/wdl:feature/update > bamstats.wdl
# make a runtime JSON template and edit it (or use the content of test.wdl.json above)
$> dockstore workflow convert wdl2json --wdl bamstats.wdl > Dockstore.json
# run it locally with the Dockstore CLI
$> dockstore workflow launch --entry github.com/dockstore/dockstore-tool-bamstats/wdl:feature/update --json Dockstore.json
```

## Running Nextflow Workflow

Install [Nextflow](https://www.nextflow.io/). Nextflow workflows cannot be run with the Dockstore CLI yet.

The workflow can be run using the following command:
```
$> nextflow run main.nf
```
