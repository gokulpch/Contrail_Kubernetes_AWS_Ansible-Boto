#!/bin/bash
############################################################################
######
##########By Default AWS sets the hostname as the IP of the instance#########
##########Changing the Hostname to identify master node######################
######
############################################################################
echo "Setting Master node hostname.................."
sudo -s <<EOF
hostnamectl set-hostname master
echo "127.0.0.1 master">>/etc/hosts
EOF
