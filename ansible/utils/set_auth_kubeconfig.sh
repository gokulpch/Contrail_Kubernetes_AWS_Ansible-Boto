#!/bin/bash
############################################################################
######
##########Setting the admin.conf to enable kubectl based operations#########
######
############################################################################
echo"Copying admin.conf from /etc/kubernetes...................."
sudo cp /etc/kubernetes/admin.conf /root/.
echo"Changing Ownership to root...................."
sudo chown root:root $HOME/admin.conf
#echo export KUBECONFIG"="/home/ubuntu/admin.conf>>~/.profile
#source ~/.profile
echo"Applying settings to Bash Profile...................."
echo "export "KUBECONFIG"="/root/admin.conf>>/root/.bashrc
echo"Source Profile...................."
source /root/.bashrc
export KUBECONFIG=$HOME/admin.conf
