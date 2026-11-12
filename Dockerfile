# 1) choose base container
# generally use the most recent tag

# base notebook, contains Jupyter and relevant tools
# See https://github.com/ucsd-ets/datahub-docker-stack/wiki/Stable-Tag 
# for a list of the most current containers we maintain
ARG BASE_CONTAINER=ghcr.io/ucsd-ets/datascience-notebook:stable

FROM $BASE_CONTAINER

LABEL maintainer="UC San Diego ITS/ETS <ets-consult@ucsd.edu>"
LABEL org.opencontainers.image.source="https://github.com/TheBoyRoy05/DSC180A-Methodology-5"

# 2) change to root to install packages
USER root

RUN apt-get update && apt-get -y install aria2 nmap traceroute

# 3) install packages using notebook user
USER jovyan

# Pin numpy to the base image's version: an unpinned install upgrades it to 2.x,
# which breaks the base image's pandas and pyarrow, built against numpy 1.x.
RUN pip install --no-cache-dir geopandas babypandas==0.1.5 \
    "numpy==$(python -c 'import numpy; print(numpy.__version__)')"

# Override command to disable running jupyter notebook at launch
CMD ["/bin/bash"]
