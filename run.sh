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

xhost +

if [ -z "$duration" ]
then #duration is not set, don't use it
  docker run -d \
    --name openworm \
    --device=/dev/dri:/dev/dri \
    -e DISPLAY=$DISPLAY \
    -e OW_OUT_DIR=$OW_OUT_DIR \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --privileged \
    -v $HOST_OUT_DIR:$OW_OUT_DIR:rw \
    openworm/openworm:0.9 \
    bash -c "DISPLAY=:44 python master_openworm.py"
else #Duration is set, use it.
  docker run -d \
    --name openworm \
    --device=/dev/dri:/dev/dri \
    -e DISPLAY=$DISPLAY \
    -e DURATION=$duration \
    -e OW_OUT_DIR=$OW_OUT_DIR \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --privileged \
    -v $HOST_OUT_DIR:$OW_OUT_DIR:rw \
    openworm/openworm:0.9 \
    bash -c "DISPLAY=:44 python master_openworm.py"
fi

docker logs -f openworm
