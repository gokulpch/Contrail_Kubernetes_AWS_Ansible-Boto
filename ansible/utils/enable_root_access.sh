#!/bin/bash
############################################################################
######
##########By Default AWS instances can be accessed only using Key_Pairs#####
##########This Snippet Enables Root access for the EC2 Instances Created####
######
############################################################################
echo "copying user ubuntu authorized_keys to user root........"
sudo cp /home/ubuntu/.ssh/authorized_keys /root/.ssh/
echo "changing parameters in ssh_config file to enable root access........"
sudo -s <<EOF
sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/^StrictModes.*/#StrictModes/g' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
echo "root:contrail1" | chpasswd
echo "Restarting Services to enable changes........"
systemctl restart sshd
EOF
