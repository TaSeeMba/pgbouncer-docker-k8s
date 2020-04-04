# Debian Docker Image For PgBouncer

## Installation 
To run the image in docker: 

1. Build the image:
    ```
    docker build -t pgbouncer .
    ```

2. Run the image:

    The following environment variables need to be first set: 
    * `DB_USER`
    * `DB_PASSWORD`
    * `DB_HOST`
    * `DB_NAME`

    Then, run the image using this command:
    ```
    docker run --rm \
        -e DB_USER=user \
        -e DB_PASSWORD=pass \
        -e DB_HOST=postgres-host \
        -e DB_NAME=database \
        -p 6432:6432 \
        pgbouncer:latest 
    ```

    The other optional parameters you can set are `MAX_DB_CONNECTIONS`, `MAX_USER_CONNECTIONS` and `POOL_MODE` values. 

    To run this image in Kubernetes using helm, refer to instructions in the helm folder.

3. To view logs of the running container, run: 
    ```
    docker logs -f pgbouncer
    ```