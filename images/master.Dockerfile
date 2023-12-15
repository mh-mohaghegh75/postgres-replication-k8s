FROM postgres:16

RUN apt-get -o Acquire::Check-Valid-Until=false update
RUN apt-get install -y iputils-ping 

ENV POSTGRES_USER=postgres
ENV POSTGRES_DB=postgres
ENV POSTGRES_PASSWORD=password

COPY ./entrypoint/00_master_init.sql /docker-entrypoint-initdb.d/00_init.sql
COPY ./entrypoint/01_master_config_init.sh /docker-entrypoint-initdb.d/01_config_init.sh

USER postgres

EXPOSE 5432

CMD ["postgres", "-c", "wal_level=logical", "-c", "hot_standby=on", "-c", "max_wal_senders=10", "-c", "max_replication_slots=10", "-c", "hot_standby_feedback=on"]

