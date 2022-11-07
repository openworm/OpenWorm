#!/bin/bash

version=$(<VERSION) # Read version of Dockerfile from file VERSION

docker stop openworm_${version}
docker rm openworm_${version}
