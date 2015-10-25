# dockstore-tool-bamstats

A repo for the `Dockerfile` to create a Docker image for the BAMStats command. Also contains the 
`Dockstore.yml` which is used by the [Dockstore](http://www.dockstore.org) to register
this container and describe how to call BAMStats for the community.

## Building

Normally you would let [Quay.io](http://quay.io) build this.  But, if you need to build
manually you would execute:

    docker build -t briandoconnor/dockstore-tool-bamstats:1.25 .


