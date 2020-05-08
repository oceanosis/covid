#!/usr/bin/env bash
set -e

BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$BASE/vars/setEnvVars"

# Superuser settings
CRDB_USER="docker"
CRDB_DB="docker"
CRDB_PASSWORD="docker"

#CRDB_INITDB_ARGS=
CRDBDATA="$BASE/crdbdata"


# Create CRDB Cluster
docker network create -d bridge roachnet || true

docker stop roach1 roach2 roach3  || true && docker rm roach1 roach2 roach3|| true

[ -d $CRDBDATA ] || mkdir -p "$CRDBDATA"

docker run -d --name=roach1 --hostname=roach1 \
    --net=roachnet \
    -p 26257:26257 -p 8080:8080  \
    -v "$CRDBDATA/roach1":"/cockroach/cockroach-data" \
    $CRDB_BUILD start \
    --insecure \
    --join=roach1,roach2,roach3 || false

docker run -d --name=roach2 --hostname=roach2 \
    --net=roachnet \
    -v "$CRDBDATA/roach2":"/cockroach/cockroach-data" \
    $CRDB_BUILD start \
    --insecure \
    --join=roach1,roach2,roach3 || false

docker run -d --name=roach3 --hostname=roach3 \
    --net=roachnet \
    -v "$CRDBDATA/roach3":"/cockroach/cockroach-data" \
    $CRDB_BUILD start \
    --insecure \
    --join=roach1,roach2,roach3 || false

docker exec -it roach1 ./cockroach init --insecure

# To test connection;
#  docker exec -it devdb sh -c 'exec psql  -U docker -d covid'
exit 0;
