#!/bin/bash
############################################################################
######									####
########## Run Contrail-Ansible to install Contrail-Components on Master #####
######									####
############################################################################
echo "Running ansible to install contrail............................."
cd /root/contrail-ansible/playbooks;  ansible-playbook  -i inventory/my-inventory site.yml;
