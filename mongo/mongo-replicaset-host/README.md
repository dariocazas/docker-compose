# MongoDB with ReplicaSet bind your host

This is the same of [mongo-replicaset](../mongo-replicaset),
but the replicaSet nodes bind to your host address, using:

- mongo-rs0-0-host: exposes in port 27017
- mongo-rs0-1-host: exposes in port 27018
- mongo-rs0-2-host: exposes in port 27019

This enable connect outside of your server. 

In file [.env](./.env) you need to assing the
variable `SERVER_NAME` with the name or the IP 
of your docker host.