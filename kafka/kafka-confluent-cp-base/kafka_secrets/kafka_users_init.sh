#!/bin/bash

echo "Waiting to zookeeper start..."
cub zk-ready ${KAFKA_ZOOKEEPER_CONNECT} 30

echo "Init user admkafka"
kafka-configs --zookeeper ${KAFKA_ZOOKEEPER_CONNECT} \
    --alter --add-config 'SCRAM-SHA-512=[password=admkafkapass]' \
    --entity-type users --entity-name admkafka

echo "Init user ${KAFKA_USER}"
kafka-configs --zookeeper ${KAFKA_ZOOKEEPER_CONNECT} \
    --alter --add-config "SCRAM-SHA-512=[password=${KAFKA_PASSWORD}]" \
    --entity-type users --entity-name ${KAFKA_USER}
