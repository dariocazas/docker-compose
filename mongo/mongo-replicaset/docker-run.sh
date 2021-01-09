#!/bin/bash

KEYFILE=./rs0/mongo-rs0-keyfile

valid_return() {
    RETVAL=$1
    ERRORTXT=$2
    if [ $RETVAL -ne 0 ]; then
        echo ${ERRORTXT}
        exit $RETVAL
    fi
}

if [ ! -f $KEYFILE ]; then
    echo "Creating $KEYFILE"
    mkdir -p "$(dirname "$KEYFILE")"
    seq 100 | tr -d '\n' | base64 > $KEYFILE

    # Permissions MUST BE set to 400
    chmod 400 $KEYFILE
    valid_return $? "Fail change permisions over $KEYFILE. Remove it an run again"

    # Inside of container, the user mongodb has 999 UID, guaranteed by https://github.com/docker-library/mongo/blob/master/4.0/Dockerfile#L4
    sudo chown 999 $KEYFILE
    valid_return $? "Fail change owner over $KEYFILE. Remove it an run again"
fi

docker-compose up