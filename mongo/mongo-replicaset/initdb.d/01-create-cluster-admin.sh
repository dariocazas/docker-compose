#!/bin/bash
# https://www.stuartellis.name/articles/shell-scripting/#enabling-better-error-handling-with-set
set -Eeuo pipefail

"${mongo[@]}" -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" --authenticationDatabase "$rootAuthDatabase" "$rootAuthDatabase" <<EOJS
    db.grantRolesToUser(
        $(_js_escape "$MONGO_INITDB_ROOT_USERNAME"),
        [ { role: 'clusterAdmin', db: $(_js_escape "$rootAuthDatabase") } ],
        { w: "majority", wtimeout: 4000 }
    )
EOJS
