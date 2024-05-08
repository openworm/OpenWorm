SET OW_OUT_DIR=/home/ow/shared
SET HOST_OUT_DIR=%~dps0

docker run -it ^
    --name openworm ^
    -e OW_OUT_DIR=%OW_OUT_DIR% ^
    --privileged ^
    -v %HOST_OUT_DIR%:%OW_OUT_DIR%:rw ^
    openworm/openworm:0.9.3 ^
    /bin/bash
