#!/bin/bash -x

#from: https://unix.stackexchange.com/a/129401
while getopts ":d:p:" opt; do
  case $opt in
    d) duration="$OPTARG"
       shift
       shift
    ;;
    p) p_out="$OPTARG"
       shift
       shift
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

OW_OUT_DIR=/home/ow/shared
HOST_OUT_DIR=$PWD

if [ "$DISPLAY" ] ; then
    XSOCK=/tmp/.X11-unix
    XAUTH=/run/user/$UID/.docker.xauth
    if [ ! -e $XAUTH ] ; then
        xauth -f "$XAUTH" generate "$DISPLAY" . untrusted
    fi
    xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
    #chmod 777 $XAUTH
    XPART="-e DISPLAY=$DISPLAY -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH --net=host"
fi

if [ -z "$duration" ]
then #duration is not set, don't use it
    DURATION_PART=""
else #Duration is set, use it.
    DURATION_PART="-e DURATION=$duration"
fi

if [ $# -eq 0 ] ; then
    docker_cmd=( "bash" "-c" 'source "$VENV/bin/activate" ; "$PYTHON" "$HOME/master_openworm.py"' )
else
    docker_cmd=( "$@" )
fi
echo "$docker_cmd"

NAME=${NAME:-openworm}
IMAGE=${IMAGE:-openworm/openworm:0.9.2}

docker run \
    --name $NAME \
    --rm \
    -it \
    --device=/dev/dri:/dev/dri \
    $DURATION_PART \
    -e OW_OUT_DIR=$OW_OUT_DIR \
    $XPART \
    --privileged \
    -v $HOST_OUT_DIR:$OW_OUT_DIR:rw \
    -v "$(readlink -f master_openworm.py):/home/ow/master_openworm.py":ro \
    $IMAGE \
    "${docker_cmd[@]}"
