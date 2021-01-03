Only many basic examples os docker-compose, to generate quickly 
test environments. 

# MongoDB

- [mongo-express](./mongo-express): administration webapp for MongoDB
- [mongo-standalone](./mongo-standalone): includes
    - One MongoDB standalone node
    - Using environemnt vars ([.env file](./mongo-standalone/.env)):
        - MongoDB version
        - Admin user credentials
        - Database, credentials and roles to an application user
- [mongo-replicaSet-minimal](./mongo-replicaSet-minimal): basic example
  where initialize a three MongoDB containers configured as a replica-set
- [mongo-replicaSet](./mongo-replicaSet): based on mongo-standalone example
  with:
    - Three MongoDB containers, running as a replica-set
    - Using environemnt vars ([.env file](./mongo-replicaSet/.env)):
        - MongoDB version
        - ReplicaSet name
        - Admin user credentials
        - Database, credentials and roles to an application user
    - Review documentation in [mongo-replicaSet](./mongo-replicaSet)
      and [mongo-replicaSet/rs0](./mongo-replicaSet/rs0) for more detail

