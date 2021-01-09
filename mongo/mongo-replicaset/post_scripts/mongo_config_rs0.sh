#!/bin/bash
if ! command -v ping &> /dev/null 
then
  apt-get update
  apt-get install -y iputils-ping
  rm -rf /var/lib/apt/lists/*
fi

sleep 3s

echo mongo_config_rs0.sh time now: `date +"%T" `

MONGO0=`ping -c 1 mongo-rs0-0 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGO1=`ping -c 1 mongo-rs0-1 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGO2=`ping -c 1 mongo-rs0-2 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`

mongo --host "${MONGO0}:27017" -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" admin <<EOF
  var cfg = {
    _id : "${MONGO_REPLICA_SET_NAME}",
    "version": 1,
    "members": [
      {
        "_id": 0,
        "host": "${MONGO0}:27017",
        "priority": 2
      },
      {
        "_id": 1,
        "host": "${MONGO1}:27017",
        "priority": 1
      },
      {
        "_id": 2,
        "host": "${MONGO2}:27017",
        "priority": 1
      }
    ]
  };
  rs.initiate(cfg, { force: true });
EOF

echo "Waiting 10s MongoDB replicaSet init as replicaSet..."
sleep 10s

mongo "mongodb://${MONGO_INITDB_ROOT_USERNAME}:${MONGO_INITDB_ROOT_PASSWORD}@${MONGO0}:27017,${MONGO1}:27017,${MONGO2}:27017/?replicaSet=${MONGO_REPLICA_SET_NAME}" \
  --eval "rs.status()"
