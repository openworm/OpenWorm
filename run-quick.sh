#!/bin/bash
set -ex

#from: https://unix.stackexchange.com/a/129401
OW_OUT_DIR=/home/ow/shared
HOST_OUT_DIR=$PWD
version=$(<VERSION) # Read version of Dockerfile from file VERSION

xhost + || true # allow connections to X server, don't throw an error if it fails


docker run -d \
--name openworm_$version \
--device=/dev/dri:/dev/dri \
-e DISPLAY=$DISPLAY \
-e OW_OUT_DIR=$OW_OUT_DIR \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
--privileged \
-v $HOST_OUT_DIR:$OW_OUT_DIR:rw \
openworm/openworm:$version \
bash -c "DISPLAY=:44 python3 master_openworm.py -n -d 10"

docker logs -f openworm_$version
