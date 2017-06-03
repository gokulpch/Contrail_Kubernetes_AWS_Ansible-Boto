#!/bin/bash
############################################################################
######
###################Ansible playbook to initiate the cluster#################
######
############################################################################
echo "Running ansible to create K8S cluster................."
ansible-playbook ./ansible/create_cluster.yml -v
