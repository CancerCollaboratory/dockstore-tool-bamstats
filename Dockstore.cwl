#!/usr/bin/env cwl-runner

class: CommandLineTool
description: "A Docker container for the BAMStats command. See the [BAMStats](http://bamstats.sourceforge.net/) website for more information."
id: "BAMStats"
label: "BAMStats tool"

dct:creator:
  "@id": "http://orcid.org/0000-0002-7681-6415"
  foaf:name: Brian O'Connor
  foaf:mbox: "mailto:briandoconnor@gmail.com"

requirements:
  - class: DockerRequirement
    dockerPull: "quay.io/briandoconnor/dockstore-tool-bamstats:1.25-2"
  - { import: node-engine.cwl }

hints:
  - class: ResourceRequirement
    coresMin: 1
    ramMin: 4092
    outdirMin: 512000
    description: "the process requires at least 4G of RAM"

inputs:
  - id: "#mem_gb"
    type: int
    default: 4
    description: "The memory, in GB, for the reporting tool"
    inputBinding:
      position: 1

  - id: "#bam_input"
    type: File
    description: "The BAM file used as input, it must be sorted."
    inputBinding:
      position: 2

outputs:
  - id: "#bamstats_report"
    type: File
    outputBinding:
      glob: bamstats_report.zip
    description: "A zip file that contains the HTML report and various graphics."

baseCommand: ["bash", "/usr/local/bin/bamstats"]
