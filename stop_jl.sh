#!/bin/bash

version=$(<VERSION) # Read version of Dockerfile from file VERSION

docker stop openworm_jl_${version}
docker rm openworm_jl_${version}
