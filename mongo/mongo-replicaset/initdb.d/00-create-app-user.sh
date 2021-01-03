#!/bin/bash
# https://www.stuartellis.name/articles/shell-scripting/#enabling-better-error-handling-with-set
set -Eeuo pipefail
 
init_user() {
    # Based on mongo/docker-entrypoint.sh
    # https://github.com/docker-library/mongo/blob/master/docker-entrypoint.sh#L303
    echo "Creating user:\n\tuser=$MONGO_INITDB_USERNAME\n\tauth_db=$MONGO_INITDB_AUTH\n\trole=$MONGO_INITDB_ROLE over $MONGO_INITDB_DATABASE" 
    "${mongo[@]}" -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" --authenticationDatabase "$rootAuthDatabase" "$MONGO_INITDB_AUTH" <<EOJS
        db.createUser({
            user: $(_js_escape "$MONGO_INITDB_USERNAME"),
            pwd: $(_js_escape "$MONGO_INITDB_PASSWORD"),
            roles: [ { role: $(_js_escape "$MONGO_INITDB_ROLE"), db: $(_js_escape "$MONGO_INITDB_DATABASE") } ]
        })
EOJS
}

if [ "$MONGO_INITDB_USERNAME" ] && [ "$MONGO_INITDB_PASSWORD" ]; then
    MONGO_INITDB_AUTH="${MONGO_INITDB_AUTH:-admin}"
    MONGO_INITDB_DATABASE="${MONGO_INITDB_DATABASE:-admin}"
    MONGO_INITDB_ROLE="${MONGO_INITDB_ROLE:-readWrite}"
    
    init_user
fi