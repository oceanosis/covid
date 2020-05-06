#!/usr/bin/env bash
set -e

BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CONTAINER_NAME="pyapp"
PYTHON_VERSION="3.7.7"
PYAPPS=$BASE/python
PYDATA=$BASE/coviddata

docker stop $CONTAINER_NAME  || true && docker rm $CONTAINER_NAME || true

[ -d $PYDATA ] || mkdir -p "$PYDATA"

if [ "$(ls -A $PYDATA)" ]; then
    rm -rf $PYDATA && mkdir -p "$PYDATA"
elif [ ! -d $PYDATA ]; then
    mkdir -p "$PYDATA"
fi

docker run -d --name $CONTAINER_NAME \
	   -v "$PYAPPS":"/apps" \
	   -v "$PYDATA":"/data" \
	   python:$PYTHON_VERSION  sleep 1000 &

#pip3 install gitpython

#python3 /apps/clone.py