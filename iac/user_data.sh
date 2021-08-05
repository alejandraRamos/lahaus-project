#!/bin/bash

sudo yum update -y
sudo yum -y install git
sudo amazon-linux-extras install ansible2 -y

git clone --branch dev https://github.com/alejandraRamos/lahaus-project.git

cd lahaus-project/ConfigManager/

sudo ansible-playbook -i Inventory/hosts -l ${ansible} ini.yml -vvv -e database_url="postgresql://myuser:password@${ip_db}/lahaus"