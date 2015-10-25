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
    dockerPull: "briandoconnor/dockstore-tool-bamstats:1.25"
  - { import: node-engine.cwl }

hints:
  - class: ResourceRequirement
    coresMin: 8
    ramMin: 4092
    outdirMin: 512000
    description: "these parameters are used to locate a VM with appropriate resources"

inputs:
  - id: "#ref_file_1"
    type: File
    description: "this describes a large reference file that does not change between runs"

  - id: "#ref_file_2"
    type: File
    description: "this describes a large reference file that does not change between runs"

  - id: "#hello_input"
    type: File
    description: "this describes an input file that should be provided before execution"

outputs:
  - id: "#hello_output"
    type: File
    outputBinding:
      glob: hello-output.txt
    description: "this describes an output file that should be saved after execution"

baseCommand: ["bash", "-c"]
arguments:
  - valueFrom:
      engine: node-engine.cwl
      script: |
        "cat " + $job.hello_input.path + " > hello-output.txt &&"
            + " ls " + $job.ref_file_1.path + " >> hello-output.txt && "
            + " head -20 " + $job.ref_file_2.path + " >> hello-output.txt"
