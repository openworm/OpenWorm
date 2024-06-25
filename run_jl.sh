#!/bin/bash

OW_OUT_DIR=/home/ow/shared
HOST_OUT_DIR=$PWD

version=$(<VERSION) # Read version of Dockerfile from file VERSION

xhost +

docker run --rm \
  --name openworm_jl_$version \
  --device=/dev/dri:/dev/dri \
  -e DISPLAY=$DISPLAY \
  -e OW_OUT_DIR=$OW_OUT_DIR \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  --privileged \
  -v $HOST_OUT_DIR:$OW_OUT_DIR:rw \
  -p 8889:8888 \
  openworm/openworm_jl:$version \
  start-notebook.py \
  --NotebookApp.token='openworm' &

sleep 3
echo
echo -e "To access the running JupyterLab instance, go to:"
echo -e "     http://localhost:8889/lab?token=openworm"
echo
echo -e "To stop the service type: ./stop_jl.sh"
echo
