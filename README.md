# dockstore-tool-bamstats

A repo for the `Dockerfile` to create a Docker image for the BAMStats command. Also contains the
`Dockstore.yml` which is used by the [Dockstore](http://www.dockstore.org) to register
this container and describe how to call BAMStats for the community.

## Building Manually

Normally you would let [Quay.io](http://quay.io) build this.  But, if you need to build
manually you would execute:

    docker build -t briandoconnor/dockstore-tool-bamstats:1.25-3 .

## Running Manually

```
$ wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/NA12878/alignment/NA12878.chrom20.ILLUMINA.bwa.CEU.low_coverage.20121211.bam
$ docker run -it -v `pwd`/NA12878.chrom20.ILLUMINA.bwa.CEU.low_coverage.20121211.bam:/NA12878.chrom20.ILLUMINA.bwa.CEU.low_coverage.20121211.bam briandoconnor/dockstore-tool-bamstats:1.25

# within the docker container
$ java -Xmx7g -jar /opt/BAMStats-1.25/BAMStats-1.25.jar -i /NA12878.chrom20.ILLUMINA.bwa.CEU.low_coverage.20121211.bam -o test.html -v html
```

## Running Through the Dockstore Descriptor Launcher

This tool can be found at the [Dockstore Descriptor](https://github.com/CancerCollaboratory/dockstore-descriptor) git repo.  It lets you run a Docker container with a CWL descriptor locally, using Docker and the CWL command
line utility.  This is great for testing.

### Create Config File

Call it `launcher.ini`:

```
working-directory=./datastore/
```

### Make a Parameters JSON

This is the parameterization of the BAM stat tool:

```
{
  "bam_input": {
        "class": "File",
        "path": "ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/NA12878/alignment/NA12878.chrom20.ILLUMINA.bwa.CEU.low_coverage.20121211.bam"
    },
    "bamstats_report": {
        "class": "File",
        "path": "s3://oicr.temp/testing-launcher/bamstats_report.zip"
    }
}
```

### Run with Launcher

Run it using Java, make sure you have the dependencies installed for the Launcher, see the link above:

```
$ java -cp uber-io.github.collaboratory.launcher-1.0.2-SNAPSHOT.jar io.github.collaboratory.LauncherCWL --config launcher.ini --descriptor Dockstore.cwl --job sample_configs.json
```
