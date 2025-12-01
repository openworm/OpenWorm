#!/bin/bash

version=$(<VERSION) # Read version of Dockerfile from file VERSION

C302_PART=""

#from: https://unix.stackexchange.com/a/129401
while getopts ":d:c:n" opt; do
  case "${opt}" in
    d) duration="$OPTARG"
    ;;
    c) configuration="$OPTARG"
    ;;
    n) C302_PART="-e NOC302=1"
    ;;
    *) echo "Usage: $0 [-d duration_in_ms] [-c configuration] [-n]" >&2
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

echo "Running OpenWorm Docker container. Additional options: $DURATION_PART $CONFIGURATION_PART $C302_PART"
# Check and get list of all running containers
output=$(docker ps -a)

# Check if the openworm container is already running
if echo "$output" | grep -q "openworm_$version"; then
    echo -e "\n**************\n  Docker container openworm_$version is already running.\n  Please stop and remove it before running a new one (run: ./stop.sh).\n**************"
    exit 1
fi

echo "Running Docker container for OpenWorm v${version}"


docker run -d \
--name openworm_$version \
--device=/dev/dri:/dev/dri \
-e DISPLAY=$DISPLAY \
$CONFIGURATION_PART \
$DURATION_PART \
$C302_PART \
-e OW_OUT_DIR=$OW_OUT_DIR \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
--privileged \
-v $HOST_OUT_DIR:$OW_OUT_DIR:rw \
openworm/openworm:$version \
bash -c "DISPLAY=:44 python3 master_openworm.py"

docker logs -f openworm_$version
