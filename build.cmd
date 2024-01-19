@SET /P version=<VERSION
docker build -t openworm/openworm:%version% .
