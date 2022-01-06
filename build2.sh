#!/bin/bash

# For generating/running a Dockerfile image based on Python 2
# Note: Python 2 is no longer officially supported and this Docker image will
# probably stop working eventually...

docker build "$@" -t "openworm/openworm:0.9.2_py2"  -f Dockerfile2 .
