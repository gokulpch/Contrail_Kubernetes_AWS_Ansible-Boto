#! /bin/sh
############################################################################
######                                                                 #####
##########  Pull Contrail Docker Images and Contrail-Ansible           #####
##########  Create required directories to place docker images         #####
######                                                                  ####
############################################################################
#git clone -b R4.0 https://github.com/Juniper/contrail-ansible.git
echo "Getting Contrail-Ansible Packages............................"
wget https://s3-us-west-2.amazonaws.com/contrail-docker-images/contrail-ansible.tgz;
echo "Getting Contrail-Docker-Images............................"
wget https://s3-us-west-2.amazonaws.com/contrail-docker-images/contrail-kubernetes-docker-images_4.0.0.0-15.tgz;
echo "Untar Contrail-Ansible packages............................"
tar -xvzf contrail-ansible.tgz;
rm -rf contrail-ansible.tgz;
echo "Create container_images directory............................"
mkdir /root/contrail-ansible/playbooks/container_images;
tar -xvzf /root/contrail-kubernetes-docker-images_4.0.0.0-15.tgz -C /root/contrail-ansible/playbooks/container_images/.;
#tar -xvzf /root/contrail-ansible/playbooks/container_images/contrail-kubernetes-docker-images_4.0.0.0-11.tgz -C /root/contrail-ansible/playbooks/container_images/.;
rm -rf contrail-kubernetes-docker-images_4.0.0.0-15.tgz;
git clone https://github.com/gokulpch/Contrail_Kubernetes_Demo_Yaml.git;
echo "Done"
