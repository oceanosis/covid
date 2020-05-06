#!/bin/bash
set -e

BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CONTAINER_NAME="devdb"
POSTGRES_VERSION="12.2"

# Superuser settings
POSTGRES_USER="docker"
POSTGRES_DB="docker"
POSTGRES_PASSWORD="docker"

#POSTGRES_INITDB_ARGS=
PGDATA="$BASE/data"
POSTGRES_INITDB_WALDIR="$BASE/logs"

POSTGRES_HOST_AUTH_METHOD=
PG_HBA_CONF="$BASE/conf/pg_hba.conf":
POSTGRESQL_CONF="$BASE/conf/postgresql.conf"

# New db for development
INIT_DB_SQL="$BASE/conf/initdb.sql"


docker stop $CONTAINER_NAME  || true && docker rm $CONTAINER_NAME || true

[ -d $PGDATA ] || mkdir -p "$PGDATA"

[ -d POSTGRES_INITDB_WALDIR ] || mkdir -p "$POSTGRES_INITDB_WALDIR"


docker run -d --name $CONTAINER_NAME \
	   -v "$PGDATA":"/var/lib/postgresql/data" \
	   -e POSTGRES_USER=$POSTGRES_USER \
	   -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
	   -e POSTGRES_INITDB_WALDIR=$POSTGRES_INITDB_WALDIR \
	   -v "$POSTGRESQL_CONF":"/etc/postgresql/postgresql.conf" \
	   -v "$INIT_DB_SQL":"/docker-entrypoint-initdb.d/initdb.sql"  \
	   postgres:$POSTGRES_VERSION postgres -c 'config_file=/etc/postgresql/postgresql.conf'

# Other options:
# 	   -v "$PG_HBA_CONF":"/etc/postgresql/pg_hba.conf"
#      -e "POSTGRES_INITDB_ARGS="

# To test connection;
#  docker exec -it devdb sh -c 'exec psql  -U devuser -d devdb'
exit 0;
