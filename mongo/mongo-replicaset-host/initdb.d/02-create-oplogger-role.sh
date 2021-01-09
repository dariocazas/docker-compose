#!/bin/bash
# Create role to allow grant to an user read oplog.rs local collection.
# This is not necessary to run a replica set, but will be util to some test.
#
# To add this role to the user "myuser", run in mongo shell:
#   use admin; db.grantRolesToUser("myuser", [{role: "oplogger", db: "admin"}]);

set -Eeuo pipefail

"${mongo[@]}" -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" --authenticationDatabase "$rootAuthDatabase" "$rootAuthDatabase" <<EOJS
    db.createRole(
    {
        role: "oplogger",
        privileges: [
            { resource: { db: "local", collection: "oplog.rs" }, actions: [ "find" ] }
        ],
        roles: []
        }
    ):
EOJS
