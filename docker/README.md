# Docker Related Files

## Prerequisites

Installed and configured docker and docker-compose are necessary to successfully
run the container.

## Building and running the container

The container is build by
```
docker-compose build
```
and started by
```
docker-compose up -d
```

## JupyterLab setup

To enter to the JupyterLab instance start the container and open
http://127.0.0.1:8888/lab

All the programs available in the openworm/openworm image are available in the
jupyterlab interface.
