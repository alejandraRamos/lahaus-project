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

service postgresql restart

sudo amazon-linux-extras enable python3.8
sudo yum install python3.8
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user

sudo yum update -y
sudo yum -y install git
git clone https://github.com/alejandraRamos/lahaus-project/tree/dev

pip3 install flask==1.1.2
pip3 install flask_sqlalchemy==2.4.1
pip3 install flask_script
pip3 install flask_migrate==2.5.2
pip3 install psycopg2-binary


python3 ./lahaus-project/app/manage.py db init
python3 ./lahaus-project/app/manage.py db migrate
python3 ./lahaus-project/app/manage.py db upgrade