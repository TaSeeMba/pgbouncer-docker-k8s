# PgBouncer Helm Chart

This helm chart installs PgBouncer in a Kubernetes cluster. The chart orchestrates installation of the Kubernetes deployment and service components of PgBouncer. 

## Docker Image Build

First build either the alpine or debian pgBouncer docker image you want to use.

## Installation

Run:
```
helm install -n pgbouncer .
```

## Configuration

Modify the `values.yaml` file of the Helm chart. 

The values of the following environment variables need to be first set in the `values.yaml` file : 
* `DB_USER` - PostgreSQL database user.
* `DB_PASSWORD` - password of the PostgreSQL database user.
* `DB_HOST` - host address of PostgreSQL database.
* `DB_NAME` - name of PostgreSQL database.
* `connection_limits_enabled` - variable to set whether pgBouncer will have a capped number of connections to PostgreSQL.
* `MAX_DB_CONNECTIONS` - maximum number of allowed database connections from pgBouncer to PostgreSQL.