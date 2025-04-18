#!/bin/bash

version=$(<VERSION) # Read version of Dockerfile from file VERSION

# Set the platform flag if we're on ARM
arch=$(uname -m)
if [[ "$arch" == "arm64" || "$arch" == "aarch64" ]]; then
    platform_flag="--platform linux/amd64"
else
    platform_flag=""
fi

# Rebuild the Docker image
docker build $platform_flag "$@" -t "openworm/openworm:$version"  --no-cache .
