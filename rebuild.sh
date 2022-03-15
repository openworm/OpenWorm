#!/bin/bash

docker build "$@" -t "openworm/openworm:0.9.2"  --no-cache .
