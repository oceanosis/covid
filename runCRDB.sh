#!/usr/bin/env bash
set -e

BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$BASE/vars/setEnvVars"

#CRDB_INITDB_ARGS=
CRDBDATA="$BASE/crdbdata"
INIT_SQL="$BASE/conf/crdb.sql"

runsql() { ./cockroach sql --insecure -e "$1"; }

# Create CRDB Cluster
docker network create -d bridge roachnet || true

for node in roach1 roach2 roach3;
do
    docker exec -it $node ./cockroach quit --insecure || true
    docker stop $node || true
    docker rm $node || true
done


if [ "$(ls -A $CRDBDATA)" ]; then
    rm -rf $CRDBDATA && mkdir -p "$CRDBDATA"
elif [ ! -d $CRDBDATA ]; then
    mkdir -p "$CRDBDATA"
fi

docker run -d --name=roach1  --hostname=roach1 \
    --net=roachnet \
    -p 26257:26257 -p 8080:8080  \
    -v "$CRDBDATA/roach1":"/cockroach/cockroach-data" \
	-v "$INIT_SQL":"/cockroach/cockroach-init.sql" \
    $CRDB_BUILD start \
    --insecure \
    --join=roach1,roach2,roach3 || false

for node in roach2 roach3;
do
docker run -d --name=$node --hostname=$node \
    --net=roachnet \
    -v "$CRDBDATA/$node":"/cockroach/cockroach-data" \
    $CRDB_BUILD start \
    --insecure \
    --join=roach1,roach2,roach3 || false
done

docker exec -it roach1 ./cockroach init --insecure || false



docker exec -it roach1 ./cockroach sql --insecure < /cockroach/cockroach-init.sql || false

# To test connection;
#  docker exec -it roach1 ./cockroach sql --insecure
exit 0;
