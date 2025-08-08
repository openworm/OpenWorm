#!/bin/bash

version=$(<VERSION) # Read version of Dockerfile from file VERSION


#from: https://unix.stackexchange.com/a/129401
while getopts ":d:c:" opt; do
  case "${opt}" in
    d) duration="$OPTARG"
    ;;
    c) configuration="$OPTARG"
    ;;
    *) echo "Usage: $0 [-d duration] [-c configuration]" >&2
       exit 1
    ;;
  esac
done

OW_OUT_DIR=/home/ow/shared
HOST_OUT_DIR=$PWD


xhost +

if [ -z "$duration" ]
then #duration is not set, don't use it
    DURATION_PART=""
else #Duration is set, use it.
    DURATION_PART="-e DURATION=$duration"
fi

if [ -z "$configuration" ]
then #configuration is not set, don't use it
    CONFIGURATION_PART=""
else #Configuration is set, use it.
    CONFIGURATION_PART="-e CONFIGURATION=$configuration"
fi


echo "Running Docker container for OpenWorm v${version}"


docker run -d \
--name openworm_$version \
--device=/dev/dri:/dev/dri \
-e DISPLAY=$DISPLAY \
$CONFIGURATION_PART \
$DURATION_PART \
-e OW_OUT_DIR=$OW_OUT_DIR \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
--privileged \
-v $HOST_OUT_DIR:$OW_OUT_DIR:rw \
openworm/openworm:$version \
bash -c "DISPLAY=:44 python3 master_openworm.py"

docker logs -f openworm_$version
