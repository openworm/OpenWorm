#!/bin/bash

version=$(<VERSION) # Read version of Dockerfile from file VERSION
docker build "$@" -t "openworm/openworm:$version" .
