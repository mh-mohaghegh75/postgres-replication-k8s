FROM postgres:16

# RUN apt-get -o Acquire::Check-Valid-Until=false update
# RUN apt-get install -y iputils-ping 

ENV PGUSER=replicator
ENV PGPASSWORD=replicator_password

USER postgres

EXPOSE 5432

# With --slot we only have one replication and the rest of the in kubernetes won't be able to work. that's why i comment the line below.
# CMD bash -c "until pg_basebackup --pgdata=/var/lib/postgresql/data -R --slot=replication_slot --host=master --port=5432 ; do echo 'Waiting for primary to connect...' && sleep 1s; done; echo 'Backup done, starting replica...'; chmod 0700 /var/lib/postgresql/data; postgres"

CMD bash -c "until pg_basebackup --pgdata=/var/lib/postgresql/data -R --host=master --port=5432 ; do echo 'Waiting for primary to connect...' && sleep 1s; done; echo 'Backup done, starting replica...'; chmod 0700 /var/lib/postgresql/data; postgres"
