#!/bin/bash

sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update

if [ ! -f /usr/bin/ansible ]; then
  echo "Installing Ansible and dependencies."
	#sudo apt-get --no-install-recommends -q -y install ansible sshpass
	sudo apt-get install python-pip python-dev git make sshpass -y
	sudo pip install PyYAML jinja2 paramiko passlib ansible 
  echo "Ansible installed."
fi 