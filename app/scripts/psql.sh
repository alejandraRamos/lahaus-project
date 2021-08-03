#!/bin/bash
apt update
apt-get install -y wget ca-certificates
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/lsb_release -cs-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
apt update
apt install -y postgresql postgresql-contrib
service postgresql restart

su postgres psql -c 'createuser root;'
su postgres psql -c 'createdb lahaus;'