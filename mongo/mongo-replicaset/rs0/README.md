# Key file

The key file is need to auth between nodes. To generate it:

```sh
openssl rand -base64 756 > mongo-rs0-keyfile
# Permissions MUST BE set to 400
chmod 400 mongo-rs0-keyfile
# Inside of container, the user mongodb has 999 UID, guaranteed by https://github.com/docker-library/mongo/blob/master/4.0/Dockerfile#L4
sudo chown 999 mongo-rs0-keyfile
```

You should mount this folder to reference the keyfile in the nodes.

Aditional [MongoDB doc](https://docs.mongodb.com/manual/tutorial/enforce-keyfile-access-control-in-existing-replica-set/#enforce-keyfile-access-control-on-existing-replica-set)