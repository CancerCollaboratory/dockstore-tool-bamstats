#############################################################
# Dockerfile to build a sample tool container for BAMStats
#############################################################

# set the base image to a version of Ubuntu with LTS
FROM ubuntu:22.04

# two different ways of declaring authorship
LABEL maintainer="aofarrel@ucsc.edu"
LABEL org.opencontainers.image.authors="Brian O'Connor <briandoconnor@gmail.com>, Ash O'Farrell <aofarrel@ucsc.edu>"

# setup packages
# software-properties-common: needed to add openjdk repository
# openjdk 11: needed by bamstats
# wget: needed to download bamstats
# unzip: needed to install bamstats
# zip: needed to handle bamstats output
USER root
RUN apt-get -m update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && apt-get update -q && apt install -y openjdk-11-jdk && \
    apt-get install -y wget && \
    apt-get install -y unzip && \
    apt-get install -y zip

# get the tool and install it in /usr/local/bin
RUN wget -q http://downloads.sourceforge.net/project/bamstats/BAMStats-1.25.zip
RUN unzip BAMStats-1.25.zip && \
    rm BAMStats-1.25.zip && \
    mv BAMStats-1.25 /opt/
COPY bin/bamstats /usr/local/bin/
RUN chmod a+x /usr/local/bin/bamstats

# switch back to the ubuntu user so this tool (and the files written) are not owned by root
RUN groupadd -r -g 1000 ubuntu && useradd -r -g ubuntu -u 1000 -m ubuntu
USER ubuntu

# by default, /bin/bash is executed
CMD ["/bin/bash"]
