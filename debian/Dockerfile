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
     apt-get clean ; \
     # entrypoint installs the configuation, allow to write as postgres user
     chown -R postgres /etc/pgbouncer 

ADD entrypoint.sh /entrypoint.sh

USER postgres

EXPOSE 6432/tcp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["pgbouncer", "/etc/pgbouncer/pgbouncer.ini"]
