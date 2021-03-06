# Kafka control center

Example base on four kafka brokers, and one Zookeeper server. 
The cluster binds several ports on your localhost:

- 22181: zookeeper
- 19094: broker 1
- 29094: broker 2
- 39094: broker 3
- 49094: broker 4

You can review an update several config properties in [.env] file

## Run

Start with docker compose as usual:

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

## Connection config to kafka brokers

For connect to cluster, you need to configure some properties:

```sh
# With one server is enoght, on first connection bind to all
bootstrap.servers=localhost:19094
sasl.mechanism=SCRAM-SHA-512
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="myuser" password="mypass";
security.protocol=SASL_PLAINTEXT
```

You can change the username and password changing in [.env], 
or creating a new with:

```sh
KAFKA_USER=<your user>
KAFKA_PASSWORD=<your pass>
kafka-configs --zookeeper localhost:22181 \
    --alter --add-config "SCRAM-SHA-512=[password=${KAFKA_PASSWORD}]" \
    --entity-type users --entity-name ${KAFKA_USER}
```

## Testing

The services are configured to restart automatically unless
stopped using:

```sh
docker-compose stop <service-name>
```

With this configuration, you should test some failover scenarios.



[.env]: ./.env