#!/bin/bash
############################################################################
######								       #####
##########                 Install latest ansible                 ##########
######                                                                 #####
############################################################################
sudo -s <<EOF
echo "Install Software Properties................."
sudo apt-get install software-properties-common;
echo "Adding Ansible ppa................."
sudo add-apt-repository ppa:ansible/ansible -y;
sudo apt-get update;
echo "Installing Ansible................."
sudo apt-get install ansible -y;
EOF
