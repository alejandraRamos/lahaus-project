#!/bin/bash

sudo yum update -y
sudo yum -y install git
sudo amazon-linux-extras install ansible2 -y

git clone https://github.com/alejandraRamos/lahaus-project.git

cd lahaus-project/ConfigManager/

sudo ansible-playbook -i inventory/ -l ${ansible} ini.yml -vvv