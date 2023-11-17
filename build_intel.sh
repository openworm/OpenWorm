#!/bin/bash

# A version of the docker container using the Intel libraries for OpenCL

version=$(<VERSION) # Read version of Dockerfile from file VERSION
docker build --platform linux/amd64  "$@" -t "openworm/openworm:$version" -f Dockerfile_intel .
