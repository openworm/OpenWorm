#!/bin/bash

version=$(<VERSION) # Read version of Dockerfile from file VERSION

docker run -it --rm -p 8888:8888 "openworm/openworm:$version" jupyter lab --NotebookApp.default_url=/lab/ --ip=0.0.0.0 --port=8888 --allow-root
