# PgBouncer Docker Image and Helm Chart

## Overview
Creation of database connections is an expensive operation, not every application is using/creating connection pools in an optimal way. When the database is under constant pressure, CPU utilization usually hovers over 70 percent and it's not because all the available resources are being used in the best way possible, but because we were bombarding the server with too many (badly optimized) queries.

In PostgreSQL, a connection is handled by starting an OS process which in turn needs a number of resources. The more connections, the more resources your database will use and once you hit the maximum limit of connections, PostgreSQL will reject new connections.

## Installation

## Benchmarks