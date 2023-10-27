#!/bin/bash

#from: https://unix.stackexchange.com/a/129401
while getopts ":d:p:" opt; do
  case $opt in
    d) duration="$OPTARG"
    ;;
    p) p_out="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

OW_OUT_DIR=/home/ow/shared
HOST_OUT_DIR=$PWD
version=$(<VERSION) # Read version of Dockerfile from file VERSION

xhost +


NOC302_PART="-e NOC302=1"
DURATION_PART="-e DURATION=10"

docker run -d \
--name openworm_$version \
--device=/dev/dri:/dev/dri \
-e DISPLAY=$DISPLAY \
$NOC302_PART \
$DURATION_PART \
-e OW_OUT_DIR=$OW_OUT_DIR \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
--privileged \
-v $HOST_OUT_DIR:$OW_OUT_DIR:rw \
openworm/openworm:$version \
bash -c "DISPLAY=:44 python master_openworm.py"

docker logs -f openworm_$version
