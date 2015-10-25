#############################################################
# Dockerfile to build a sample tool container for BAMStats
#############################################################

# Set the base image to SeqWare
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Brian O'Connor <briandoconnor@gmail.com>

# Setup packages
USER root
RUN apt-get -m update && apt-get install -y apt-utils tar git curl nano wget dialog net-tools build-essential time

# get the tool
RUN wget -q http://downloads.sourceforge.net/project/bamstats/BAMStats-1.25.zip
RUN unzip BAMStats-1.25.zip
CMD ["/bin/bash"]
