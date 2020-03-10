#!/bin/sh

# db connection credentials
DB_HOST=$DB_HOST
DB_PORT=$DB_PORT
DB_NAME=$DB_NAME
POSTGRES_USER=$POSTGRES_USER
POSTGRES_PASSWORD=$POSTGRES_PASSWORD
# pgbouncer credentials
PGBOUNCER_HOST=$PGBOUNCER_HOST
PGBOUNCER_PORT=$PGBOUNCER_PORT

echo $POSTGRES_USER $POSTGRES_PASSWORD > userlist.txt


CONFIG="
[databases]
\ntemplate1 = host=$DB_HOST port=$DB_PORT dbname=$DB_NAME
\n\n[pgbouncer]
\nlisten_port = $PGBOUNCER_PORT
\nlisten_addr = $PGBOUNCER_HOST
\nauth_type = md5 
\nauth_file = userlist.txt
\nlogfile = pgbouncer.log
\npidfile = pgbouncer.pid 
\nadmin_users = $POSTGRES_USER
"

echo $CONFIG > pgbouncer.ini