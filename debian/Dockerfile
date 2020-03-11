FROM debian:10-slim
LABEL maintainer="https://github.com/TaSeeMba" \
      version="1.0" \
      appversion="1.11.1" \
      description="PGDG PgBouncer running on Debian 10"

# adding PGDG apt repo (official postgresql project repo, https://apt.postgresql.org/pub/repos/apt/)
# and installing pgdg build of pgbouncer
RUN  apt-get -y update; apt-get install -y --no-install-recommends  curl ca-certificates gnupg ;  \
     curl https://www.postgresql.org/media/keys/ACCC4CF8.asc |  apt-key add - ; \
     echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" >/etc/apt/sources.list.d/pgdg.list ; apt-get -y update ; \
     apt-get install -y --no-install-recommends -t buster-pgdg pgbouncer  postgresql-client-11 ;  \
     apt-get clean

# retrieving gomplate, used for config generation
RUN  curl -L -o /usr/local/bin/gomplate https://github.com/hairyhenderson/gomplate/releases/download/v3.5.0/gomplate_linux-amd64 ; chmod a+x /usr/local/bin/gomplate

# directory for dynamic configuration
RUN mkdir /pgconf ; chown postgres /pgconf
VOLUME /templates


USER postgres

EXPOSE 5432/tcp

ENTRYPOINT ["echo" ,"Image meant to be run in K8s and has no default command, to run pod use\npgbouncer /pgconf/pgbouncer.ini\n"]
