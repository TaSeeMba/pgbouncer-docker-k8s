#!/bin/sh
# Based on https://raw.githubusercontent.com/brainsam/pgbouncer/master/entrypoint.sh

set -e

# Here are some parameters. See all on
# https://pgbouncer.github.io/config.html

PG_CONFIG_DIR=/etc/pgbouncer

if [ -n "$DATABASE_URL" ]; then
  # Thanks to https://stackoverflow.com/a/17287984/146289

  # Allow to pass values like dj-database-url / django-environ accept
  proto="$(echo $DATABASE_URL | grep :// | sed -e's,^\(.*://\).*,\1,g')"
  url="$(echo $DATABASE_URL | sed -e s,$proto,,g)"

  # extract the user and password (if any)
  userpass="$(echo $url | grep @ | cut -d@ -f1)"
  DB_PASSWORD="$(echo $userpass | grep : | cut -d: -f2)"
  if [ -n "$DB_PASSWORD" ]; then
    DB_USER=$(echo $userpass | grep : | cut -d: -f1)
  else
    DB_USER=$userpass
  fi

  # extract the host -- updated
  hostport=`echo $url | sed -e s,$userpass@,,g | cut -d/ -f1`
  port=`echo $hostport | grep : | cut -d: -f2`
  if [ -n "$port" ]; then
      DB_HOST=`echo $hostport | grep : | cut -d: -f1`
      DB_PORT=$port
  else
      DB_HOST=$hostport
  fi

  DB_NAME="$(echo $url | grep / | cut -d/ -f2-)"
fi

# Write the password with MD5 encryption, to avoid printing it during startup.
# Notice that `docker inspect` will show unencrypted env variables.
if [ -n "$DB_USER" -a -n "$DB_PASSWORD" ] && ! grep -q "^\"$DB_USER\"" ${PG_CONFIG_DIR}/userlist.txt; then
  if [ "$AUTH_TYPE" != "plain" ]; then
     pass="md5$(echo -n "$DB_PASSWORD$DB_USER" | md5sum | cut -f 1 -d ' ')"
  else
     pass="$DB_PASSWORD"
  fi
  echo "\"$DB_USER\" \"$pass\"" >> ${PG_CONFIG_DIR}/userlist.txt
  echo "Wrote authentication credentials to ${PG_CONFIG_DIR}/userlist.txt"
fi

if [ ! -f ${PG_CONFIG_DIR}/pgbouncer.ini ]; then
  echo "Create pgbouncer config in ${PG_CONFIG_DIR}"

# Config file is in “ini” format. Section names are between “[” and “]”.
# Lines starting with “;” or “#” are taken as comments and ignored.
# The characters “;” and “#” are not recognized when they appear later in the line.
  printf "\
################## Auto generated ##################
[databases]
${DB_NAME:-*} = host=${DB_HOST:?"Setup pgbouncer config error! You must set DB_HOST env"} \
port=${DB_PORT:-5432} user=${DB_USER:-postgres}
${CLIENT_ENCODING:+client_encoding = ${CLIENT_ENCODING}\n}\

[pgbouncer]
listen_addr = ${LISTEN_ADDR:-0.0.0.0}
listen_port = ${LISTEN_PORT:-6432}
unix_socket_dir =
user = postgres
auth_file = ${AUTH_FILE:-$PG_CONFIG_DIR/userlist.txt}
auth_type = ${AUTH_TYPE:-md5}
ignore_startup_parameters = ${IGNORE_STARTUP_PARAMETERS:-extra_float_digits}
${POOL_MODE:+pool_mode = ${POOL_MODE}\n}\
${MAX_DB_CONNECTIONS:+max_db_connections = ${MAX_DB_CONNECTIONS}\n}\
${MAX_USER_CONNECTIONS:+max_user_connections = ${MAX_USER_CONNECTIONS}\n}\

# Log settings
admin_users = ${ADMIN_USERS:-postgres}

################## end file ##################
" > ${PG_CONFIG_DIR}/pgbouncer.ini
cat ${PG_CONFIG_DIR}/pgbouncer.ini
echo "Starting $*..."
fi

exec "$@"
