#!/bin/bash

sudo yum update -y
sudo yum -y install git
sudo amazon-linux-extras install ansible2 -y

git clone https://github.com/alejandraRamos/lahaus-project.git

cd lahaus-project/ConfigManager/

sudo ansible-playbook -i Inventory/hosts -l tag_Name_tf_instance_devops ini.yml -vvv -e database_url="postgresql://myuser:password@${ip_db}/lahaus" -e awslog_group=${log_group}