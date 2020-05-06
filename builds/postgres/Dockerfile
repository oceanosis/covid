ARG POSTGRES_VERSION

FROM postgres:$POSTGRES_VERSION

ARG app_version

RUN echo "Building $app_version"

COPY pg_hba.conf /var/lib/postgresql/data/pg_hba.conf



