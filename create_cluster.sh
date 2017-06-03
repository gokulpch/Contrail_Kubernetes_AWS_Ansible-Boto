#!/bin/bash
############################################################################
######
###################Ansible playbook to initiate the cluster#################
######
############################################################################
echo "Running ansible to create K8S cluster................."
ansible-playbook /root/Contrail_Kubernetes_AWS_Ansible-Boto/ansible/create_cluster.yml -v
