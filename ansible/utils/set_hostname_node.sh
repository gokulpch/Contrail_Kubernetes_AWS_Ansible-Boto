#!/bin/bash
############################################################################
######
##########By Default AWS sets the hostname as the IP of the instance#########
##########Changing the Hostname to identify Node#############################
######
############################################################################
echo "Setting node hostname.................."
sudo -s <<EOF
hostnamectl set-hostname node
echo "127.0.0.1 node">>/etc/hosts
EOF
