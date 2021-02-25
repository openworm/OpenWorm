#!/bin/bash

docker build "$@" -t "openworm/openworm:0.9.1"  --no-cache .
