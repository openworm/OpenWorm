#!/bin/bash

docker build "$@" -t "openworm/openworm:0.9_py3"  -f Dockerfile3 . 
