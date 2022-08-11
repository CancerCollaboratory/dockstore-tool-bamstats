#!/usr/bin/env cwl-runner
  
class: CommandLineTool
id: "BAMStats - Sort demo"
label: "BAMStats tool - Sort demo"
cwlVersion: v1.0 
doc: |
    This demonstrates an alternate descriptor to Dockstore.cwl
    A Docker container for the sort command using a container shared with bamstats.

dct:creator:
  "@id": "http://orcid.org/0000-0002-7681-6415"
  foaf:name: Brian O'Connor
  foaf:mbox: "mailto:briandoconnor@gmail.com"

requirements:
  - class: DockerRequirement
    dockerPull: "ghcr.io/dockstore/dockstore-tool-bamstats:1.25-8"

inputs:
  input:
    type:
      type: array
      items: File
    inputBinding:
      position: 4
  
  output:
    type: string

  key:
    type: 
      type: array
      items: string 
      inputBinding:
        prefix: "-k"
    inputBinding:
      position: 1
    description: |
      -k, --key=POS1[,POS2]
      start a key at POS1, end it at POS2 (origin 1)

stdout: $(inputs.output)

outputs:
  sorted:
    type: File
    description: "The sorted file"
    outputBinding: 
      glob: $(inputs.output)

baseCommand: ["sort"]
