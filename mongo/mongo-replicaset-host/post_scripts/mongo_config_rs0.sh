#!/bin/bash
if ! command -v ping &> /dev/null 
then
  apt-get update
  apt-get install -y iputils-ping
  rm -rf /var/lib/apt/lists/*
fi

sleep 3s

echo mongo_config_rs0.sh time now: `date +"%T" `

echo mongo --host "${SERVER_NAME}:27017" -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" admin 

mongo --host "${SERVER_NAME}:27017" -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" admin <<EOF
  var cfg = {
    _id : "${MONGO_REPLICA_SET_NAME}",
    "version": 1,
    "members": [
      {
        "_id": 0,
        "host": "${SERVER_NAME}:27017",
        "priority": 2
      },
      {
        "_id": 1,
        "host": "${SERVER_NAME}:27018",
        "priority": 1
      },
      {
        "_id": 2,
        "host": "${SERVER_NAME}:27019",
        "priority": 1
      }
    ]
  };
  rs.initiate(cfg, { force: true });
EOF

echo "Waiting 10s MongoDB replicaSet init as replicaSet..."
sleep 10s

mongo "mongodb://${MONGO_INITDB_ROOT_USERNAME}:${MONGO_INITDB_ROOT_PASSWORD}@${SERVER_NAME}:27017,${SERVER_NAME}:27018,${SERVER_NAME}:27019/?replicaSet=${MONGO_REPLICA_SET_NAME}" \
  --eval "rs.status()"
