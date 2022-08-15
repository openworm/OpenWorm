#!/bin/bash

# For generating/running a Dockerfile image based on Python 2
# Note: Python 2 is no longer officially supported and this Docker image will
# probably stop working eventually...

version=$(<VERSION) # Read version of Dockerfile from file VERSION
docker build "$@" -t "openworm/openworm:${version}_py2"  -f Dockerfile2 .
