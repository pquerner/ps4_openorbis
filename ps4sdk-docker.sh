#!/bin/sh
DIR=(${PWD##*/})
docker run --env PS4SDKWORKDIR=${DIR} -v `pwd`:/${DIR} --rm -it --net host ps4sdk-docker
