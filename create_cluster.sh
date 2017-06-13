#!/bin/bash
############################################################################
######
###################Ansible playbook to initiate the cluster#################
######
############################################################################
echo "Running ansible to create K8S cluster................."
#ansible-playbook /root/Contrail_Kubernetes_AWS_Ansible-Boto/ansible/create_cluster.yaml -v
for i in `seq 1 5`;do echo;done
printf "Opening a new screen session......."
for i in `seq 1 5`;do echo;done
tmux new -d -s K8S-Install 'ANSIBLE_LOG_PATH="/root/install.log" ansible-playbook /root/Contrail_Kubernetes_AWS_Ansible-Boto/ansible/create_cluster.yaml -v'
tmux detach -s K8S-Install
for i in `seq 1 5`;do echo;done
echo "To attach use 'tmux attach -t K8S-Install'"
for i in `seq 1 2`;do echo;done
echo "To detach(leave the session running) use 'Ctrl-b d'"
for i in `seq 1 5`;do echo;done
