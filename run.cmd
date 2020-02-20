@echo off
setlocal

set OW_OUT_DIR=/home/ow/shared
set HOST_OUT_DIR=%~dp0

:GETOPTS
 if /i "%1" == "-d" set DURATION=%2 & shift
 shift
if not "%1" == "" goto GETOPTS

if not defined DURATION set DURATION=15

  
echo on

docker run -d ^
  --name openworm ^
  -e OW_OUT_DIR=%OW_OUT_DIR% ^
  -e DURATION=%DURATION% ^
  --privileged ^
  -v %HOST_OUT_DIR%:%OW_OUT_DIR%:rw ^
  openworm/openworm:0.9 ^
  /bin/bash -c "python master_openworm.py"

docker logs -f openworm
  
@echo off
endlocal