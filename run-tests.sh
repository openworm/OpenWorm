#!/bin/bash
set -ex

OW_OUT_DIR=/home/ow/shared
HOST_OUT_DIR=$PWD

version=$(<VERSION) # Read version of Dockerfile from file VERSION

docker run -d \
  --name openworm_$version \
  --device=/dev/dri:/dev/dri \
  -e DISPLAY=$DISPLAY \
  -e OW_OUT_DIR=$OW_OUT_DIR \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  --privileged \
  -v $HOST_OUT_DIR:$OW_OUT_DIR:rw \
  openworm/openworm:$version \
  bash -c "cd /home/ow/sibernetic && time ./test.sh && ls -alt /home/ow/sibernetic/simulations && cp -R /home/ow/sibernetic/simulations/* $OW_OUT_DIR/output"

echo "Set running running Docker container with Sibernetic in detached mode. Attaching to logs now..."

docker logs -f openworm_$version

echo "Finished running the Docker container"