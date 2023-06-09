FROM postgres:10.0 as base

ARG DBNAME=db
ARG DBUSER=app
ARG DBPASS=pass

ENV POSTGRES_USER=$DBUSER
ENV POSTGRES_PASSWORD=$DBPASS
ENV POSTGRES_DB=$DBNAME

# Create

COPY docker-entrypoint-initdb.d /

RUN /docker-entrypoint.sh postgres &  > /dev/null 2>&1 ; while ! pg_isready -d "$POSTGRES_DB"; do sleep 10s ; done \
   && psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f /schema.sql \
   && psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f /data.sql \
   && rm -f /*.sql

FROM base

CMD ["postgres"]
