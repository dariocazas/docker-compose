Only many basic examples os docker-compose, to generate quickly 
test environments. 

# MongoDB

- [mongo-express] MongoDB administration webapp
- [mongo-standalone] includes
    - One MongoDB standalone node
    - Using environemnt vars in `.env` file:
        - MongoDB version
        - Admin user credentials
        - Database, credentials and roles to an application user
- [mongo-replicaset-minimal] basic example where initialize
  three MongoDB containers configured as a replica-set
- [mongo-replicaset] based on mongo-standalone example with:
    - Three MongoDB containers, running as a replica-set
    - Using environemnt vars in `.env` file:
        - MongoDB version
        - ReplicaSet name
        - Admin user credentials
        - Database, credentials and roles to an application useradmkafka
    - Review documentation in [mongo-replicaset] and 
      [mongo-replicaset/rs0] for more detail

# Kafka

Before begin, you should be review [kafka listeners explained by rmoff]
about kafka listeners with docker.

- [kafka-confluent-cp-base] based on [Confluent Platform all in one] 
  docker images, that includes:
  - 4 broker nodes
  - Authentication (no authorization)
  - Automatic topic creation
- [kafka-confluent-cp-sr] based [kafka-confluent-cp-base], and include:
  - schema-registry
- [kafka-confluent-cp-kafkaconnect] based [kafka-confluent-cp-base], and include:
  - 2 workers of kafka connect
- [kafka-confluent-cp-controlcenter] based [kafka-confluent-cp-base], and include:
  - Confluent Control Center: Kafka distribution administration webapp
- [kafka-confluent-cp-v1] based on previous composes:
  - 4 broker nodes
  - Authentication (no authorization)
  - Automatic topic creation
  - schema-registry
  - 2 workers of kafka connect
  - Confluent Control Center
- [kafka-your-own-dockerfiles] util to generate your own distribution, 
  based on donwloaded versions. Include scripts to create:
  - Your own kafka base distribution
  - Your own schema registry distribution

[mongo-express]: ./mongo/mongo-express
[mongo-standalone]: ./mongo/mongo-standalone
[mongo-replicaset-minimal]: ./mongo/mongo-replicaset-minimal
[mongo-replicaset]: ./mongo/mongo-replicaset
[mongo-replicaset/rs0]: ./mongo/mongo-replicaset/rs0
[kafka listeners explained by rmoff]: https://rmoff.net/2018/08/02/kafka-listeners-explained/
[Confluent Platform all in one]: https://github.com/confluentinc/cp-all-in-one
[kafka-confluent-cp-base]: ./kafka/kafka-confluent-cp-base
[kafka-confluent-cp-sr]: ./kafka/kafka-confluent-cp-sr
[kafka-confluent-cp-kafkaconnect]: ./kafka/kafka-confluent-cp-kafkaconnect
[kafka-confluent-cp-controlcenter]: ./kafka/kafka-confluent-cp-controlcenter
[kafka-confluent-cp-v1]: ./kafka/kafka-confluent-cp-v1
[kafka-your-own-dockerfiles]: ./kafka/kafka-yourown-dockerfiles