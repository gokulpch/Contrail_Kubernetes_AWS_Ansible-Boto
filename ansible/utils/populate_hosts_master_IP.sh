#!/bin/bash
############################################################################
######								       #####	
######### Populate contrail-ansible hosts file with Master IP          #####
######  							       #####
############################################################################
echo "Getting Private IP of Master Node"
ip route get 255.255.255.255 | grep -Po '(?<=src )(\d{1,3}.){4}' | xargs -I '{}' sed -i "s/192.168.0.24/{}/g" /root/contrail-ansible/playbooks/inventory/my-inventory/hosts;
ip route get 255.255.255.255 | grep -Po '(?<=src )(\d{1,3}.){4}' | xargs -I '{}' sed -i "s/192.168.0.26/#192.168.0.26/g" /root/contrail-ansible/playbooks/inventory/my-inventory/hosts;
