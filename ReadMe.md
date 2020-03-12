# PgBouncer Docker Image and Helm Chart

Using connection pooling, we can have multiple client-side connections reusing PostgreSQL connections. Connection pooling acts as middleware between a Postgres server and the application by maintaining a sophisticated connection pools to the server. 

This project provides Alpine and Debian Docker files which can be used to spin-up pgbouncer, a PostgreSQL connection pooler, in Docker and Kubernetes environments. 

## Overview

Database connections to PostgreSQL from microservices can become unpredictable at system peak times. From our experience of running microservices at scale, apps often fail to connect to PostgreSQL and at other times, database resources are usually under pressure yet there is no significant load on the system. Time to execute queries was unusually high, sometimes in the margins of over 5 seconds for simple queries. These issues occured intermittently and were often not easily reproducible in the test environment. 

Documentation of most ORM frameworks tells developers to insert database connection strings in a settings or config file. Such a setup results in your apps or microservices directly connecting to PostgreSQL. For instance, [Django] (https://www.djangoproject.com/) recommends connection to PostgreSQL [here] (https://docs.djangoproject.com/en/3.0/ref/settings/), with a typical example configuration like: 

```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'mydatabase',
        'USER': 'mydatabaseuser',
        'PASSWORD': 'mypassword',
        'HOST': '127.0.0.1',
        'PORT': '5432',
    }
}
```

## Background
Creation of database connections is an expensive operation, not every application is using or creating connection pools in an optimal way. When PostgreSQL database is under constant pressure, CPU utilization usually hovers over 70 percent and it's not because all the available resources are being used in the best way possible, but because we were bombarding the server with too many (badly optimized) queries.

In PostgreSQL, a connection is handled by starting an OS process which in turn needs a number of resources. The more connections, the more resources your database will use and once you hit the maximum limit of connections, PostgreSQL will reject new connections.

## Installation

## Benchmarks
