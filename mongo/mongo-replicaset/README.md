# MongoDB with ReplicaSet

Example with replicaSet, using three nodes:

- mongo-rs0-0: node with higher priority to be primary
- mongo-rs0-1: node usually as secondary
- mongo-rs0-2: node usually as secondary

The docker-compose instante another service (mongo-setup)
to enable the replicaSet. After do this, the container stop.

## Run

To prepare the first execution, is necesary run (review 
[this](./rs0/README.md) for more detail)

```sh
# Permissions MUST BE set to 400
chmod 400 mongo-rs0-keyfile
# Inside of container, the user mongodb has 999 UID, guaranteed by https://github.com/docker-library/mongo/blob/master/4.0/Dockerfile#L4
sudo chown 999 mongo-rs0-keyfile
```

After this, you can start the docker-compose as usual:

```sh
docker-compose up
```

To stop it:

```sh
docker-compose stop
```

To destroy (including volume and network):

```sh
docker-compose down
```

## Connect to MongoDB

You can use this connection string:

```sh
mongodb://<user>:<pass>@localhost:27017/?replicaSet=<replicaset-name>
```

When you connect to this port, MongoDB Driver lookup the instances of the 
replica set and connect against all. The replica set is build based on 
container IPs, for these reason hasn't problem with name resolution.

This is an example using default [.env](./.env) configuration, using
mongo shell as a client:

```sh
$ mongo "mongodb://root:example@localhost:27017/?replicaSet=rs0"
MongoDB shell version v4.0.21
connecting to: mongodb://localhost:27017/?gssapiServiceName=mongodb&replicaSet=rs0
2021-01-03T00:50:30.684+0100 I NETWORK  [js] Starting new replica set monitor for rs0/localhost:27017
2021-01-03T00:50:30.686+0100 I NETWORK  [js] Successfully connected to localhost:27017 (1 connections now open to localhost:27017 with a 5 second timeout)
2021-01-03T00:50:30.686+0100 I NETWORK  [js] changing hosts to rs0/172.80.11.2:27017,172.80.11.3:27017,172.80.11.4:27017 from rs0/localhost:27017
2021-01-03T00:50:30.687+0100 I NETWORK  [ReplicaSetMonitor-TaskExecutor] Successfully connected to 172.80.11.2:27017 (1 connections now open to 172.80.11.2:27017 with a 5 second timeout)
2021-01-03T00:50:30.687+0100 I NETWORK  [js] Successfully connected to 172.80.11.4:27017 (1 connections now open to 172.80.11.4:27017 with a 5 second timeout)
2021-01-03T00:50:30.687+0100 I NETWORK  [ReplicaSetMonitor-TaskExecutor] Successfully connected to 172.80.11.3:27017 (1 connections now open to 172.80.11.3:27017 with a 5 second timeout)
Implicit session: session { "id" : UUID("fe10ef9c-0d15-4529-8a0f-a3b2bf01bc2b") }

rs0:PRIMARY> exit
```

## Testing

The services are configured to restart automatically unless
stopped using:

```sh
docker-compose stop <service-name>
```

With this configuration, you should test some failover scenarios:

- Fail one secondary node, stopping the mongo-1 or mongo-2 node
    - ReplicaSet continue running
    - When failed node is started, resync your data from oplog
- Fail two secondary nodes, stopping the mongo-1 and mongo-2 node
    - ReplicaSet can run as read-only?? or stop all clients??
- Fail primary node, stopping the mongo-0 node
    - New node elected as primary (mongo-1 or mongo-2)
    - When mongo-0 is started, resync your data from oplog
    - When mongo-0 is restored, and due to higher priority 
        to be primary, will be elected

## References

- https://zgadzaj.com/development/docker/docker-compose/turning-standalone-mongodb-server-into-a-replica-set-with-docker-compose
- https://autoize.com/set-up-minimal-mongodb-three-3-replica-set-with-docker/
- https://prashix.medium.com/setup-mongodb-replicaset-with-authentication-enabled-using-docker-compose-5edd2ad46a90
- https://stackoverflow.com/questions/52940021/mongodb-error-unable-to-reach-primary-for-set-set-name-when-connect-to-mongo
- https://github.com/frontalnh/mongodb-replica-set/tree/master/dev

