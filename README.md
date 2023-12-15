Deploy postgres replication cluster with kubernetes.

First of all you have a docker compose file that you can run your cluster within docker container.

if you wanna deploy the cluster on k8s you have to build master and slave docker images:
$ Docker build -t master_postgres:1.0.0 -f ./images/master.Dockerfile .
AND 
$ Docker build -t slave_postgres:1.0.0 -f ./images/slave.Dockerfile .

and then you can run the cluster with k8s:
$ kubectl apply -f ./k8s/postgres.yaml
