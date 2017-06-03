#!/bin/bash
############################################################################
######								       #####
##########  Copying Keys to Enable Password less Login for Ansible     #####
######								       #####
############################################################################
echo "Getting Public IP Address of Master using AWS_CLI..................."
master_public="$(aws ec2 describe-instances --filters "Name=tag:Name,Values=contrail-K8S-Master" | grep PublicIpAddress | cut -d':' -f2 | tr -d '", ')"

echo "Getting Private IP Address of Master using AWS_CLI..................."
master_private="$(aws ec2 describe-instances --filters "Name=tag:Name,Values=contrail-K8S-Master" | grep "\<PrivateIpAddress\>" | cut -d':' -f2 | tr -d '", ' | sort -u)"

echo "Getting Private IP Address of Slave using AWS_CLI..................."
slave_private="$(aws ec2 describe-instances --filters "Name=tag:Name,Values=contrail-K8S-Minion" | grep "\<PrivateIpAddress\>" | cut -d':' -f2 | tr -d '", ' | sort -u)"

echo MASTER-Public: "${master_public}"
echo MASTER-Private: "${master_private}"
echo MINION-Private: "${slave_private}"

echo "Logging into Master and Minion to copy Keys..................."
ssh -tt root@"${master_public}" << EOF
 yes | ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N ''
 apt-get install sshpass -y
 sshpass -p contrail1 ssh-copy-id -o 'StrictHostKeyChecking=no' root@"${slave_private}"
 sshpass -p contrail1 ssh-copy-id -o 'StrictHostKeyChecking=no' root@"${master_private}"
exit 0
EOF
exit 0
