#!/bin/bash
############################################################################
######                                                                 #####
######### Populating Hosts file with Minion node details	       #####
###### 								       #####
############################################################################
echo "Getting Public_IP_Address of Master node.................."
master="$(aws ec2 describe-instances --filters "Name=tag:Name,Values=contrail-K8S-Master" | grep PublicIpAddress | cut -d':' -f2 | tr -d '", ')"

echo "Getting Private_IP_Address of Minion node.................."
slave="$(aws ec2 describe-instances --filters "Name=tag:Name,Values=contrail-K8S-Minion" | grep "\<PrivateIpAddress\>" | cut -d':' -f2 | tr -d '", ' | sort -u)"

echo "Print Master and Minion IP.................."
echo MASTER: "${master}"
echo MINION: "${slave}"

echo "Logging into Master node and modify hosts file with Minion address.................."
ssh -tt -o StrictHostKeyChecking=no root@"${master}" << EOF
 sed -i "s/192.168.0.25/$slave/g" /root/contrail-ansible/playbooks/inventory/my-inventory/hosts;
exit 0
EOF
exit 0
